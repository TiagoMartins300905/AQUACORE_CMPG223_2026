<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Medicals_Dashboard.aspx.cs" Inherits="AQUACORE_CMPG223.Medicals_Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            Medical Records
        </div>

        <div style="text-align: center">

            <br />
            <asp:Label ID="Label1" runat="server" Text="Add Medical Records"></asp:Label>
            <br />
            <asp:Label ID="Label2" runat="server" ForeColor="Gray" Text="Add a medical record for an animal"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnAdd" runat="server" Text="Add Record" OnClick="btnAdd_Click" />
            <br />
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Update Medical Records"></asp:Label>
            <br />
            <asp:Label ID="Label4" runat="server" ForeColor="Gray" Text="Update existing medical records"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnUpdate" runat="server" Text="Update Record" OnClick="btnUpdate_Click" />
            <br />
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="Delete Record"></asp:Label>
            <br />
            <asp:Label ID="Label6" runat="server" ForeColor="Gray" Text="Delete an existing record"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnDelete" runat="server" Text="Delete Record" OnClick="btnDelete_Click" />
            <br />
            <br />
            <br />
            <asp:Label ID="Label8" runat="server" Text="Display Medical Records"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnDisplay" runat="server" Text="Display Records" OnClick="btnDisplay_Click" />
            <br />
            <br />
            <br />
            <asp:Label ID="Label9" runat="server" Text="Go back to previous menu"></asp:Label>
            <br />
            <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" />

        </div>
    </form>
</body>
</html>
