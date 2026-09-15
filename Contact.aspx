<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="AQUACORE_CMPG223.Contact" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact & Help Desk - AquaCore</title>
    <link rel="icon" type="image/png" href="BRZLogo.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        :root {
            --green-dark: #14532d;
            --teal: #0f766e;
            --teal-light: #14b8a6;
            --aqua-light: #dffcf7;
            --text-dark: #16352f;
            --text-muted: #5f7771;
            --shadow: 0 10px 30px rgba(15, 118, 110, 0.14);
            --shadow-hover: 0 16px 35px rgba(15, 118, 110, 0.22);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            color: var(--text-dark);
            background:
                radial-gradient(circle at 10% 10%, rgba(34, 197, 94, 0.16), transparent 30%),
                radial-gradient(circle at 90% 90%, rgba(20, 184, 166, 0.16), transparent 30%),
                linear-gradient(135deg, #dffff8 0%, #c9f8ed 50%, #b8eee4 100%);
            padding: 35px 20px;
        }

        .main-container {
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
        }

        header {
            text-align: center;
            background: rgba(255, 255, 255, 0.80);
            border: 1px solid rgba(255, 255, 255, 0.85);
            border-radius: 24px;
            padding: 30px 25px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            margin-bottom: 25px;
        }

        header h1 {
            color: var(--green-dark);
            font-size: 32px;
            font-weight: 750;
            margin-bottom: 6px;
        }

        header p {
            color: var(--teal);
            font-size: 15px;
            font-style: italic;
        }

        nav {
            display: flex;
            justify-content: center;
            background: rgba(15, 118, 110, 0.94);
            border-radius: 12px;
            padding: 11px;
            margin-bottom: 25px;
            box-shadow: 0 6px 18px rgba(15, 118, 110, 0.15);
        }

        nav a {
            color: white;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            padding: 8px 22px;
            border-radius: 8px;
            transition: background-color 0.25s ease;
        }

        nav a:hover {
            background: rgba(255, 255, 255, 0.15);
        }

        .help-card {
            background: rgba(255, 255, 255, 0.78);
            border: 1px solid rgba(255, 255, 255, 0.85);
            border-radius: 22px;
            padding: 35px 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            text-align: center;
        }

        .help-card h2 {
            color: var(--green-dark);
            margin-bottom: 10px;
            font-size: 24px;
        }

        .help-card p {
            color: var(--text-muted);
            margin-bottom: 25px;
            font-size: 14px;
        }

        .btn {
            display: inline-block;
            margin: 8px;
            padding: 14px 28px;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--teal), var(--green-dark));
            color: white;
            font-size: 15px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            box-shadow: 0 5px 15px rgba(15, 118, 110, 0.20);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 22px rgba(15, 118, 110, 0.30);
        }

        #lblInfo {
            display: block;
            margin-top: 25px;
            padding: 18px 20px;
            font-size: 15px;
            color: var(--green-dark);
            font-weight: 600;
            background: rgba(255, 255, 255, 0.85);
            border-left: 4px solid var(--teal);
            border-radius: 10px;
            text-align: left;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-container">

            <header>
                <h1>Help Desk &amp; Contact Information</h1>
                <p>We're here to help you make the most of your visit</p>
            </header>

            <nav>
                <a href="MainScreen.aspx">Home</a>
            </nav>

            <div class="help-card">
                <h2>Need Assistance?</h2>
                <p>Select one of the following options for help:</p>

                <asp:Button ID="btnGeneral" runat="server" CssClass="btn" Text="General Information" OnClick="btnGeneral_Click" />
                <asp:Button ID="btnTickets" runat="server" CssClass="btn" Text="Ticket Help" OnClick="btnTickets_Click" />
                <asp:Button ID="btnLost" runat="server" CssClass="btn" Text="Lost &amp; Found" OnClick="btnLost_Click" />
                <asp:Button ID="btnEmergency" runat="server" CssClass="btn" Text="Emergency Contact" OnClick="btnEmergency_Click" />

                <asp:Label ID="lblInfo" runat="server" Text=""></asp:Label>
            </div>

        </div>
    </form>
</body>
</html>