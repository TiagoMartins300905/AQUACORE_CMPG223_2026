<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorWelcomePage.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorWelcomePage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AQUACORE AQUARIUM</title>
    <link rel="website icon" type="png" href="BRZLogo.png" />
    <style>
        body {
            background-color: #B1FFFF;
            font-family: 'Poppins', sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        h1 {
            font-size: 36px;
            font-weight: 700;
            color: #14532d;
            margin-top: 20px;
        }

        .subtext {
            font-size: 18px;
            font-style: italic;
            color: #2f855a;
            margin-bottom: 30px;
        }

        .image-gallery {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            padding: 20px;
        }

        .image-gallery img {
            width: 400px;
            height: 470px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .button-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
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
        .auto-style1 {
            width: 427px;
            height: 640px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>WELCOME AQUACORE AQUARIUM!</h1>
        <p class="subtext">Water awaits!</p>

        <div class="image-gallery">
    <img alt="Otter" src="AQUACORE_IMAGES/Otter.jpg" />
    <img alt="Penguin" src="AQUACORE_IMAGES/Penguin.jpg" />
    <img alt="Giraffe" src="AQUACORE_IMAGES/20 Trendy Jellyfish.jpg" />
</div>

        <div class="button-container">
            <asp:Button ID="Button1" runat="server" CssClass="btn login-btn" Text="Login" OnClick="Button1_Click" />
            <asp:Button ID="Button2" runat="server" CssClass="btn signup-btn" Text="Sign Up" OnClick="Button2_Click" />
            <asp:Button ID="Button3" runat="server" CssClass="btn back-btn" Text="Back" OnClick="Button3_Click" />
        </div>
    </form>
</body>
</html>