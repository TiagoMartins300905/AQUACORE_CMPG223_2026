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
            <br />
            <br />
            <asp:Label ID="Label12" runat="server" Text="Animal ID:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtAnimalID" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label13" runat="server" Text="Veterinarian Name:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtVet" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label14" runat="server" Text="Date Of Check-Up:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtCheckUp" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label15" runat="server" Text="Follow-Up Required?"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="rdbYes" runat="server" ForeColor="Black" GroupName="FollowUp" OnCheckedChanged="rdbYes_CheckedChanged" Text="Yes" TextAlign="Left" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="rdbNo" runat="server" GroupName="FollowUp" OnCheckedChanged="rdbYes_CheckedChanged" Text="No" />
            <br />
            <br />
            <asp:Button ID="btnAdd" runat="server" Text="Add Record" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnBack" runat="server" Text="Medicals Menu" />

        </div>
    </form>
</body>
</html>
