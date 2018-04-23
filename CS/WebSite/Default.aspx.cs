using System;
using DevExpress.Web.ASPxGridView;

public partial class _Default : System.Web.UI.Page {
    protected void grid_AfterPerformCallback(object sender, ASPxGridViewAfterPerformCallbackEventArgs e) {
        if (e.CallbackName == "COLUMNMOVE") {
            ASPxGridView gridView = (ASPxGridView)sender;
            if ((gridView.Columns[hf["fieldName"].ToString()]).Visible)
                gridView.JSProperties["cpMoveTo"] = "Header";
            else
                gridView.JSProperties["cpMoveTo"] = "Customization Window";
        }
    }
}
