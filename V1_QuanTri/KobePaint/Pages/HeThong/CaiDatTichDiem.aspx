<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="CaiDatTichDiem.aspx.cs" Inherits="KobePaint.Pages.HeThong.CaiDatTichDiem" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<dx:ASPxPopupControl ID="pcLogin" ClientInstanceName="pcLogin" runat="server"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        HeaderText="THÔNG TIN TÍCH ĐIỂM VÀ GIẢM GIÁ" ShowOnPageLoad="true" Modal="true" CloseAction="CloseButton"  PopupAction="None" Width="500px">
        <ClientSideEvents PopUp="function(s, e) { s.UpdatePosition(); }" />
        <HeaderStyle BackColor="#2196F3" Font-Bold="True" ForeColor="White" Font-Names="&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif" Font-Size="Large" />
        <FooterStyle HorizontalAlign="Center" />
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxFormLayout ID="formLayout" runat="server" Width="100%" DataSourceID="dsTichDiem">
                    <Items>
                        <dx:LayoutItem FieldName="TienSangDiem" Caption="Qui đổi tiền sang điểm" HelpText="(Đvt: 1 điểm)">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer6" runat="server" SupportsDisabledAttribute="True">
                                    <dx:ASPxSpinEdit ID="speTienSangDiem" DisplayFormatString="N0" runat="server" ToolTip="(VD: 10.000 = 1 điểm)" Number="0" MinValue="0" MaxValue ="1000000" AllowNull="false" >
                                        <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                             <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                             <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem FieldName="DiemSangTien" Caption="Qui đổi điểm sang tiền" HelpText="(Đvt: 1.000 đồng)">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer7" runat="server">
                                    <dx:ASPxSpinEdit ID="speDiemSangTien" DisplayFormatString="N0" ToolTip="(VD: 10 điểm = 1.000)" runat="server" Number="0" MinValue="0" MaxValue ="1000000" AllowNull="false" >
                                    <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                             <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Qui đổi điểm sang %" FieldName="DiemSangPhanTram" HelpText="(Đvt: 1%)">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                    <dx:ASPxSpinEdit ID="speDiemSangPhanTram" DisplayFormatString="N0" ToolTip="(VD: 10 điểm = 1%)" runat="server" Number="0" MinValue="0" MaxValue ="1000000" AllowNull="false" >
                                        <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                            <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                             <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Loại giảm giá" FieldName="LoaiGiamGia" HelpText="(% - $)">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server" SupportsDisabledAttribute="True">
                                    <dx:ASPxComboBox ID="ccbLoaiGiamGia" runat="server">
                                        <Items>
                                            <dx:ListEditItem Text="Giảm giá tiền" Value="0" />
                                            <dx:ListEditItem Text="Giảm giá %" Value="1" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                             <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                             <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                        </dx:LayoutItem>
                                           
                        <dx:LayoutItem Caption="Trạng thái" FieldName="TrangThaiGiamGia">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                    <dx:ASPxComboBox ID="ccbTrangThai" runat="server">
                                        <Items>
                                            <dx:ListEditItem Text="Không áp dụng giảm giá" Value="0" />
                                            <dx:ListEditItem Text="Áp dụng giảm giá" Value="1" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem HorizontalAlign="Center" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer8" runat="server">
                                    <dx:ASPxButton ID="btOK" runat="server" Text="Cập nhật" AutoPostBack="true" Width="150px" OnClick="btOK_Click">         
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
                <asp:SqlDataSource ID="dsTichDiem" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [TienSangDiem], [DiemSangTien], [DiemSangPhanTram], [TrangThaiGiamGia], [LoaiGiamGia] FROM [wsettings]"></asp:SqlDataSource>
            </dx:PopupControlContentControl>
        
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        
        </ContentStyle>
    
    </dx:ASPxPopupControl>
    <dx:ASPxGlobalEvents ID="ASPxGlobalEvents1" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	            pcLogin.UpdatePosition();
            }" />
    </dx:ASPxGlobalEvents>
    &nbsp;
  
</asp:Content>
