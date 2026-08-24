<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorTicket.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorTicket" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Your Ticket</title>
    <link rel ="website icon" type ="png" href ="BRZLogo.png" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        body{ 
            font-family:'Poppins',sans-serif; background:#B1FFFF; display:flex; justify-content:center; align-items:center; height:100vh; }
        .ticket{ 
            background:#fff; padding:30px; border-radius:12px; box-shadow:0 6px 14px rgba(0,0,0,0.2); text-align:center; width:300px; position:relative; }
        h2{ 
            color:#14532d; margin-bottom:20px; }
        img{ 
            margin-top:15px; }
        .btn-back, .btn-print { background:#14532d; color:white; border:none; padding:6px 12px; border-radius:6px; cursor:pointer; margin:5px; }
        .btn-back { 
            position:absolute; top:15px; left:15px; }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="ticket">
        <asp:Button ID="btnBack" runat="server" Text="← Back" OnClick="btnBack_Click" CssClass="btn-back" />
        <h2>Your Ticket Details</h2>
        <asp:Label ID="lblDetails" runat="server" />
        <br />
        <asp:Image ID="imgQR" runat="server" Width="200px" Height="200px" />
        <br />
        <asp:Button ID="btnPrint" runat="server" Text="Print Ticket" OnClientClick="window.print(); return false;" CssClass="btn-print" />
    </div>
</form>
</body>
</html>