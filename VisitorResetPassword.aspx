<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorResetPassword.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorResetPassword" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset Password</title>
    <link rel ="website icon" type ="png" href ="BRZLogo.png" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        body{ background:#B1FFFF; font-family:'Poppins',sans-serif; margin:0 }
        
        .back-btn{ 
            position:absolute; top:15px; left:15px }
        .back-btn a{ 
            text-decoration:none; font-size:16px; color:#14532d; font-weight:600 }
        .card{ 
            background:#fff; width:360px; margin:100px auto; padding:28px; border-radius:14px; box-shadow:0 6px 16px rgba(0,0,0,.2) }
        h2{ 
            text-align:center; color:#14532d; margin-bottom:12px }
        input{ 
            width:100%; padding:10px; border:1px solid #ccc; border-radius:8px; margin-top:14px; font-size:15px }
        .btn{ 
            width:100%; padding:12px; background:#10b981; color:#fff; border:none; border-radius:10px; font-weight:600; margin-top:16px; cursor:pointer }
        
        .btn:hover{ 
            background:#059669 }
        .msg
        { 
            text-align:center; margin-top:12px; font-weight:600 }
        .input-field 
        {
            width:100%;
            padding:10px;
            border:1px solid #ccc;
            border-radius:8px;
            margin-top:6px;
            font-size:15px;
            box-sizing:border-box;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="back-btn"><a href="VisitorForgotPassword.aspx">← Back</a></div>

    <div class="card">
        <h2>Reset Password</h2>

        <div style="margin-bottom:16px;">
            <label for="txtNewPass">New Password</label>
            <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" CssClass="input-field" placeholder="New Password" />
            <asp:RequiredFieldValidator ID="rfvNewPass" runat="server" ControlToValidate="txtNewPass" ErrorMessage="⚠ New password required" ForeColor="Red" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtNewPass" ErrorMessage="⚠ Password must be at least 6 characters, include uppercase, lowercase, number & symbol" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?/~\-]).{6,}$" ForeColor="Red" Display="Dynamic" />
            <small>(Password must be at least 6 characters and include 1 uppercase letter, 1 lowercase letter, 1 number, 1 special symbol)</small>
        </div>

        <div style="margin-bottom:16px;">
            <label for="txtConfirmPass">Confirm Password</label>
            <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="input-field" placeholder="Confirm New Password" />
            <asp:RequiredFieldValidator ID="rfvConfirmPass" runat="server" ControlToValidate="txtConfirmPass" ErrorMessage="⚠ Confirm password required" ForeColor="Red" Display="Dynamic" />
            <asp:CompareValidator ID="cvPass" runat="server" ControlToValidate="txtConfirmPass" ControlToCompare="txtNewPass" ErrorMessage="⚠ Passwords must match" ForeColor="Red" Display="Dynamic" />
        </div>
        
        <asp:Button ID="btnChange" runat="server" Text="Change Password" CssClass="btn" OnClick="btnChange_Click" />
        <div class="msg"><asp:Label ID="lblMsg" runat="server" /></div>

        <div style="text-align:center; margin-top:10px;">
            <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="VisitorLogin.aspx" Text="Back to Login" Visible="false" style="color:#2563eb; font-weight:600; text-decoration:none;" />
        </div>

    </div>
</form>
</body>
</html>