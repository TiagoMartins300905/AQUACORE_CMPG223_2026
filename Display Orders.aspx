<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Display Orders.aspx.cs" Inherits="AQUACORE_CMPG223.Display_Orders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Display"></asp:Label>
        </div>
        <asp:GridView ID="gvOrders" runat="server" Height="314px" Width="658px">
        </asp:GridView>
        <p>
            <asp:Button ID="btnDashboard" runat="server" Text="Orders Dashboard" />
        </p>
    </form>
</body>
</html>
