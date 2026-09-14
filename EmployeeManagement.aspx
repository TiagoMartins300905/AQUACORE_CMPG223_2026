<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeManagement.aspx.cs" Inherits="AQUACORE_CMPG223.EmployeeManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AquaCore - Employee Management</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        :root {
            --bg-base: #030a16;
            --ocean-blue: #0b2545;
            --aqua-glow: #00d2ff;
            --card-glass: rgba(8, 22, 44, 0.70);
            --card-border: rgba(0, 210, 255, 0.22);
            --text-primary: #eef4f8;
            --text-muted: #8da4be;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Plus Jakarta Sans', 'Segoe UI', sans-serif;
        }

        body {
            background-color: var(--bg-base);
            background-image: 
                radial-gradient(circle at 15% 20%, rgba(2, 132, 199, 0.15) 0%, transparent 40%),
                radial-gradient(circle at 85% 80%, rgba(13, 148, 136, 0.12) 0%, transparent 45%);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px 20px;
            position: relative;
            overflow-x: hidden;
        }

        .ambient-orb {
            position: absolute;
            border-radius: 50%;
            pointer-events: none;
            filter: blur(120px);
            opacity: 0.25;
            z-index: 0;
        }
        .orb-1 { width: 500px; height: 500px; background: #0284c7; top: -100px; left: -100px; }
        .orb-2 { width: 600px; height: 600px; background: #0d9488; bottom: -150px; right: -100px; }

        .dashboard-container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 1100px;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .glass-panel {
            background: var(--card-glass);
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            border: 1px solid var(--card-border);
            border-radius: 20px;
            padding: 32px;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.6);
        }

        .header-panel {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .header-title h1 {
            font-size: 2rem;
            font-weight: 700;
            background: linear-gradient(135deg, #ffffff 40%, #bae6fd 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 4px;
        }

        .header-title p {
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .nav-buttons {
            display: flex;
            gap: 12px;
        }

        .btn {
            padding: 10px 18px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            border: none;
            text-decoration: none;
            text-align: center;
            transition: all 0.2s;
        }

        .btn-add {
            background: linear-gradient(135deg, #00f0ff, #0284c7);
            color: #030a16;
            font-weight: 700;
        }
        .btn-add:hover { filter: brightness(1.1); }

        .btn-outline {
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-primary);
            border: 1px solid rgba(148, 163, 184, 0.2);
        }
        .btn-outline:hover {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border-color: var(--aqua-glow);
        }

        .tools-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .tools-row h2 {
            font-size: 1.4rem;
            color: #bae6fd;
        }

        .search-group {
            display: flex;
            gap: 10px;
        }

        .input-control {
            width: 250px;
            padding: 10px 14px;
            border-radius: 12px;
            border: 1px solid rgba(148, 163, 184, 0.2);
            background: rgba(3, 10, 22, 0.6);
            color: #ffffff;
            font-size: 0.95rem;
            outline: none;
        }
        .input-control:focus {
            border-color: var(--aqua-glow);
            box-shadow: 0 0 0 3px rgba(0, 240, 255, 0.15);
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
            border-radius: 12px;
            border: 1px solid rgba(148, 163, 184, 0.15);
        }

        .aqua-grid {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
            text-align: left;
        }

        .aqua-grid th {
            background: rgba(2, 132, 199, 0.15);
            color: var(--aqua-glow);
            padding: 14px;
            font-weight: 600;
            border-bottom: 1px solid var(--card-border);
            text-transform: uppercase;
            font-size: 0.78rem;
            letter-spacing: 0.8px;
        }

        .aqua-grid td {
            padding: 14px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            color: var(--text-primary);
        }

        .aqua-grid tr:hover td {
            background: rgba(255, 255, 255, 0.03);
        }

        .empty-data {
            padding: 30px;
            text-align: center;
            color: var(--text-muted);
        }
        
        .status-msg {
            display: block;
            margin-top: 15px;
            font-weight: 600;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="ambient-orb orb-1"></div>
    <div class="ambient-orb orb-2"></div>

    <form id="form1" runat="server">
        <div class="dashboard-container">
            
            <div class="glass-panel header-panel">
                <div class="header-title">
                    <h1>AquaCore Operations</h1>
                    <p>Staff Directory and Management Dashboard</p>
                </div>
                <div class="nav-buttons">
                    <a href="AddEmployee.aspx" class="btn btn-add">➕ Add Employee</a>
                    <a href="UpdateEmployee.aspx" class="btn btn-outline">✏️ Update</a>
                    <a href="DeleteEmployee.aspx" class="btn btn-outline">🗑️ Delete</a>
                </div>
            </div>

            <div class="glass-panel">
                <div class="tools-row">
                    <h2>Personnel Directory</h2>
                    <div class="search-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="input-control" placeholder="Search name or role..." />
                        <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn btn-add" OnClick="btnSearch_Click" />
                    </div>
                </div>

                <div class="table-responsive">
                    <asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="False" 
                        CssClass="aqua-grid" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="StaffID" HeaderText="ID" ItemStyle-Width="50px" />
                            <asp:TemplateField HeaderText="Full Name">
                                <ItemTemplate>
                                    <strong><%# Eval("Name") %> <%# Eval("Surname") %></strong>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Username" HeaderText="Username" />
                            <asp:BoundField DataField="Role" HeaderText="Role" />
                            <asp:BoundField DataField="ContactDetails" HeaderText="Contact Info" />
                            <asp:BoundField DataField="CreatedDate" HeaderText="Enrolled" DataFormatString="{0:MMM dd, yyyy}" />
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="empty-data">
                                No personnel records match your search criteria.
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>

                <asp:Label ID="lblStatus" runat="server" CssClass="status-msg" />
            </div>

        </div>
    </form>
</body>
</html>