<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ChiNhanh.aspx.cs" Inherits="KobePaint.Pages.HeThong.ChiNhanh" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxGridView ID="gridDanhSach" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridDanhSach" DataSourceID="dsChiNhanh" KeyFieldName="IDChiNhanh" Width="100%" OnCustomColumnDisplayText="gridDanhSachKH_CustomColumnDisplayText">
        <SettingsEditing Mode="EditForm">
        </SettingsEditing>
        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFilterRow="True" ShowTitlePanel="True"/>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin khách hàng cần tìm..." Title="DANH SÁCH CHI NHÁNH" ConfirmDelete="Xác nhận xóa !!" />
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
        <SettingsBehavior  ConfirmDelete="True" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
            <NewButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_add_16x16" ToolTip="Thêm">
                </Image>
            </NewButton>
            <UpdateButton ButtonType="Image" RenderMode="Image">
                <Image IconID="save_save_32x32" ToolTip="Lưu">
                </Image>
            </UpdateButton>
            <CancelButton ButtonType="Image" RenderMode="Image">
                <Image IconID="actions_close_32x32" ToolTip="Hủy">
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
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="IDChiNhanh" ReadOnly="True" VisibleIndex="0" Width="40px">
                <EditFormSettings Visible="False" />
                <Settings AllowAutoFilter="False" AllowFilterBySearchPanel="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn Caption=" " ShowEditButton="True" VisibleIndex="15" Width="80px" ShowDeleteButton="True" ShowNewButtonInHeader="True">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="Tên chi nhánh" FieldName="TenChiNhanh" VisibleIndex="1">
                <PropertiesTextEdit>
                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True">
                        <RequiredField ErrorText="Nhập tên chi nhánh" IsRequired="True" />
                    </ValidationSettings>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn VisibleIndex="2" Caption="Điện thoại" FieldName="DienThoai">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn VisibleIndex="3" Caption="Địa chỉ" FieldName="DiaChi">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn VisibleIndex="4" Caption="MST" FieldName="MST">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn VisibleIndex="6" Caption="Tỉnh thành" FieldName="TinhThanh">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn Caption="Kinh doanh" FieldName="DaXoa" VisibleIndex="14">
                <PropertiesCheckEdit DisplayTextChecked="Ngừng kinh doanh" DisplayTextUnchecked="Đang kinh doanh">
                    <DisplayImageUnchecked IconID="actions_apply_16x16" ToolTip="Đang kinh doanh">
                    </DisplayImageUnchecked>
                    <DisplayImageChecked IconID="actions_close_16x16devav" ToolTip="Ngừng kinh doanh">
                    </DisplayImageChecked>
                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True">
                        <RequiredField IsRequired="True" />
                    </ValidationSettings>
                </PropertiesCheckEdit>
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataDateColumn Caption="Ngày đăng ký" FieldName="NgayDangKy" VisibleIndex="5">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy">
                    <ValidationSettings ErrorTextPosition="Bottom" SetFocusOnError="True">
                        <RequiredField ErrorText="Nhập ngày đăng ký" IsRequired="True" />
                    </ValidationSettings>
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsChiNhanh" runat="server" ConnectionString="<%$ ConnectionStrings:KobePaintConnectionString %>" 
        DeleteCommand="UPDATE chChiNhanh SET DaXoa = 1 WHERE (IDChiNhanh = @IDChiNhanh)" 
        InsertCommand="INSERT INTO chChiNhanh(TenChiNhanh, DienThoai, DiaChi, MST, NgayDangKy, TinhThanh, DaXoa,Logo,QuyThuChi) VALUES (@TenChiNhanh, @DienThoai, @DiaChi, @MST, @NgayDangKy, @TinhThanh, @DaXoa,@Logo,0)" 
        SelectCommand="SELECT *FROM chChiNhanh WHERE (IDChiNhanh &lt;&gt; 1)" 
        UpdateCommand="UPDATE chChiNhanh SET TenChiNhanh = @TenChiNhanh, DienThoai = @DienThoai, DiaChi = @DiaChi, MST = @MST, NgayDangKy = @NgayDangKy, TinhThanh = @TinhThanh, DaXoa = @DaXoa WHERE (IDChiNhanh = @IDChiNhanh) UPDATE nvNhanVien SET DaXoa = @DaXoa WHERE (IDChiNhanh = @IDChiNhanh)" >
        <DeleteParameters>
            <asp:Parameter Name="IDChiNhanh" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TenChiNhanh" />
            <asp:Parameter Name="DienThoai" />
            <asp:Parameter Name="DiaChi" />
            <asp:Parameter Name="MST" />
            <asp:Parameter Name="NgayDangKy" />
            <asp:Parameter Name="TinhThanh" />
            <asp:Parameter Name="DaXoa" DefaultValue="0" />
            <asp:Parameter Name="Logo" DefaultValue="~/Content/Images/0903_SA_full.png" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="TenChiNhanh" />
            <asp:Parameter Name="DienThoai" />
            <asp:Parameter Name="DiaChi" />
            <asp:Parameter Name="MST" />
            <asp:Parameter Name="NgayDangKy" />
            <asp:Parameter Name="TinhThanh" />
            <asp:Parameter Name="IDChiNhanh" Type="Int32" />
            <asp:Parameter Name="DaXoa"  />
        </UpdateParameters>
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridDanhSach);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridDanhSach);
        }" />
    </dx:ASPxGlobalEvents>
</asp:Content>
