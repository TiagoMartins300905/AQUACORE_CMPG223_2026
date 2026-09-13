<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateOrder.aspx.cs" Inherits="AQUACORE_CMPG223.UpdateOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Order Update"></asp:Label>
        </div>
        <p>
            <asp:Label ID="Label6" runat="server" Text="Order ID"></asp:Label>
            :&nbsp;
            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtOrderID" ErrorMessage="RequiredFieldValidator">OrderID cannot be empty!</asp:RequiredFieldValidator>
        </p>
        <p>
            <asp:Label ID="Label7" runat="server" Text="Customer Name:"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCustomerName" ErrorMessage="RequiredFieldValidator">Customer name cannot be empty!</asp:RequiredFieldValidator>
        </p>
        <p>
            <asp:Label ID="Label8" runat="server" Text="Table Number:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtTable" ErrorMessage="RequiredFieldValidator">Table number cannot be empty!</asp:RequiredFieldValidator>
        </p>
        <p style="height: 173px">
            <asp:Label ID="Label9" runat="server" Text="Food Item: "></asp:Label>
            <asp:CheckBoxList ID="cblFooditems" runat="server">
                <asp:ListItem Value="55">Burger - R55</asp:ListItem>
                <asp:ListItem Value="85">Pizza - R85</asp:ListItem>
                <asp:ListItem Value="65">Pasta - R65</asp:ListItem>
                <asp:ListItem Value="25">Drink - R25</asp:ListItem>
            </asp:CheckBoxList>
        </p>
        <p>
            <asp:Label ID="Label10" runat="server" Text="Quantity: "></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtQuantity" ErrorMessage="RequiredFieldValidator">Quantity cannot be empty!</asp:RequiredFieldValidator>
        </p>
        <p>
            <asp:Label ID="Label13" runat="server" Text="OrderDate:"></asp:Label>
&nbsp;&nbsp;
            <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtDate" ErrorMessage="RequiredFieldValidator">OrderDate cannot be empty!</asp:RequiredFieldValidator>
        </p>
        <p>
            <asp:Label ID="Label11" runat="server" Text="Status:"></asp:Label>
&nbsp;<asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem Value="0">---Select---</asp:ListItem>
                <asp:ListItem>Pending</asp:ListItem>
                <asp:ListItem>Completed</asp:ListItem>
            </asp:DropDownList>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="Label12" runat="server" Text="Total Prize: "></asp:Label>
            <asp:Label ID="lblPrize" runat="server" Text="label"></asp:Label>
        </p>
        <asp:Button ID="Button2" runat="server" Text="Update" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" Text="Order Dashboard" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
