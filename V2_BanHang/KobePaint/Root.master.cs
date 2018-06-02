using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using System.Web.Security;
using KobePaint.App_Code;

namespace KobePaint {
    public partial class RootMaster : System.Web.UI.MasterPage {
        protected void Page_Load(object sender, EventArgs e) {
            if (Context.User.Identity.IsAuthenticated)
            {
                string[] infoUser = Context.User.Identity.Name.Split('-');
               
                if (!IsPostBack)
                {
                    switch (infoUser[2])
                    {
                        case "1": XmlDataSourceHeader.DataFile = "~/App_Data/MenuQuanTri.xml"; break;
                        case "2": XmlDataSourceHeader.DataFile = "~/App_Data/MenuVanPhong.xml"; break;
                        case "3": XmlDataSourceHeader.DataFile = "~/App_Data/MenuBanHang.xml"; break;
                        default: XmlDataSourceHeader.DataFile = "~/App_Data/MenuToanQuyen.xml"; break;
                    }
                    var thongtin = DBDataProvider.DB.chChiNhanhs.Where(x => x.IDChiNhanh == Formats.IDChiNhanh()).FirstOrDefault();
                    if (thongtin != null)
                        imgLogo.ImageUrl = thongtin.Logo.ToString();
                }
            }
            else
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
        }


        protected void btnDangXuat_Click1(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
        }
    }
}