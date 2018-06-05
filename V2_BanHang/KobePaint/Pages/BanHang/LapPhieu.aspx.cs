using DevExpress.Web;
using KobePaint.App_Code;
using KobePaint.Reports;
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

namespace KobePaint.Pages.BanHang
{
    public partial class LapPhieu : System.Web.UI.Page
    {
        public List<oChiTietHoaDon> listReceiptProducts
        {
            get
            {
                if (Session["listReceiptProducts"] == null)
                    Session["listReceiptProducts"] = new List<oChiTietHoaDon>();
                return (List<oChiTietHoaDon>)Session["listReceiptProducts"];
            }
            set
            {
                Session["listReceiptProducts"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
            if (!IsPostBack)
            {
                dsNhaCungCap.SelectParameters["ChiNhanhID"].DefaultValue = Formats.IDChiNhanh().ToString();
                hdfViewReport["view"] = 0;
                ccbBarcode.Focus();
                listReceiptProducts = new List<oChiTietHoaDon>();
                ccbNhaCungCap.Value = "1";
                CongNo();
                
            }
            if (hdfViewReport["view"].ToString() == "2")
            {
                reportViewer.Report = CreatReport();
                hdfViewReport["view"] = 0;
            }
            if (hdfViewReport["view"].ToString() == "1" )
            {
                reportViewer.Report = CreatReport80();
                hdfViewReport["view"] = 0;
            }
            

        }
        rpBanHangChiNhanh CreatReport80()
        {
            rpBanHangChiNhanh rp = new rpBanHangChiNhanh();
            rp.odsPhieuGiaoHang.DataSource = oCusExport80;
            rp.CreateDocument();
            return rp;
        }
        rpPhieuGiaoHang CreatReport()
        {
            rpPhieuGiaoHang rp = new rpPhieuGiaoHang();
            rp.odsPhieuGiaoHang.DataSource = oCusExport;
            rp.CreateDocument();
            return rp;
        }
        private oReportBanHang80 oCusExport80
        {
            get
            {
                return (oReportBanHang80)Session["ocus80"];
            }
            set
            {
                Session["ocus80"] = value;
            }
        } 
        private oReportGiaoHang oCusExport
        {
            get
            {
                return (oReportGiaoHang)Session["ocus_PriewBanHang"];
            }
            set
            {
                Session["ocus_PriewBanHang"] = value;
            }
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
                case "price": GetPrice();  break;
                case "UnitChange": Unitchange(para[1]); BindGrid(); break;
                case "Save": Save(); DeleteListProducts(); CreateReportReview_Save(Convert.ToInt32(hiddenFields["IDPhieuMoi"].ToString())); Reset(); break;
                case "Review": CreateReportReview(); break;
                case "importexcel": BindGrid(); BindGrid(); break;
                case "xoahang": XoaHangChange(para[1]); break;
                case "UnitChange_GiamGia": Unitchange_GiamGia(para[1]); BindGrid(); break;
                default: InsertIntoGrid(); BindGrid(); break;
            }
        }

       

       
        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            switch (e.Parameter)
            {
                case "refresh": BindInfo(); break;
                case "giamgia": GiamGia(); break;
                case "renew": spTienGiamGia.Number = 0; break;
                case "khachhang": CongNo(); break;
                case "khachthanhtoan": KhachThanhToan(); break;
                case "lammoi": Reset(); break;
                default: break;
            }
        }

        #region report 
        private void CreateReportReview_Save(int IDPhieu)
        {
            hdfViewReport["view"] = 1;
            var PhieuGiaoHang = DBDataProvider.GetPhieuGiaoHang(IDPhieu);
            oCusExport = new oReportGiaoHang();
            oCusExport.MaKhachHang = PhieuGiaoHang.khKhachHang.MaKhachHang;
            oCusExport.TenKhachHang = PhieuGiaoHang.khKhachHang.HoTen;
            oCusExport.DienThoai = PhieuGiaoHang.DienThoai;
            oCusExport.DiaChiGiaoHang = PhieuGiaoHang.DiaChiGiaoHang;
            oCusExport.TenNhanVien = PhieuGiaoHang.nvNhanVien.HoTen;
            oCusExport.GhiChuGiaoHang = PhieuGiaoHang.GhiChuGiaoHang;
            oCusExport.NgayGiao = Formats.ConvertToVNDateString(PhieuGiaoHang.NgayGiao.ToString());
            oCusExport.NgayTao = Formats.ConvertToVNDateString(PhieuGiaoHang.NgayTao.ToString());
            oCusExport.TongSoLuong = Convert.ToInt32(PhieuGiaoHang.TongSoLuong);
            oCusExport.TongTien = Convert.ToDouble(PhieuGiaoHang.TongTien);
            oCusExport.ThanhToan = Convert.ToDouble(PhieuGiaoHang.ThanhToan);
            oCusExport.CongNoHienTai = Convert.ToDouble(PhieuGiaoHang.CongNoHienTai);
            oCusExport.SoHoaDon = PhieuGiaoHang.SoHoaDon;
            oCusExport.GiamGia = Convert.ToDouble(PhieuGiaoHang.GiamGia);
            oCusExport.SoDonHangTrongNam = PhieuGiaoHang.SoDonHangTrongNam.ToString();
            oCusExport.TieuDePhieu = "PHIẾU BÁN HÀNG " + PhieuGiaoHang.STTDonHang;
            string TrangThai = "";
            switch (PhieuGiaoHang.TrangThai)
            {
                case 0:
                    TrangThai = "(Đã đặt)";
                    break;
                case 1:
                    TrangThai = "(Kiêm phiếu xuất kho)";
                    break;
                case 3:
                    TrangThai = "(Kiêm phiếu xuất kho)";
                    break;
                default:
                    TrangThai = "(Đã hủy)";
                    break;
            }
            oCusExport.TrangThaiPhieu = TrangThai;
            oCusExport.listProduct = new List<oProduct>();
            List<ghPhieuGiaoHangChiTiet> ListHang = DBDataProvider.ListChiTietGiaoHang(IDPhieu);
            int i = 1;
            #region khổ 80
            oCusExport80 = new oReportBanHang80();
            oCusExport80.TenChiNhanh = PhieuGiaoHang.chChiNhanh.TenChiNhanh;
            oCusExport80.DienThoai = PhieuGiaoHang.chChiNhanh.DienThoai;
            oCusExport80.DiaChiChiNhanh = PhieuGiaoHang.chChiNhanh.DiaChi;
            oCusExport80.ThuNgan = PhieuGiaoHang.nvNhanVien.HoTen;
            oCusExport80.KhachHang = PhieuGiaoHang.khKhachHang.HoTen;
            oCusExport80.NgayBan = Formats.ConvertToVNDateString(PhieuGiaoHang.NgayGiao.ToString());
            oCusExport80.TongTien = Convert.ToDouble(PhieuGiaoHang.TongTien);
            oCusExport80.GiamGia = Convert.ToDouble(PhieuGiaoHang.GiamGia);
            oCusExport80.MaPhieu = PhieuGiaoHang.MaPhieu;
            oCusExport80.KhachCanTra = Convert.ToDouble((PhieuGiaoHang.TongTien - PhieuGiaoHang.GiamGia));
            oCusExport80.listProduct = new List<oChiTietBanHang80>();
            #endregion
            foreach (var Hang in ListHang)
            {
                oProduct prod = new oProduct();
                prod.STT = i++;
                prod.MaHang = Hang.hhHangHoa.MaHang;
                prod.TenHang = Hang.hhHangHoa.TenHangHoa;
                prod.TenDonViTinh = Hang.hhHangHoa.hhDonViTinh.TenDonViTinh;
                prod.SoLuong = Convert.ToInt32(Hang.SoLuong);
                prod.DonGia = Convert.ToDouble(Hang.GiaBan);
                prod.ThanhTien = Convert.ToDouble(Hang.ThanhTien);
                oCusExport.listProduct.Add(prod);
                #region khổ 80
                oChiTietBanHang80 pro = new oChiTietBanHang80();
                pro.TenHangHoa = Hang.hhHangHoa.TenHangHoa;
                pro.SoLuong = Convert.ToInt32(Hang.SoLuong);
                pro.DonGia = Convert.ToDouble(Hang.GiaBan);
                pro.ThanhTien = Convert.ToDouble(Hang.ThanhTien);
                oCusExport80.listProduct.Add(pro);
                #endregion
            }
            cbpInfoImport.JSProperties["cp_rpView"] = true;
        }

        private void CreateReportReview()
        {
            hdfViewReport["view"] = 2;
            oCusExport = new oReportGiaoHang();
            var KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == Convert.ToInt32(ccbNhaCungCap.Value.ToString())).FirstOrDefault();
            oCusExport.MaKhachHang = KH.MaKhachHang;
            oCusExport.TenKhachHang = KH.HoTen;
            oCusExport.DienThoai = KH.DienThoai;
            oCusExport.DiaChiGiaoHang = KH.DiaChi;
            oCusExport.TenNhanVien = Formats.NameUser();
            oCusExport.GhiChuGiaoHang = "";
            oCusExport.NgayGiao = Formats.ConvertToVNDateString(dateNgayNhap.Text);
            oCusExport.NgayTao = Formats.ConvertToVNDateString(DateTime.Now.ToString());
            oCusExport.GiamGia = Convert.ToDouble(spGiamGia.Number);
            oCusExport.CongNoHienTai = Convert.ToDouble(KH.CongNo);
            oCusExport.SoDonHangTrongNam = ".....";
            oCusExport.TieuDePhieu = "PHIẾU BÁN HÀNG ";
            oCusExport.TrangThaiPhieu = "(Xem trước)";
            oCusExport.listProduct = new List<oProduct>();
            oCusExport.ThanhToan = Convert.ToDouble(spKhachHangThoan.Number);// khách thanh toán
            #region khổ 80
            oCusExport80 = new oReportBanHang80();
            oCusExport80.TenChiNhanh = ".........................";
            oCusExport80.DienThoai = ".........................";
            oCusExport80.DiaChiChiNhanh = "(xem trước)";
            oCusExport80.ThuNgan = Formats.NameUser();
            oCusExport80.KhachHang = KH.HoTen;
           
            oCusExport80.NgayBan = Formats.ConvertToVNDateString(DateTime.Now.ToString());
            oCusExport80.MaPhieu = "275595";
            oCusExport80.listProduct = new List<oChiTietBanHang80>();
            #endregion
            int i = 1;
            double TongTien = 0;
            foreach (var Hang in listReceiptProducts)
            {
                TongTien += Hang.ThanhTien;
                oProduct prod = new oProduct();
                prod.STT = i++;
                prod.MaHang = Hang.MaHang;
                prod.TenHang = Hang.TenHangHoa;
                prod.TenDonViTinh = Hang.TenDonViTinh;
                prod.SoLuong = Convert.ToInt32(Hang.SoLuong);
                prod.DonGia = Convert.ToDouble(Hang.GiaBan);
                prod.ThanhTien = Convert.ToDouble(Hang.ThanhTien);
                oCusExport.listProduct.Add(prod);
                #region khổ 80
                oChiTietBanHang80 pro = new oChiTietBanHang80();
                pro.TenHangHoa = Hang.TenHangHoa;
                pro.SoLuong = Convert.ToInt32(Hang.SoLuong);
                pro.DonGia = Convert.ToDouble(Hang.GiaBan);
                pro.ThanhTien = Convert.ToDouble(Hang.ThanhTien);
                oCusExport80.listProduct.Add(pro);
                #endregion
            }
            oCusExport.TongTien = TongTien;
            oCusExport80.TongTien = TongTien;
            oCusExport80.GiamGia = Convert.ToDouble(spGiamGia.Number);
            oCusExport80.KhachCanTra = Convert.ToDouble(spThanhToan.Number);
            cbpInfoImport.JSProperties["cp_rpView"] = true;
        }
        #endregion

        private void KhachThanhToan()
        {
            double ThanhToan = Convert.ToDouble(spThanhToan.Number.ToString());
            double KhachThanhToan = Convert.ToDouble(spKhachHangThoan.Number.ToString());
            spTienTraKhach.Text = (KhachThanhToan - ThanhToan).ToString();
        }

        private void GiamGia()
        {
            BindInfo();
            spTienTraKhach.Number = 0;
            if (rdHinhThuc.SelectedIndex == 0)
            {
                // giảm VNĐ
                double TienGiamGia = Convert.ToDouble(spTienGiamGia.Number.ToString());
                spGiamGia.Text = (TienGiamGia).ToString();
                spThanhToan.Text = (Convert.ToDouble(spTongTien.Number) - TienGiamGia).ToString();
                spKhachHangThoan.Text = (Convert.ToDouble(spTongTien.Number) - TienGiamGia).ToString();
                hiddenTienGiamGia["GiamGia"] = TienGiamGia.ToString();
            }
            else
            {
                //giảm %
                double PhanTram = Convert.ToDouble(spTienGiamGia.Number.ToString());
                double TongTien = Convert.ToDouble(spTongTien.Number.ToString());
                double GiamGiaTien = (TongTien * (double)(PhanTram / 100));
                spGiamGia.Text = (GiamGiaTien).ToString();
                spThanhToan.Text = (TongTien- GiamGiaTien).ToString();
                spKhachHangThoan.Text = (TongTien - GiamGiaTien).ToString();
                hiddenTienGiamGia["GiamGia"] = PhanTram.ToString();
            }
        }
        

        #region lưu lại
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
                            TongTien += prod.ThanhTien;
                            TongSoLuong += prod.SoLuong;
                        }
                        string MaPhieu = null, strMaPhieu = "PX";
                        string MAX = (DBDataProvider.DB.ghPhieuGiaoHangs.Count() + 1).ToString();
                        for (int i = 1; i < (7 - MAX.Length); i++)
                        {
                            strMaPhieu += "0";
                        }
                        MaPhieu = strMaPhieu + MAX;

                        int IDkhachHang = Int32.Parse(ccbNhaCungCap.Value.ToString());
                        var KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDkhachHang).FirstOrDefault();
                        ghPhieuGiaoHang giaohang = new ghPhieuGiaoHang();
                        giaohang.NgayTao = DateTime.Now;
                        giaohang.MaPhieu = MaPhieu;
                        giaohang.ChiNhanhID = Formats.IDChiNhanh();
                        giaohang.NhanVienID = Formats.IDUser();
                        giaohang.GhiChuGiaoHang = "";
                        giaohang.KhachHangID = IDkhachHang;
                        giaohang.NgayGiao = Formats.ConvertToDateTime(dateNgayNhap.Text);
                        giaohang.NguoiGiao = "";
                        giaohang.DiaChiGiaoHang = KH.DiaChi;
                        giaohang.DaXoa = 0;
                        giaohang.TTThanhToan = 0; //0 chưa thanh toán. 1 đã thanh toán
                        giaohang.TrangThai = 3;// chưa duyệt, 1 đã duyệt, 3 bán hàng
                        giaohang.TongSoLuong = TongSoLuong;
                        giaohang.DienThoai = KH.DienThoai;
                        giaohang.TongTien = TongTien;
                        giaohang.NgayDuyet = DateTime.Parse(dateNgayNhap.Text);
                        giaohang.GiamGia = Convert.ToDouble(spGiamGia.Number);
                        giaohang.ThanhToan = Convert.ToDouble(spKhachHangThoan.Number);// khách thanh toán
                        giaohang.ConLai = TongTien - (Convert.ToDouble(spGiamGia.Number) + Convert.ToDouble(spKhachHangThoan.Number)); // (-1)*Convert.ToDouble(spTienTraKhach.Number);
                        giaohang.STTDonHang = DBDataProvider.STTPhieuGiaoHang_DaiLy(IDkhachHang);
                        giaohang.SoDonHangTrongNam = DBDataProvider.SoDonHangTrongNam_GiaoHang();
                        giaohang.CongNoHienTai = KH.CongNo;
                        DBDataProvider.DB.ghPhieuGiaoHangs.InsertOnSubmit(giaohang);
                        DBDataProvider.DB.SubmitChanges();
                        int IDPhieuGiaoHang =  Convert.ToInt32(giaohang.IDPhieuGiaoHang);
                        hiddenFields["IDPhieuMoi"] = IDPhieuGiaoHang;
                        foreach (var prod in listReceiptProducts)
                        {
                            // insert phiếu giao hàng chi tiết
                            ghPhieuGiaoHangChiTiet chitiet = new ghPhieuGiaoHangChiTiet();
                            chitiet.PhieuGiaoHangID = IDPhieuGiaoHang;
                            chitiet.HangHoaID = prod.IDHangHoa;
                            chitiet.TonKho = prod.TonKho;
                            chitiet.SoLuong = prod.SoLuong;
                            chitiet.GiaBan = prod.GiaBan;
                            chitiet.GiaVon = prod.GiaVon;
                            chitiet.ThanhTien = prod.ThanhTien;
                            DBDataProvider.DB.ghPhieuGiaoHangChiTiets.InsertOnSubmit(chitiet);
                            // trừ tạm tồn kho.
                            var TonKhoBanDau = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == prod.IDHangHoa).FirstOrDefault();
                            if (TonKhoBanDau != null)
                            {
                                TonKhoBanDau.hhTonKhos.Where(tk => tk.ChiNhanhID == Formats.IDChiNhanh()).FirstOrDefault().SoLuong -= prod.SoLuong;
                                var HH = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == prod.IDHangHoa).FirstOrDefault();
                                //ghi thẻ kho
                                #region thẻ kho
                                kTheKho thekho = new kTheKho();
                                thekho.NgayNhap = DateTime.Now;
                                thekho.DienGiai = "Bán hàng #" + giaohang.MaPhieu;
                                thekho.Nhap = 0;
                                thekho.Xuat = prod.SoLuong;
                                thekho.Ton = HH.hhTonKhos.Where(tk => tk.ChiNhanhID == Formats.IDChiNhanh()).FirstOrDefault().SoLuong;
                                thekho.ChiNhanhID = Formats.IDChiNhanh();
                                thekho.GiaThoiDiem = prod.GiaBan;
                                thekho.HangHoaID = HH.IDHangHoa;
                                thekho.NhanVienID = Formats.IDUser();
                                DBDataProvider.DB.kTheKhos.InsertOnSubmit(thekho);
                                #endregion
                            }
                        }
                        // tính điẻm
                        KH.TongTienHang += TongTien;
                        KH.LanCuoiMuaHang = DateTime.Now;

                        DBDataProvider.DB.SubmitChanges();
                        scope.Complete();
                        Reset();
                        cbpInfoImport.JSProperties["cp_Reset"] = true;
                    }
                    else
                    {
                        throw new Exception("Danh sách hàng hóa trống !!");
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
        #endregion

        protected void ccbNhaCungCap_Callback(object sender, CallbackEventArgsBase e)
        {
            ccbNhaCungCap.DataBind();
        }

        #region bind data hàng hóa
        protected void ccbBarcode_ItemRequestedByValue(object source, ListEditItemRequestedByValueEventArgs e)
        {
            long value = 0;
            if (e.Value == null || !Int64.TryParse(e.Value.ToString(), out value))
                return;
            ASPxComboBox comboBox = (ASPxComboBox)source;
            dsHangHoa.SelectCommand = @"SELECT hhHangHoa.IDHangHoa, hhHangHoa.MaHang, hhHangHoa.TenHangHoa, hhHangHoa.GiaBan,hhHangHoa.GiaVon
                                        FROM hhHangHoa
                                        WHERE (hhHangHoa.IDHangHoa = @IDHangHoa AND hhHangHoa.DaXoa = 0)";
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
                                                    
	                                        WHERE ((hhHangHoa.MaHang LIKE @MaHang) OR hhHangHoa.TenHangHoa LIKE @TenHang) AND hhHangHoa.DaXoa = 0	
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

        private void BindInfo()
        {
            double TongTien = 0;
            foreach (var prod in listReceiptProducts)
            {
                TongTien += prod.ThanhTien;
            }
            spTongTien.Text = TongTien.ToString();
            spThanhToan.Text = TongTien.ToString();
            spKhachHangThoan.Text = TongTien.ToString();
            spTienTraKhach.Number = 0;
        }
        private void BindGrid()
        {
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
        }
        private void DeleteListProducts()
        {
            listReceiptProducts = new List<oChiTietHoaDon>();
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
        }
        protected void Reset()
        {
            ccbNhaCungCap.SelectedIndex = -1;
            ccbNhaCungCap.Text = "";
            ccbNhaCungCap.Focus();
            spThanhToan.Number = 0;
            spTongTien.Number = 0;
            dateNgayNhap.Date = DateTime.Now;
            spGiamGia.Number = 0;
            spKhachHangThoan.Number = 0;
            spTienGiamGia.Number = 0;
            spTienGiamGia.Text = "0";
            spTienTraKhach.Number = 0;
            ccbBarcode.Text = "";
            rdHinhThuc.SelectedIndex = 0;
            txtTenBangGia.Text = "";
        }
        private void CongNo()
        {
            var KH = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == Convert.ToInt32(ccbNhaCungCap.Value.ToString())).FirstOrDefault();
            if (KH != null)
            {
                speDiemTichLuy.Text = KH.DiemTichLuy.ToString();
                txtTenBangGia.Text = KH.bgBangGia.TenBangGia;
            }
        }
        protected void GetPrice()
        {
            ccbBarcode.Text = "";
            ccbBarcode.Focus();
        }

        #region InsertHang
        protected void UpdateSTT()
        {
            ccbBarcode.Value = "";
            ccbBarcode.Text = "";
            speSoLuong.Number = 1;
            ccbBarcode.Focus();
            for (int i = 1; i <= listReceiptProducts.Count; i++)
            {
                listReceiptProducts[i - 1].STT = i;
            }
        }
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
            int tblHangHoa_Count = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == ID && x.DaXoa == 0).Count();
            if (tblHangHoa_Count > 0)
            {
                int IDKhachHang = Convert.ToInt32(ccbNhaCungCap.Value.ToString());
                var IDKhachHang_IDBangGia = DBDataProvider.DB.khKhachHangs.Where(x => x.IDKhachHang == IDKhachHang).FirstOrDefault();
                var tblHangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == ID && x.DaXoa == 0).FirstOrDefault();
                var exitProdInList = listReceiptProducts.SingleOrDefault(r => r.IDHangHoa == ID);
                if (exitProdInList == null)
                {
                    var GiaBan_IDKhachHang = DBDataProvider.DB.bgChiTietBangGias.Where(x => x.BangGiaID == IDKhachHang_IDBangGia.IDBangGia && x.HangHoaID == tblHangHoa.IDHangHoa && x.bgBangGia.DaXoa == 0).FirstOrDefault();
                    double GiaBan = GiaBan_IDKhachHang == null ? Convert.ToDouble(tblHangHoa.GiaBan) : Convert.ToDouble(GiaBan_IDKhachHang.GiaMoi);
                    oChiTietHoaDon cthd = new oChiTietHoaDon(
                        tblHangHoa.IDHangHoa,
                        tblHangHoa.MaHang,
                        tblHangHoa.TenHangHoa,
                        tblHangHoa.hhDonViTinh.TenDonViTinh,
                        Convert.ToInt32(tblHangHoa.hhTonKhos.Where(s=>s.ChiNhanhID == Convert.ToInt32(Formats.IDChiNhanh())).FirstOrDefault().SoLuong),
                        Convert.ToInt32(speSoLuong.Number),
                        GiaBan,
                        Convert.ToDouble(tblHangHoa.GiaVon),
                        GiaBan,
                        0, GiaBan * Convert.ToInt32(speSoLuong.Number)
                        );
                    listReceiptProducts.Add(cthd);
                }
                else
                {
                    exitProdInList.SoLuong += Convert.ToInt32(speSoLuong.Number);
                    exitProdInList.ThanhTien = exitProdInList.SoLuong * exitProdInList.GiaBan;
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
        #endregion

        #region xóa hàng
        protected void btnXoaHang_Init(object sender, EventArgs e)
        {
            ASPxButton btnButton = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btnButton.NamingContainer as GridViewDataRowTemplateContainer;
            btnButton.ClientSideEvents.Click = String.Format("function(s, e) {{ onXoaHangChanged({0}); }}", container.KeyValue);
        }
        private void XoaHangChange(string para)
        {
            int STT = Convert.ToInt32(para);
            var itemToRemove = listReceiptProducts.SingleOrDefault(r => r.STT == STT);
            if (itemToRemove != null)
            {
                listReceiptProducts.Remove(itemToRemove);
                UpdateSTT();
            }
            BindGrid();
        }
        #endregion


        #region cập nhật SL + DG
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
            sourceRow.SoLuong = UnitProductNew;
            sourceRow.ThanhTien = sourceRow.SoLuong * sourceRow.GiaBan;
        }
        private void Unitchange_GiamGia(string para)
        {
            int IDProduct = Convert.ToInt32(para);
            ASPxSpinEdit SpinEdit_GiamGia = gridImportPro.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridImportPro.Columns["Giảm giá"], "spGiamGiaReturn") as ASPxSpinEdit;
            double GiamGia = Convert.ToDouble(SpinEdit_GiamGia.Number);
            var sourceRow = listReceiptProducts.Where(x => x.STT == IDProduct).SingleOrDefault();
            double DonGiaHienTai = sourceRow.GiaBanCu;
            if (GiamGia >= 0 && GiamGia <= 100)
            {
                //giảm %
                double GiamGiaTien = (DonGiaHienTai * (double)(GiamGia / 100));
                if (GiamGia == 0)
                    sourceRow.GiaBan = DonGiaHienTai;
                else
                    sourceRow.GiaBan = DonGiaHienTai - GiamGiaTien;
            }
            else
            {
                //giảm tiền
                sourceRow.GiaBan = DonGiaHienTai - GiamGia;
            }
            sourceRow.GiamGia = GiamGia;
            sourceRow.ThanhTien = sourceRow.SoLuong * sourceRow.GiaBan;
        }
        #endregion

    }
}