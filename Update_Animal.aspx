<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Update_Animal.aspx.cs" Inherits="AQUACORE_CMPG223.Update_Animal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Animals</title>
    
</head>
<body>
    <h2 style="text-align: center"> Update&nbsp; Animals </h2>

    <form id="form1" runat="server">
        <div style="text-align: center">
            Specify Animal Details to Update an Existing animal
        </div>

        <div>

            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Animal ID:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtID" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtID" ErrorMessage="Animal ID cannot be empty!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Name:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtName" ErrorMessage="Name cannot be empty!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Species:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            <asp:TextBox ID="txtSpecies" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSpecies" ErrorMessage="Animal species is required!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" Text="Date Of Birth:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtDOB" runat="server" AutoPostBack="True"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDOB" ErrorMessage="Enter animal's DOB!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="Gender:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="rdbMale" runat="server" GroupName="Gender" OnCheckedChanged="rdbMale_CheckedChanged1" Text="Male" AutoPostBack="True" />
&nbsp;<asp:RadioButton ID="rdbFemale" runat="server" GroupName="Gender" OnCheckedChanged="rdbMale_CheckedChanged1" Text="Female" AutoPostBack="True" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblGender" runat="server" ForeColor="Red" Text="Animal Gender cannot be left out!"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label6" runat="server" Text="Habitat Location:"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="ddHabitat" runat="server">
                <asp:ListItem>---Choose Habitat----</asp:ListItem>
                <asp:ListItem>Open Ocean Tank</asp:ListItem>
                <asp:ListItem>Coral Reef Display</asp:ListItem>
                <asp:ListItem>Kelp Forest</asp:ListItem>
                <asp:ListItem>Tidal Touch Pool</asp:ListItem>
                <asp:ListItem>Mangrove Estuary</asp:ListItem>
            </asp:DropDownList>

            &nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddHabitat" ErrorMessage="Animal Habitat is required!" ForeColor="Red" InitialValue="---Choose Habitat----"></asp:RequiredFieldValidator>
            <br />
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnUpdate" runat="server" Text="Update Animal" OnClick="btnUpdate_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            

            <asp:Button ID="btnMenu" runat="server" OnClick="btnMenu_Click" Text="Animals Menu" CausesValidation="false"/>
            

            <br />

        </div>
    </form>
</body>
</html>
