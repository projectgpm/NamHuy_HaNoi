using DevExpress.Web;
using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.Kho
{
    public partial class DanhSachChuyenKho : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
        }

        protected void gridChiTietNhapKho_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridChiTietNhapKho_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["ChuyenKhoID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void gridNhaphang_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridNhaphang_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int IDChuyenKho = Convert.ToInt32(e.Keys[0].ToString());
            using (var scope = new TransactionScope())
            {
                try
                {
                    var ChuyenKho = DBDataProvider.DB.kChuyenKhos.Where(x => x.IDPhieuChuyen == IDChuyenKho).FirstOrDefault();
                    if (ChuyenKho != null)
                    {
                        ChuyenKho.DaXoa = 1;

                        List<kChuyenKhoChiTiet> chitiet = DBDataProvider.ChuyenKhoChiTiet(IDChuyenKho);
                        foreach (var nk in chitiet)
                        {
                            int IDHangHoa = Convert.ToInt32(nk.HangHoaID);
                            int SoLuong = Convert.ToInt32(nk.SoLuong);
                            var HangHoa = DBDataProvider.DB.hhHangHoas.Where(x => x.IDHangHoa == IDHangHoa).FirstOrDefault();
                            if (HangHoa != null)
                            {
                                // trừ kho chuyển
                                #region ghi thẻ kho trừ
                                kTheKho thekho = new kTheKho();
                                thekho.NgayNhap = DateTime.Now;
                                thekho.DienGiai = "Xóa phiếu chuyển kho #" + ChuyenKho.MaPhieu;
                                thekho.Nhap = SoLuong;
                                thekho.Xuat = 0;
                                thekho.GiaThoiDiem = 0;
                                thekho.ChiNhanhID = ChuyenKho.ChiNhanhChuyenID;
                                thekho.Ton = HangHoa.hhTonKhos.Where(s => s.ChiNhanhID == ChuyenKho.ChiNhanhChuyenID).FirstOrDefault().SoLuong += SoLuong;
                                thekho.HangHoaID = IDHangHoa;
                                thekho.NhanVienID = Formats.IDUser();
                                DBDataProvider.DB.kTheKhos.InsertOnSubmit(thekho);
                                #endregion

                                // cộng kho nhận
                                #region ghi thẻ kho
                                kTheKho thekho1 = new kTheKho();
                                thekho1.NgayNhap = DateTime.Now;
                                thekho1.DienGiai = "Xóa phiếu chuyển kho #" + ChuyenKho.MaPhieu;
                                thekho1.Nhap = 0;
                                thekho1.Xuat = SoLuong;
                                thekho1.GiaThoiDiem = 0;
                                thekho1.ChiNhanhID = ChuyenKho.ChiNhanhNhanID;
                                thekho1.Ton = HangHoa.hhTonKhos.Where(s => s.ChiNhanhID == ChuyenKho.ChiNhanhNhanID).FirstOrDefault().SoLuong -= SoLuong;
                                thekho1.HangHoaID = IDHangHoa;
                                thekho1.NhanVienID = Formats.IDUser();
                                DBDataProvider.DB.kTheKhos.InsertOnSubmit(thekho1);
                                #endregion
                            }
                        }
                        DBDataProvider.DB.SubmitChanges();
                        scope.Complete();
                    }

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            gridNhaphang.CancelEdit();
            e.Cancel = true;
            gridNhaphang.DataBind();
        }
    }
}