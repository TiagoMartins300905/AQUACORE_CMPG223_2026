<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainScreen.aspx.cs" Inherits="AQUACORE_CMPG223.MainScreen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Blue River Zoo System - Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" type="image/png" href="BRZLogo.png" />
    <link href="css/StyleSheet1.css" rel="stylesheet" />
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; margin: 0; padding: 0; background: #f9f9f9; }
        header { background-color: #2e7d32; color: white; padding: 20px; text-align: center; }
        nav { display: flex; justify-content: center; background-color: #388e3c; padding: 12px; }
        nav a { color: white; text-decoration: none; margin: 0 15px; font-weight: bold; transition: color 0.3s; }
        nav a:hover { color: #ffeb3b; }
        .content { text-align: center; padding: 40px; }
        .content h1 { font-size: 36px; margin-bottom: 15px; color: #333; }
        .content p { font-size: 18px; margin-bottom: 25px; color: #555; }
        .btn { padding: 30px 60px; background-color: #2e7d32; color: white; border: none; border-radius: 6px; cursor: pointer; margin: 8px; transition: background 0.3s; }
        .btn:hover { background-color: #1b5e20; }
        .auto-style1 { text-align: right; }
        .auto-style3 { border-style: none; border-color: inherit; border-width: medium; padding: 50px 100px; background-color: #2e7d32; color: white; border-radius: 6px; cursor: pointer; margin: 8px; transition: background 0.3s; font-size: x-large; }
        .auto-style4 { font-size: xx-large; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <img src="BRZLogo.png" alt="Zoo Logo" style="height:60px;" />
            <h2 class="auto-style4">Welcome to Blue River Zoo</h2>
        </header>

        <nav class="auto-style1">
            <a href="Contact.aspx">Contact</a>
        </nav>

        <div class="content">
            <h1>Experience the Wild Like Never Before!</h1>
            <p>Explore our collection of animals, book tickets, and manage zoo operations with ease.</p>
            <asp:Button ID="btnVisitors" runat="server" Text="Visitors" CssClass="auto-style3" OnClick="btnVisitors_Click" />
            <asp:Button ID="btnStaff" runat="server" Text="Staff" CssClass="auto-style3" OnClick="btnStaff_Click" />
            <asp:Button ID="btnAdmin" runat="server" Text="Admin" CssClass="auto-style3" OnClick="btnAdmin_Click" />
        </div>
    </form>
</body>
</html>
