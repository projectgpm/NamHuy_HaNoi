<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CanhBaoCongNo.ascx.cs" Inherits="KobePaint.Pages.HeThong.CanhBaoCongNo" %>
  <script type="text/javascript">
      function ShowPopup(elementID, paras) {
          cbpInfoStep.PerformCallback(paras);
          popupInfoStep.ShowAtElementByID(elementID);
      }
      function HidePopup() {
          popupInfoStep.Hide();
      }
    </script>
    <dx:ASPxGridView ID="gridDanhSachKH" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridDanhSachKH" DataSourceID="dsKhachHang" KeyFieldName="IDKhachHang" Width="100%" OnHtmlDataCellPrepared="gridDanhSachKH_HtmlDataCellPrepared" OnCustomColumnDisplayText="gridDanhSachKH_CustomColumnDisplayText">
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="HanMucCongNo" Expression="[CongNo] > [HanMucCongNo] && [HanMucCongNo] != 0" Format="LightRedFillWithDarkRedText" />                       
        </FormatConditions>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowTitlePanel="False"/>
        <SettingsBehavior  ConfirmDelete="True" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
            <UpdateButton ButtonType="Image" RenderMode="Image">
                <Image IconID="save_save_32x32">
                </Image>
            </UpdateButton>
            <CancelButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_close_32x32">
                </Image>
            </CancelButton>
            <EditButton ButtonType="Image" RenderMode="Image">
                <Image IconID="mail_editcontact_16x16office2013" ToolTip="Cập nhật">
                </Image>
            </EditButton>
            <DeleteButton ButtonType="Image" RenderMode="Image">
                <Image IconID="edit_delete_16x16" ToolTip="Xóa">
                </Image>
            </DeleteButton>
        </SettingsCommandButton>
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin khách hàng cần tìm..." Title="DANH SÁCH KHÁCH HÀNG" ConfirmDelete="Xác nhận xóa !!" />
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="IDKhachHang" ReadOnly="True" VisibleIndex="0" Width="40px">
                <EditFormSettings Visible="False" />
                <Settings AllowAutoFilter="False" AllowFilterBySearchPanel="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Mã KH" FieldName="MaKhachHang" VisibleIndex="2" Width="100px">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Họ tên" FieldName="HoTen" VisibleIndex="3" CellStyle-Font-Bold="true" Width="100%">
<CellStyle Font-Bold="True"></CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DiaChi" VisibleIndex="5" Caption="Địa chỉ" Width="120px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Điện thoại" FieldName="DienThoai" VisibleIndex="4" Width="100px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Lần cuối mua hàng" FieldName="LanCuoiMuaHang" VisibleIndex="8" Width="130px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yy H:mm" EditFormat="Custom" EditFormatString="dd/MM/yy H:mm:ss">
                </PropertiesDateEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataSpinEditColumn Caption="Tổng tiền hàng" FieldName="TongTienHang" VisibleIndex="9" Width="120px">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Nợ" FieldName="CongNo" VisibleIndex="12" CellStyle-Font-Bold="true" Width="120px" >
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="False" />

<CellStyle Font-Bold="True"></CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataComboBoxColumn Caption="Loại khách hàng" FieldName="LoaiKhachHangID" VisibleIndex="1" Width="120px">
                <PropertiesComboBox DataSourceID="dsLoaiKhachHang" TextField="TenLoaiKhachHang" ValueField="IDLoaiKhachHang">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataSpinEditColumn Caption="Hạn mức công nợ" FieldName="HanMucCongNo" VisibleIndex="6" Width="120px">
                <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N0" NumberFormat="Custom">
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Thời hạn thanh toán" FieldName="ThoiHanThanhToan" VisibleIndex="7" Width="150px">
                <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N0" NumberFormat="Custom">
                    <ValidationSettings>
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
        </Columns>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight Expression="[TienTTConLai] &gt;= [HanMucCongNo] And [HanMucCongNo] &lt;&gt; 0" FieldName="TienTTConLai" Format="Custom">
                <CellStyle BackColor="LightPink" ForeColor="DarkRed">
                </CellStyle>
            </dx:GridViewFormatConditionHighlight>
        <dx:GridViewFormatConditionHighlight Expression="[CongNo] &gt; [HanMucCongNo] &amp;&amp; [HanMucCongNo] != 0" FieldName="HanMucCongNo"></dx:GridViewFormatConditionHighlight>
        </FormatConditions>
        <Styles>
            <Header HorizontalAlign="Center">
                <Paddings Padding="3px" />
            </Header>
            <GroupRow ForeColor="#428BCA">
            </GroupRow>
            <Cell>
                <Paddings PaddingBottom="3px" PaddingTop="3px" />
            </Cell>
            <GroupPanel>
                <Paddings Padding="0px" />
            </GroupPanel>
            <FilterCell>
                <Paddings Padding="0px" />
            </FilterCell>
            <SearchPanel>
                <Paddings PaddingBottom="5px" PaddingTop="5px" />
            </SearchPanel>
        </Styles>
        <Paddings Padding="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsLoaiKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [TenLoaiKhachHang], [IDLoaiKhachHang] FROM [khLoaiKhachHang] WHERE (([DaXoa] = @DaXoa) AND ([IDLoaiKhachHang] &lt;&gt; @IDLoaiKhachHang))">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
            <asp:Parameter DefaultValue="2" Name="IDLoaiKhachHang" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT IDKhachHang, LoaiKhachHangID, MaKhachHang, HoTen, DienThoai, DiaChi, GhiChu, Email, LanCuoiMuaHang, TongTienHang, MaSoThue, TienTraHang, CongNo, DaXoa, NgayTao, ThanhToan, IDBangGia, HanMucCongNo, ThoiHanThanhToan, TTThanhToan, NgayDuyet FROM View_HanMucCongNo WHERE (TTThanhToan = 0) AND (NgayDuyet IS NOT NULL) AND (DATEDIFF(DAY, NgayDuyet, GETDATE()) &gt; ThoiHanThanhToan)">
        <SelectParameters>
            <%--<asp:Parameter Name="DaXoa" Type="Int32" />--%>
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridDanhSachKH);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridDanhSachKH);
        }" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxPopupControl ID="popupInfoStep" runat="server" ClientInstanceName="popupInfoStep" ShowHeader="False" Width="300px">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <div id="contentPopup">
                    <dx:ASPxCallbackPanel ID="cbpInfoStep" ClientInstanceName="cbpInfoStep" runat="server" OnCallback="cbpInfoStep_Callback" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent ID="PanelContent1" runat="server">
                                <asp:Literal ID="litNoiDung" runat="server"></asp:Literal>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>