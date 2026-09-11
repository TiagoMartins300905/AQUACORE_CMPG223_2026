<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateFeeding.aspx.cs" Inherits="AQUACORE_CMPG223.UpdateFeeding" %>

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

        .auto-style19 {}

        .auto-style20 {
            text-align: center;
        }

        .auto-style22 {
            height: 87px;
            width: 585px;
        }

        .auto-style23 {
            height: 187px;
        }

        .auto-style25 {}
        .auto-style27 {
            text-align: center;
            font-size: x-large;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="auto-style2">

            <h1 class="auto-style3">
                AquaCore-Feeding Schedule
            </h1>
            <p class="auto-style27">
                Update Feeding Schedule:</p>

            <p class="auto-style3">
                <asp:Label
                    ID="lblHeading"
                    runat="server"
                    Text="Please select a schedule ID to update:">
                </asp:Label>
            </p>

            <p class="auto-style3">

                <asp:DropDownList
                    ID="ddlScheduleID"
                    runat="server"
                    CssClass="auto-style25"
                    Height="33px"
                    Width="347px">

                    <asp:ListItem>--Select a schedule ID--</asp:ListItem>

                </asp:DropDownList>

            </p>

            <p class="auto-style3">

                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1"
                    runat="server"
                    ControlToValidate="ddlScheduleID"
                    ErrorMessage="A schedule ID is required!"
                    InitialValue="--Select a schedule ID--"
                    ValidationGroup="UpdateValidation">
                </asp:RequiredFieldValidator>

            </p>

            <p class="auto-style3">&nbsp;</p>

        </div>

        <div class="auto-style1">

            <table style="width:100%;">

                <tr>
                    <td class="auto-style23" colspan="3"></td>
                </tr>

                <!-- Animal -->
                <tr>
                    <td class="auto-style15">

                        <asp:Label
                            ID="lblAnimal"
                            runat="server"
                            Text="Animal:">
                        </asp:Label>

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

                    </td>
                </tr>

                <!-- Marine Keeper -->
                <tr>
                    <td class="auto-style9">

                        <asp:Label
                            ID="lblKeeper"
                            runat="server"
                            Text="Marine Keeper:">
                        </asp:Label>

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

                    </td>
                </tr>

                <!-- Time -->
                <tr>
                    <td class="auto-style11">

                        <asp:Label
                            ID="lblTime"
                            runat="server"
                            Text="Time:">
                        </asp:Label>

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

                    </td>
                </tr>

                <!-- Food Type -->
                <tr>
                    <td class="auto-style11">

                        <asp:Label
                            ID="foodTypelbl"
                            runat="server"
                            Text="Food Type:">
                        </asp:Label>

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

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        <!-- UPDATE: Runs validation -->
                        <asp:Button
                            ID="btnUpdate"
                            runat="server"
                            CssClass="auto-style17"
                            Height="41px"
                            Text="Update Schedule"
                            Width="136px"
                            ValidationGroup="UpdateValidation" />

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

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
