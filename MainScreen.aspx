<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainScreen.aspx.cs" Inherits="AQUACORE_CMPG223.MainScreen" %>

<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head runat="server">
    <title>AquaCore Aquarium - Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" type="image/png" href="BRZLogo.png" />
    <link href="css/StyleSheet1.css" rel="stylesheet" />

    <style>
        :root {
            --green-dark: #14532d;
            --green: #15803d;
            --green-light: #22c55e;
            --teal: #0f766e;
            --teal-light: #14b8a6;
            --aqua-light: #dffcf7;
            --aqua-mid: #c9f8ed;
            --white: #ffffff;
            --text-dark: #16352f;
            --text-muted: #5f7771;
            --orange: #f97316;
            --blue: #2563eb;
            --shadow: 0 10px 30px rgba(15, 118, 110, 0.14);
            --shadow-hover: 0 16px 35px rgba(15, 118, 110, 0.22);
        }

        /* =========================
           GLOBAL
        ========================= */
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
                radial-gradient(circle at 10% 10%, rgba(34, 197, 94, 0.17), transparent 30%),
                radial-gradient(circle at 90% 85%, rgba(20, 184, 166, 0.17), transparent 30%),
                linear-gradient(135deg, #dffff8 0%, #c9f8ed 50%, #b8eee4 100%);
            padding: 30px 20px;
        }

        /* =========================
           MAIN CONTAINER
        ========================= */
        .main-container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* =========================
           HEADER
        ========================= */
        header {
            text-align: center;
            background: rgba(255, 255, 255, 0.80);
            border: 1px solid rgba(255, 255, 255, 0.85);
            border-radius: 24px;
            padding: 28px 20px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            margin-bottom: 15px;
        }

        .logo {
            width: 75px;
            height: 75px;
            object-fit: contain;
            margin-bottom: 10px;
            border-radius: 18px;
        }

        header h1 {
            color: var(--green-dark);
            font-size: 34px;
            font-weight: 750;
            margin-bottom: 6px;
            letter-spacing: -0.5px;
        }

        .header-subtext {
            color: var(--teal);
            font-size: 15px;
            font-style: italic;
        }

        /* =========================
           NAVIGATION
        ========================= */
        nav {
            display: flex;
            justify-content: center;
            align-items: center;
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
            transition: background-color 0.25s ease, transform 0.25s ease;
        }

        nav a:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-1px);
            color: white;
        }

        /* =========================
           HERO / CONTENT
        ========================= */
        .content {
            text-align: center;
            background: rgba(255, 255, 255, 0.72);
            border: 1px solid rgba(255, 255, 255, 0.80);
            border-radius: 22px;
            padding: 40px 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(8px);
            margin-bottom: 25px;
        }

        .content h2 {
            color: var(--green-dark);
            font-size: 29px;
            margin-bottom: 10px;
        }

        .content p {
            max-width: 700px;
            margin: 0 auto 30px;
            color: var(--text-muted);
            font-size: 15px;
            line-height: 1.7;
        }

        /* =========================
           ROLE BUTTONS
        ========================= */
        .button-container {
            display: grid;
            /* Changed to 2 columns to perfectly fit the two remaining buttons */
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            max-width: 600px; /* Reduced max-width so they aren't stretched too wide */
            margin: 0 auto;
        }

        .role-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 190px;
            padding: 25px 20px;
            border: none;
            border-radius: 17px;
            color: white;
            cursor: pointer;
            font-size: 20px;
            font-weight: 700;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .role-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-hover);
        }

        /* Visitor */
        .visitor-card {
            background: linear-gradient(135deg, #0f766e, #15803d);
        }

        /* Staff */
        .staff-card {
            background: linear-gradient(135deg, #15803d, #22c55e);
        }

        /* =========================
           FOOTER
        ========================= */
        .footer {
            text-align: center;
            color: var(--text-muted);
            font-size: 12px;
            padding: 10px;
        }

        /* =========================
           TABLET & MOBILE
        ========================= */
        @media (max-width: 850px) {
            .button-container {
                grid-template-columns: 1fr;
                max-width: 350px;
            }
            .role-card { min-height: 150px; }
        }

        @media (max-width: 600px) {
            body { padding: 20px 12px; }
            header { padding: 25px 15px; border-radius: 18px; }
            header h1 { font-size: 27px; }
            .logo { width: 65px; height: 65px; }
            nav { margin-bottom: 18px; }
            .content { padding: 30px 18px; border-radius: 18px; }
            .content h2 { font-size: 24px; }
            .content p { font-size: 14px; margin-bottom: 25px; }
            .button-container { gap: 14px; }
            .role-card { min-height: 145px; padding: 20px; }
        }
    </style>
</head> 
<body>
<form id="form1" runat="server">
    <div class="main-container">

        <!-- HEADER -->
        <header>
            <img src="BRZLogo.png" alt="AquaCore Aquarium Logo" class="logo" />
            <h1>Welcome to AQUACORE AQUARIUM</h1>
            <p class="header-subtext">Discover the wonder beneath the surface.</p>
        </header>

        <!-- NAVIGATION -->
        <nav>
            <a href="Contact.aspx">Contact Us</a>
        </nav>

        <!-- MAIN CONTENT -->
        <div class="content">
            <h2>Experience the Underwater World</h2>
            <p>
                Explore amazing aquatic life, book your aquarium
                experience, and access the tools you need.
                Choose your role below to get started.
            </p>

            <!-- ROLE BUTTONS -->
            <div class="button-container">
                <!-- VISITOR -->
                <asp:Button
                    ID="btnVisitors"
                    runat="server"
                    Text="Visitors"
                    CssClass="role-card visitor-card"
                    OnClick="btnVisitors_Click" />

                <!-- STAFF -->
                <asp:Button
                    ID="btnStaff"
                    runat="server"
                    Text="Staff"
                    CssClass="role-card staff-card"
                    OnClick="btnStaff_Click" />
            </div>
        </div>

        <!-- FOOTER -->
        <div class="footer">
            AquaCore • Discover • Explore • Experience
        </div>

    </div>
</form>
</body> 
</html>