using DevExpress.Web;
using KobePaint.App_Code;
using KobePaint.Reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.GiaoHang
{
    public partial class DanhSachGiaoHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
            else
            {
                if (!IsPostBack)
                {

                    dsKhachHang.SelectParameters["ChiNhanhID"].DefaultValue = Formats.IDChiNhanh().ToString();
                    dsGiaohang.SelectParameters["Quyen"].DefaultValue = Formats.PermissionUser().ToString();
                    dsGiaohang.SelectParameters["NhanVienID"].DefaultValue = Formats.IDUser().ToString();
                    hdfViewReport["view"] = 0;
                }
                if (hdfViewReport["view"].ToString() != "0")
                {
                    if (hdfViewReport["view"].ToString() == "1")
                        reportViewer.Report = CreatReport();
                    else if (hdfViewReport["view"].ToString() == "2")
                        reportViewer.Report = CreatReportNoPrice();
                    else
                        reportViewer.Report = CreatReport80();
                    hdfViewReport["view"] = 0;
                }
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
        rpPhieuGiaoHangNoPrice CreatReportNoPrice()
        {
            rpPhieuGiaoHangNoPrice rp = new rpPhieuGiaoHangNoPrice();
            rp.odsPhieuGiaoHang.DataSource = oCusExport;
            rp.CreateDocument();
            return rp;
        }
        protected void gridChiTietDonHang_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["PhieuGiaoHangID"] = (sender as ASPxGridView).GetMasterRowKeyValue(); 
        }

        protected void gridChiTietDonHang_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexGroupColumn(sender, e);
        }

        protected void gridGiaoHang_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexGroupColumn(sender, e);
        }

        protected void gridGiaoHang_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {

        }

        protected void btnInPhieu_Init(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btn.NamingContainer as GridViewDataRowTemplateContainer;
            btn.ClientSideEvents.Click = String.Format("function(s, e) {{ onPrintClick({0}); }}", container.KeyValue);
        }
        private oReportGiaoHang oCusExport
        {
            get
            {
                return (oReportGiaoHang)Session["ocus"];
            }
            set
            {
                Session["ocus"] = value;
            }
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
        protected void cbpViewReport_Callback(object sender, CallbackEventArgsBase e)
        {
            int IDPhieuGiaoHang = int.Parse(e.Parameter);
            var PhieuGiaoHang = DBDataProvider.GetPhieuGiaoHang(IDPhieuGiaoHang);
            //if (hdfViewReport["view"].ToString() != "3")
            //{
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
                List<ghPhieuGiaoHangChiTiet> ListHang = DBDataProvider.ListChiTietGiaoHang(IDPhieuGiaoHang);
                int i = 1;
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
            //}
            //else
            //{
                // khổ 80
                
            //}
        }
    }
}