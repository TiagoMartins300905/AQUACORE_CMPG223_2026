<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add_Medical_R.aspx.cs" Inherits="AQUACORE_CMPG223.Add_Medical_R" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            Add a Medical Record
            <br />
            <asp:Label ID="Label10" runat="server" ForeColor="Gray" Text="Enter all required details to add a medical record"></asp:Label>
            <br />
        </div>
        <div>

            <br />
            <asp:Label ID="Label11" runat="server" Text="Record ID:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtRecordID" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRecordID" ErrorMessage="Record ID Required!!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label12" runat="server" Text="Animal ID:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtAnimalID" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAnimalID" ErrorMessage="Animal ID Required" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label13" runat="server" Text="Veterinarian Name:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtVet" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtVet" ErrorMessage="Veterinarian Name Required!!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label14" runat="server" Text="Date Of Check-Up:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtCheckUp" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtVet" ErrorMessage="Date of check-up required!!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label15" runat="server" Text="Follow-Up Required?"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="rdbYes" runat="server" ForeColor="Black" GroupName="FollowUp" OnCheckedChanged="rdbYes_CheckedChanged" Text="Yes" TextAlign="Left" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="rdbNo" runat="server" GroupName="FollowUp" OnCheckedChanged="rdbYes_CheckedChanged" Text="No" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblValidate" runat="server" ForeColor="Red" Text="Please choose an option"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnAdd" runat="server" Text="Add Record" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnBack" runat="server" Text="Medicals Menu" CausesValidation="false" OnClick="btnBack_Click" />

        </div>
    </form>
</body>
</html>
