<%@ Control Language="C#" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<script runat="server" type="text/C#">
    string _eventNames;
    int _eventLogHeight;
    int _eventLogWidth;
    
    public string EventNames {
        get { return _eventNames; }
        set { _eventNames = value; }
    }
    public int EventLogHeight {
        get { return _eventLogHeight; }
        set { _eventLogHeight = value; }
    }
    public int EventLogWidth {
        get { return _eventLogWidth; }
        set { _eventLogWidth = value; }
    }
    protected System.Collections.Generic.IEnumerable<string> GetEventNameList() {
        return Regex.Split(EventNames, "[^A-Za-z]+");
    }
    protected void Page_Load(object sender, EventArgs e) {
        Repeater.DataSource = GetEventNameList();
        Repeater.DataBind();
    }
    protected string GetStyleAttribute() {
        if (EventLogWidth > 0 || EventLogHeight > 0) {
            string heightStr = (EventLogHeight > 0) ? string.Format("height: {0}px", EventLogHeight) : string.Empty;
            string widthStr = (EventLogWidth > 0) ? string.Format("width: {0}px", EventLogWidth) : string.Empty;
            return string.Format("style=\"{0} {1}\"", widthStr, heightStr);
        }
        return null;
    }
</script>
<script language="javascript" type="text/javascript">
    function ClearButton_Click() {
        DXEventMonitor.Clear();
    }
</script>
<div class="EventLogPanel">
    <div id="EventLog" <%= GetStyleAttribute() %>>
    </div>
    <dx:ASPxButton runat="server" ID="ClearButton" AutoPostBack="false" Text="Clear">
        <ClientSideEvents Click="ClearButton_Click" />
    </dx:ASPxButton>
</div>
<div class="EventListPanel">
    <div>Trace Events:</div>
    <asp:Repeater runat="server" ID="Repeater">
        <ItemTemplate>
            <input type="checkbox" id="EventCheck<%# Container.DataItem %>" checked="checked" />
            <label for="EventCheck<%# Container.DataItem %>"><%# Container.DataItem %></label>
            <br />
        </ItemTemplate>
    </asp:Repeater>
</div>