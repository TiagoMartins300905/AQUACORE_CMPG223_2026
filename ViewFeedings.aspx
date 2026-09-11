<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewFeedings.aspx.cs" Inherits="AQUACORE_CMPG223.ViewFeedings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .auto-style2 {
            font-size: x-large;
        }
        .auto-style3 {
            height: 346px;
        }
        .auto-style4 {
            width: 100%;
            height: 343px;
        }
        .auto-style5 {
            height: 43px;
        }
        .auto-style6 {
            width: 346px;
        }
        .auto-style7 {
            height: 43px;
            width: 346px;
        }
        .auto-style8 {
            width: 352px;
            text-align: center;
        }
        .auto-style9 {
            height: 43px;
            width: 352px;
            text-align: center;
        }
        .auto-style10 {
            margin-left: 63px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auto-style1"> <h1>AquaCore-Feeding Schedule</h1>
            <p class="auto-style2">View Feeding Schedules:</p> 
        </div>
        <div class="auto-style3">
            <table class="auto-style4">
                <tr>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="auto-style8">
                        <asp:Label ID="lblSort" runat="server" Text="Select sort by:"></asp:Label>
                        <br />
                        <asp:DropDownList ID="DropDownList1" runat="server">
                            <asp:ListItem>--Select Sort--</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="auto-style8">
                        <asp:Label ID="lblFilter" runat="server" Text="Filter by:"></asp:Label>
                        <br />
                        <asp:RadioButton ID="rdoASC" runat="server" Text="Ascending" />
                        <asp:RadioButton ID="rdoDESC" runat="server" Text="Descending" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="auto-style8">
                        <asp:GridView ID="GridView1" runat="server" CssClass="auto-style10">
                        </asp:GridView>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style7"></td>
                    <td class="auto-style9">
                        <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Go Back" />
                    </td>
                    <td class="auto-style5"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
