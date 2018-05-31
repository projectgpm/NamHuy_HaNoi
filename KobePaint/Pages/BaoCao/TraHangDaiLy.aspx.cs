﻿using DevExpress.Export;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using KobePaint.App_Code;
using KobePaint.Reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.BaoCao
{
    public partial class TraHangDaiLy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
            if (!IsPostBack)
            {
                hdfViewReport["view"] = 0;
            }
            if (hdfViewReport["view"].ToString() != "0")
            {
                if (hdfViewReport["view"].ToString() == "1")
                    reportViewer.Report = CreatReport();
                else
                    reportViewer.Report = CreatReportNoPrice();
                hdfViewReport["view"] = 0;
            }
        }
        rpPhieuTraHang CreatReport()
        {
            rpPhieuTraHang rp = new rpPhieuTraHang();
            rp.odsPhieuGiaoHang.DataSource = oReturnNodeReport;
            rp.CreateDocument();
            return rp;
        }
        rpPhieuTraHangNoPrice CreatReportNoPrice()
        {
            rpPhieuTraHangNoPrice rp = new rpPhieuTraHangNoPrice();
            rp.odsPhieuGiaoHang.DataSource = oReturnNodeReport;
            rp.CreateDocument();
            return rp;
        }
        private oReportGiaoHang oReturnNodeReport
        {
            get
            {
                return (oReportGiaoHang)Session["oReturnNodeReport"];
            }
            set
            {
                Session["oReturnNodeReport"] = value;
            }
        }
        protected void btnInPhieu_Init(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btn.NamingContainer as GridViewDataRowTemplateContainer;
            btn.ClientSideEvents.Click = String.Format("function(s, e) {{ onPrintClick({0}); }}", container.KeyValue);
        }
        protected void dateEditControl_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }
        protected void grid_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void btnXuatExcel_Click(object sender, EventArgs e)
        {
            exporterGrid.FileName = "Bao_Cao_Khach_Hang_Tra_Hang" + "_" + DateTime.Now.ToString("yy-MM-dd");
            exporterGrid.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }
        protected void cbpViewReport_Callback(object sender, CallbackEventArgsBase e)
        {
            int IDPhieuTraHang = int.Parse(e.Parameter);
            var PhieuTraHang = DBDataProvider.GetPhieuTraHang_DaiLy(IDPhieuTraHang);

            oReturnNodeReport = new oReportGiaoHang();
            oReturnNodeReport.MaKhachHang = PhieuTraHang.khKhachHang.MaKhachHang;
            oReturnNodeReport.TenKhachHang = PhieuTraHang.khKhachHang.HoTen;
            oReturnNodeReport.DienThoai = PhieuTraHang.khKhachHang.DienThoai;
            oReturnNodeReport.DiaChiGiaoHang = PhieuTraHang.khKhachHang.DiaChi;
            oReturnNodeReport.TenNhanVien = PhieuTraHang.nvNhanVien.HoTen;
            oReturnNodeReport.GhiChuGiaoHang = PhieuTraHang.GhiChu;
            oReturnNodeReport.NgayGiao = Formats.ConvertToVNDateString(PhieuTraHang.NgayTra.ToString());
            oReturnNodeReport.NgayTao = Formats.ConvertToVNDateString(PhieuTraHang.NgayNhap.ToString());
            oReturnNodeReport.TongTien = Convert.ToDouble(PhieuTraHang.TongTienHang);
            oReturnNodeReport.TieuDePhieu = "PHIẾU TRẢ HÀNG " + PhieuTraHang.STTDonHang;

            oReturnNodeReport.listProduct = new List<oProduct>();
            List<kPhieuTraHangChiTiet> ListHang = DBDataProvider.ListChiTietTraHang_DaiLy(IDPhieuTraHang);
            int i = 1;
            foreach (var Hang in ListHang)
            {
                oProduct prod = new oProduct();
                prod.STT = i++;
                prod.MaHang = Hang.hhHangHoa.MaHang;
                prod.TenHang = Hang.hhHangHoa.TenHangHoa;
                prod.TenDonViTinh = Hang.hhHangHoa.hhDonViTinh.TenDonViTinh;
                prod.SoLuong = Convert.ToInt32(Hang.SoLuong);
                prod.DonGia = Convert.ToDouble(Hang.TienTra);
                prod.ThanhTien = Convert.ToDouble(Hang.ThanhTien);
                oReturnNodeReport.listProduct.Add(prod);
            }
        }
    }
}