<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Delete_Animal.aspx.cs" Inherits="AQUACORE_CMPG223.Delete_Animal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            Remove an animal from the system
        </div>

        <div style="text-align: center">
            <br />
            <asp:Label ID="Label1" runat="server" Text="Enter the ID of the animal you want to remove"></asp:Label>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Animal ID:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtAnimalID" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="btnDeleteAnimal" runat="server" Text="Delete Animal" OnClick="btnDeleteAnimal_Click" />
            <br />
            <br />
            <br />
            <asp:Button ID="btnMenu" runat="server" OnClick="btnMenu_Click" Text="Animal Menu" />
        </div>
    </form>
</body>
</html>
