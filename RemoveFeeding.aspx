<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveFeeding.aspx.cs" Inherits="AQUACORE_CMPG223.RemoveFeeding" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 361px;
            text-align: center;
        }
        .auto-style2 {
            text-align: center;
        }
        .auto-style3 {}
        .auto-style5 {
            text-align: center;
            font-size: x-large;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div><h1 class="auto-style2">AquaCore-Feeding Schedule</h1>
            <p class="auto-style5">Delete Feeding Schedule:</p>
        </div>
        <div class="auto-style1">
            <br />
            <br />
            <asp:Label ID="lblHeading" runat="server" Text="Select a schedule ID to delete:"></asp:Label>
            <br />
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="auto-style3" Height="41px" Width="414px">
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
            <br />
            <br />
            <br />
            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnBack" runat="server" Text="GoBack" OnClick="btnBack_Click" />
        </div>
    </form>
</body>
</html>
