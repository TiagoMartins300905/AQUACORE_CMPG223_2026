<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddAnimals.aspx.cs" Inherits="AQUACORE_CMPG223.AddAnimals" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            Specify Animal Details to Add Animals To Database
        </div>

        <div>

            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Animal ID:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtID" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Name:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Species:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            <asp:TextBox ID="txtSpecies" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" Text="Date Of Birth:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtDOB" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="Gender:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="rdbMale" runat="server" GroupName="Gender" OnCheckedChanged="rdbMale_CheckedChanged1" Text="Male" />
&nbsp;<asp:RadioButton ID="rdbFemale" runat="server" GroupName="Gender" OnCheckedChanged="rdbMale_CheckedChanged1" Text="Female" />
            <br />
            <br />
            <asp:Label ID="Label6" runat="server" Text="Habitat Location:"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem>---Choose Habitat----</asp:ListItem>
                <asp:ListItem>Open Ocean Tank</asp:ListItem>
                <asp:ListItem>Coral Reef Display</asp:ListItem>
                <asp:ListItem>Kelp Forest</asp:ListItem>
                <asp:ListItem>Tidal Touch Pool</asp:ListItem>
                <asp:ListItem>Mangrove Estuary</asp:ListItem>
            </asp:DropDownList>

        </div>
    </form>
</body>
</html>
