<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedingMenu.aspx.cs" Inherits="AQUACORE_CMPG223.FeedingMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 591px;
        }
        .auto-style2 {
            font-size: x-large;
            text-align: center;
        }
        .auto-style3 {
            text-align: center;
        }
        .auto-style5 {
            height: 110px;
            text-align: center;
        }
        .auto-style6 {
            height: 132px;
            text-align: center;
        }
        .auto-style7 {
            text-align: center;
            height: 108px;
        }
        .auto-style8 {
            text-align: center;
            height: 107px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div><h1 class="auto-style3">AquaCore-Feeding Schedule</h1>
            <p class="auto-style2">Menu</p>
        </div>
        <div class="auto-style1">
            <table style="width:100%;">
                <tr>
                    <td class="auto-style5">
                        <asp:Label ID="lblAdd" runat="server" Text="Add Schedule:"></asp:Label>
                        <br />
                        <asp:Button ID="btnAdd" runat="server" Text="Add Feeding" OnClick="btnAdd_Click1" />
                        <br />
                        <asp:Label ID="lblAddDes" runat="server" Text="Click this to add a new feeding schedule"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <asp:Label ID="lblUpdate" runat="server" Text="Update Schedule:"></asp:Label>
                        <br />
                        <asp:Button ID="btnUpdate" runat="server" Text="Update Feeding" OnClick="btnUpdate_Click" />
                        <br />
                        <asp:Label ID="lblUpdateDes" runat="server" Text="Click this to update an existing schedule"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        <asp:Label ID="lblDelete" runat="server" Text="Delete Schedule:"></asp:Label>
                        <br />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete Feeding:" OnClick="btnDelete_Click" />
                        <br />
                        <asp:Label ID="lblDeleteDes" runat="server" Text="Click this to delete an existing feeding schedule"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">
                        <asp:Label ID="lblView" runat="server" Text="View Shedules:"></asp:Label>
                        <br />
                        <asp:Button ID="btnView" runat="server" Text="View feedings:" OnClick="btnView_Click" />
                        <br />
                        <asp:Label ID="lblViewDes" runat="server" Text="Click this to view all existing feedings"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style8">
                        <asp:Label ID="lblReturn" runat="server" Text="Return:"></asp:Label>
                        <br />
                        <asp:Button ID="Button5" runat="server" Text="Go Back" OnClick="Button5_Click" />
                        <br />
                        <asp:Label ID="Label10" runat="server" Text="Click this button to return to previous menu"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
