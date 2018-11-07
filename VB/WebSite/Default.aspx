<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dx" %>
<%@ Register Src="EventMonitor.ascx" TagName="EventMonitor" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<link rel="stylesheet" type="text/css" href="DXEventMonitorStyles.css" />
	<script language="javascript" type="text/javascript" src="DXEventMonitor.js"></script>
	<script language="javascript" type="text/javascript">
		function OnCustomizationWindowCloseUp(s, e) {
			UpdateBtnToggleCustomWindowText();
		}
		function OnBtnToggleCustomWindowClick(s, e) {
			if (grid.IsCustomizationWindowVisible())
				grid.HideCustomizationWindow();
			else
				grid.ShowCustomizationWindow();
			UpdateBtnToggleCustomWindowText();
		}
		function UpdateBtnToggleCustomWindowText() {
			var text = grid.IsCustomizationWindowVisible() ? 'Hide' : 'Show';
			text += ' Customization Window';
			btnToggleCustomWindow.SetText(text);
		}
		function OnColumnStartDragging(s, e) {
			hiddenField.Set('fieldName', e.column.fieldName);
		}
		function OnEndCallback(s, e) {
			if (s.cpMoveTo != undefined) {
				var str = hiddenField.Get('fieldName') + ' was moved to ' + s.cpMoveTo;
				DXEventMonitor.Trace(s, e, 'EndCallback', str);
				delete s.cpMoveTo;
			}
		}
	</script>
	<title></title>
</head>
<body>
	<form id="form1" runat="server">
	<div>
		<dx:ASPxButton ID="buttonToggleCustomWindow" runat="server" ClientInstanceName="btnToggleCustomWindow"
			Text="Show Customization Window" AutoPostBack="false" Width="250px">
			<ClientSideEvents Click="OnBtnToggleCustomWindowClick" />
		</dx:ASPxButton>
		<br />
		<dx:ASPxGridView ID="grid" runat="server" ClientInstanceName="grid" AutoGenerateColumns="False"
			DataSourceID="gridDataSource" KeyFieldName="ProductID" OnAfterPerformCallback="grid_AfterPerformCallback">
			<ClientSideEvents ColumnStartDragging="OnColumnStartDragging" EndCallback="OnEndCallback" />
			<SettingsCustomizationWindow Enabled="True" />
			<Columns>
				<dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" VisibleIndex="0">
					<EditFormSettings Visible="False" />
				</dx:GridViewDataTextColumn>
				<dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="1">
				</dx:GridViewDataTextColumn>
				<dx:GridViewDataTextColumn FieldName="SupplierID" VisibleIndex="2">
				</dx:GridViewDataTextColumn>
				<dx:GridViewDataTextColumn FieldName="CategoryID" VisibleIndex="3">
				</dx:GridViewDataTextColumn>
			</Columns>
		</dx:ASPxGridView>
		<asp:AccessDataSource ID="gridDataSource" runat="server" DataFile="~/App_Data/nwind.mdb"
			SelectCommand="SELECT [ProductID], [ProductName], [SupplierID], [CategoryID] FROM [Products]">
		</asp:AccessDataSource>
	</div>
	<dx:ASPxHiddenField ID="hf" ClientInstanceName="hiddenField" runat="server">
	</dx:ASPxHiddenField>
	<br />
	<uc1:EventMonitor ID="EventMonitorGridView" runat="server" EventNames="EndCallback" />
	</form>
</body>
</html>