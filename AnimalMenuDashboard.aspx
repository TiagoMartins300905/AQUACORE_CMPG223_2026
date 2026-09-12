<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnimalMenuDashboard.aspx.cs" Inherits="AQUACORE_CMPG223.AnimalMenuDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-align: left;
        }
        .auto-style2 {
            text-align: center;
        }
        .auto-style3 {
            width: 100%;
            height: 270px;
        }
        .auto-style4 {
            text-align: center;
            width: 362px;
        }
        .auto-style5 {
            width: 362px;
        }
        .auto-style6 {
            text-align: center;
            width: 331px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auto-style1">
            <h1 class="auto-style2">Welcome to the</h1>
            <h2 class="auto-style2">AquaCore Animal Management System</h2>
        </div>
        <table class="auto-style3">
            <tr>
                <td class="auto-style2" colspan="3">Select a area you would like to maintain</td>
            </tr>
            <tr>
                <td class="auto-style4">
                    <asp:Button ID="btnAnimals" runat="server" Text="Marine animals" />
                </td>
                <td class="auto-style6">
                    <asp:Button ID="btnFeeding" runat="server" OnClick="btnFeeding_Click" Text="Feeding Schedules" />
                </td>
                <td class="auto-style2">
                    <asp:Button ID="btnMedical" runat="server" Text="Medical Records" />
                </td>
            </tr>
            <tr>
                <td class="auto-style5">&nbsp;</td>
                <td class="auto-style6">
                    <asp:Button ID="btnReturn" runat="server" Text="Return to Login" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
