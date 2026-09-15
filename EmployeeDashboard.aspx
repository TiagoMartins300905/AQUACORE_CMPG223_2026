<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeDashboard.aspx.cs" Inherits="AQUACORE_CMPG223.EmployeeDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AquaCore - Employee Dashboard</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

    <style>
        :root {
            --bg-base: #030a16;
            --surface: rgba(8, 22, 44, 0.65);
            --border-glow: rgba(0, 210, 255, 0.22);
            --text-main: #f8fafc;
            --text-sub: #94a3b8;
            --font-family: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: var(--font-family);
        }

        body {
            background-color: var(--bg-base);
            background-image: 
                radial-gradient(circle at 15% 20%, rgba(2, 132, 199, 0.15) 0%, transparent 40%),
                radial-gradient(circle at 85% 80%, rgba(13, 148, 136, 0.12) 0%, transparent 45%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2.5rem 1.5rem;
            position: relative;
            overflow-x: hidden;
            color: var(--text-main);
        }

        .ambient-orb {
            position: absolute;
            border-radius: 50%;
            pointer-events: none;
            filter: blur(100px);
            opacity: 0.35;
            z-index: 0;
        }
        .orb-1 { width: 450px; height: 450px; background: radial-gradient(circle, #0284c7, #003e74); top: -80px; left: -100px; }
        .orb-2 { width: 550px; height: 550px; background: radial-gradient(circle, #0d9488, #002b48); bottom: -150px; right: -100px; }

        .dashboard-wrapper {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 600px; 
        }

        .glass-card {
            background: var(--surface);
            backdrop-filter: blur(24px) saturate(180%);
            -webkit-backdrop-filter: blur(24px) saturate(180%);
            border: 1px solid var(--border-glow);
            border-radius: 24px;
            padding: 3rem 2.5rem;
            box-shadow: 0 30px 60px -12px rgba(0, 0, 0, 0.65);
            text-align: center;
        }

        .welcome-text h1 {
            font-size: 2.2rem;
            font-weight: 700;
            background: linear-gradient(135deg, #ffffff 40%, #bae6fd 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 5px;
        }

        .welcome-text p {
            color: var(--text-sub);
            font-size: 0.95rem;
            margin-bottom: 30px;
        }

        .role-badge {
            display: inline-block;
            background: rgba(0, 210, 255, 0.15);
            color: #00d2ff;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 25px;
            border: 1px solid rgba(0, 210, 255, 0.3);
        }

        .btn-grid {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-bottom: 30px;
        }

        .dash-btn {
            width: 100%;
            padding: 16px;
            border: 1px solid rgba(148, 163, 184, 0.2);
            border-radius: 12px;
            background: rgba(3, 10, 22, 0.55);
            color: #ffffff;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            text-align: left;
            display: flex;
            align-items: center;
            gap: 15px;
            text-decoration: none;
        }

        .dash-btn:hover {
            background: rgba(0, 210, 255, 0.1);
            border-color: rgba(0, 210, 255, 0.4);
            transform: translateY(-2px);
        }

        .btn-icon {
            font-size: 1.4rem;
        }

        .logout-btn {
            background: transparent;
            color: #ff4d4d;
            border: 1px solid rgba(255, 77, 77, 0.3);
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .logout-btn:hover {
            background: rgba(255, 77, 77, 0.1);
        }
    </style>
</head>
<body>
    <div class="ambient-orb orb-1"></div>
    <div class="ambient-orb orb-2"></div>

    <div class="dashboard-wrapper">
        <form id="Form1" runat="server" class="glass-card">
            
            <div class="welcome-text">
                <h1><asp:Label ID="LblWelcomeName" runat="server" Text="Welcome"></asp:Label></h1>
                <p>Select a portal below to manage operations.</p>
                <asp:Label ID="LblRole" runat="server" CssClass="role-badge" Text="Role: Unknown"></asp:Label>
            </div>

            <div class="btn-grid">
                <!-- Animal Management Button (Role Restricted) -->
                <asp:LinkButton ID="BtnAnimal" runat="server" CssClass="dash-btn" OnClick="BtnAnimal_Click" Visible="false">
                    <span class="btn-icon">🐬</span> Animal Management Dashboard
                </asp:LinkButton>

                <!-- Restaurant Orders Button (Role Restricted) -->
                <asp:LinkButton ID="BtnRestaurant" runat="server" CssClass="dash-btn" OnClick="BtnRestaurant_Click" Visible="false">
                    <span class="btn-icon">🍽️</span> Restaurant Orders Dashboard
                </asp:LinkButton>

                <!-- Adaptive Button: Becomes "Manage Employees" for Admins/Managers, or "Update My Details" for Staff -->
                <asp:LinkButton ID="BtnAdaptiveAction" runat="server" CssClass="dash-btn" OnClick="BtnAdaptiveAction_Click">
                    <span class="btn-icon" id="SpanIcon" runat="server">✏️</span> 
                    <asp:Literal ID="LitBtnText" runat="server" Text="Update My Details"></asp:Literal>
                </asp:LinkButton>
            </div>

            <asp:Button ID="BtnLogout" runat="server" Text="Sign Out" CssClass="logout-btn" OnClick="BtnLogout_Click" />

        </form>
    </div>
</body>
</html>