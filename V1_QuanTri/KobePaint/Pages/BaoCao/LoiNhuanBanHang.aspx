<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="LoiNhuanBanHang.aspx.cs" Inherits="KobePaint.Pages.BaoCao.LoiNhuanBanHang" %>
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
    <dx:ASPxVerticalGrid ID="VerLoiNhuan" runat="server" Width="50%" DataSourceID="dsLoiNhuan">
        <Rows>
            <dx:VerticalGridSpinEditRow Caption="Lợi nhuận thuần (10=(7+8)-9)" FieldName="LOINHUANTHUAN" Fixed="False" Height="0" VisibleIndex="11">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
            <dx:VerticalGridSpinEditRow Caption="Chi phí khác (9)" FieldName="CHIPHIKHAC" Fixed="False" Height="0" VisibleIndex="10">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
            <dx:VerticalGridSpinEditRow Caption="Thu nhập khác (8)" FieldName="THUNHAPKHAC" Fixed="False" Height="0" VisibleIndex="9">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
            <dx:VerticalGridSpinEditRow Caption="Lợi nhuận từ hoạt động kinh doanh (7=5-6)" FieldName="LOINHUANKINHDOANH" Fixed="False" Height="0" VisibleIndex="8">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
            <dx:VerticalGridSpinEditRow Caption="Chi phí (6)" FieldName="CHIPHI" Fixed="False" Height="0" VisibleIndex="7">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
            <dx:VerticalGridSpinEditRow Caption="Lợi nhuận gộp về bán hàng (5=3-4)" FieldName="LOINHUANGOPVEHANGBAN" Fixed="False" Height="0" VisibleIndex="6">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
            <dx:VerticalGridSpinEditRow Caption="Giá vốn hàng bán (4)" FieldName="GIAVONHANGBAN" Fixed="False" Height="0" VisibleIndex="5">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
            <dx:VerticalGridSpinEditRow Caption="Doanh thu thuần (3=1-2)" FieldName="DOANHTHUTHUAN" Fixed="False" Height="0" VisibleIndex="4">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
            <dx:VerticalGridSpinEditRow Caption="- Giá trị hàng bán bị trả lại (2.2)" FieldName="GIATRIBANHANGBITRALAI" Fixed="False" Height="0" VisibleIndex="3">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
            <dx:VerticalGridSpinEditRow Caption="- Chiết khấu hóa đơn (2.1)" FieldName="CHIETKHAUHOADON" Fixed="False" Height="0" VisibleIndex="2">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
            <dx:VerticalGridSpinEditRow Caption="Giảm trừ Doanh thu (2 = 2.1+2.2)" FieldName="GIAMTRUDOANHTHU" Fixed="False" Height="0" VisibleIndex="1">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
            <dx:VerticalGridSpinEditRow Caption="Doanh thu bán hàng (1)" FieldName="DOANHTHUBANHANG" Fixed="False" Height="0" VisibleIndex="0">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
            </dx:VerticalGridSpinEditRow>
        </Rows>
<SettingsPager Mode="ShowAllRecords"></SettingsPager>
          </dx:ASPxVerticalGrid>
      
          <asp:SqlDataSource ID="dsLoiNhuan" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="spLoiNhuanBanHang" SelectCommandType="StoredProcedure">
              <SelectParameters>
                 <asp:ControlParameter ControlID="formThongTin$fromDay" Name="TuNgay" PropertyName="Value" Type="DateTime" ConvertEmptyStringToNull="true" DefaultValue="" />
            <asp:ControlParameter ControlID="formThongTin$toDay" Name="DenNgay" PropertyName="Value" Type="DateTime" ConvertEmptyStringToNull="true" DefaultValue="" />
              </SelectParameters>
          </asp:SqlDataSource>
      
      <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
          <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
      </dx:ASPxGlobalEvents>
</asp:Content>
