<%@ Control Language="vb" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web" TagPrefix="dx" %>
<script runat="server" type="text/C#">
	Dim _eventNames As String
	Dim _eventLogHeight As Integer
	Dim _eventLogWidth As Integer

	Public Property EventNames() As String
		Get
			Return _eventNames
		End Get
		Set(ByVal value As String)
			_eventNames = value
		End Set
	End Property
	Public Property EventLogHeight() As Integer
		Get
			Return _eventLogHeight
		End Get
		Set(ByVal value As Integer)
			_eventLogHeight = value
		End Set
	End Property
	Public Property EventLogWidth() As Integer
		Get
			Return _eventLogWidth
		End Get
		Set(ByVal value As Integer)
			_eventLogWidth = value
		End Set
	End Property
	Protected Function GetEventNameList() As System.Collections.Generic.IEnumerable(Of String)
		Return Regex.Split(EventNames, "[^A-Za-z]+")
	End Function
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		Repeater.DataSource = GetEventNameList()
		Repeater.DataBind()
	End Sub
	Protected Function GetStyleAttribute() As String
		If EventLogWidth > 0 OrElse EventLogHeight > 0 Then
			Dim heightStr As String = If((EventLogHeight > 0), String.Format("height: {0}px", EventLogHeight), String.Empty)
			Dim widthStr As String = If((EventLogWidth > 0), String.Format("width: {0}px", EventLogWidth), String.Empty)
			Return String.Format("style=""{0} {1}""", widthStr, heightStr)
		End If
		Return Nothing
	End Function
</script>
<script language="javascript" type="text/javascript">
	function ClearButton_Click() {
		DXEventMonitor.Clear();
	}
</script>
<div class="EventLogPanel">
	<div id="EventLog" <%=GetStyleAttribute()%>>
	</div>
	<dx:ASPxButton runat="server" ID="ClearButton" AutoPostBack="false" Text="Clear">
		<ClientSideEvents Click="ClearButton_Click" />
	</dx:ASPxButton>
</div>
<div class="EventListPanel">
	<div>Trace Events:</div>
	<asp:Repeater runat="server" ID="Repeater">
		<ItemTemplate>
			<input type="checkbox" id="EventCheck<%#Container.DataItem%>" checked="checked" />
			<label for="EventCheck<%#Container.DataItem%>"><%#Container.DataItem%></label>
			<br />
		</ItemTemplate>
	</asp:Repeater>
</div>