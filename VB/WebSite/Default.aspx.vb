Imports Microsoft.VisualBasic
Imports System
Imports DevExpress.Web.ASPxGridView

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Protected Sub grid_AfterPerformCallback(ByVal sender As Object, ByVal e As ASPxGridViewAfterPerformCallbackEventArgs)
		If e.CallbackName = "COLUMNMOVE" Then
			Dim gridView As ASPxGridView = CType(sender, ASPxGridView)
			If (gridView.Columns(hf("fieldName").ToString())).Visible Then
				gridView.JSProperties("cpMoveTo") = "Header"
			Else
				gridView.JSProperties("cpMoveTo") = "Customization Window"
			End If
		End If
	End Sub
End Class
