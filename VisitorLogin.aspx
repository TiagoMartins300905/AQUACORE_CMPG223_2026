<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorLogin.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorLogin" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Blue River Zoo Visitor Portal</title>
    <link rel="icon" type="image/png" href="BRZLogo.png" />
    <style type="text/css">
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap');

        * {
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: url('tiger.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 0;
        }

        .login-container {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,.3);
            width: 360px;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            font-weight: 600;
            color: #1f2937;
        }

        label {
            font-weight: 500;
            margin-top: 12px;
            display: block;
            text-align: left;
            color: #111827;
        }

        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-top: 6px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            margin-top: 18px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background: #3e8e41;
        }

        .msg {
            margin-top: 12px;
            font-weight: 600;
            color: red;
        }

        .links {
            margin-top: 14px;
            font-size: 14px;
        }

        .links a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
            margin: 0 6px;
        }

        .links a:hover {
            text-decoration: underline;
        }

        .back-btn {
            position: absolute;
            top: 15px;
            left: 15px;
            z-index: 1;
        }

        .back-btn a {
            text-decoration: none;
            font-size: 16px;
            color: #fff;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="back-btn"><a href="VisitorWelcomePage.aspx">← Back</a></div>

        <div class="login-container">
            <h2>Login</h2>

            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Enter email"/>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                ErrorMessage="⚠ Email is required" ForeColor="Red" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                ErrorMessage="⚠ Enter a valid email address" ForeColor="Red" Display="Dynamic"
                ValidationExpression="\w+([-+.\']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />

            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter password"/>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                ErrorMessage="⚠ Password is required" ForeColor="Red" Display="Dynamic" />

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />

            <div class="msg"><asp:Label ID="lblMsg" runat="server" /></div>

            <!-- Forgot Password & Sign Up Links -->
            <div class="links">
                <a href="VisitorForgotPassword.aspx">Forgot Password?</a> |
                <a href="VisitorSignUp.aspx">Sign Up</a>
            </div>
        </div>
    </form>
</body>
</html>
