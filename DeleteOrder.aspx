<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteOrder.aspx.cs" Inherits="AQUACORE_CMPG223.DeleteOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="Delete an Order"></asp:Label>
        <br />
        <br />
        <p>
            <asp:Label ID="Label2" runat="server" Text="Enter the Order ID of the order you want to delete."></asp:Label>
        </p>
        <p>
            <asp:Label ID="Label3" runat="server" Text="OrderID:"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="btnDelete" runat="server" Text="Delete" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnDashboard" runat="server" Text="Order Dashboard" />
        </p>
    </form>
</body>
</html>
