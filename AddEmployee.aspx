<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="AQUACORE_CMPG223.AddEmployee" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AquaCore - Register Personnel</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

    <style>
        :root { --bg-base: #030a16; --surface: rgba(8, 22, 44, 0.65); --border-glow: rgba(0, 210, 255, 0.22); --text-main: #f8fafc; --text-sub: #94a3b8; --accent-cyan: #00f0ff; --font-family: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif; }
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: var(--font-family); }
        body { background-color: var(--bg-base); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 2.5rem 1.5rem; position: relative; overflow-x: hidden; color: var(--text-main); }
        .ambient-orb { position: absolute; border-radius: 50%; pointer-events: none; filter: blur(100px); opacity: 0.35; z-index: 0; }
        .orb-1 { width: 450px; height: 450px; background: radial-gradient(circle, #0284c7, #003e74); top: -80px; left: -100px; }
        .orb-2 { width: 550px; height: 550px; background: radial-gradient(circle, #0d9488, #002b48); bottom: -150px; right: -100px; }
        .portal-wrapper { position: relative; z-index: 1; width: 100%; max-width: 650px; }
        .glass-card { background: var(--surface); backdrop-filter: blur(24px) saturate(180%); border: 1px solid var(--border-glow); border-radius: 24px; padding: 2.75rem 2.5rem; box-shadow: 0 30px 60px -12px rgba(0, 0, 0, 0.65); }
        .card-header { text-align: center; margin-bottom: 2rem; }
        .card-header h1 { font-size: 2rem; font-weight: 700; background: linear-gradient(135deg, #ffffff 40%, #bae6fd 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 0.4rem; }
        .card-header p { color: var(--text-sub); font-size: 0.9rem; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px; }
        .form-field { display: flex; flex-direction: column; }
        label { font-size: 0.8rem; font-weight: 600; color: #cbd5e1; margin-bottom: 6px; }
        .input-box { width: 100%; padding: 12px 14px; background: rgba(3, 10, 22, 0.55); border: 1px solid rgba(148, 163, 184, 0.18); border-radius: 12px; color: #ffffff; font-size: 0.92rem; outline: none; }
        .input-box:focus { border-color: var(--accent-cyan); box-shadow: 0 0 0 3px rgba(0, 240, 255, 0.18); }
        select.input-box option { background-color: #08162c; color: #f8fafc; }
        .actions-wrapper { margin-top: 1.75rem; display: flex; flex-direction: column; gap: 10px; }
        .btn-submit { width: 100%; padding: 13px; border: none; border-radius: 12px; background: linear-gradient(135deg, #00f0ff 0%, #0284c7 100%); color: #030a16; font-size: 0.95rem; font-weight: 700; cursor: pointer; }
        .btn-submit:hover { filter: brightness(1.08); }
        .btn-secondary { display: inline-block; text-align: center; width: 100%; padding: 11px; border-radius: 12px; background: transparent; border: 1px solid rgba(148, 163, 184, 0.2); color: var(--text-sub); font-size: 0.88rem; font-weight: 600; text-decoration: none; }
        .btn-secondary:hover { background: rgba(255, 255, 255, 0.05); color: #ffffff; }
        .status-alert { display: block; margin-top: 1.25rem; font-size: 0.85rem; font-weight: 600; text-align: center; }
        @media (max-width: 600px) { .form-row { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
    <div class="ambient-orb orb-1"></div>
    <div class="ambient-orb orb-2"></div>

    <div class="portal-wrapper">
        <form id="Form1" runat="server" class="glass-card">
            
            <div class="card-header">
                <h1>Enroll Personnel</h1>
                <p>Register new staff members into the aquatic management system.</p>
            </div>

            <div class="form-row">
                <div class="form-field">
                    <label>Name</label>
                    <asp:TextBox ID="TxtName" runat="server" CssClass="input-box" placeholder="e.g. John" />
                </div>
                <div class="form-field">
                    <label>Surname</label>
                    <asp:TextBox ID="TxtSurname" runat="server" CssClass="input-box" placeholder="e.g. Doe" />
                </div>
            </div>

            <div class="form-row">
                <div class="form-field">
                    <label>Username</label>
                    <asp:TextBox ID="TxtUsername" runat="server" CssClass="input-box" placeholder="e.g. jdoe123" />
                </div>
                <div class="form-field">
                    <label>Password</label>
                    <asp:TextBox ID="TxtPassword" runat="server" CssClass="input-box" TextMode="Password" placeholder="Enter password" />
                </div>
            </div>

            <div class="form-row">
                <div class="form-field">
                    <label>Role</label>
                    <asp:DropDownList ID="DdlRole" runat="server" CssClass="input-box">
                        <asp:ListItem Text="-- Select Role --" Value="" />
                        <asp:ListItem Text="Manager" Value="Manager" />
                        <asp:ListItem Text="Marine Keeper" Value="Marine Keeper" />
                        <asp:ListItem Text="Restaurant Employee" Value="RestaurantEmployee" />
                        <asp:ListItem Text="Admin" Value="Admin" />
                    </asp:DropDownList>
                </div>
                <div class="form-field">
                    <label>Contact Details</label>
                    <asp:TextBox ID="TxtContactDetails" runat="server" CssClass="input-box" placeholder="e.g. 082 123 4567" />
                </div>
            </div>

            <div class="actions-wrapper">
                <asp:Button ID="BtnSubmit" runat="server" Text="Confirm &amp; Register" CssClass="btn-submit" OnClick="BtnSubmit_Click" />
                <a href="EmployeeManagement.aspx" class="btn-secondary">Return to Staff Directory</a>
            </div>

            <asp:Label ID="LblStatus" runat="server" CssClass="status-alert" />

        </form>
    </div>
</body>
</html>