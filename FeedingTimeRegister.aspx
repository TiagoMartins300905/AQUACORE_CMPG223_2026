<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedingTimeRegister.aspx.cs" Inherits="AQUACORE_CMPG223.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 545px;
        }
        .auto-style2 {
            height: 52px;
        }
        .auto-style3 {
            text-align: center;
        }
        .auto-style5 {
            width: 205px;
        }
        .auto-style7 {}
        .auto-style8 {}
        .auto-style9 {
            width: 205px;
            height: 92px;
        }
        .auto-style10 {
            height: 92px;
        }
        .auto-style11 {
            width: 205px;
            height: 87px;
        }
        .auto-style12 {
            height: 87px;
        }
        .auto-style13 {}
        .auto-style14 {}
        .auto-style15 {
            width: 205px;
            height: 79px;
        }
        .auto-style16 {
            height: 79px;
        }
        .auto-style17 {}
        .auto-style18 {}
        .auto-style19 {}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auto-style2"><h1 class="auto-style3">AquaCore-Feeding Schedule</h1>
        </div>
        <div class="auto-style1">
            <table style="width:100%;">
                <tr>
                    <td class="auto-style5">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style15">
                        <asp:Label ID="lblAnimal" runat="server" Text="Animal:"></asp:Label>
                    </td>
                    <td class="auto-style16" colspan="2">
                        <asp:DropDownList ID="ddlAnimal" runat="server" CssClass="auto-style7" Height="24px" Width="350px">
                            <asp:ListItem>--Select Animal--</asp:ListItem>
                        </asp:DropDownList>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlAnimal" ErrorMessage="Please select a animal!" InitialValue="--Select Animal--"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9">
                        <asp:Label ID="lblKeeper" runat="server" Text="Marine Keeper:"></asp:Label>
                    </td>
                    <td class="auto-style10" colspan="2">
                        <asp:DropDownList ID="ddlKeeper" runat="server" CssClass="auto-style8" Height="33px" Width="350px">
                            <asp:ListItem>--Select Keeper--</asp:ListItem>
                        </asp:DropDownList>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlKeeper" ErrorMessage="Please select a keeper!" InitialValue="--Select Keeper--"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style11">
                        <asp:Label ID="lblTime" runat="server" Text="Time:"></asp:Label>
                    </td>
                    <td class="auto-style12" colspan="2">
                        <asp:DropDownList ID="ddlTime" runat="server" CssClass="auto-style13" Height="16px" Width="360px">
                            <asp:ListItem>--Select a time--</asp:ListItem>
                        </asp:DropDownList>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlTime" ErrorMessage="Please add a feeding time!" InitialValue="--Select a time--"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style11">
                        <asp:Label ID="foodTypelbl" runat="server" Text="Food Type:"></asp:Label>
                    </td>
                    <td class="auto-style12" colspan="2">
                        <asp:DropDownList ID="ddlFoodType" runat="server" CssClass="auto-style14" Height="30px" Width="372px">
                            <asp:ListItem>--Select food type--</asp:ListItem>
                        </asp:DropDownList>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlFoodType" ErrorMessage="Please add a food type!" InitialValue="--Select food type--"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style11">&nbsp;</td>
                    <td class="auto-style12">&nbsp;</td>
                    <td class="auto-style12">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style11">&nbsp;</td>
                    <td class="auto-style12">
                        <asp:Button ID="btnAdd" runat="server" CssClass="auto-style17" Height="41px" Text="Add Schedule" Width="117px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnClear" runat="server" CssClass="auto-style18" Height="41px" Text="Clear" Width="117px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnBack" runat="server" CssClass="auto-style19" Height="41px" Text="Go Back" Width="117px" />
                    </td>
                    <td class="auto-style12">&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
