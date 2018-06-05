using KobePaint.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.HeThong
{
    public partial class CaiDatTichDiem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
        }

        protected void btOK_Click(object sender, EventArgs e)
        {
            var _tichdiem = DBDataProvider.DB.wsettings.Where(x=>x.ID == 1).SingleOrDefault();
            if (_tichdiem != null)
            {
                _tichdiem.TienSangDiem = Convert.ToDouble(speTienSangDiem.Number);
                _tichdiem.DiemSangTien = Convert.ToDouble(speDiemSangTien.Number);
                _tichdiem.DiemSangPhanTram = Convert.ToDouble(speDiemSangPhanTram.Number);
                _tichdiem.TrangThaiGiamGia = Convert.ToInt32(ccbTrangThai.Value);
                _tichdiem.LoaiGiamGia = Convert.ToInt32(ccbLoaiGiamGia.Value);

            }
            DBDataProvider.DB.SubmitChanges();
        }
    }
}