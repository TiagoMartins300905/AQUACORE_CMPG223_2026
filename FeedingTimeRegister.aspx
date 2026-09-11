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
            height: 139px;
        }

        .auto-style10 {
            height: 139px;
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
            height: 32px;
        }

        .auto-style16 {
            height: 32px;
        }

        .auto-style17 {}

        .auto-style18 {}

        .auto-style19 {}

        .auto-style20 {
            text-align: center;
        }

        .auto-style21 {
            width: 585px;
        }

        .auto-style22 {
            height: 87px;
            width: 585px;
        }
        .auto-style23 {
            text-align: center;
            height: 54px;
        }
        .auto-style24 {
            width: 100%;
            margin-top: 73px;
        }
        .auto-style25 {
            text-align: center;
            height: 44px;
            font-size: x-large;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="auto-style2">
            <h1 class="auto-style3">AquaCore-Feeding Schedule</h1>
            <p class="auto-style25">Add Feeding Schedule:</p>
            <p class="auto-style23">&nbsp;</p>
            <p class="auto-style3">&nbsp;</p>
        </div>

        <div class="auto-style1">

            <table class="auto-style24">

                <tr>
                    <td class="auto-style5">&nbsp;</td>
                    <td class="auto-style21">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>

                <!-- Animal -->
                <tr>
                    <td class="auto-style15">
                        <asp:Label ID="lblAnimal" runat="server" Text="Animal:"></asp:Label>
                    </td>

                    <td class="auto-style16" colspan="2">

                        <asp:DropDownList
                            ID="ddlAnimal"
                            runat="server"
                            CssClass="auto-style7"
                            Height="24px"
                            Width="350px">

                            <asp:ListItem>--Select Animal--</asp:ListItem>

                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator1"
                            runat="server"
                            ControlToValidate="ddlAnimal"
                            ErrorMessage="Please select an animal!"
                            InitialValue="--Select Animal--"
                            ValidationGroup="ScheduleValidation">
                        </asp:RequiredFieldValidator>

                    </td>
                </tr>

                <!-- Marine Keeper -->
                <tr>
                    <td class="auto-style9">
                        <asp:Label ID="lblKeeper" runat="server" Text="Marine Keeper:"></asp:Label>
                    </td>

                    <td class="auto-style10" colspan="2">

                        <asp:DropDownList
                            ID="ddlKeeper"
                            runat="server"
                            CssClass="auto-style8"
                            Height="33px"
                            Width="350px">

                            <asp:ListItem>--Select Keeper--</asp:ListItem>

                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator2"
                            runat="server"
                            ControlToValidate="ddlKeeper"
                            ErrorMessage="Please select a keeper!"
                            InitialValue="--Select Keeper--"
                            ValidationGroup="ScheduleValidation">
                        </asp:RequiredFieldValidator>

                    </td>
                </tr>

                <!-- Time -->
                <tr>
                    <td class="auto-style11">
                        <asp:Label ID="lblTime" runat="server" Text="Time:"></asp:Label>
                    </td>

                    <td class="auto-style12" colspan="2">

                        <asp:DropDownList
                            ID="ddlTime"
                            runat="server"
                            CssClass="auto-style13"
                            Height="16px"
                            Width="360px">

                            <asp:ListItem>--Select a time--</asp:ListItem>

                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator3"
                            runat="server"
                            ControlToValidate="ddlTime"
                            ErrorMessage="Please add a feeding time!"
                            InitialValue="--Select a time--"
                            ValidationGroup="ScheduleValidation">
                        </asp:RequiredFieldValidator>

                    </td>
                </tr>

                <!-- Food Type -->
                <tr>
                    <td class="auto-style11">
                        <asp:Label ID="foodTypelbl" runat="server" Text="Food Type:"></asp:Label>
                    </td>

                    <td class="auto-style12" colspan="2">

                        <asp:DropDownList
                            ID="ddlFoodType"
                            runat="server"
                            CssClass="auto-style14"
                            Height="30px"
                            Width="372px">

                            <asp:ListItem>--Select food type--</asp:ListItem>

                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="RequiredFieldValidator4"
                            runat="server"
                            ControlToValidate="ddlFoodType"
                            ErrorMessage="Please add a food type!"
                            InitialValue="--Select food type--"
                            ValidationGroup="ScheduleValidation">
                        </asp:RequiredFieldValidator>

                    </td>
                </tr>

                <!-- Message -->
                <tr>
                    <td class="auto-style11">&nbsp;</td>

                    <td class="auto-style22">
                        <asp:Label
                            ID="lblMessage"
                            runat="server"
                            CssClass="auto-style20">
                        </asp:Label>
                    </td>

                    <td class="auto-style12">&nbsp;</td>
                </tr>

                <!-- Buttons -->
                <tr>
                    <td class="auto-style11">&nbsp;</td>

                    <td class="auto-style22">

                        <!-- ADD: Runs validation -->
                        <asp:Button
                            ID="btnAdd"
                            runat="server"
                            CssClass="auto-style17"
                            Height="41px"
                            Text="Add Schedule"
                            Width="117px"
                            ValidationGroup="ScheduleValidation" />

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        <!-- CLEAR: Does NOT run validation -->
                        <asp:Button
                            ID="btnClear"
                            runat="server"
                            CssClass="auto-style18"
                            Height="41px"
                            Text="Clear"
                            Width="117px"
                            CausesValidation="false"
                            OnClick="btnClear_Click" />

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        <!-- GO BACK: Does NOT run validation -->
                        <asp:Button
                            ID="btnBack"
                            runat="server"
                            CssClass="auto-style19"
                            Height="41px"
                            Text="Go Back"
                            Width="117px"
                            CausesValidation="false"
                            OnClick="btnBack_Click" />

                    </td>

                    <td class="auto-style12">&nbsp;</td>
                </tr>

            </table>

        </div>

    </form>
</body>
</html>
