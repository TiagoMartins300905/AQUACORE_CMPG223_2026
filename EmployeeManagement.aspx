<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeManagement.aspx.cs" Inherits="AQUACORE_CMPG223.EmployeeManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AquaCore - Employee Management</title>
    <style>
        :root {
            --abyss-deep: #051329;
            --ocean-blue: #0b2545;
            --aqua-glow: #00d2ff;
            --card-glass: rgba(11, 37, 69, 0.75);
            --card-border: rgba(0, 210, 255, 0.25);
            --text-primary: #eef4f8;
            --text-muted: #8da4be;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
        }

        body {
            background: radial-gradient(circle at 50% 10%, #0d325e 0%, var(--ocean-blue) 40%, var(--abyss-deep) 100%);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px 20px;
        }

        .dashboard-container {
            width: 100%;
            max-width: 1000px;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* Reusable Glass Panel */
        .glass-panel {
            background: var(--card-glass);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
        }

        /* Navigation Header */
        .header-panel {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .header-title h1 {
            font-size: 2rem;
            color: #ffffff;
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
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            border: none;
            text-decoration: none;
            text-align: center;
            transition: all 0.2s;
        }

        .btn-add {
            background: linear-gradient(135deg, #00d2ff, #0077b6);
            color: #ffffff;
        }
        .btn-add:hover { opacity: 0.9; }

        .btn-outline {
            background: rgba(255, 255, 255, 0.08);
            color: var(--text-primary);
            border: 1px solid rgba(255, 255, 255, 0.15);
        }
        .btn-outline:hover {
            background: rgba(255, 255, 255, 0.15);
            color: #ffffff;
        }

        /* Directory Tools */
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
            color: var(--aqua-glow);
        }

        .search-group {
            display: flex;
            gap: 10px;
        }

        .input-control {
            width: 250px;
            padding: 10px 14px;
            border-radius: 8px;
            border: 1px solid rgba(0, 210, 255, 0.25);
            background: rgba(5, 19, 41, 0.6);
            color: #ffffff;
            font-size: 0.95rem;
            outline: none;
        }
        .input-control:focus {
            border-color: var(--aqua-glow);
            box-shadow: 0 0 8px rgba(0, 210, 255, 0.3);
        }

        /* Dark Theme GridView */
        .table-responsive {
            width: 100%;
            overflow-x: auto;
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .aqua-grid {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
            text-align: left;
        }

        .aqua-grid th {
            background: rgba(0, 210, 255, 0.1);
            color: var(--aqua-glow);
            padding: 14px;
            font-weight: 600;
            border-bottom: 1px solid var(--card-border);
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
        }

        .aqua-grid td {
            padding: 14px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
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
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            
            <!-- Navigation Header -->
            <div class="glass-panel header-panel">
                <div class="header-title">
                    <h1>AquaCore Operations</h1>
                    <p>Staff Directory and Management Dashboard</p>
                </div>
                <div class="nav-buttons">
                    <a href="AddEmployee.aspx" class="btn btn-add">➕ Add Employee</a>
                    <a href="UpdateEmployee.aspx" class="btn btn-outline">✏️ Update</a>
                    <!-- Updated Link Here -->
                    <a href="DeleteEmployee.aspx" class="btn btn-outline">🗑️ Delete</a>
                </div>
            </div>

            <!-- Active Directory -->
            <div class="glass-panel">
                <div class="tools-row">
                    <h2>Personnel Directory</h2>
                    <div class="search-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="input-control" placeholder="Search by name or dept..." />
                        <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn btn-add" OnClick="btnSearch_Click" />
                    </div>
                </div>

                <div class="table-responsive">
                    <asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="False" 
                        CssClass="aqua-grid" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="EmployeeID" HeaderText="ID" ItemStyle-Width="50px" />
                            <asp:TemplateField HeaderText="Full Name">
                                <ItemTemplate>
                                    <strong><%# Eval("FirstName") %> <%# Eval("LastName") %></strong>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Email" HeaderText="Email Address" />
                            <asp:BoundField DataField="Department" HeaderText="Department" />
                            <asp:BoundField DataField="Salary" HeaderText="Salary" DataFormatString="R {0:N2}" />
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