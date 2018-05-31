<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PheDuyetGiaoHang.ascx.cs" Inherits="KobePaint.Pages.GiaoHang.PheDuyetGiaoHang" %>
<script type="text/javascript">
    var timeout;
    function scheduleGridUpdate(grid) {
        window.clearTimeout(timeout);
        timeout = window.setTimeout(
            function () { gridDonHang.Refresh(); },
            300000
        );
    }
    function gridDonHang_Init(s, e) {
        scheduleGridUpdate(s);
    }
    function gridDonHang_BeginCallback(s, e) {
        window.clearTimeout(timeout);
    }
    function gridDonHang_EndCallback(s, e) {
        scheduleGridUpdate(s);
    }
    </script>
<%@ Register assembly="DevExpress.XtraReports.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>
<dx:ASPxGridView ID="gridDonHang" ClientInstanceName="gridDonHang" runat="server" AutoGenerateColumns="False" DataSourceID="dsDonHang" KeyFieldName="IDPhieuGiaoHang" Width="100%" OnCustomColumnDisplayText="gridDonHang_CustomColumnDisplayText" OnRowUpdating="gridDonHang_RowUpdating">
    <ClientSideEvents Init="gridDonHang_Init" BeginCallback="gridDonHang_BeginCallback" EndCallback="gridDonHang_EndCallback" />  
      <SettingsEditing Mode="Batch">
        </SettingsEditing>
     <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowTitlePanel="True"/>
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
            <UpdateButton>
                <Image IconID="save_save_32x32" ToolTip="Lưu tất cả thay đổi">
                </Image>
            </UpdateButton>
            <CancelButton>
                <Image IconID="actions_close_32x32">
                </Image>
            </CancelButton>
        </SettingsCommandButton>
        <%--<ClientSideEvents endcallback="onEndCallBack" />--%>
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="gridChiTietHang" runat="server" AutoGenerateColumns="False" DataSourceID="dsChiTietDonHang" KeyFieldName="ID" OnBeforePerformDataSelect="gridChiTietHang_BeforePerformDataSelect" OnCustomColumnDisplayText="gridChiTietHang_CustomColumnDisplayText" Width="100%">
                    <settings showtitlepanel="True" />
                    <settingstext title="CHI TIẾT GIAO HÀNG" />
                    <SettingsPager Mode="ShowAllRecords">
                    </SettingsPager>
                    <SettingsCommandButton>
                        <ShowAdaptiveDetailButton ButtonType="Image">
                        </ShowAdaptiveDetailButton>
                        <HideAdaptiveDetailButton ButtonType="Image">
                        </HideAdaptiveDetailButton>
                    </SettingsCommandButton>
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" VisibleIndex="0">
                            <EditFormSettings Visible="False" />
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Hàng hóa" FieldName="TenHangHoa" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Giá vốn" FieldName="GiaVon" VisibleIndex="3">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Mã hàng" FieldName="MaHang" VisibleIndex="1">
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Giá bán" FieldName="GiaBan" VisibleIndex="5">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Số lượng" FieldName="SoLuong" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Thành tiền" FieldName="ThanhTien" VisibleIndex="8">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                    </Columns>

                    <Styles>
                        <Header HorizontalAlign="Center" forecolor="#009933">
                            <Border BorderStyle="Dashed" />
                        </Header>
                        <Cell>
                            <Border BorderStyle="Dashed" />
                        </Cell>
                        <titlepanel font-bold="True" font-size="13px" forecolor="#009933" BackColor="#F4F4F4">
                        </titlepanel>
                    </Styles>
                    <Border BorderColor="Silver" BorderStyle="Solid" />   
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="dsChiTietDonHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT hhHangHoa.MaHang, hhHangHoa.TenHangHoa, ghPhieuGiaoHangChiTiet.ID, ghPhieuGiaoHangChiTiet.SoLuong, ghPhieuGiaoHangChiTiet.ThanhTien, ghPhieuGiaoHangChiTiet.TonKho, ghPhieuGiaoHangChiTiet.GiaBan, ghPhieuGiaoHangChiTiet.GiaVon FROM ghPhieuGiaoHangChiTiet INNER JOIN hhHangHoa ON ghPhieuGiaoHangChiTiet.HangHoaID = hhHangHoa.IDHangHoa WHERE (ghPhieuGiaoHangChiTiet.PhieuGiaoHangID = @PhieuGiaoHangID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="PhieuGiaoHangID" SessionField="PhieuGiaoHangID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." CommandBatchEditCancel="Hủy bỏ" CommandBatchEditUpdate="Lưu" />
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="IDPhieuGiaoHang" ReadOnly="True" VisibleIndex="0" Width="40px">
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Số đơn hàng" FieldName="SoHoaDon" VisibleIndex="4">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Ngày đặt hàng" FieldName="NgayTao" VisibleIndex="5" ReadOnly="true">
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormat="Custom" EditFormatString="dd/MM/yyyy">
                    

<CalendarProperties FirstDayOfWeek="Monday" ShowClearButton="False" ShowTodayButton="False" ShowWeekNumbers="False" ClearButtonText="Hủy">
                        

<FastNavProperties Enabled="False" />
                    

</CalendarProperties>
                

</PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn Caption="Ngày xuất hàng" FieldName="NgayGiao" VisibleIndex="6" ReadOnly="true">
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormat="Custom" EditFormatString="dd/MM/yyyy">
                    

<CalendarProperties FirstDayOfWeek="Monday" ShowClearButton="False" ShowTodayButton="False" ShowWeekNumbers="False" ClearButtonText="Hủy">
                        

<FastNavProperties Enabled="False" />
                    

</CalendarProperties>
                

</PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Ghi chú" FieldName="GhiChuGiaoHang" VisibleIndex="7" ReadOnly="true">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="NV Đặt hàng" FieldName="NhanVienID" VisibleIndex="2" ReadOnly="true">
                <PropertiesComboBox DataSourceID="dsNhanVien" TextField="HoTen" ValueField="IDNhanVien">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="Khách hàng" FieldName="KhachHangID" VisibleIndex="3" ReadOnly="True" Width="150px">
                <PropertiesComboBox DataSourceID="dsKhachHang" TextField="HoTen" ValueField="IDKhachHang">
                </PropertiesComboBox>
                <EditFormSettings Visible="True" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataSpinEditColumn Caption="Tổng tiền" FieldName="TongTien" VisibleIndex="8" ReadOnly="True" CellStyle-Font-Bold ="true">
                <PropertiesSpinEdit DecimalPlaces="2" DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="True" />

<CellStyle Font-Bold="True"></CellStyle>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Số lượng hàng" FieldName="TongSoLuong" VisibleIndex="10" ReadOnly="true">
                <PropertiesSpinEdit DisplayFormatString="g" NumberType="Integer">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataTextColumn Caption="Địa chỉ giao hàng" FieldName="DiaChiGiaoHang" Width="150px" VisibleIndex="11" ReadOnly="true">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="Phê duyệt" FieldName="TrangThai" VisibleIndex="12" Width="150px" CellStyle-HorizontalAlign="Center" CellStyle-Font-Bold="true">
               <%-- <DataItemTemplate>
                    <dx:ASPxComboBox runat="server" ID="TrangThai"
                        Value='<%# Eval("TrangThai")%>' ValueType="System.Int32" Width="100%">
                    </dx:ASPxComboBox >
                </DataItemTemplate>--%>

<CellStyle HorizontalAlign="Center" Font-Bold="True">
<Paddings Padding="2px"></Paddings>
                </CellStyle>
                <PropertiesComboBox EnableFocusedStyle="False">
                    <Items>
                        <dx:ListEditItem Text="Đã đặt" Value="0" />
                        <dx:ListEditItem Text="Giao hàng" Value="1" />
                        <dx:ListEditItem Text="Hủy đơn hàng" Value="2" />
                    </Items>
                </PropertiesComboBox>
            <Settings AllowAutoFilter="False" AllowHeaderFilter="False" />

                 <CellStyle>
                    <Paddings Padding="2px" />
                </CellStyle>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataSpinEditColumn Caption="Giảm giá" FieldName="GiamGia" ReadOnly="True" VisibleIndex="9">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataComboBoxColumn Caption="Chi nhánh" FieldName="ChiNhanhID" VisibleIndex="1" Width="100px">
                <PropertiesComboBox DataSourceID="dsChiNhanh" TextField="TenChiNhanh" ValueField="IDChiNhanh">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
    <FormatConditions>
            <dx:GridViewFormatConditionTopBottom FieldName="TrangThai" Rule="TopPercent" Threshold="20" Format="YellowFillWithDarkYellowText" />
        </FormatConditions>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsChiNhanh" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDChiNhanh], [TenChiNhanh] FROM [chChiNhanh] WHERE ([DaXoa] = @DaXoa) ORDER BY [TenChiNhanh]">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>
    <asp:SqlDataSource ID="dsDonHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        SelectCommand="SELECT IDPhieuGiaoHang, NgayTao, MaPhieu, NhanVienID, GhiChuGiaoHang, KhachHangID, NgayGiao, NguoiGiao, DiaChiGiaoHang, DaXoa, TrangThai, TongSoLuong, TongTien, DienThoai, SoHoaDon, TTThanhToan, ThanhToan, ConLai, GiamGia FROM ghPhieuGiaoHang WHERE (TrangThai = 0)" 
        UpdateCommand="UPDATE gPhieuGiaoHang SET NgayDatHang = @NgayDatHang, NgayXuatHang = @NgayXuatHang, XeID = @XeID, TaiXeID = @TaiXeID, PheDuyet = @PheDuyet,  NgayDuyet = getdate() WHERE (IDPhieuGiaoHang = @IDPhieuGiaoHang)">
        <UpdateParameters>
            <asp:Parameter Name="NgayDatHang" Type="DateTime" />
            <asp:Parameter Name="NgayXuatHang" Type="DateTime" />
            <asp:Parameter Name="XeID" Type="Int32" />
            <asp:Parameter Name="TaiXeID" Type="Int32" />
            <asp:Parameter Name="PheDuyet" Type="Boolean" />
            <asp:Parameter Name="IDPhieuGiaoHang" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateHeightControlInPage(gridDonHang, 60);
        }" ControlsInitialized="function(s, e) {
	        UpdateHeightControlInPage(gridDonHang, 60);
        }" />
    </dx:ASPxGlobalEvents>
    <asp:SqlDataSource ID="dsNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDNhanVien], [HoTen] FROM [nvNhanVien] WHERE [DaXoa] = 0 AND [NhomID] <> 5"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsKhachHang" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDKhachHang], [HoTen] FROM [khKhachHang] WHERE [DaXoa] = 0"></asp:SqlDataSource>

    

