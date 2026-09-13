<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RestaurantOrders_Dashboard.aspx.cs" Inherits="AQUACORE_CMPG223.RestaurantOrders_Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title> Restaurant Orders Dashboard </title>
    <style type="text/css">
        .auto-style1 {
            width: 437px;
        }
    </style>
</head>
<body style="margin-bottom: 118px">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Restaurant Orders Management"></asp:Label>
            <table style="width:100%;">
                <tr>
                    <td>
                        <asp:Label ID="lbl" runat="server" Text="Add new order"></asp:Label>
                    </td>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Add Order" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="Update Order"></asp:Label>
                    </td>
                    <td>
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Delete Order"></asp:Label>
                    </td>
                    <td>
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
        <table style="width:100%;">
            <tr>
                <td class="auto-style1">
                    <asp:Label ID="Label5" runat="server" Text="Display Orders"></asp:Label>
                </td>
                <td>
                    <asp:Button ID="btnDisplay" runat="server" Text="Display" />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
