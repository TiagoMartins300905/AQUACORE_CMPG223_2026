<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="EmployeeManagement.aspx.cs"
Inherits="AQUACORE_CMPG223.EmployeeManagement" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<meta charset="utf-8" />

<meta name="viewport"
    content="width=device-width, initial-scale=1" />

<link rel="preconnect"
    href="https://fonts.googleapis.com" />

<link rel="preconnect"
    href="https://fonts.gstatic.com"
    crossorigin="anonymous" />

<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap"
    rel="stylesheet" />

<style>

    :root {
        --bg-base: #030a16;
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
            radial-gradient(
                circle at 15% 20%,
                rgba(2, 132, 199, 0.15) 0%,
                transparent 40%
            ),
            radial-gradient(
                circle at 85% 80%,
                rgba(13, 148, 136, 0.12) 0%,
                transparent 45%
            );

        color: var(--text-primary);

        min-height: 100vh;

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

    .orb-1 {
        width: 500px;
        height: 500px;
        background: #0284c7;
        top: -100px;
        left: -100px;
    }

    .orb-2 {
        width: 600px;
        height: 600px;
        background: #0d9488;
        bottom: -150px;
        right: -100px;
    }

    .dashboard-container {
        position: relative;
        z-index: 1;

        width: 100%;
        max-width: 1100px;

        margin: 0 auto;

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

        box-shadow:
            0 20px 40px -15px
            rgba(0, 0, 0, 0.6);
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

        background:
            linear-gradient(
                135deg,
                #ffffff 40%,
                #bae6fd 100%
            );

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
        flex-wrap: wrap;
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

        transition: all 0.2s ease;
    }

    .btn-add {
        background:
            linear-gradient(
                135deg,
                #00f0ff,
                #0284c7
            );

        color: #030a16;

        font-weight: 700;
    }

    .btn-add:hover {
        filter: brightness(1.1);
        transform: translateY(-1px);
    }

    .btn-outline {
        background:
            rgba(255, 255, 255, 0.05);

        color: var(--text-primary);

        border:
            1px solid
            rgba(148, 163, 184, 0.2);
    }

    .btn-outline:hover {
        background:
            rgba(255, 255, 255, 0.1);

        color: #ffffff;

        border-color:
            var(--aqua-glow);
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

        border:
            1px solid
            rgba(148, 163, 184, 0.2);

        background:
            rgba(3, 10, 22, 0.6);

        color: #ffffff;

        font-size: 0.95rem;

        outline: none;
    }

    .input-control::placeholder {
        color: #7188a0;
    }

    .input-control:focus {
        border-color:
            var(--aqua-glow);

        box-shadow:
            0 0 0 3px
            rgba(0, 240, 255, 0.15);
    }

    .table-responsive {
        width: 100%;

        overflow-x: auto;

        border-radius: 12px;

        border:
            1px solid
            rgba(148, 163, 184, 0.15);
    }

    .aqua-grid {
        width: 100%;

        border-collapse: collapse;

        font-size: 0.95rem;

        text-align: left;
    }

    .aqua-grid th {
        background:
            rgba(2, 132, 199, 0.15);

        color:
            var(--aqua-glow);

        padding: 14px;

        font-weight: 600;

        border-bottom:
            1px solid
            var(--card-border);

        text-transform: uppercase;

        font-size: 0.78rem;

        letter-spacing: 0.8px;

        white-space: nowrap;
    }

    .aqua-grid td {
        padding: 14px;

        border-bottom:
            1px solid
            rgba(255, 255, 255, 0.04);

        color:
            var(--text-primary);
    }

    .aqua-grid tr:hover td {
        background:
            rgba(255, 255, 255, 0.03);
    }

    .aqua-grid tr:last-child td {
        border-bottom: none;
    }

    .status-msg {
        display: block;

        margin-top: 15px;

        font-weight: 600;

        text-align: center;
    }

    .action-row {
        display: flex;

        justify-content: center;

        align-items: center;

        gap: 12px;

        margin-top: 25px;

        padding-top: 25px;

        border-top:
            1px solid
            rgba(0, 210, 255, 0.12);
    }

    .print-button {
        min-width: 240px;

        padding: 12px 20px;

        border-radius: 12px;

        background:
            linear-gradient(
                135deg,
                #00f0ff,
                #0284c7
            );

        color: #030a16;

        font-size: 0.9rem;

        font-weight: 700;

        border: none;

        cursor: pointer;

        transition: all 0.2s ease;
    }

    .print-button:hover {
        transform: translateY(-2px);

        box-shadow:
            0 6px 18px
            rgba(0, 210, 255, 0.25);
    }

    .print-title {
        display: none;
    }

    .generated-time {
        color: #666666 !important;

        font-size: 12px;

        margin-top: 8px;
    }

    @media (max-width: 768px) {

        body {
            padding: 20px 12px;
        }

        .glass-panel {
            padding: 22px;
        }

        .header-panel {
            flex-direction: column;
            align-items: flex-start;
        }

        .nav-buttons {
            width: 100%;
        }

        .nav-buttons .btn {
            flex: 1;
        }

        .tools-row {
            flex-direction: column;
            align-items: stretch;
        }

        .search-group {
            width: 100%;
        }

        .input-control {
            width: 100%;
        }

        .action-row {
            flex-direction: column;
        }

        .print-button {
            width: 100%;
        }
    }

    @media print {

        @page {
            size: A4 landscape;
            margin: 12mm;
        }

        body {
            background: white !important;
            background-image: none !important;
            color: black !important;
            padding: 0 !important;
        }

        .ambient-orb {
            display: none !important;
        }

        .dashboard-container {
            max-width: 100% !important;
            width: 100% !important;
        }

        .glass-panel {
            background: white !important;
            border: none !important;
            box-shadow: none !important;
            backdrop-filter: none !important;
            padding: 5px !important;
        }

        .header-panel {
            display: block !important;
            text-align: center !important;
        }

        .nav-buttons,
        .search-group,
        .action-row,
        .status-msg {
            display: none !important;
        }

        .header-title h1 {
            background: none !important;
            -webkit-text-fill-color: black !important;
            color: black !important;
        }

        .header-title p {
            color: #555 !important;
        }

        .tools-row h2 {
            color: black !important;
        }

        .print-title {
            display: block !important;

            text-align: center;

            color: #000000 !important;

            margin-bottom: 15px;
        }

        .print-title h1 {
            color: #0284c7 !important;
            margin-bottom: 5px;
        }

        .print-title h2 {
            color: #333333 !important;
            margin-bottom: 5px;
        }

        .print-title p {
            color: #666666 !important;
        }

        .generated-time {
            color: #555555 !important;
            font-size: 12px !important;
            margin-top: 8px !important;
        }

        .table-responsive {
            overflow: visible !important;
            border:
                1px solid
                #999 !important;
        }

        .aqua-grid {
            width: 100% !important;
            color: black !important;
            font-size: 10px !important;
        }

        .aqua-grid th {
            background:
                #0284c7 !important;

            color: white !important;

            border:
                1px solid
                #777 !important;

            padding: 7px !important;
        }

        .aqua-grid td {
            color: black !important;

            background: white !important;

            border:
                1px solid
                #aaa !important;

            padding: 7px !important;
        }

        .aqua-grid tr:hover td {
            background: white !important;
        }
    }

</style>

<script type="text/javascript">

    function printEmployees() {

        var now = new Date();

        var dateTime =
            now.toLocaleDateString(
                'en-ZA',
                {
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                }
            )
            +
            " at "
            +
            now.toLocaleTimeString(
                'en-ZA',
                {
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                    hour12: false
                }
            );

        var printDateTime =
            document.getElementById(
                "printDateTime"
            );

        if (printDateTime) {
            printDateTime.innerText = dateTime;
        }

        window.print();

        return false;
    }

</script>

</head> <body>
<div class="ambient-orb orb-1"></div>

<div class="ambient-orb orb-2"></div>

<form id="form1" runat="server">

    <div class="dashboard-container">

        <div class="glass-panel header-panel">

            <div class="header-title">

                <h1>
                    AquaCore Operations
                </h1>

                <p>
                    Staff Directory and Management Dashboard
                </p>

            </div>

            <div class="nav-buttons">

                <asp:Button
                    ID="btnReturn"
                    runat="server"
                    Text="↩️ Return"
                    CssClass="btn btn-outline"
                    OnClick="btnReturn_Click" />

                <a
                    href="AddEmployee.aspx"
                    class="btn btn-add">
                    ➕ Add Employee
                </a>

                <a
                    href="UpdateEmployee.aspx"
                    class="btn btn-outline">
                    ✏️ Update
                </a>

                <a
                    href="DeleteEmployee.aspx"
                    class="btn btn-outline">
                    🗑️ Delete
                </a>

            </div>

        </div>

        <div class="glass-panel">

            <div class="tools-row">

                <h2>
                    Personnel Directory
                </h2>

                <div class="search-group">

                    <asp:TextBox
                        ID="TxtSearch"
                        runat="server"
                        CssClass="input-control"
                        placeholder="Search name or role..." />

                    <asp:Button
                        ID="btnSearch"
                        runat="server"
                        Text="Filter"
                        CssClass="btn btn-add"
                        OnClick="BtnSearch_Click" />

                </div>

            </div>

            <div class="print-title">

                <h1>
                    AquaCore Operations
                </h1>

                <h2>
                    Employee Records
                </h2>

                <p>
                    Staff Directory and Management
                </p>

                <p class="generated-time">
                    Generated on:
                    <span id="printDateTime"></span>
                </p>

            </div>

            <div class="table-responsive">

                <asp:GridView
                    ID="GvEmployees"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="aqua-grid"
                    GridLines="None"
                    EmptyDataText="No employee records found.">

                    <Columns>

                        <asp:BoundField
                            DataField="StaffID"
                            HeaderText="ID"
                            ItemStyle-Width="50px" />

                        <asp:TemplateField
                            HeaderText="Full Name">

                            <ItemTemplate>

                                <strong>
                                    <%# Eval("Name") %>
                                    <%# Eval("Surname") %>
                                </strong>

                            </ItemTemplate>

                        </asp:TemplateField>

                        <asp:BoundField
                            DataField="Username"
                            HeaderText="Username" />

                        <asp:BoundField
                            DataField="Role"
                            HeaderText="Role" />

                        <asp:BoundField
                            DataField="ContactDetails"
                            HeaderText="Contact Info" />

                        <asp:BoundField
                            DataField="CreatedDate"
                            HeaderText="Enrolled"
                            DataFormatString="{0:MMM dd, yyyy}" />

                    </Columns>

                </asp:GridView>

            </div>

            <asp:Label
                ID="LblStatus"
                runat="server"
                CssClass="status-msg" />

            <div class="action-row">

                <asp:Button
                    ID="btnPrint"
                    runat="server"
                    Text="🖨️ Print Employee Records"
                    CssClass="print-button"
                    OnClientClick="return printEmployees();"
                    CausesValidation="false" />

            </div>

        </div>

    </div>

</form>

</body> </html>