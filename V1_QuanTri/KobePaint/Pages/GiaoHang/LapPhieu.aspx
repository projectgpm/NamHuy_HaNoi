﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="LapPhieu.aspx.cs" Inherits="KobePaint.Pages.GiaoHang.LapPhieu" %>
<%@ Register assembly="DevExpress.XtraReports.v16.1.Web, Version=16.1.2.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function AdjustSize() {
            var hInfoPanel = splImport.GetPaneByName('splpInfoImport').GetClientHeight();
            var hInfoLayout = flayoutInfosImport.GetHeight();
            gridImportPro.SetHeight(hInfoPanel - hInfoLayout);
        }
        function onKhachHangSelect() {
            cbpInfo.PerformCallback('khachhang');
            cbpInfoImport.PerformCallback('price');
        }
        function onGiamGiaClick() {
            popGiamGia.Show();
        }
        function GetPrice() {
            if (ccbNhaCungCap.GetSelectedIndex() == -1) {
                alert('Vui lòng chọn khách hàng');
                ccbBarcode.SetSelectedIndex(-1);
                ccbNhaCungCap.Focus();
            }
            else {
                if (ccbBarcode.GetSelectedIndex() != -1) {
                    cbpInfoImport.PerformCallback('price');
                }
            }
        }
        function onUnitReturnChanged_GiamGia(key) {
            cbpInfoImport.PerformCallback('UnitChange_GiamGia|' + key);
            cbpInfo.PerformCallback('giamgia');
        }
        function ImportProduct() {
            if (ccbNhaCungCap.GetSelectedIndex() == -1) {
                alert('Vui lòng chọn khách hàng');
                ccbBarcode.SetSelectedIndex(-1);
                ccbNhaCungCap.Focus();
            }
            else {
                cbpInfoImport.PerformCallback("import");
                //cbpInfo.PerformCallback('refresh');
                cbpInfo.PerformCallback('giamgia');
            }
            
        }

        function LoadNhacCungCap() {
            ccbNhaCungCap.PerformCallback();
        }
        function onSaveClick() {
            if (checkInput() && checkInputGiamGia() && confirm('Xác nhận thao tác ?')) {
                cbpInfoImport.PerformCallback('Save');
                cbpInfo.PerformCallback('lammoi');

            }
        }


        function onExcelClick() {
            popupViewExcel.Show();
        }

        function checkInput() {
            if (ccbNhaCungCap.GetSelectedIndex() == -1) {
                ccbBarcode.SetSelectedIndex(-1);
                ccbNhaCungCap.Focus();
                alert('Vui lòng chọn khách hàng');
                return false;
            }
            if (spThanhToan.GetValue() == null) {
                spThanhToan.Focus();
                alert('Vui lòng nhập số tiền thanh toán');
                return false;
            };
            if (spThanhToan.GetValue() > spTongTien.GetValue()) {
                spThanhToan.Focus();
                alert('Vui lòng nhập số tiền thanh toán nhỏ hơn hoặc bằng tổng tiền.');
                return false;
            };
            if (spThanhToan.GetValue() < 0) {
                spThanhToan.Focus();
                alert('Tiền thanh toán phải lớn hơn hoặc bằng 0.');
                return false;
            };
            return true;
        }

        function onReviewClick() {
            if (checkInput() && checkInputGiamGia())
                cbpInfoImport.PerformCallback('Review');
        }

        function onFileUploadComplete() {
            cbpInfoImport.PerformCallback('importexcel');
            //cbpInfo.PerformCallback('refresh');
            cbpInfo.PerformCallback('giamgia');
            popupViewExcel.Hide();
        }

        ///////////////////////////////////
        function onUnitReturnChanged(key) {
            cbpInfoImport.PerformCallback('UnitChange|' + key);
            cbpInfo.PerformCallback('giamgia');
           // cbpInfo.PerformCallback('refresh');
        }

        function endCallBackProduct(s, e) {
            if (s.cp_rpView) {
                hdfViewReport.Set('view', '1');
                popupViewReport.Show();
                reportViewer.GetViewer().Refresh();
                delete (s.cp_rpView);
            }
            if (s.cp_Reset) {
                cbpInfoImport.PerformCallback('Reset');
                delete (s.cp_Reset);
                ShowPopup(4000);
            }
        }
        function endCallBackInfo(s, e) {
            //if (s.cp_refresh) {
            //    cbpInfo.PerformCallback('refresh');
            //    delete (s.cp_refresh);
            //}
        }
        function btnApDungonClick() {
            if (checkInputGiamGia()) {
                cbpInfo.PerformCallback('giamgia');
                popGiamGia.Hide();
            }
        }
        function checkInputGiamGia() {
            if (rdHinhThuc.GetSelectedIndex() == 0 && spTienGiamGia.GetValue() < 0) {
                alert('Số tiền giảm giá phải lớn hơn 0');
                spTienGiamGia.Focus();
                return false;
            }
            if (rdHinhThuc.GetSelectedIndex() == 0 && spTienGiamGia.GetValue() > spTongTien.GetValue()) {
                alert('Số tiền giảm giá phải nhỏ hơn hoặc bằng tổng tiền');
                spTienGiamGia.Focus();
                return false;
            }
            if (rdHinhThuc.GetSelectedIndex() == 1 && (spTienGiamGia.GetValue() < 0 || spTienGiamGia.GetValue() > 100)) {
                //giảm giá %
                alert('Tỷ lệ giảm giá trong khoảng 0% đến 100%');
                spTienGiamGia.Focus();
                return false;
            }
            if (spTienGiamGia.GetValue() == null) {
                alert('Vui lòng nhập giảm giá');
                spTienGiamGia.Focus();
                return false;
            }
            return true;
        }
        function rdHinhThuconSelect() {
            cbpInfo.PerformCallback('renew');
        }
        function spKhachHangThoanNumberChange() {
            if (checkKhachThanhToan())
                cbpInfo.PerformCallback('khachthanhtoan');
        }
        function checkKhachThanhToan() {
            if (spKhachHangThoan.GetValue() > spThanhToan.GetValue()) {
                alert('Khách thanh toán phải nhỏ hơn hoặc bằng khách cần trả');
                spKhachHangThoan.Focus();
                return false;
            }
            if (spKhachHangThoan.GetValue() < 0) {
                alert('Khách thanh toán phải lớn hơn hoặc bằng 0');
                spKhachHangThoan.Focus();
                return false;
            }
            return true;
        }

        function onXoaHangChanged(key) {
            cbpInfoImport.PerformCallback('xoahang|' + key);
           // cbpInfo.PerformCallback('refresh');
            cbpInfo.PerformCallback('giamgia');
        }
    </script>

    <style>
        .dxflGroupCell_Material {
            padding: 0 5px;
        }

        .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > tbody > tr:first-child > .dxflGroupCell_Material > .dxflItem_Material, .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > .dxflChildInFirstRowSys > .dxflGroupCell_Material > .dxflItem_Material {
            padding-top: 1px;
        }
    </style>

    <dx:ASPxPanel ID="panelImport" runat="server" Width="100%" DefaultButton="btnImportToList">
        <PanelCollection>
            <dx:PanelContent ID="PanelContent1" runat="server">
                <dx:ASPxSplitter ID="splImport" runat="server" ClientInstanceName="splImport" FullscreenMode="True" Height="100%" SeparatorVisible="False" Width="100%" Orientation="Vertical">
                    <Styles>
                        <Pane>
                            <Paddings Padding="0px" />
                        </Pane>
                    </Styles>
                    <Panes>
                        <dx:SplitterPane Name="splpInfo">
                            <Panes>

                                <dx:SplitterPane MaxSize="350px" Name="splpInfoNCC"  >
                                    <ContentCollection>
                                        <dx:SplitterContentControl ID="SplitterContentControl1" runat="server">

                                             <dx:ASPxCallbackPanel SettingsLoadingPanel-Enabled="False"  ID="cbpInfo" ClientInstanceName="cbpInfo" runat="server" Width="100%" OnCallback="cbpInfo_Callback" >
                                                <PanelCollection>
                                                    <dx:PanelContent ID="PanelContent3" runat="server">
                                                        <dx:ASPxFormLayout ID="flayoutInfoNCC" runat="server" Width="100%">
                                                            <Items>
                                                                <dx:LayoutGroup Caption="Thông tin đơn hàng" GroupBoxDecoration="HeadingLine">
                                                                    <CellStyle>
                                                                        <Paddings Padding="0px" />
                                                                    </CellStyle>
                                                                    <ParentContainerStyle>
                                                                        <Paddings Padding="0px" />
                                                                    </ParentContainerStyle>
                                                                    <Items>
                                                                        
                                                                        <dx:LayoutItem Caption="Khách hàng">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="width: 90%">
                                                                                                <dx:ASPxComboBox ID="ccbNhaCungCap" TextFormatString="{0};{1}" ClientInstanceName="ccbNhaCungCap" runat="server" NullText="-- Chọn khách hàng --" Width="100%" DataSourceID="dsNhaCungCap" TextField="HoTen" ValueField="IDKhachHang" OnCallback="ccbNhaCungCap_Callback">
                                                                                                    <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" ValidationGroup="InfosInput">
                                                                                                        <RequiredField ErrorText="Chọn nhà cung cấp" IsRequired="True" />
                                                                                                    </ValidationSettings>
                                                                                                    <ClientSideEvents DropDown="function(s,e){ LoadNhacCungCap(); }" SelectedIndexChanged="onKhachHangSelect"></ClientSideEvents>
                                                                                                 <Columns>
                                                                                                        <dx:ListBoxColumn FieldName="MaKhachHang" Width="90px" Caption="Mã khách hàng" />
                                                                                                        <dx:ListBoxColumn FieldName="HoTen" Width="150px" Caption="Tên khách hàng" />
                                                                                                    </Columns>
                                                                                                </dx:ASPxComboBox>
                                                                                                <asp:SqlDataSource ID="dsNhaCungCap" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" SelectCommand="SELECT [IDKhachHang],[MaKhachHang], [HoTen] FROM [khKhachHang] WHERE ([LoaiKhachHangID] <> @LoaiKhachHangID) AND DaXoa = 0 ORDER BY IDKhachHang DESC">
                                                                                                    <SelectParameters>
                                                                                                        <asp:Parameter DefaultValue="2" Name="LoaiKhachHangID" Type="Int32" />
                                                                                                    </SelectParameters>
                                                                                                </asp:SqlDataSource>
                                                                                            </td>
                                                                                            <td style="width: 10%; padding-left: 10px;">
                                                                                                <dx:ASPxHyperLink ID="hpThemNCC" Target="_blank" runat="server" Text="Thêm" NavigateUrl="~/Pages/KhachHang/ThemKH.aspx" ImageUrl="~/images/plus.png"  ToolTip="Thêm mới">
                                                                                                </dx:ASPxHyperLink>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                           
                                                                        </dx:LayoutItem>
                                                                        <dx:LayoutItem Caption="Công nợ">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                                                                   <dx:ASPxTextBox ID="txtNo" NullText="0" ClientInstanceName="txtNo" DisplayFormatString="N0" Font-Bold="true" HorizontalAlign="Right"  Width="100%" ForeColor="Red" ReadOnly="true" runat="server">
                                                                                    </dx:ASPxTextBox>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                            <CaptionSettings Location="Left" />
                                                                        </dx:LayoutItem>
                                                                        <dx:LayoutItem Caption="Bảng giá">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                                                                    <dx:ASPxTextBox ID="txtTenBangGia" ClientInstanceName ="txtTenBangGia" Font-Bold="true" ForeColor="Red" runat="server" Width="100%" ReadOnly="true"></dx:ASPxTextBox>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                            <CaptionSettings Location="Left" />
                                                                        </dx:LayoutItem>
                                                                        <dx:LayoutItem Caption="Ngày bán">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                                                                    <dx:ASPxDateEdit ID="dateNgayNhap" runat="server" OnInit="dateEditControl_Init" Width="100%">
                                                                                        <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom">
                                                                                            <RequiredField ErrorText="Không được để trống" IsRequired="True" />
                                                                                        </ValidationSettings>
                                                                                    </dx:ASPxDateEdit>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                            <CaptionSettings Location="Left" />
                                                                        </dx:LayoutItem>
                                                                       
                                                                        <dx:LayoutItem Caption="Tổng tiền" FieldName="TongTien">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer13" runat="server">
                                                                                    <dx:ASPxSpinEdit AllowNull = "False" MinValue="0" MaxValue="10000000000"  Number="0" ID="spTongTien" ReadOnly="true" ClientInstanceName="spTongTien" DisplayFormatString="N0" Increment="5000" HorizontalAlign="Right" Width="100%" runat="server" Font-Bold="true" ForeColor="Blue">
                                                                                    <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                                                    </dx:ASPxSpinEdit>

                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                            <CaptionSettings Location="Left" />
                                                                        </dx:LayoutItem>
                                                                        <dx:LayoutItem Caption="Giảm giá">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer6" runat="server">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="width: 90%">
                                                                                                <dx:ASPxSpinEdit ID="spGiamGia" Number="0"  DisplayFormatString="N0" Increment="5000" HorizontalAlign="Right" Width="100%" runat="server" Font-Bold="true" ForeColor="Red" ReadOnly="true" ClientInstanceName="spGiamGia">
                                                                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons> 
                                                                                                </dx:ASPxSpinEdit>
                                                                                            </td>
                                                                                            <td style="width: 10%; padding-left: 10px;">
                                                                                                <dx:ASPxButton ID="btnGiamGia" runat="server" ClientInstanceName="btnGiamGia" AutoPostBack="false" RenderMode="Link">
                                                                                                    <ClientSideEvents Click="onGiamGiaClick" />
                                                                                                    <Image ToolTip="Áp giảm giá" Url="~/images/saleof.png">
                                                                                                    </Image>
                                                                                                </dx:ASPxButton>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                    
                                                                                    
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                            <CaptionSettings Location="Left" />
                                                                        </dx:LayoutItem>
                                                                      <dx:LayoutItem Caption="Khách cần trả" FieldName="ThanhToan">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer12" runat="server">
                                                                                    <dx:ASPxSpinEdit Number="0" AllowNull = "False" MinValue="0" MaxValue="10000000000" ReadOnly="true" ID="spThanhToan" ClientInstanceName="spThanhToan" DisplayFormatString="N0" Increment="5000" HorizontalAlign="Right" Width="100%" runat="server" Font-Bold="true" ForeColor="Blue">
                                                                                   <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                                                    </dx:ASPxSpinEdit>

                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                            <CaptionSettings Location="Left" />
                                                                        </dx:LayoutItem>
                                                                        <dx:LayoutItem Caption="Khách thanh toán">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer7" runat="server">
                                                                                    <dx:ASPxSpinEdit ID="spKhachHangThoan" AllowNull = "False" MinValue="0" MaxValue="10000000000" Number="0"  ClientInstanceName="spKhachHangThoan" DisplayFormatString="N0" Increment="5000" HorizontalAlign="Right" Width="100%" runat="server" Font-Bold="true" ForeColor="Blue">
                                                                                        <ClientSideEvents NumberChanged="spKhachHangThoanNumberChange" />
                                                                                        <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                                                    </dx:ASPxSpinEdit>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                            <CaptionSettings Location="Left" />
                                                                        </dx:LayoutItem>
                                                                        <dx:LayoutItem Caption="Tiền trả khách">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer8" runat="server">
                                                                                    <dx:ASPxSpinEdit ID="spTienTraKhach" AllowNull = "False" MinValue="0" MaxValue="10000000000" Number="0" ReadOnly="true" ClientInstanceName="spTienTraKhach" DisplayFormatString="N0" Increment="5000" HorizontalAlign="Right" Width="100%" runat="server" Font-Bold="true" ForeColor="Blue">
                                                                                        <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                                                    </dx:ASPxSpinEdit>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                            <CaptionSettings Location="Left" />
                                                                        </dx:LayoutItem>
                                                                          <dx:LayoutItem Caption="Ghi chú">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer9" runat="server">
                                                                                    <dx:ASPxMemo ID="memoGhiChu"  ClientInstanceName="memoGhiChu" runat="server" Rows="3" Width="100%"></dx:ASPxMemo>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                        </dx:LayoutItem>
                                                                    </Items>
                                                                </dx:LayoutGroup>
                                                            </Items>
                                                            <SettingsItemCaptions Location="Top" />
                                                        </dx:ASPxFormLayout>
                                                    </dx:PanelContent>
                                                </PanelCollection>
                                                <SettingsLoadingPanel Enabled="False"></SettingsLoadingPanel>
                                                 <ClientSideEvents EndCallback="endCallBackInfo" />
                                                </dx:ASPxCallbackPanel>

                                        </dx:SplitterContentControl>
                                    </ContentCollection>
                                </dx:SplitterPane>

                                <dx:SplitterPane Name="splpInfoImport">
                                    <ContentCollection>
                                        <dx:SplitterContentControl ID="SplitterContentControl2" runat="server">
                                            <dx:ASPxCallbackPanel  SettingsLoadingPanel-Enabled="False" ID="cbpInfoImport" ClientInstanceName="cbpInfoImport" runat="server" Width="100%" OnCallback="cbpInfoImport_Callback">
                                                <PanelCollection>
                                                    <dx:PanelContent ID="PanelContent2" runat="server">
                                                        <dx:ASPxFormLayout ID="flayoutInfosImport" ClientInstanceName="flayoutInfosImport" runat="server" Width="100%">
                                                            <Items>
                                                                <dx:LayoutGroup Caption="Thông tin giao hàng" ColCount="6" GroupBoxDecoration="HeadingLine">
                                                                    <Items>
                                                                        <dx:LayoutItem Caption="" ColSpan="4" ShowCaption="False" Width="100%">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer10" runat="server">
                                                                                    <dx:ASPxComboBox ID="ccbBarcode" runat="server" ValueType="System.String"
                                                                                        ClientInstanceName="ccbBarcode"
                                                                                        DropDownWidth="600" DropDownStyle="DropDown"
                                                                                        ValueField="IDHangHoa"
                                                                                        NullText="Nhập Barcode hoặc mã hàng" Width="100%" TextFormatString="{0} - {1}"
                                                                                        EnableCallbackMode="true" CallbackPageSize="20"
                                                                                        OnItemsRequestedByFilterCondition="ccbBarcode_ItemsRequestedByFilterCondition"
                                                                                        OnItemRequestedByValue="ccbBarcode_ItemRequestedByValue">
                                                                                        <Columns>
                                                                                            <dx:ListBoxColumn FieldName="MaHang" Width="50px" Caption="Mã Hàng" />
                                                                                            <dx:ListBoxColumn FieldName="TenHangHoa" Width="250px" Caption="Tên Hàng Hóa" />
                                                                                        </Columns>
                                                                                        <DropDownButton Visible="False">
                                                                                        </DropDownButton>
                                                                                    </dx:ASPxComboBox>
                                                                                    <asp:SqlDataSource ID="dsHangHoa" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>">
                                                                                        <SelectParameters>
                                                                                            <asp:Parameter DefaultValue="0" Name="DaXoa" Type="Int32" />
                                                                                        </SelectParameters>
                                                                                    </asp:SqlDataSource>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                        </dx:LayoutItem>
                                                                        <dx:LayoutItem Caption="" ShowCaption="False">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer11" runat="server">
                                                                                    <dx:ASPxButton ID="btnImportToList" runat="server" Text="Đưa vào DS" AutoPostBack="False">
                                                                                        <ClientSideEvents Click="ImportProduct" />
                                                                                    </dx:ASPxButton>
                                                                                    <dx:ASPxHiddenField ID="hiddenFields" runat="server"></dx:ASPxHiddenField>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                        </dx:LayoutItem>
                                                                        <dx:LayoutItem Caption="Excel" ShowCaption="False">
                                                                            <LayoutItemNestedControlCollection>
                                                                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer14" runat="server">
                                                                                    <dx:ASPxButton ID="btnExcel" runat="server" AutoPostBack="False" ClientInstanceName="btnExcel" Text="Nhập Excel">
                                                                                        <ClientSideEvents Click="onExcelClick" />
                                                                                    </dx:ASPxButton>
                                                                                </dx:LayoutItemNestedControlContainer>
                                                                            </LayoutItemNestedControlCollection>
                                                                        </dx:LayoutItem>
                                                                    </Items>
                                                                </dx:LayoutGroup>
                                                            </Items>
                                                            <SettingsItemCaptions Location="Top" />
                                                        </dx:ASPxFormLayout>

                                                        <dx:ASPxGridView ID="gridImportPro" ClientInstanceName="gridImportPro" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="STT">
                                                            <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFooter="True" />
                                                            <SettingsPager Mode="ShowAllRecords">
                                                            </SettingsPager>
                                                            <SettingsBehavior AllowSort="False" />
                                                            <SettingsCommandButton>
                                                                <ShowAdaptiveDetailButton ButtonType="Image">
                                                                </ShowAdaptiveDetailButton>
                                                                <HideAdaptiveDetailButton ButtonType="Image">
                                                                </HideAdaptiveDetailButton>
                                                                <DeleteButton ButtonType="Image" RenderMode="Image">
                                                                    <Image IconID="actions_cancel_16x16">
                                                                    </Image>
                                                                </DeleteButton>
                                                            </SettingsCommandButton>
                                                            <SettingsText EmptyDataRow="Chưa có dữ liệu" />
                                                            <Columns>
                                                                <dx:GridViewDataTextColumn Caption="STT" FieldName="STT" ShowInCustomizationForm="True" VisibleIndex="0" Width="40px">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn Caption="Tên hàng hóa" FieldName="TenHangHoa" ShowInCustomizationForm="True" VisibleIndex="2" Width="100%">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn Caption="Mã HH" FieldName="MaHang" ShowInCustomizationForm="True" VisibleIndex="1" Width="100px">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn Caption="Tồn" FieldName="TonKho" ShowInCustomizationForm="True" VisibleIndex="3" Width="50px">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataSpinEditColumn Caption="Thành tiền" FieldName="ThanhTien" ShowInCustomizationForm="True" VisibleIndex="8" Width="100px">
                                                                    <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                                                    </PropertiesSpinEdit>
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn Caption="Giá vốn" FieldName="GiaVon" ShowInCustomizationForm="True" VisibleIndex="6" Width="100px" Name="giavon">
                                                                    <PropertiesSpinEdit DisplayFormatString="N0"></PropertiesSpinEdit>
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn Caption="Số lượng" FieldName="SoLuong" ShowInCustomizationForm="True" VisibleIndex="4" Width="100px">
                                                                    <PropertiesSpinEdit DisplayFormatString="N0"></PropertiesSpinEdit>
                                                                    <DataItemTemplate>
                                                                        <dx:ASPxSpinEdit ID="spUnitReturn" runat="server" AllowNull = "False" MinValue="1" MaxValue="10000000000" Number='<%# Convert.ToInt32(Eval("SoLuong")) %>' DisplayFormatString="N0" Width="100%" NumberType="Integer" OnInit="spUnitReturn_Init" HorizontalAlign="Center">
                                                                        </dx:ASPxSpinEdit>
                                                                    </DataItemTemplate>
                                                                    <CellStyle>
                                                                        <Paddings Padding="2px" />
                                                                    </CellStyle>
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataSpinEditColumn Caption="Giá bán" FieldName="GiaBan" ShowInCustomizationForm="True" VisibleIndex="7" Width="100px" Name="giaban">
                                                                    <PropertiesSpinEdit DisplayFormatString="N0"></PropertiesSpinEdit>
                                                                    <DataItemTemplate>
                                                                        <dx:ASPxSpinEdit ID="spGiaBanReturn" runat="server" AllowNull = "False" MinValue="0" MaxValue="10000000000" Number='<%# Convert.ToDouble(Eval("GiaBan")) %>' DisplayFormatString="N0" Width="100%" NumberType="Integer" OnInit="spGiaBanReturn_Init" Increment="5000" HorizontalAlign="Right">
                                                                            <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                                         </dx:ASPxSpinEdit>
                                                                    </DataItemTemplate>
                                                                    <CellStyle>
                                                                        <Paddings Padding="2px" />
                                                                    </CellStyle>
                                                                </dx:GridViewDataSpinEditColumn>
                                                                <dx:GridViewDataButtonEditColumn Caption="Xóa" ShowInCustomizationForm="True" VisibleIndex="10" Width="50px">
                                                                     <DataItemTemplate>
                                                                        <dx:ASPxButton AutoPostBack="false" ID="BtnXoaHang" ClientInstanceName="BtnXoaHang" runat="server" 
                                                                             RenderMode="Link" OnInit="btnXoaHang_Init">

                                                                            <Image IconID="actions_cancel_16x16">
                                                                            </Image>
                                                                        </dx:ASPxButton>
                                                                    </DataItemTemplate>
                                                                    <CellStyle HorizontalAlign="Center">
                                                                    </CellStyle>
                                                                </dx:GridViewDataButtonEditColumn>
                                                                <dx:GridViewDataSpinEditColumn Caption="Giảm giá" FieldName="GiamGia" ShowInCustomizationForm="True" VisibleIndex="5" Width="100px">
                                                                    <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                                                    </PropertiesSpinEdit>
                                                                    <DataItemTemplate>
                                                                        <dx:ASPxSpinEdit ID="spGiamGiaReturn" AllowNull = "False" MinValue="0" MaxValue="10000000000" ClientInstanceName="spGiamGiaReturn" runat="server" Number='<%# Convert.ToDouble(Eval("GiamGia")) %>' DisplayFormatString="N0" Width="100%" NumberType="Integer" OnInit="spGiamGiaReturn_Init" Increment="1" HorizontalAlign="Right">
                                                                         <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                                        </dx:ASPxSpinEdit>
                                                                    </DataItemTemplate>
                                                                    <CellStyle>
                                                                        <Paddings Padding="0px" />
                                                                    </CellStyle>
                                                                </dx:GridViewDataSpinEditColumn>
                                                            </Columns>
                                                            <FormatConditions>
                                                                <dx:GridViewFormatConditionHighlight FieldName="TonKho" Expression="[TonKho] < 1" Format="LightRedFillWithDarkRedText" />
                                                                <dx:GridViewFormatConditionHighlight FieldName="TonKho" Expression="[TonKho] > 0" Format="GreenFillWithDarkGreenText" />
                                                                <dx:GridViewFormatConditionTopBottom FieldName="TonKho" Rule="TopItems" Threshold="15" Format="BoldText" CellStyle-HorizontalAlign="Center">
                                                                    <CellStyle HorizontalAlign="Center"></CellStyle>
                                                                </dx:GridViewFormatConditionTopBottom>
                                                            </FormatConditions>
                                                            <TotalSummary>
                                                                <dx:ASPxSummaryItem DisplayFormat="Tổng mặt hàng: {0:N0}" FieldName="MaHang" ShowInColumn="Mã HH" SummaryType="Count" />
                                                                <dx:ASPxSummaryItem DisplayFormat="Tổng tiền: {0:N0}" FieldName="ThanhTien" ShowInColumn="Thành tiền" SummaryType="Sum" />
                                                                <dx:ASPxSummaryItem DisplayFormat="Tổng: {0:N0}" FieldName="SoLuong" ShowInColumn="Số lượng" SummaryType="Sum" />
                                                            </TotalSummary>
                                                            <Styles>
                                                                <Footer Font-Bold="True">
                                                                </Footer>
                                                            </Styles>
                                                        </dx:ASPxGridView>
                                                    </dx:PanelContent>
                                                </PanelCollection>
                                                <SettingsLoadingPanel Enabled="False"></SettingsLoadingPanel>
                                                <ClientSideEvents EndCallback="endCallBackProduct" />
                                            </dx:ASPxCallbackPanel>
                                        </dx:SplitterContentControl>
                                    </ContentCollection>
                                </dx:SplitterPane>
                            </Panes>
                            <ContentCollection>
                                <dx:SplitterContentControl ID="SplitterContentControl3" runat="server">
                                </dx:SplitterContentControl>
                            </ContentCollection>
                        </dx:SplitterPane>
                        <dx:SplitterPane Name="splpProcess" MaxSize="100px" Size="100px">
                            <ContentCollection>
                                <dx:SplitterContentControl ID="SplitterContentControl4" runat="server">
                                    <div style="align-items: center; text-align: center; padding-top: 5px;">
                                        <table style="margin: 0 auto;">
                                            <tr>
                                                 <td style="padding-right:10px;">
                                                    <dx:ASPxButton  ID="btnPreview" runat="server" Text="Xem trước" BackColor="#5cb85c" AutoPostBack="false" UseSubmitBehavior="false">
                                                        <ClientSideEvents Click="onReviewClick" />
                                                    </dx:ASPxButton>
                                                   </td>
                                                <td style="padding-left: 10px">
                                                    <dx:ASPxButton ID="btnLuuTiepTuc" runat="server" Text="Đặt hàng" AutoPostBack="false" UseSubmitBehavior="false">
                                                        <ClientSideEvents Click="onSaveClick" />
                                                    </dx:ASPxButton>
                                                </td>
                                              
                                            </tr>
                                        </table>
                                    </div>
                                </dx:SplitterContentControl>
                            </ContentCollection>
                        </dx:SplitterPane>
                    </Panes>
                </dx:ASPxSplitter>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxPanel>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>


    <dx:ASPxPopupControl ID="popupViewExcel" runat="server" ClientInstanceName="popupViewExcel" HeaderText="Nhập hàng hóa từ Excel" Width="800px" Height="200px" PopupHorizontalAlign="WindowCenter">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                <dx:ASPxHiddenField ID="hdfViewReport" ClientInstanceName="hdfViewReport" runat="server">
                </dx:ASPxHiddenField>
                <table>
                    <tr>
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Tải file mẫu:"></dx:ASPxLabel>
                        </td>
                        <td style="float: left; padding-left: 3px;">
                            <dx:ASPxHyperLink ID="linkNhapKho" runat="server" Text="PhieuGiaoHang.xls" NavigateUrl="~/BieuMau/phieugiaohang.xls">
                            </dx:ASPxHyperLink>
                        </td>
                    </tr>

                </table>
                <table>
                    <tr style="padding-top: 20px">
                        <td>
                            <dx:ASPxLabel ID="ASPxLabel2" runat="server" Font-Italic="true" Text="Lưu ý: Hệ thống chỉ hỗ trợ tối đa 500 hàng hóa cho mỗi lần nhập dữ liệu từ file."></dx:ASPxLabel>
                        </td>

                    </tr>
                </table>
                <table>
                    <tr>
                        <td>
                            <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="UploadControl" Width="500px"
                                NullText="Chọn file excel nhập hàng..." UploadMode="Advanced" ShowUploadButton="True" ShowProgressPanel="True"
                                OnFileUploadComplete="UploadControl_FileUploadComplete">
                                <BrowseButton Text="Chọn file excel...">
                                    <Image IconID="actions_open_32x32office2013">
                                    </Image>
                                </BrowseButton>
                                <RemoveButton Text="Xóa">
                                    <Image IconID="actions_cancel_32x32office2013">
                                    </Image>
                                </RemoveButton>
                                <UploadButton Text="Tải lên">
                                    <Image IconID="miscellaneous_publish_32x32office2013">
                                    </Image>
                                </UploadButton>
                                <CancelButton Text="Hủy">
                                    <Image IconID="actions_cancel_32x32office2013">
                                    </Image>
                                </CancelButton>
                                <AdvancedModeSettings EnableMultiSelect="True" EnableDragAndDrop="True" />
                                <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".xlt, .xls" NotAllowedFileExtensionErrorText="Vui lòng chọn đúng định dạng .xlt .xls">
                                </ValidationSettings>
                                <ClearFileSelectionImage IconID="actions_cancel_32x32office2013" ToolTip="Xóa file">
                                </ClearFileSelectionImage>
                                <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                            </dx:ASPxUploadControl>
                        </td>
                    </tr>
                </table>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
     <dx:ASPxPopupControl ID="popGiamGia"  runat="server" Width="320" CloseAction="CloseButton" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="popGiamGia"
        HeaderText="Áp giảm giá" ShowHeader="false" AllowDragging="True" PopupAnimationType="None" EnableViewState="False" AutoUpdatePosition="true">
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroup');  }" />
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxPanel ID="Panel12" runat="server" DefaultButton="btOK">
                    <PanelCollection>
                        <dx:PanelContent ID="PanelContent4" runat="server">
                            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout1" Width="100%" Height="100%">
                                <Items>

                                    <dx:LayoutItem Caption="Giảm giá">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxSpinEdit AllowNull = "False" MinValue="0" MaxValue="10000000000" ID="spTienGiamGia" DisplayFormatString="N0" HorizontalAlign="Right"  ForeColor="Blue" Increment="5000" Number="0" runat="server" ClientInstanceName="spTienGiamGia" Width="100%">
                                               <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                     </dx:ASPxSpinEdit>
                                                <dx:ASPxHiddenField ID="hiddenTienGiamGia" ClientInstanceName="hiddenTienGiamGia" runat="server"></dx:ASPxHiddenField>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:LayoutItem Caption="Hình thức ">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxRadioButtonList ID="rdHinhThuc" runat="server" ClientInstanceName="rdHinhThuc" RepeatColumns="2" ItemSpacing="50px"  SelectedIndex="0" Width="100%">
                                                    <Items>
                                                        <dx:ListEditItem Selected="True" Text="VNĐ" Value="0" />
                                                        <dx:ListEditItem Text="%" Value="1" />
                                                    </Items>
                                                    <ClientSideEvents SelectedIndexChanged="rdHinhThuconSelect" />
                                                    <Border BorderStyle="Ridge" />
                                                </dx:ASPxRadioButtonList>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    
                                    <dx:LayoutItem ShowCaption="False" Paddings-PaddingTop="19"  Width="100%" HorizontalAlign="Center" VerticalAlign="Middle">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                 <div style="align-items: center; text-align: center; padding-top: 5px;">
                                                <table style="margin: 0 auto;">
                                                    <tr >
                                                        <td >
                                                            <dx:ASPxButton ID="btnApDung" ClientInstanceName="btnApDung" runat="server" Text="Áp dụng" Width="100px" AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                                <ClientSideEvents Click="btnApDungonClick" />
                                                            </dx:ASPxButton>

                                                        </td>
                                                        <td style="padding-left:10px">
                                                            <dx:ASPxButton ID="btCancel" runat="server" Text="Hủy bỏ" Width="100px" AutoPostBack="False" Style="float: left; margin-right: 8px">
                                                                <ClientSideEvents Click="function(s, e) { popGiamGia.Hide(); }" />
                                                            </dx:ASPxButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                                </div>
                                                
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>

<Paddings PaddingTop="19px"></Paddings>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:ASPxFormLayout>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxPanel>
                
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
     <dx:ASPxPopupControl ID="popupViewReport" HeaderImage-Height="50px" CloseAction="CloseButton"  ClientInstanceName="popupViewReport" runat="server" HeaderText="Phiếu xuất hàng" Width="850px" Height="600px" ScrollBars="Auto" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowHeader="true" Modal="True" >
    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl3" runat="server">

            <dx:ASPxDocumentViewer ID="reportViewer" ClientInstanceName="reportViewer" runat="server">
            </dx:ASPxDocumentViewer>
           
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
</asp:Content>
