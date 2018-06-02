using DevExpress.Web;
using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.Kho
{
    public partial class ChuyenKho : System.Web.UI.Page
    {
        public List<oImportProduct_ChiTietChuyenKho> listReceiptProducts
        {
            get
            {
                if (Session["sslistChuyenKho"] == null)
                    Session["sslistChuyenKho"] = new List<oImportProduct_ChiTietChuyenKho>();
                return (List<oImportProduct_ChiTietChuyenKho>)Session["sslistChuyenKho"];
            }
            set
            {
                Session["sslistChuyenKho"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.User.Identity.IsAuthenticated)
            {
                if (!IsPostBack)
                {

                    ccbChiNhanhNhan.Focus();
                    ccbChiNhanhChuyen.Value = Formats.IDChiNhanh().ToString();
                    string[] infoUser = Context.User.Identity.Name.Split('-');
                    txtNguoiNhap.Text = infoUser[1];
                    listReceiptProducts = new List<oImportProduct_ChiTietChuyenKho>();
                }
            }
            else
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
        }

        protected void dateEditControl_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }

        
        protected void cbpInfoImport_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "LamMoi": LamMoi(); ccbBarcode.Text = ""; ccbBarcode.Focus(); break;
                case "UnitChange": Unitchange(para[1]); BindGrid(); break;
                case "importexcel": BindGrid(); break;
                case "Save": Save(); BindGrid(); break;
                case "redirect": DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/Pages/Kho/DanhSachChuyenKho.aspx"); break;
                default: InsertIntoGrid(); BindGrid(); break;
            }
        }
        private void BindGrid()
        {
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
        }
        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            switch (e.Parameter)
            {
                case "ChiNhanhChuyen": ccbChiNhanhNhan.Text = ""; ccbChiNhanhNhan.DataBind(); ccbChiNhanhNhan.Focus(); break;
            }
        }
        public void LamMoi()
        {
            listReceiptProducts = new List<oImportProduct_ChiTietChuyenKho>();
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
        }
        protected void ccbChiNhanhChuyen_Callback(object sender, CallbackEventArgsBase e)
        {
            //LamMoi();
            ccbChiNhanhNhan.DataBind();
        }

        #region số lượng
        protected void spUnitReturn_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }
        private void Unitchange(string para)
        {
            int IDProduct = Convert.ToInt32(para);
            ASPxSpinEdit SpinEdit = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Số lượng"], "spUnitReturn") as ASPxSpinEdit;
            int UnitProductNew = Convert.ToInt32(SpinEdit.Number);
            var sourceRow = listReceiptProducts.Where(x => x.STT == IDProduct).SingleOrDefault();
            if (UnitProductNew < 1)
            {
                if (sourceRow != null)
                {
                    listReceiptProducts.Remove(sourceRow);
                    UpdateSTT();
                }
            }
            else
            {
                sourceRow.SoLuong = UnitProductNew;
            }
        }
        #endregion

        #region bind data hàng hóa
        protected void ccbBarcode_ItemRequestedByValue(object source, ListEditItemRequestedByValueEventArgs e)
        {
            long value = 0;
            if (e.Value == null || !Int64.TryParse(e.Value.ToString(), out value))
                return;
            ASPxComboBox comboBox = (ASPxComboBox)source;
            dsHangHoa.SelectCommand = @"SELECT hhHangHoa.IDHangHoa, hhHangHoa.MaHang, hhHangHoa.TenHangHoa, hhHangHoa.GiaBan,hhHangHoa.GiaVon
                                        FROM hhHangHoa
                                        WHERE (hhHangHoa.IDHangHoa = @IDHangHoa AND hhHangHoa.DaXoa = 0  AND hhHangHoa.LoaiHHID = 1)";
            dsHangHoa.SelectParameters.Clear();
            dsHangHoa.SelectParameters.Add("IDHangHoa", TypeCode.Int64, e.Value.ToString());
            comboBox.DataSource = dsHangHoa;
            comboBox.DataBind();
        }

        protected void ccbBarcode_ItemsRequestedByFilterCondition(object source, ListEditItemsRequestedByFilterConditionEventArgs e)
        {
            ASPxComboBox comboBox = (ASPxComboBox)source;
            dsHangHoa.SelectCommand = @"SELECT [IDHangHoa], [MaHang], [TenHangHoa], [GiaBan] , [GiaVon]
                                        FROM (
	                                        select hhHangHoa.IDHangHoa, hhHangHoa.MaHang, hhHangHoa.TenHangHoa, hhHangHoa.GiaBan,hhHangHoa.GiaVon,
	                                        row_number()over(order by hhHangHoa.MaHang) as [rn] 
	                                        FROM hhHangHoa 
                                                    
	                                        WHERE ((hhHangHoa.MaHang LIKE @MaHang) OR hhHangHoa.TenHangHoa LIKE @TenHang) AND hhHangHoa.DaXoa = 0 AND hhHangHoa.LoaiHHID = 1
	                                        ) as st 
                                        where st.[rn] between @startIndex and @endIndex";
            dsHangHoa.SelectParameters.Clear();
            dsHangHoa.SelectParameters.Add("MaHang", TypeCode.String, string.Format("%{0}%", e.Filter));
            dsHangHoa.SelectParameters.Add("TenHang", TypeCode.String, string.Format("%{0}%", e.Filter));
            dsHangHoa.SelectParameters.Add("startIndex", TypeCode.Int64, (e.BeginIndex + 1).ToString());
            dsHangHoa.SelectParameters.Add("endIndex", TypeCode.Int64, (e.EndIndex + 1).ToString());
            comboBox.DataSource = dsHangHoa;
            comboBox.DataBind();
        }
        #endregion

        #region InsertHang
        protected void InsertIntoGrid()
        {
            if (ccbBarcode.Text.Trim() != "")
            {
                if (ccbBarcode.Value == null)
                {
                    //barcode
                    int tbThongTin_Count = DBDataProvider.DB.hhBarcodes.Where(r => r.Barcode == ccbBarcode.Text.Trim()).Count();
                    if (tbThongTin_Count > 0)
                    {
                        var tbThongTin = DBDataProvider.DB.hhBarcodes.Where(r => r.Barcode == ccbBarcode.Text.Trim()).FirstOrDefault();
                        Insert_Hang(Convert.ToInt32(tbThongTin.IDHangHoa));
                    }
                    else
                    {
                        ccbBarcode.Value = "";
                        ccbBarcode.Text = "";
                        ccbBarcode.Focus();
                        throw new Exception("Mã hàng không tồn tại !!");
                    }
                }
                else
                {
                    // idhanghoa
                    int IDProduct;
                    bool isNumeric = Int32.TryParse(ccbBarcode.Value.ToString(), out IDProduct);
                    if (isNumeric)
                    {
                        Insert_Hang(IDProduct);
                    }
                    else
                    {
                        ccbBarcode.Value = "";
                        ccbBarcode.Text = "";
                        ccbBarcode.Focus();
                        throw new Exception("Mã hàng không tồn tại !!");
                    }
                }
            }
        }

        public void Insert_Hang(int ID)
        {
            int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == ID && x.DaXoa == 0 && x.LoaiHHID == 1).Count();
            if (tblHangHoa_Count > 0)
            {
                var tblHangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == ID && x.DaXoa == 0).FirstOrDefault();
                var exitProdInList = listReceiptProducts.SingleOrDefault(r => r.IDHangHoa == ID);
                if (exitProdInList == null)
                {

                    oImportProduct_ChiTietChuyenKho newRecpPro = new oImportProduct_ChiTietChuyenKho(
                        tblHangHoa.IDHangHoa,
                        tblHangHoa.MaHang,
                        tblHangHoa.TenHangHoa,
                        tblHangHoa.hhDonViTinh.TenDonViTinh,
                        Convert.ToInt32(tblHangHoa.hhTonKhos.Where(s=>s.ChiNhanhID == Convert.ToInt32(ccbChiNhanhChuyen.Value.ToString())).FirstOrDefault().SoLuong),
                        1,
                        Convert.ToInt32(tblHangHoa.hhTonKhos.Where(s=>s.ChiNhanhID == Convert.ToInt32(ccbChiNhanhNhan.Value.ToString())).FirstOrDefault().SoLuong)
                      );
                    listReceiptProducts.Add(newRecpPro);
                }
                else
                {
                    exitProdInList.SoLuong += 1;
                }
                UpdateSTT();
            }
            else
            {
                ccbBarcode.Value = "";
                ccbBarcode.Text = "";
                ccbBarcode.Focus();
                throw new Exception("Mã hàng không tồn tại !!");
            }
        }
        protected void UpdateSTT()
        {
            ccbBarcode.Value = "";
            ccbBarcode.Text = "";
            ccbBarcode.Focus();
            for (int i = 1; i <= listReceiptProducts.Count; i++)
            {
                listReceiptProducts[i - 1].STT = i;
            }

        }

        protected void gridImportPro_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int stt = int.Parse(e.Keys["STT"].ToString());
            var itemToRemove = listReceiptProducts.SingleOrDefault(r => r.STT == stt);
            if (itemToRemove != null)
            {
                listReceiptProducts.Remove(itemToRemove);
                UpdateSTT();
            }
            e.Cancel = true;
            BindGrid();
        }
        #endregion

        #region nhập excel
        public string strFileExcel { get; set; }
        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string folder = null;
            string filein = null;
            string ThangNam = null;
            ThangNam = string.Concat(System.DateTime.Now.Month.ToString(), System.DateTime.Now.Year.ToString());
            if (!Directory.Exists(Server.MapPath("~/Uploads/") + ThangNam))
            {
                Directory.CreateDirectory(Server.MapPath("~/Uploads/") + ThangNam);
            }
            folder = Server.MapPath("~/Uploads/" + ThangNam + "/");
            if (UploadControl.HasFile)
            {
                strFileExcel = Guid.NewGuid().ToString();
                string theExtension = Path.GetExtension(UploadControl.FileName);
                strFileExcel += theExtension;
                filein = folder + strFileExcel;
                e.UploadedFile.SaveAs(filein);
                strFileExcel = ThangNam + "/" + strFileExcel;
            }

            string Excel = Server.MapPath("~/Uploads/") + strFileExcel;
            string excelConnectionString = string.Empty;
            excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Excel + ";Extended Properties=Excel 8.0;";
            OleDbConnection excelConnection = new OleDbConnection(excelConnectionString);
            OleDbCommand cmd = new OleDbCommand("Select * from [Sheet1$]", excelConnection);
            excelConnection.Open();
            OleDbDataReader dReader = default(OleDbDataReader);
            dReader = cmd.ExecuteReader();
            DataTable dataTable = new DataTable();
            dataTable.Load(dReader);
            int r = dataTable.Rows.Count;
            Import_Temp(dataTable);
            UpdateSTT();
        }
        private void Import_Temp(DataTable datatable)
        {
            int intRow = datatable.Rows.Count;
            if (datatable.Columns.Contains("Mã hàng hóa") && datatable.Columns.Contains("Số lượng"))
            {
                if (intRow != 0)
                {
                    for (int i = 0; i <= intRow - 1; i++)
                    {
                        DataRow dr = datatable.Rows[i];
                        string MaHang = dr["Mã hàng hóa"].ToString().Trim();
                        if (MaHang != "")
                        {
                            int SoLuong = Convert.ToInt32(dr["Số lượng"].ToString() == "" ? 0 : Convert.ToInt32(dr["Số lượng"].ToString()));
                            int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.MaHang == MaHang && x.DaXoa == 0 && x.LoaiHHID == 1).Count();
                            if (tblHangHoa_Count > 0)
                            {
                                var tblHangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.MaHang == MaHang && x.DaXoa == 0 && x.LoaiHHID == 1).FirstOrDefault();
                                var exitProdInList = listReceiptProducts.SingleOrDefault(r => r.MaHang == MaHang);
                                if (exitProdInList == null)
                                {
                                    oImportProduct_ChiTietChuyenKho newRecpPro = new oImportProduct_ChiTietChuyenKho(
                                      tblHangHoa.IDHangHoa,
                                      tblHangHoa.MaHang,
                                      tblHangHoa.TenHangHoa,
                                      tblHangHoa.hhDonViTinh.TenDonViTinh,
                                      Convert.ToInt32(tblHangHoa.hhTonKhos.Where(s => s.ChiNhanhID == Convert.ToInt32(ccbChiNhanhChuyen.Value.ToString())).FirstOrDefault().SoLuong),
                                      SoLuong,
                                      Convert.ToInt32(tblHangHoa.hhTonKhos.Where(s => s.ChiNhanhID == Convert.ToInt32(ccbChiNhanhNhan.Value.ToString())).FirstOrDefault().SoLuong)
                                    );
                                    listReceiptProducts.Add(newRecpPro);
                                }

                            }

                        }
                    }

                }
            }
            else
            {
                throw new Exception("File excel không đúng. Vui lòng kiểm tra lại!!");
            }
        }
        #endregion


        protected void Save()
        {
            using (var scope = new TransactionScope())
            {
                try
                {
                    if (listReceiptProducts.Count > 0)
                    {
                        double TongTien = 0;
                        int TongSoLuong = 0;
                        foreach (var prod in listReceiptProducts)
                        {
                            TongSoLuong += prod.SoLuong;
                        }
                        string MaPhieu = null, strMaPhieu = "CK";
                        string MAX = (DBDataProvider.DB.kChuyenKhos.Count() + 1).ToString();
                        for (int i = 1; i < (7 - MAX.Length); i++)
                        {
                            strMaPhieu += "0";
                        }
                        MaPhieu = strMaPhieu + MAX;
                        //Insert vào bảng chuyển kho
                        kChuyenKho chuyenkho = new kChuyenKho();
                        chuyenkho.ChiNhanhChuyenID = Convert.ToInt32(ccbChiNhanhChuyen.Value);
                        chuyenkho.ChiNhanhNhanID = Convert.ToInt32(ccbChiNhanhNhan.Value);
                        chuyenkho.MaPhieu = MaPhieu;
                        chuyenkho.NgayChuyen = dateNgayNhap.Date;
                        chuyenkho.NguoiNhapID = Formats.IDUser();
                        chuyenkho.TongSoLuong = TongSoLuong;
                        chuyenkho.GhiChu = memoGhiChu.Text;
                        chuyenkho.NgayTao = DateTime.Now;
                        chuyenkho.DaXoa = 0;
                        DBDataProvider.DB.kChuyenKhos.InsertOnSubmit(chuyenkho);
                        DBDataProvider.DB.SubmitChanges();

                        int IDChuyenKho = Convert.ToInt32(chuyenkho.IDPhieuChuyen);
                        foreach (var prod in listReceiptProducts)
                        {
                            kChuyenKhoChiTiet chitiet = new kChuyenKhoChiTiet();
                            chitiet.ChuyenKhoID = IDChuyenKho;
                            chitiet.HangHoaID = prod.IDHangHoa;
                            chitiet.SoLuong = prod.SoLuong;
                            chitiet.TonKhoChuyen = prod.TonChuyen;
                            chitiet.TonKhoNhan = prod.TonNhan;
                            DBDataProvider.DB.kChuyenKhoChiTiets.InsertOnSubmit(chitiet);
                            DBDataProvider.DB.SubmitChanges();

                           
                            var HH = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == prod.IDHangHoa).FirstOrDefault();
                            if (HH != null)
                            {
                                // trừ kho chuyển
                                #region ghi thẻ kho trừ
                                kTheKho thekho = new kTheKho();
                                thekho.NgayNhap = DateTime.Now;
                                thekho.DienGiai = "Chuyển kho #" + MaPhieu;
                                thekho.Nhap = 0;
                                thekho.Xuat = prod.SoLuong;
                                thekho.GiaThoiDiem = 0;
                                thekho.ChiNhanhID = Convert.ToInt32(ccbChiNhanhChuyen.Value);
                                thekho.Ton = HH.hhTonKhos.Where(s => s.ChiNhanhID == Convert.ToInt32(ccbChiNhanhChuyen.Value)).FirstOrDefault().SoLuong -= prod.SoLuong;
                                thekho.HangHoaID = prod.IDHangHoa;
                                thekho.NhanVienID = Formats.IDUser();
                                DBDataProvider.DB.kTheKhos.InsertOnSubmit(thekho);
                                #endregion

                                // cộng kho nhận
                                #region ghi thẻ kho
                                kTheKho thekho1 = new kTheKho();
                                thekho1.NgayNhap = DateTime.Now;
                                thekho1.DienGiai = "Chuyển kho #" + MaPhieu;
                                thekho1.Nhap = prod.SoLuong;
                                thekho1.Xuat = 0;
                                thekho1.GiaThoiDiem = 0;
                                thekho1.ChiNhanhID = Convert.ToInt32(ccbChiNhanhNhan.Value);
                                thekho1.Ton = HH.hhTonKhos.Where(s => s.ChiNhanhID == Convert.ToInt32(ccbChiNhanhNhan.Value)).FirstOrDefault().SoLuong += prod.SoLuong;
                                thekho1.HangHoaID = prod.IDHangHoa;
                                thekho1.NhanVienID = Formats.IDUser();
                                DBDataProvider.DB.kTheKhos.InsertOnSubmit(thekho1);
                                #endregion
                               
                            }
                        }
                        DBDataProvider.DB.SubmitChanges();
                        scope.Complete();
                        cbpInfoImport.JSProperties["cp_Reset"] = true;
                    }
                    else
                    {
                        throw new Exception("Danh sách chuyển kho trống !!");
                        ccbBarcode.Text = "";
                        ccbBarcode.Value = "";
                        ccbBarcode.Focus();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
    }
}