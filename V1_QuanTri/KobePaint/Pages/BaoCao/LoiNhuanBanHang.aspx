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
             UpdateHeightControlInPage(fromBaoCao, hformThongTin);
         }
         function onXemBaoCaoClick() {
             if (checkInput())
                 cbpInfo.PerformCallback('refresh');
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
    <dx:ASPxCallbackPanel ID="cbpInfo" ClientInstanceName="cbpInfo" runat="server" Width="100%" OnCallback="cbpInfo_Callback">
        <PanelCollection>
            <dx:PanelContent ID="PanelContent3" runat="server">
                 <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
              <Items>
                  <dx:LayoutGroup Caption="Báo cáo lợi nhuận bán hàng" ColCount="4" HorizontalAlign="Center">
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
    
                <dx:ASPxFormLayout ID="fromBaoCao" ClientInstanceName="fromBaoCao" runat="server" DataSourceID="dsLoiNhuan" Width="100%">
                    <Items>
                        <dx:LayoutGroup Caption="Lợi nhuận chi tiết" GroupBoxDecoration="HeadingLine" HorizontalAlign="Center">
                            <Items>
                                <dx:LayoutItem FieldName="DOANHTHUBANHANG" HelpText="(Đvt: đồng)" Caption="- Doanh thu bán hàng (1)">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speDoanhThuBanHang" runat="server" Number="0" ReadOnly ="true" DisplayFormatString="N0" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="GIAMTRUDOANHTHU" HelpText="(Đvt: đồng)" Caption="- Giảm trừ Doanh thu (2 = 2.1+2.2)">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speGiamTruDoanhThu" runat="server" Number="0" ReadOnly ="true" DisplayFormatString="N0" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="CHIETKHAUHOADON" HelpText="(Đvt: đồng)" Caption="--- Chiết khấu hóa đơn (2.1)" CaptionStyle-Font-Italic="true">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speChietKhauHoaDon" runat="server" Number="0" ReadOnly ="true" DisplayFormatString="N0" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="GIATRIBANHANGBITRALAI" HelpText="(Đvt: đồng)" Caption="--- Giá trị hàng bán bị trả lại (2.2)" CaptionStyle-Font-Italic="true">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speBanHangTraLai" runat="server" Number="0" ReadOnly ="true" DisplayFormatString="N0" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="DOANHTHUTHUAN" HelpText="(Đvt: đồng)" Caption="- Doanh thu thuần (3=1-2)">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speDoanhThuThuan" runat="server" Number="0" ReadOnly ="true" DisplayFormatString="N0" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="GIAVONHANGBAN" HelpText="(Đvt: đồng)" Caption="- Giá vốn hàng bán (4)">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speGiaVonNhanBan" runat="server" Number="0" ReadOnly ="true" DisplayFormatString="N0" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="LOINHUANGOPVEHANGBAN" HelpText="(Đvt: đồng)" Caption="- Lợi nhuận gộp về bán hàng (5=3-4)">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speLoiNhuanGopHangBan" runat="server" Number="0" ReadOnly ="true" DisplayFormatString="N0" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="CHIPHI" HelpText="(Đvt: đồng)" Caption="- Chi phí (6)">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speChiPhi" runat="server" Number="0"  DisplayFormatString="N0" ReadOnly="true" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="LOINHUANKINHDOANH" HelpText="(Đvt: đồng)" Caption="- Lợi nhuận từ hoạt động kinh doanh (7=5-6)">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speLoiNhuanKinhDoanh" runat="server" Number="0" ReadOnly ="true" DisplayFormatString="N0" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="THUNHAPKHAC" HelpText="(Đvt: đồng)" Caption="- Thu nhập khác (8)">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speThuNhapKhac" runat="server" Number="0" ReadOnly ="true" DisplayFormatString="N0" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>

                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="CHIPHIKHAC" HelpText="(Đvt: đồng)" Caption="- Chi phí khác (9)">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speChiPhiKhac" runat="server" Number="0" ReadOnly ="true" DisplayFormatString="N0" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                                <dx:LayoutItem FieldName="LOINHUANTHUAN" HelpText="(Đvt: đồng)" Caption="- Lợi nhuận thuần (10=(7+8)-9)">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="speLoiNhuanThuan" runat="server" Font-Bold="true"  Number="0" ReadOnly ="true" DisplayFormatString="N0" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                      <HelpTextSettings Position="Right" VerticalAlign="Middle" />
                                     <HelpTextStyle ForeColor="#00CC00" Wrap="False"></HelpTextStyle>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                      </dx:ASPxFormLayout>
                <asp:SqlDataSource ID="dsLoiNhuan" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="spLoiNhuanBanHang" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="formThongTin$fromDay" Name="TuNgay" PropertyName="Value" Type="DateTime" ConvertEmptyStringToNull="true" DefaultValue="" />
                        <asp:ControlParameter ControlID="formThongTin$toDay" Name="DenNgay" PropertyName="Value" Type="DateTime" ConvertEmptyStringToNull="true" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
             </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>
</asp:Content>
