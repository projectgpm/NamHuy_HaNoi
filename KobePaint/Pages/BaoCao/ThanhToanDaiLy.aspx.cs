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
    public partial class ThanhToanDaiLy : System.Web.UI.Page
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
                reportViewer.Report = CreatReport();
                hdfViewReport["view"] = 0;
            }
        }
        private DevExpress.XtraReports.UI.XtraReport CreatReport()
        {
            rpPhieuThanhToan rp = new rpPhieuThanhToan();
            rp.odsPayNode.DataSource = oPhieuTTExport;
            rp.CreateDocument();
            return rp;

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
            exporterGrid.FileName = "Bao_Cao_KH_Thanh_Toan" + "_" + DateTime.Now.ToString("yy-MM-dd");
            exporterGrid.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }
        protected void cbpViewReport_Callback(object sender, CallbackEventArgsBase e)
        {
            int IDPhieuThu = int.Parse(e.Parameter);
            var PhieuTT = DBDataProvider.DB.ghPhieuDaiLyThanhToans.Where(x => x.IDPhieuThu == IDPhieuThu).SingleOrDefault();
            hdfViewReport["view"] = 1;
            oPhieuTTExport = new oThanhToan();
            oPhieuTTExport.NgayThu = DBDataProvider.TinhThanhCty() + ", " + Formats.ConvertToFullStringDate(DateTime.Parse(PhieuTT.NgayThu.ToString()));
            oPhieuTTExport.IDKhachHang = Convert.ToInt32(PhieuTT.KhachHangID);
            oPhieuTTExport.STTPhieuThu = Convert.ToInt32(PhieuTT.STTPhieuThu);
            oPhieuTTExport.TieuDe = "PHIẾU THANH TOÁN " + PhieuTT.STTPhieuThu;
            oPhieuTTExport.SoHoaDon = PhieuTT.SoHoaDon;
            oPhieuTTExport.TenKhachHang = PhieuTT.khKhachHang.HoTen;
            oPhieuTTExport.MaKhachHang = PhieuTT.khKhachHang.MaKhachHang;
            oPhieuTTExport.DienThoai = PhieuTT.khKhachHang.DienThoai;
            oPhieuTTExport.NoiDung = PhieuTT.NoiDung;
            oPhieuTTExport.SoTienThu = Convert.ToDouble(PhieuTT.SoTienThu);
            oPhieuTTExport.CongNoTruocThanhToan = Convert.ToDouble(PhieuTT.CongNoCu);
            oPhieuTTExport.CongNoSauThanhToan = Convert.ToDouble(PhieuTT.CongNoCu - PhieuTT.SoTienThu);
            ConvertNumToText num2Text = new ConvertNumToText();
            oPhieuTTExport.SoTienBangChu = num2Text.replace_special_word(PhieuTT.SoTienThu.ToString());
        }
        private oThanhToan oPhieuTTExport
        {
            get
            {
                return (oThanhToan)Session["oPhieuTT"];
            }
            set
            {
                Session["oPhieuTT"] = value;
            }
        }

        protected void fromDay_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl_AddDay(sender, e,-1);
        }
    }
}