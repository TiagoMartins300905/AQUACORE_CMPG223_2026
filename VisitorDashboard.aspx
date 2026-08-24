<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorDashboard.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Visitor Dashboard</title>
    <style>
        body {
            background-color: #B1FFFF;
            font-family: 'Poppins', sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(4px);
            padding: 20px 30px;
            border-radius: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .header h2 {
            font-size: 28px;
            font-weight: 700;
            color: #14532d;
            margin: 0;
        }

        .header h2 span {
            color: #0f766e;
        }

        .welcome-text {
            font-size: 16px;
            color: #2f855a;
            margin-top: 5px;
            font-style: italic;
        }

        .logout-btn {
            color: #dc2626;
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
            padding: 8px 20px;
            border: 2px solid #dc2626;
            border-radius: 8px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.5);
        }

        .logout-btn:hover {
            background: #dc2626;
            color: white;
            text-decoration: none;
        }

        .menu {
            display: flex;
            gap: 20px;
            margin-top: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .menu a {
            padding: 12px 35px;
            background-color: #3b82f6;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 18px;
            transition: background-color 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .menu a:hover {
            background-color: #2563eb;
        }

        .image-gallery {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            padding: 20px;
            margin-top: 20px;
        }

        .image-gallery img {
            width: 400px;
            height: 470px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .btn {
            padding: 12px 30px;
            font-size: 18px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: 600;
        }

        .login-btn {
            background-color: #fc9834;
            color: white;
        }

        .login-btn:hover {
            background-color: #0f766e;
        }

        .signup-btn {
            background-color: #3b82f6;
            color: white;
        }

        .signup-btn:hover {
            background-color: #2563eb;
        }

        .back-btn {
            background-color: #6b7280;
            color: white;
        }

        .back-btn:hover {
            background-color: #374151;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-container">
            <div class="header">
                <div>
                    <h2>Welcome, <span><asp:Label ID="lblName" runat="server" /></span>!</h2>
                    <div class="welcome-text">Water awaits!</div>
                </div>
                <asp:LinkButton ID="btnLogout" runat="server" CssClass="logout-btn" Text="Logout" OnClick="btnLogout_Click" />
            </div>

            <div class="menu">
                <a href="VisitorReservations.aspx">Book Tickets</a>
                <a href="VisitorMyReservations.aspx">My Reservations</a>
            </div>

            <div class="image-gallery">
                <asp:Image ID="img1" runat="server" ImageUrl="~/AQUACORE_IMAGES/Otter.jpg" />
                <asp:Image ID="img2" runat="server" ImageUrl="~/AQUACORE_IMAGES/Penguin.jpg" />
                <asp:Image ID="img3" runat="server" ImageUrl="~/AQUACORE_IMAGES/20 Trendy Jellyfish.jpg" />
            </div>
        </div>
    </form>
</body>
</html>