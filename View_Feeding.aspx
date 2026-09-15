<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="View_Feeding.aspx.cs"
    Inherits="AQUACORE_CMPG223.View_Feeding" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - View Feeding Schedules</title>

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

            font-family:
                'Segoe UI',
                -apple-system,
                BlinkMacSystemFont,
                sans-serif;
        }

        body {

            background: radial-gradient(
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

        .dashboard-container {

            width: 100%;

            max-width: 1100px;

            display: flex;

            flex-direction: column;

            gap: 24px;
        }

        /* ============================================================
           GLASS PANELS
        ============================================================ */

        .glass-panel {

            background: var(--card-glass);

            border: 1px solid var(--card-border);

            border-radius: 16px;

            padding: 32px;

            box-shadow:
                0 10px 30px rgba(0, 0, 0, 0.35);
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

            margin-bottom: 5px;
        }

        .header-title p {

            color: var(--text-muted);

            font-size: 0.95rem;
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

            transition: all 0.2s;
        }

        .btn-outline {

            background: rgba(255, 255, 255, 0.08);

            color: var(--text-primary);

            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .btn-outline:hover {

            background: rgba(255, 255, 255, 0.15);

            color: #ffffff;
        }

        .btn-print {

            background:
                linear-gradient(
                    135deg,
                    #00f0ff,
                    #0284c7
                );

            color: #051329;

            font-weight: 700;

            min-width: 220px;
        }

        .btn-print:hover {

            filter: brightness(1.1);

            transform: translateY(-1px);

            box-shadow:
                0 6px 18px rgba(0, 210, 255, 0.25);
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

            margin-bottom: 5px;
        }

        .page-heading p {

            color: var(--text-muted);

            font-size: 0.9rem;
        }

        /* ============================================================
           CONTROLS
        ============================================================ */

        .controls-panel {

            display: flex;

            align-items: end;

            gap: 25px;

            flex-wrap: wrap;

            margin-bottom: 25px;
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

            border: 1px solid rgba(0, 210, 255, 0.25);

            background: rgba(5, 19, 41, 0.6);

            color: #ffffff;

            font-size: 0.95rem;

            outline: none;
        }

        .input-control:focus {

            border-color: var(--aqua-glow);

            box-shadow:
                0 0 8px rgba(0, 210, 255, 0.3);
        }

        .input-control option {

            background: #0b2545;

            color: white;
        }

        /* ============================================================
           RADIO BUTTONS
        ============================================================ */

        .radio-group {

            display: flex;

            gap: 18px;

            align-items: center;

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
           TABLE
        ============================================================ */

        .table-responsive {

            width: 100%;

            overflow-x: auto;

            border-radius: 10px;

            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .aqua-grid {

            width: 100%;

            border-collapse: collapse;

            font-size: 0.9rem;

            text-align: left;
        }

        .aqua-grid th {

            background: rgba(0, 210, 255, 0.1);

            color: var(--aqua-glow);

            padding: 14px;

            font-weight: 600;

            border-bottom:
                1px solid var(--card-border);

            text-transform: uppercase;

            font-size: 0.8rem;

            letter-spacing: 0.5px;
        }

        .aqua-grid td {

            padding: 14px;

            border-bottom:
                1px solid rgba(255, 255, 255, 0.05);

            color: var(--text-primary);
        }

        .aqua-grid tr:hover td {

            background: rgba(255, 255, 255, 0.03);
        }

        /* ============================================================
           BOTTOM BUTTONS
        ============================================================ */

        .bottom-row {

            display: flex;

            justify-content: flex-end;

            align-items: center;

            gap: 12px;

            margin-top: 25px;

            padding-top: 20px;

            border-top:
                1px solid rgba(0, 210, 255, 0.12);
        }

        /* ============================================================
           PRINT TITLE
        ============================================================ */

        .print-title {

            display: none;
        }

        /* ============================================================
           PRINT STYLES
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
            }

            .header-panel {

                display: block !important;

                text-align: center !important;

                margin-bottom: 10px !important;
            }

            .header-title h1 {

                color: #0284c7 !important;

                font-size: 26px !important;
            }

            .header-title p {

                color: #555555 !important;
            }

            .btn,
            .controls-panel,
            .bottom-row {

                display: none !important;
            }

            .page-heading {

                text-align: center !important;

                margin-bottom: 10px !important;
            }

            .page-heading h2 {

                color: #333333 !important;

                font-size: 20px !important;
            }

            .page-heading p {

                color: #666666 !important;
            }

            .print-title {

                display: block !important;

                text-align: center !important;

                color: #0284c7 !important;

                margin: 10px 0 20px 0 !important;

                border-bottom:
                    3px solid #0284c7;

                padding-bottom: 12px;
            }

            .print-title h1 {

                color: #0284c7 !important;

                font-size: 26px !important;

                margin-bottom: 5px !important;
            }

            .print-title h2 {

                color: #333333 !important;

                font-size: 20px !important;

                margin-bottom: 5px !important;
            }

            .print-title p {

                color: #666666 !important;

                font-size: 12px !important;
            }

            .table-responsive {

                overflow: visible !important;

                border:
                    1px solid #999999 !important;
            }

            .aqua-grid {

                width: 100% !important;

                color: #000000 !important;

                font-size: 10px !important;
            }

            .aqua-grid th {

                background: #0284c7 !important;

                color: #ffffff !important;

                border:
                    1px solid #777777 !important;

                padding: 7px !important;
            }

            .aqua-grid td {

                color: #000000 !important;

                background: #ffffff !important;

                border:
                    1px solid #aaaaaa !important;

                padding: 7px !important;
            }

            .aqua-grid tr:hover td {

                background: #ffffff !important;
            }

            .print-footer {

                display: block !important;

                text-align: center;

                margin-top: 20px;

                padding-top: 10px;

                border-top:
                    1px solid #cccccc;

                color: #777777 !important;

                font-size: 10px;
            }
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

            .bottom-row .btn {

                width: 100%;
            }

            .btn-print {

                width: 100%;
            }
        }

    </style>

    <script type="text/javascript">

        function printFeedingSchedules() {

            var currentDate = new Date();

            var formattedDate =
                currentDate.toLocaleDateString(
                    'en-ZA',
                    {
                        day: '2-digit',
                        month: 'long',
                        year: 'numeric'
                    }
                );

            var formattedTime =
                currentDate.toLocaleTimeString(
                    'en-ZA',
                    {
                        hour: '2-digit',
                        minute: '2-digit',
                        second: '2-digit'
                    }
                );

            var generatedElement =
                document.getElementById('printGeneratedDate');

            if (generatedElement) {

                generatedElement.innerHTML =
                    'Generated on: ' +
                    formattedDate +
                    ' at ' +
                    formattedTime;
            }

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
            ====================================================== -->

            <div class="glass-panel header-panel">

                <div class="header-title">

                    <h1>AquaCore Operations</h1>

                    <p>
                        Feeding Schedule Management
                    </p>

                </div>

                <div>

                    <asp:Button
                        ID="btnBack"
                        runat="server"
                        Text="← Go Back"
                        CssClass="btn btn-outline"
                        OnClick="btnBack_Click" />

                </div>

            </div>


            <!-- =====================================================
                 FEEDING SCHEDULES
            ====================================================== -->

            <div class="glass-panel">

                <div class="page-heading">

                    <h2>
                        View Feeding Schedules
                    </h2>

                    <p>
                        View, sort and filter all existing feeding schedules.
                    </p>

                </div>


                <!-- =================================================
                     PRINT TITLE
                ================================================== -->

                <div class="print-title">

                    <h1>
                        AquaCore Operations
                    </h1>

                    <h2>
                        Feeding Schedule Records
                    </h2>

                    <p>
                        <span id="printGeneratedDate">
                            Generated on:
                        </span>
                    </p>

                </div>


                <!-- =================================================
                     CONTROLS
                ================================================== -->

                <div class="controls-panel">

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


                <!-- =================================================
                     FEEDING TABLE
                ================================================== -->

                <div class="table-responsive">

                    <asp:GridView
                        ID="GridView1"
                        runat="server"
                        CssClass="aqua-grid"
                        GridLines="None">

                    </asp:GridView>

                </div>


                <!-- =================================================
                     PRINT FOOTER
                ================================================== -->

                <div class="print-footer">

                    AquaCore • Feeding Schedule Management

                </div>


                <!-- =================================================
                     BOTTOM BUTTONS
                ================================================== -->

                <div class="bottom-row">

                    <asp:Button
                        ID="btnPrint"
                        runat="server"
                        Text="🖨️ Print Feeding Schedules"
                        CssClass="btn btn-print"
                        OnClientClick="return printFeedingSchedules();"
                        CausesValidation="false" />

                    <asp:Button
                        ID="btnBackBottom"
                        runat="server"
                        Text="← Back"
                        CssClass="btn btn-outline"
                        OnClick="btnBack_Click" />

                </div>

            </div>

        </div>

    </form>

</body>

</html>
