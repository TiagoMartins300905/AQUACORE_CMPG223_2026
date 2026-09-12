<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Delete.aspx.cs" Inherits="AQUACORE_CMPG223.Delete" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auto-style1">
            Delete Medical Record
            <br />
            <br />
            <asp:Label ID="Label11" runat="server" Text="Record ID:"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtRecordID" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="btnDelete" runat="server" Text="Delete Record" />
            <br />
            <br />
            <asp:Button ID="btnBack" runat="server" Text="Medicals Menu" />
        </div>
    </form>
</body>
</html>
