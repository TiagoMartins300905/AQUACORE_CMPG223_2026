<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateEmployee.aspx.cs" Inherits="AQUACORE_CMPG223.UpdateEmployee" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AquaCore - Update Employee</title>
    <style>
        :root {
            --abyss-deep: #051329;
            --ocean-blue: #0b2545;
            --aqua-glow: #00d2ff;
            --card-glass: rgba(11, 37, 69, 0.75);
            --card-border: rgba(0, 210, 255, 0.25);
            --text-primary: #eef4f8;
            --text-muted: #8da4be;
            --accent-warning: #ffd166;
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

        /* Divider to separate the dropdown from the form */
        .divider {
            height: 1px;
            background: rgba(0, 210, 255, 0.2);
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
        
        .input-control:disabled {
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-muted);
            cursor: not-allowed;
        }

        select.input-control option {
            background-color: #0b2545;
            color: #ffffff;
        }

        .btn-group {
            display: flex;
            gap: 12px;
            margin-top: 24px;
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

        .btn-submit {
            background: linear-gradient(135deg, #ffd166, #f77f00);
            color: #051329;
        }

        .btn-submit:hover {
            opacity: 0.9;
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
            <h2>Modify Personnel</h2>
            <p>Select an employee from the dropdown below to load and update their records.</p>

            <!-- Employee Selection -->
            <div class="form-group">
                <label>Select Employee to Edit</label>
                <asp:DropDownList ID="ddlSelectEmployee" runat="server" CssClass="input-control" AutoPostBack="True" OnSelectedIndexChanged="ddlSelectEmployee_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

            <asp:Label ID="lblStatus" runat="server" CssClass="status-msg" />

            <!-- The rest of the form is hidden until an employee is selected -->
            <asp:Panel ID="pnlEditForm" runat="server" Visible="False">
                <div class="divider"></div>

                <div class="form-group">
                    <label>First Name</label>
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="input-control" />
                </div>

                <div class="form-group">
                    <label>Last Name</label>
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="input-control" />
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-control" />
                </div>

                <div class="form-group">
                    <label>Department</label>
                    <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="input-control">
                        <asp:ListItem Text="-- Select Department --" Value="" />
                        <asp:ListItem Text="Operations" Value="Operations" />
                        <asp:ListItem Text="Quality Control" Value="Quality Control" />
                        <asp:ListItem Text="Maintenance" Value="Maintenance" />
                        <asp:ListItem Text="Administration" Value="Administration" />
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Salary (ZAR)</label>
                    <asp:TextBox ID="txtSalary" runat="server" CssClass="input-control" />
                </div>

                <div class="btn-group">
                    <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CssClass="btn btn-submit" OnClick="btnUpdate_Click" />
                    <a href="EmployeeManagement.aspx" class="btn btn-back">Cancel</a>
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>