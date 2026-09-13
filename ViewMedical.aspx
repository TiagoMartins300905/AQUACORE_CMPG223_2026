<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="ViewMedical.aspx.cs"
Inherits="AQUACORE_CMPG223.ViewMedical" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<title>AquaCore - View Medical Records</title>

<style>

    :root {
        --abyss-deep: #051329;
        --ocean-blue: #0b2545;
        --aqua-glow: #00d2ff;
        --card-glass: rgba(11, 37, 69, 0.75);
        --card-border: rgba(0, 210, 255, 0.25);

        --text-primary: #eef4f8;
        --text-muted: #8da4be;

        --medical-red: #ff6b7a;
    }

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;

        font-family:
            'Segoe UI',
            -apple-system,
            BlinkMacSystemFont,
            sans-serif;
    }

    body {

        background:
            radial-gradient(
                circle at 50% 10%,
                #0d325e 0%,
                var(--ocean-blue) 40%,
                var(--abyss-deep) 100%
            );

        color: var(--text-primary);

        min-height: 100vh;

        display: flex;

        flex-direction: column;

        align-items: center;

        padding: 40px 20px;
    }

    /* Main Container */

    .dashboard-container {

        width: 100%;

        max-width: 1100px;

        display: flex;

        flex-direction: column;

        gap: 24px;
    }

    /* Glass Panels */

    .glass-panel {

        background: var(--card-glass);

        border: 1px solid var(--card-border);

        border-radius: 16px;

        padding: 32px;

        box-shadow:
            0 10px 30px rgba(0, 0, 0, 0.35);

        backdrop-filter: blur(8px);
    }

    /* Header */

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

        margin-bottom: 6px;
    }

    .header-title p {

        color: var(--text-muted);

        font-size: 0.95rem;
    }

    /* Medical Badge */

    .medical-badge {

        display: inline-flex;

        align-items: center;

        gap: 7px;

        margin-top: 12px;

        padding: 6px 12px;

        border-radius: 20px;

        background:
            rgba(255, 107, 122, 0.08);

        border:
            1px solid rgba(255, 107, 122, 0.2);

        color: #ff9aa5;

        font-size: 0.78rem;

        font-weight: 600;
    }

    /* Buttons */

    .btn {

        padding: 10px 18px;

        border-radius: 8px;

        font-weight: 600;

        font-size: 0.9rem;

        cursor: pointer;

        border: none;

        text-decoration: none;

        text-align: center;

        transition: all 0.2s ease;
    }

    .btn-outline {

        background:
            rgba(255, 255, 255, 0.08);

        color: var(--text-primary);

        border:
            1px solid rgba(255, 255, 255, 0.15);
    }

    .btn-outline:hover {

        background:
            rgba(255, 255, 255, 0.15);

        color: #ffffff;

        transform: translateY(-1px);
    }

    /* Page Heading */

    .page-heading {

        margin-bottom: 25px;
    }

    .page-heading h2 {

        font-size: 1.4rem;

        color: var(--aqua-glow);

        margin-bottom: 6px;
    }

    .page-heading p {

        color: var(--text-muted);

        font-size: 0.9rem;

        line-height: 1.5;
    }

    /* Controls */

    .controls-panel {

        display: flex;

        align-items: flex-end;

        gap: 30px;

        flex-wrap: wrap;

        margin-bottom: 25px;

        padding: 20px;

        border-radius: 12px;

        background:
            rgba(5, 19, 41, 0.45);

        border:
            1px solid rgba(0, 210, 255, 0.12);
    }

    .control-group {

        display: flex;

        flex-direction: column;

        gap: 8px;
    }

    .control-label {

        color: var(--text-primary);

        font-size: 0.9rem;

        font-weight: 600;
    }

    /* Dropdown */

    .input-control {

        min-width: 230px;

        padding: 10px 14px;

        border-radius: 8px;

        border:
            1px solid rgba(0, 210, 255, 0.25);

        background:
            rgba(5, 19, 41, 0.75);

        color: #ffffff;

        font-size: 0.9rem;

        outline: none;

        transition: all 0.2s ease;
    }

    .input-control:focus {

        border-color: var(--aqua-glow);

        box-shadow:
            0 0 8px rgba(0, 210, 255, 0.3);
    }

    .input-control option {

        background: #0b2545;

        color: #ffffff;
    }

    /* Radio Buttons */

    .radio-group {

        display: flex;

        align-items: center;

        gap: 18px;

        min-height: 40px;
    }

    .radio-group label {

        color: var(--text-primary);

        cursor: pointer;

        font-size: 0.9rem;
    }

    .radio-group input {

        accent-color: var(--aqua-glow);
    }

    /* Table Container */

    .table-heading {

        display: flex;

        align-items: center;

        gap: 10px;

        margin-bottom: 15px;
    }

    .table-heading-icon {

        width: 38px;

        height: 38px;

        display: flex;

        align-items: center;

        justify-content: center;

        border-radius: 10px;

        background:
            rgba(0, 210, 255, 0.08);

        border:
            1px solid rgba(0, 210, 255, 0.2);

        font-size: 1.1rem;
    }

    .table-heading h3 {

        color: #ffffff;

        font-size: 1rem;
    }

    /* Responsive Table */

    .table-responsive {

        width: 100%;

        overflow-x: auto;

        border-radius: 12px;

        border:
            1px solid rgba(255, 255, 255, 0.1);

        background:
            rgba(5, 19, 41, 0.4);
    }

    /* GridView */

    .aqua-grid {

        width: 100%;

        border-collapse: collapse;

        font-size: 0.88rem;

        text-align: left;
    }

    .aqua-grid th {

        background:
            rgba(0, 210, 255, 0.1);

        color: var(--aqua-glow);

        padding: 14px;

        font-weight: 600;

        border-bottom:
            1px solid var(--card-border);

        text-transform: uppercase;

        font-size: 0.78rem;

        letter-spacing: 0.5px;

        white-space: nowrap;
    }

    .aqua-grid td {

        padding: 14px;

        border-bottom:
            1px solid rgba(255, 255, 255, 0.05);

        color: var(--text-primary);

        white-space: nowrap;
    }

    .aqua-grid tr:hover td {

        background:
            rgba(0, 210, 255, 0.05);
    }

    .aqua-grid tr:last-child td {

        border-bottom: none;
    }

    /* Empty/Info Area */

    .info-note {

        margin-top: 15px;

        padding: 12px 15px;

        border-radius: 8px;

        background:
            rgba(0, 210, 255, 0.05);

        border:
            1px solid rgba(0, 210, 255, 0.12);

        color: var(--text-muted);

        font-size: 0.82rem;
    }

    /* Bottom Navigation */

    .bottom-row {

        display: flex;

        justify-content: flex-end;

        margin-top: 25px;
    }

    /* Footer */

    .footer-note {

        text-align: center;

        color: var(--text-muted);

        font-size: 0.78rem;

        opacity: 0.8;

        margin-top: 2px;
    }

    /* Mobile */

    @media (max-width: 700px) {

        body {

            padding: 20px 10px;
        }

        .glass-panel {

            padding: 22px;
        }

        .controls-panel {

            flex-direction: column;

            align-items: stretch;
        }

        .input-control {

            width: 100%;

            min-width: 0;
        }

        .radio-group {

            flex-wrap: wrap;
        }

        .bottom-row {

            justify-content: stretch;
        }

        .bottom-row input {

            width: 100%;
        }

        .header-panel {

            align-items: flex-start;
        }

        .header-panel .btn {

            width: 100%;
        }
    }

</style>

</head> <body> <form id="form1" runat="server">
<div class="dashboard-container">


    <!-- HEADER -->

    <div class="glass-panel header-panel">

        <div class="header-title">

            <h1>AquaCore Operations</h1>

            <p>
                Medical Records Management
            </p>

            <div class="medical-badge">

                🩺 Animal Health &amp; Medical Care

            </div>

        </div>

        <div>

            <asp:Button
                ID="btnTopBack"
                runat="server"
                Text="← Go Back"
                CssClass="btn btn-outline"
                OnClick="btnBack_Click" />

        </div>

    </div>


    <!-- MAIN CONTENT -->

    <div class="glass-panel">

        <div class="page-heading">

            <h2>View Medical Records</h2>

            <p>
                Browse the medical history and health records of animals
                registered within the AquaCore aquarium system.
            </p>

        </div>


        <!-- CONTROLS -->

        <div class="controls-panel">


            <!-- SORT -->

            <div class="control-group">

                <asp:Label
                    ID="lblSort"
                    runat="server"
                    Text="Sort By:"
                    CssClass="control-label" />

                <asp:DropDownList
                    ID="DropDownList1"
                    runat="server"
                    CssClass="input-control">

                    <asp:ListItem>
                        --Select Sort--
                    </asp:ListItem>

                </asp:DropDownList>

            </div>


            <!-- ORDER -->

            <div class="control-group">

                <asp:Label
                    ID="lblFilter"
                    runat="server"
                    Text="Order:"
                    CssClass="control-label" />

                <div class="radio-group">

                    <asp:RadioButton
                        ID="rdoASC"
                        runat="server"
                        Text="Ascending"
                        GroupName="SortOrder" />

                    <asp:RadioButton
                        ID="rdoDESC"
                        runat="server"
                        Text="Descending"
                        GroupName="SortOrder" />

                </div>

            </div>


        </div>


        <!-- TABLE -->

        <div class="table-heading">

            <div class="table-heading-icon">
                📋
            </div>

            <h3>
                Animal Medical Records
            </h3>

        </div>


        <div class="table-responsive">

            <asp:GridView
                ID="GridView1"
                runat="server"
                CssClass="aqua-grid"
                GridLines="None">

            </asp:GridView>

        </div>


        <div class="info-note">

            🐠 Medical records shown here are linked to the animals
            registered in AquaCore and can be sorted using the controls above.

        </div>


        <!-- BACK -->

        <div class="bottom-row">

            <asp:Button
                ID="btnBack"
                runat="server"
                Text="← Medicals Menu"
                CssClass="btn btn-outline"
                OnClick="btnBack_Click" />

        </div>

    </div>


    <div class="footer-note">

        AquaCore • Animal Health &amp; Medical Records

    </div>

</div>

</form> </body> </html>