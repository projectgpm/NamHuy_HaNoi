<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="BaoCaoChuyenKho.aspx.cs" Inherits="KobePaint.Pages.BaoCao.BaoCaoChuyenKho" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <style>


        .dxflGroupCell_Material{
            padding: 0 5px;
        }
        .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > tbody > tr:first-child > .dxflGroupCell_Material > .dxflItem_Material, .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > .dxflChildInFirstRowSys > .dxflGroupCell_Material > .dxflItem_Material
        {
            padding-top: 1px;
        }
    </style>
     <script type="text/javascript">
         function AdjustSize() {
             var hformThongTin = formThongTin.GetHeight();
             UpdateHeightControlInPage(gridChiTietXuatKho, hformThongTin);
         }
         function onXemBaoCaoClick() {
             if (checkInput())
                 gridChiTietXuatKho.Refresh();
         }
         function checkInput() {
             if (fromDay.GetValue() == null) {
                 alert('Vui lòng chọn ngày xem báo cáo');
                 fromDay.Focus();
                 return false;
             }
             if (toDay.GetValue() == null) {
                 alert('Vui lòng chọn ngày xem báo cáo');
                 toDay.Focus();
                 return false;
             }
             return true;
         }
    </script>
      <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
          <Items>
              <dx:LayoutGroup Caption="Báo cáo chuyển kho chi tiết" ColCount="4" HorizontalAlign="Center">
                  <Items>
                      <dx:LayoutItem Caption="Từ ngày">
                          <LayoutItemNestedControlCollection>
                              <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                  <dx:ASPxDateEdit ID="fromDay" ClientInstanceName="fromDay" runat="server" OnInit="fromDay_Init">
                                  </dx:ASPxDateEdit>
                              </dx:LayoutItemNestedControlContainer>
                          </LayoutItemNestedControlCollection>
                      </dx:LayoutItem>
                      <dx:LayoutItem Caption="đến ngày">
                          <LayoutItemNestedControlCollection>
                              <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                  <dx:ASPxDateEdit ID="toDay" ClientInstanceName="toDay" runat="server" OnInit="dateEditControl_Init">
                                      <DateRangeSettings StartDateEditID="fromDay" />
                                  </dx:ASPxDateEdit>
                              </dx:LayoutItemNestedControlContainer>
                          </LayoutItemNestedControlCollection>
                      </dx:LayoutItem>
                      <dx:LayoutItem Caption="Xem báo cáo" ShowCaption="False">
                          <LayoutItemNestedControlCollection>
                              <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                  <dx:ASPxButton ID="btnXemBaoCao" runat="server" Text="Xem báo cáo" AutoPostBack="false">
                                      <ClientSideEvents Click="onXemBaoCaoClick" />
                                  </dx:ASPxButton>
                              </dx:LayoutItemNestedControlContainer>
                          </LayoutItemNestedControlCollection>
                      </dx:LayoutItem>
                      <dx:LayoutItem Caption="Xuất excel" ShowCaption="False">
                          <LayoutItemNestedControlCollection>
                              <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                  <dx:ASPxButton ID="btnXuatExcel" runat="server" Text="Xuất excel" OnClick="btnXuatExcel_Click">
                                  </dx:ASPxButton>
                              </dx:LayoutItemNestedControlContainer>
                          </LayoutItemNestedControlCollection>
                      </dx:LayoutItem>
                  </Items>
                  <SettingsItemCaptions Location="Left" />
              </dx:LayoutGroup>
          </Items>
          <Styles>
              <LayoutItem>
                  <Paddings PaddingTop="0px" />
              </LayoutItem>
          </Styles>
      </dx:ASPxFormLayout>
      <dx:ASPxGridView ID="gridChiTietXuatKho" ClientInstanceName="gridChiTietXuatKho" runat="server" AutoGenerateColumns="False" DataSourceID="dsChiTietNhapKho" KeyFieldName="ID" Width="100%" OnCustomColumnDisplayText="gridChiTietNhapKho_CustomColumnDisplayText">
          <Settings VerticalScrollBarMode="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowHeaderFilterButton="true"/>
          <SettingsCommandButton>
              <ShowAdaptiveDetailButton ButtonType="Image">
              </ShowAdaptiveDetailButton>
              <HideAdaptiveDetailButton ButtonType="Image">
              </HideAdaptiveDetailButton>
          </SettingsCommandButton>
          <SettingsText HeaderFilterCancelButton="Hủy" SearchPanelEditorNullText="Nhập thông tin cần tìm..." CommandBatchEditCancel="Hủy bỏ" CommandBatchEditUpdate="Lưu" PopupEditFormCaption="Cập nhật mã hóa đơn"  EmptyDataRow="Không có dữ liệu" CommandCancel="Hủy" ConfirmDelete="Bạn có chắc chắn muốn xóa?" HeaderFilterFrom="Từ" HeaderFilterLastMonth="Tháng trước" HeaderFilterLastWeek="Tuần trước" HeaderFilterLastYear="Năm trước" HeaderFilterNextMonth="Tháng sau" HeaderFilterNextWeek="Tuần sau" HeaderFilterNextYear="Năm sau" HeaderFilterOkButton="Lọc" HeaderFilterSelectAll="Chọn tất cả" HeaderFilterShowAll="Tất cả" HeaderFilterShowBlanks="Trống" HeaderFilterShowNonBlanks="Không trống" HeaderFilterThisMonth="Tháng này" HeaderFilterThisWeek="Tuần này" HeaderFilterThisYear="Năm nay" HeaderFilterTo="Đến" HeaderFilterToday="Hôm nay" HeaderFilterTomorrow="Ngày mai" HeaderFilterYesterday="Ngày hôm qua" />
          <SettingsPager PageSize="20">
              <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
          </SettingsPager>
          <Columns>
              <dx:GridViewDataTextColumn Caption="STT" ReadOnly="True" VisibleIndex="0" Width="40px" FieldName="ID">
                  <Settings AllowAutoFilter="False" ShowFilterRowMenu="False" />
                  <CellStyle HorizontalAlign="Center">
                  </CellStyle>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataDateColumn Caption="Ngày chuyển" VisibleIndex="3" FieldName="NgayChuyen">
                  <SettingsHeaderFilter>
                      <DateRangeCalendarSettings ClearButtonText="Bỏ" FirstDayOfWeek="Monday" ShowClearButton="False" ShowTodayButton="False" ShowWeekNumbers="False" TodayButtonText="Hôm nay" />
                      <DateRangePeriodsSettings ShowWeeksSection="False" />
                  </SettingsHeaderFilter>
                  <%--<CellStyle HorizontalAlign="Center">
                  </CellStyle>--%>
                  <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormat="Custom" EditFormatString="dd/MM/yyyy">
                      <CalendarProperties FirstDayOfWeek="Monday" ShowClearButton="False" ShowTodayButton="False" ShowWeekNumbers="False" ClearButtonText="Hủy" TodayButtonText="Hôm nay">
                          <FastNavProperties Enabled="False" />
                      </CalendarProperties>
                  </PropertiesDateEdit>
              </dx:GridViewDataDateColumn>
              <dx:GridViewDataDateColumn Caption="Ngày tạo" VisibleIndex="4" FieldName="NgayTao">
                  <SettingsHeaderFilter>
                      <DateRangeCalendarSettings ClearButtonText="Bỏ" FirstDayOfWeek="Monday" ShowClearButton="False" ShowTodayButton="False" ShowWeekNumbers="False" TodayButtonText="Hôm nay" />
                      <DateRangePeriodsSettings ShowWeeksSection="False" />
                  </SettingsHeaderFilter>
                 <%-- <CellStyle HorizontalAlign="Center">
                  </CellStyle>--%>
                  <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormat="Custom" EditFormatString="dd/MM/yyyy">
                      <CalendarProperties FirstDayOfWeek="Monday" ShowClearButton="False" ShowTodayButton="False" ShowWeekNumbers="False" ClearButtonText="Hủy" TodayButtonText="Hôm nay">
                          <FastNavProperties Enabled="False" />
                      </CalendarProperties>
                  </PropertiesDateEdit>
              </dx:GridViewDataDateColumn>
              <dx:GridViewDataTextColumn Caption="Mã phiếu" VisibleIndex="5" Width="150px" FieldName="MaPhieu">
                  <SettingsHeaderFilter Mode="CheckedList">
                  </SettingsHeaderFilter>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn Caption="Tên hàng hóa" CellStyle-Font-Bold="true" CellStyle-HorizontalAlign="Left" VisibleIndex="6" Width="200px" FieldName="TenHangHoa">
                  <SettingsHeaderFilter Mode="CheckedList">
                  </SettingsHeaderFilter>
                 <%-- <CellStyle HorizontalAlign="Center">
                  </CellStyle>--%>

<CellStyle HorizontalAlign="Left" Font-Bold="True"></CellStyle>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn Caption="Mã HH" VisibleIndex="7" FieldName="MaHang">
                  <SettingsHeaderFilter Mode="CheckedList">
                  </SettingsHeaderFilter>
                  <CellStyle HorizontalAlign="Center">
                  </CellStyle>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn Caption="ĐVT" VisibleIndex="8" FieldName="TenDonViTinh">
                  <CellStyle HorizontalAlign="Right">
                  </CellStyle>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn Caption="Số lượng" VisibleIndex="10" CellStyle-Font-Bold="true" FieldName="SoLuong">
<CellStyle Font-Bold="True"></CellStyle>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn Caption="Người nhập" VisibleIndex="12" FieldName="HoTen">
                  <CellStyle HorizontalAlign="Right">
                  </CellStyle>
                  <SettingsHeaderFilter Mode="CheckedList">
                  </SettingsHeaderFilter>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataComboBoxColumn Caption="Chi nhánh nhận" FieldName="ChiNhanhNhanID" VisibleIndex="2">
                  <PropertiesComboBox DataSourceID="dsChiNhanh" TextField="TenChiNhanh" ValueField="IDChiNhanh">
                  </PropertiesComboBox>
              </dx:GridViewDataComboBoxColumn>
              <dx:GridViewDataComboBoxColumn Caption="Chi nhánh chuyển" FieldName="ChiNhanhChuyenID" VisibleIndex="1">
                  <PropertiesComboBox DataSourceID="dsChiNhanh" TextField="TenChiNhanh" ValueField="IDChiNhanh">
                  </PropertiesComboBox>
              </dx:GridViewDataComboBoxColumn>
          </Columns>
          <TotalSummary>
              <dx:ASPxSummaryItem DisplayFormat="Tổng : {0:N0}" FieldName="SoLuong" ShowInColumn="Số lượng" SummaryType="Sum" />
          </TotalSummary>
          <Styles>
              <Footer Font-Bold="True">
              </Footer>
          </Styles>
      </dx:ASPxGridView>
      <asp:SqlDataSource ID="dsChiNhanh" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDChiNhanh], [TenChiNhanh] FROM [chChiNhanh] ORDER BY [TenChiNhanh]"></asp:SqlDataSource>
      <asp:SqlDataSource ID="dsChiTietNhapKho" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
         SelectCommand="spChuyenKho" SelectCommandType="StoredProcedure">
          <SelectParameters>
              <asp:ControlParameter ControlID="formThongTin$fromDay" Name="TuNgay" PropertyName="Value" Type="DateTime" />
              <asp:ControlParameter ControlID="formThongTin$toDay" Name="DenNgay" PropertyName="Value" Type="DateTime" />
          </SelectParameters>
      </asp:SqlDataSource>
      <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
          <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
      </dx:ASPxGlobalEvents>
      <dx:ASPxGridViewExporter ID="exporterGrid" runat="server" GridViewID="gridChiTietXuatKho">
      </dx:ASPxGridViewExporter>
</asp:Content>
