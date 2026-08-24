<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorForgotPassword.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorForgotPassword" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>
    <link rel="website icon" type="png" href="BRZLogo.png" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #dbeafe, #bfdbfe);
            font-family:'Poppins',sans-serif;
            margin:0;
            display:flex;
            align-items:center;
            justify-content:center;
            height:100vh;
        }
        .card {
            background:#fff;
            width:380px;
            padding:30px;
            border-radius:16px;
            box-shadow:0 8px 20px rgba(0,0,0,0.15);
            text-align:center;
        }
        h2 { color:#1e3a8a; margin-bottom:20px }
        label { 
            font-weight:600; 
            display:block; 
            text-align:left; 
            margin-top:12px; 
            margin-bottom:6px; 
            color:#374151; 
        }
        input {
            width:100%;
            padding:12px;
            border:1px solid #ccc;
            border-radius:8px;
            margin-bottom:12px;
            font-size:15px;
            box-sizing:border-box;
        }
        .btn {
            width:100%;
            padding:12px;
            background:#3b82f6;
            color:#fff;
            border:none;
            border-radius:10px;
            font-weight:600;
            font-size:15px;
            cursor:pointer;
            transition:background 0.3s;
            margin-top:10px;
        }
        .btn:hover { background:#2563eb }
        .msg { margin-top:12px; font-weight:600; color:#dc2626 }
        .back-link {
            display:block;
            margin-top:16px;
            color:#2563eb;
            font-weight:600;
            text-decoration:none;
            transition:color 0.3s;
        }
        .back-link:hover { color:#1e40af }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="card">
        <h2>Forgot Password</h2>

        
        <label for="txtEmail">Enter your email</label>
        <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter registered email" />
        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="⚠ Email required" ForeColor="Red" Display="Dynamic" />
        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="⚠ Enter valid email"  ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red" Display="Dynamic" />

        <asp:Button ID="btnReset" runat="server" Text="Reset Password" CssClass="btn" OnClick="btnReset_Click" />

        <div class="msg"><asp:Label ID="lblMsg" runat="server" /></div>

        <a href="VisitorLogin.aspx" class="back-link">Back to Login</a>
    </div>
</form>
</body>
</html>