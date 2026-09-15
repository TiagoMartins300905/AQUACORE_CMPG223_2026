<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ViewMedical.aspx.cs"
    Inherits="AQUACORE_CMPG223.ViewMedical" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <meta charset="utf-8" />

    <meta name="viewport"
        content="width=device-width, initial-scale=1" />

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

        /* ============================================================
           MAIN CONTAINER
           ============================================================ */

        .dashboard-container {

            width: 100%;

            max-width: 1100px;

            display: flex;

            flex-direction: column;

            gap: 24px;
        }

        /* ============================================================
           GLASS PANEL
           ============================================================ */

        .glass-panel {

            background: var(--card-glass);

            border: 1px solid var(--card-border);

            border-radius: 16px;

            padding: 32px;

            box-shadow:
                0 10px 30px rgba(0, 0, 0, 0.35);

            backdrop-filter: blur(8px);
        }

        /* ============================================================
           HEADER
           ============================================================ */

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

        /* ============================================================
           MEDICAL BADGE
           ============================================================ */

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

        /* ============================================================
           BUTTONS
           ============================================================ */

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

        .btn-print {

            background:
                linear-gradient(
                    135deg,
                    #00f0ff,
                    #0284c7
                );

            color: #03101f;

            font-weight: 700;

            border: none;
        }

        .btn-print:hover {

            transform: translateY(-1px);

            box-shadow:
                0 5px 18px rgba(0, 210, 255, 0.3);
        }

        /* ============================================================
           PAGE HEADING
           ============================================================ */

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

        /* ============================================================
           CONTROLS
           ============================================================ */

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

        /* ============================================================
           DROPDOWN
           ============================================================ */

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

        /* ============================================================
           RADIO BUTTONS
           ============================================================ */

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

        /* ============================================================
           TABLE HEADING
           ============================================================ */

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

        /* ============================================================
           TABLE
           ============================================================ */

        .table-responsive {

            width: 100%;

            overflow-x: auto;

            border-radius: 12px;

            border:
                1px solid rgba(255, 255, 255, 0.1);

            background:
                rgba(5, 19, 41, 0.4);
        }

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

        /* ============================================================
           INFO NOTE
           ============================================================ */

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

        /* ============================================================
           BOTTOM BUTTONS
           ============================================================ */

        .bottom-row {

            display: flex;

            justify-content: flex-end;

            gap: 12px;

            margin-top: 25px;
        }

        /* ============================================================
           PRINT HEADER
           ============================================================ */

        .print-header {

            display: none;
        }

        .print-generated {

            font-size: 11px;

            color: #555555;

            margin-top: 5px;
        }

        /* ============================================================
           FOOTER
           ============================================================ */

        .footer-note {

            text-align: center;

            color: var(--text-muted);

            font-size: 0.78rem;

            opacity: 0.8;

            margin-top: 2px;
        }

        /* ============================================================
           MOBILE
           ============================================================ */

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

                flex-direction: column;
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

        /* ============================================================
           PRINT
           ============================================================ */

        @media print {

            @page {

                size: A4 landscape;

                margin: 12mm;
            }

            body {

                background: #ffffff !important;

                color: #000000 !important;

                padding: 0 !important;

                display: block !important;
            }

            .dashboard-container {

                max-width: 100% !important;

                width: 100% !important;
            }

            .glass-panel {

                background: #ffffff !important;

                border: none !important;

                box-shadow: none !important;

                padding: 5px !important;

                backdrop-filter: none !important;
            }

            .header-panel {

                display: block !important;

                text-align: center !important;

                padding-bottom: 10px !important;
            }

            .header-title h1 {

                color: #000000 !important;

                font-size: 22px !important;
            }

            .header-title p {

                color: #555555 !important;
            }

            .medical-badge {

                display: none !important;
            }

            .header-panel > div:last-child {

                display: none !important;
            }

            .controls-panel {

                display: none !important;
            }

            .page-heading {

                text-align: center !important;

                margin-bottom: 12px !important;
            }

            .page-heading h2 {

                color: #0284c7 !important;
            }

            .page-heading p {

                color: #555555 !important;
            }

            .table-heading {

                margin-bottom: 8px !important;
            }

            .table-heading-icon {

                display: none !important;
            }

            .table-heading h3 {

                color: #000000 !important;
            }

            .table-responsive {

                overflow: visible !important;

                border: 1px solid #999999 !important;

                background: #ffffff !important;
            }

            .aqua-grid {

                width: 100% !important;

                color: #000000 !important;

                font-size: 10px !important;
            }

            .aqua-grid th {

                background: #0284c7 !important;

                color: #ffffff !important;

                border: 1px solid #777777 !important;

                padding: 7px !important;
            }

            .aqua-grid td {

                background: #ffffff !important;

                color: #000000 !important;

                border: 1px solid #aaaaaa !important;

                padding: 7px !important;
            }

            .aqua-grid tr:hover td {

                background: #ffffff !important;
            }

            .info-note {

                color: #555555 !important;

                background: #f5f5f5 !important;

                border: 1px solid #cccccc !important;
            }

            .bottom-row {

                display: none !important;
            }

            .footer-note {

                color: #555555 !important;

                margin-top: 10px !important;
            }

            .print-header {

                display: block !important;

                text-align: center !important;

                margin-bottom: 15px !important;
            }

            .print-header h1 {

                color: #0284c7 !important;

                font-size: 20px !important;

                margin-bottom: 4px !important;
            }

            .print-header p {

                color: #555555 !important;

                font-size: 11px !important;
            }

            .print-generated {

                color: #333333 !important;

                font-size: 11px !important;

                margin-top: 5px !important;
            }
        }

    </style>

    <script type="text/javascript">

        function printMedicalRecords() {

            // Get the current date and time
            var now = new Date();

            // Day
            var day = String(now.getDate()).padStart(2, '0');

            // Month names
            var monthNames = [
                "January",
                "February",
                "March",
                "April",
                "May",
                "June",
                "July",
                "August",
                "September",
                "October",
                "November",
                "December"
            ];

            var month =
                monthNames[now.getMonth()];

            // Year
            var year =
                now.getFullYear();

            // Time
            var hours =
                String(now.getHours()).padStart(2, '0');

            var minutes =
                String(now.getMinutes()).padStart(2, '0');

            var seconds =
                String(now.getSeconds()).padStart(2, '0');

            // Final generated date/time
            var generatedDateTime =
                day + " " +
                month + " " +
                year + ", " +
                hours + ":" +
                minutes + ":" +
                seconds;

            // Put the date/time into the print header
            var printDateTime =
                document.getElementById("printDateTime");

            if (printDateTime) {

                printDateTime.innerText =
                    generatedDateTime;
            }

            // Open browser print dialog
            window.print();

            return false;
        }

    </script>

</head>

<body>

    <form id="form1" runat="server">

        <div class="dashboard-container">

            <!-- =====================================================
                 HEADER
                 ===================================================== -->

            <div class="glass-panel header-panel">

                <div class="header-title">

                    <h1>
                        AquaCore Operations
                    </h1>

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


            <!-- =====================================================
                 MAIN CONTENT
                 ===================================================== -->

            <div class="glass-panel">

                <!-- PRINT HEADER -->

                <div class="print-header">

                    <h1>
                        AquaCore Operations
                    </h1>

                    <p>
                        Animal Medical Records
                    </p>

                    <p class="print-generated">

                        Generated:
                        <span id="printDateTime">
                        </span>

                    </p>

                </div>


                <!-- PAGE HEADING -->

                <div class="page-heading">

                    <h2>
                        View Medical Records
                    </h2>

                    <p>
                        Browse the medical history and health records
                        of animals registered within the AquaCore
                        aquarium system.
                    </p>

                </div>


                <!-- =================================================
                     SORT CONTROLS
                     ================================================= -->

                <div class="controls-panel">

                    <!-- SORT BY -->

                    <div class="control-group">

                        <asp:Label
                            ID="lblSort"
                            runat="server"
                            Text="Sort By:"
                            CssClass="control-label" />

                        <asp:DropDownList
                            ID="DropDownList1"
                            runat="server"
                            CssClass="input-control"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">

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
                                GroupName="SortOrder"
                                AutoPostBack="true"
                                OnCheckedChanged="rdoASC_CheckedChanged" />

                            <asp:RadioButton
                                ID="rdoDESC"
                                runat="server"
                                Text="Descending"
                                GroupName="SortOrder"
                                AutoPostBack="true"
                                OnCheckedChanged="rdoDESC_CheckedChanged" />

                        </div>

                    </div>

                </div>


                <!-- =================================================
                     TABLE HEADING
                     ================================================= -->

                <div class="table-heading">

                    <div class="table-heading-icon">
                        📋
                    </div>

                    <h3>
                        Animal Medical Records
                    </h3>

                </div>


                <!-- =================================================
                     TABLE
                     ================================================= -->

                <div class="table-responsive">

                    <asp:GridView
                        ID="GridView1"
                        runat="server"
                        CssClass="aqua-grid"
                        GridLines="None">

                    </asp:GridView>

                </div>


                <!-- =================================================
                     INFORMATION
                     ================================================= -->

                <div class="info-note">

                    🐠 Medical records shown here are linked to the
                    animals registered in AquaCore.

                </div>


                <!-- =================================================
                     BUTTONS
                     ================================================= -->

                <div class="bottom-row">

                    <!-- PRINT -->

                    <asp:Button
                        ID="btnPrint"
                        runat="server"
                        Text="🖨️ Print Medical Records"
                        CssClass="btn btn-print"
                        OnClientClick="return printMedicalRecords();"
                        CausesValidation="false" />

                    <!-- BACK -->

                    <asp:Button
                        ID="btnBack"
                        runat="server"
                        Text="← Medicals Menu"
                        CssClass="btn btn-outline"
                        OnClick="btnBack_Click" />

                </div>

            </div>


            <!-- =====================================================
                 FOOTER
                 ===================================================== -->

            <div class="footer-note">

                AquaCore • Animal Health &amp; Medical Records

            </div>

        </div>

    </form>

</body>

</html>
