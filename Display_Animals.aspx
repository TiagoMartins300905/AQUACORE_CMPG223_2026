<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Display_Animals.aspx.cs" Inherits="AQUACORE_CMPG223.Display_Animals" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            AquaCore Animals
        </div>

        

        <div>
            <asp:GridView ID="GridView1" runat="server" Height="343px" style="text-align: left" Width="384px">
            </asp:GridView>
        </div>
    </form>
</body>
</html>
