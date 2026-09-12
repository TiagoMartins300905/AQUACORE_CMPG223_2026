<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateMedical.aspx.cs" Inherits="AQUACORE_CMPG223.UpdateMedical" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            Update a Medical Record
            <br />
            <asp:Label ID="Label10" runat="server" ForeColor="Gray" Text="Enter all required details to update a medical record"></asp:Label>
            <br />
        </div>
        <div>

            <br />
            <asp:Label ID="Label11" runat="server" Text="Record ID:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;<asp:DropDownList ID="ddlMedical" runat="server" Height="28px" Width="193px">
                <asp:ListItem>--Select Medical ID--</asp:ListItem>
            </asp:DropDownList>
            &nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRecordID" ErrorMessage="Record ID Required!!" ForeColor="Red" InitialValue="--Select Medical ID--"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label12" runat="server" Text="Animal ID:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="ddlAnimal" runat="server" Height="17px" Width="196px">
                <asp:ListItem>--Select Animal ID--</asp:ListItem>
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <asp:Label ID="Label13" runat="server" Text="Veterinarian Name:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtVet" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <asp:Label ID="Label14" runat="server" Text="Date Of Check-Up:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtCheckUp" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <asp:Label ID="Label15" runat="server" Text="Follow-Up Required?"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="rdbYes" runat="server" ForeColor="Black" GroupName="FollowUp" OnCheckedChanged="rdbYes_CheckedChanged" Text="Yes" TextAlign="Left" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="rdbNo" runat="server" GroupName="FollowUp" OnCheckedChanged="rdbYes_CheckedChanged" Text="No" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <asp:Button ID="btnUpdate" runat="server" Text="Update Record" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnBack" runat="server" Text="Medicals Menu" CausesValidation="false" OnClick="btnBack_Click" />

        </div>
        <div>
        </div>
    </form>
</body>
</html>
