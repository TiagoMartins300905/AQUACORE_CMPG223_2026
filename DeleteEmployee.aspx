<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteEmployee.aspx.cs" Inherits="AQUACORE_CMPG223.DeleteEmployee" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AquaCore - Delete Employee</title>
    <style>
        :root {
            --abyss-deep: #051329;
            --ocean-blue: #0b2545;
            --aqua-glow: #00d2ff;
            --card-glass: rgba(11, 37, 69, 0.75);
            --card-border: rgba(0, 210, 255, 0.25);
            --text-primary: #eef4f8;
            --text-muted: #8da4be;
            --accent-danger: #ff4d4d;
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
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .form-card {
            background: var(--card-glass);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            padding: 32px;
            width: 100%;
            max-width: 550px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
        }

        .form-card h2 {
            font-size: 1.8rem;
            margin-bottom: 8px;
            color: #ffffff;
        }

        .form-card p {
            color: var(--text-muted);
            font-size: 0.95rem;
            margin-bottom: 24px;
        }

        .form-group {
            margin-bottom: 16px;
            display: flex;
            flex-direction: column;
        }

        /* Divider */
        .divider {
            height: 1px;
            background: rgba(255, 77, 77, 0.3);
            margin: 24px 0;
        }

        label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--aqua-glow);
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .input-control {
            width: 100%;
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

        select.input-control option {
            background-color: #0b2545;
            color: #ffffff;
        }

        /* Confirmation Details Box */
        .details-box {
            background: rgba(255, 77, 77, 0.05);
            border: 1px solid rgba(255, 77, 77, 0.2);
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 20px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .detail-row:last-child {
            margin-bottom: 0;
        }

        .detail-label {
            color: var(--text-muted);
        }

        .detail-value {
            font-weight: 600;
            color: #ffffff;
        }
        
        .warning-text {
            color: var(--accent-danger);
            font-size: 0.85rem;
            font-weight: 600;
            text-align: center;
            margin-bottom: 15px;
        }

        .btn-group {
            display: flex;
            gap: 12px;
        }

        .btn {
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            border: none;
            flex: 1;
            text-align: center;
            text-decoration: none;
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff4d4d, #c92a2a);
            color: #ffffff;
        }

        .btn-danger:hover {
            opacity: 0.9;
            box-shadow: 0 0 12px rgba(255, 77, 77, 0.4);
        }

        .btn-back {
            background: rgba(255, 255, 255, 0.08);
            color: var(--text-muted);
            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .btn-back:hover {
            background: rgba(255, 255, 255, 0.15);
            color: #ffffff;
        }

        .status-msg {
            display: block;
            margin-top: 16px;
            font-size: 0.9rem;
            font-weight: 600;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-card">
            <h2>Delete Staff</h2>
            <p>Select an employee to permanently delete their records from the system.</p>

            <!-- Employee Selection -->
            <div class="form-group">
                <label>Select Employee to Delete</label>
                <asp:DropDownList ID="ddlSelectEmployee" runat="server" CssClass="input-control" AutoPostBack="True" OnSelectedIndexChanged="ddlSelectEmployee_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

            <asp:Label ID="lblStatus" runat="server" CssClass="status-msg" />

            <!-- Confirmation Panel (Hidden until selection) -->
            <asp:Panel ID="pnlConfirmForm" runat="server" Visible="False">
                <div class="divider"></div>
                
                <p class="warning-text">⚠️ Are you sure you want to delete this record? This action cannot be undone.</p>

                <div class="details-box">
                    <div class="detail-row">
                        <span class="detail-label">Name:</span>
                        <asp:Label ID="lblName" runat="server" CssClass="detail-value" />
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Email:</span>
                        <asp:Label ID="lblEmail" runat="server" CssClass="detail-value" />
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Department:</span>
                        <asp:Label ID="lblDept" runat="server" CssClass="detail-value" />
                    </div>
                </div>

                <div class="btn-group">
                    <asp:Button ID="btnDelete" runat="server" Text="Permanently Delete" CssClass="btn btn-danger" OnClick="btnDelete_Click" OnClientClick="return confirm('Final warning: Delete this employee?');" />
                    <a href="EmployeeManagement.aspx" class="btn btn-back">Cancel</a>
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>