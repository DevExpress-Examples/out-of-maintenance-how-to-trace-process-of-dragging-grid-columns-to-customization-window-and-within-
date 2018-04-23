DXEventMonitor = {
    TimerId: -1,
    PendingUpdates: [],

    Trace: function(sender, e, eventName, str) {
        var checkbox = document.getElementById("EventCheck" + eventName);
        if (!checkbox.checked) return;

        var self = DXEventMonitor;
        var name = sender.name;
        var message = str;
        var lastSeparator = name.lastIndexOf("_");
        if (lastSeparator > -1)
            name = name.substr(lastSeparator + 1);

        var builder = ["<table cellspacing=0 cellpadding=0 border=0>"];
        self.BuildTraceRowHtml(builder, "Sender", name, 100);
        self.BuildTraceRowHtml(builder, "EventType", eventName);
        self.BuildTraceRowHtmlColumnDragged(builder, message);
        var count = 0;
        for (var child in e) {
            if (typeof e[child] == "function") continue;
            var childValue = e[child];
            if (typeof e[child] == "object" && e[child] && e[child].name)
                childValue = "[name: '" + e[child].name + "']";
            self.BuildTraceRowHtml(builder, count ? "" : "Arguments", child + " = " + childValue);
            count++;
        }
        builder.push("</table><br />");

        self.PendingUpdates.unshift(builder.join(""));
        if (self.TimerId < 0)
            self.TimerId = window.setTimeout(self.Update, 0);
    },

    BuildTraceRowHtml: function(builder, name, text, width) {
        builder.push("<tr><td valign=top");
        if (width)
            builder.push(" style='width: ", width, "px'");
        builder.push(">");
        if (name)
            builder.push("<b>", name, ":</b>");
        builder.push("</td><td valign=top>", text, "</td></tr>");
    },

    BuildTraceRowHtmlColumnDragged: function(builder, text) {
        builder.push("<tr><td colspan='2' valign=top");
        builder.push(">");
        builder.push(text, "</td></tr>");
    },

    GetLogElement: function() {
        return document.getElementById("EventLog")
    },

    Update: function() {
        var self = DXEventMonitor;
        var element = self.GetLogElement();

        element.innerHTML = self.PendingUpdates.join("") + element.innerHTML;
        self.TimerId = -1;
        self.PendingUpdates = [];
    },

    Clear: function() {
        DXEventMonitor.GetLogElement().innerHTML = "";
    }
};