<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ViewVisitors.aspx.cs"
    Inherits="AQUACORE_CMPG223.ViewVisitors" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <style>

        :root {
            --coral: #ff7f6e;
            --coral-light: #ff9b8c;
            --coral-dark: #e86657;

            --turquoise: #2dd4bf;
            --turquoise-dark: #14b8a6;

            --cream: #fff8f2;
            --sand: #f7e7d7;

            --text-dark: #263238;
            --text-muted: #6b7280;

            --white: #ffffff;

            --card-shadow:
                0 12px 30px rgba(0, 0, 0, 0.10);

            --soft-shadow:
                0 6px 18px rgba(0, 0, 0, 0.08);
        }


        /* ============================================================
           RESET
        ============================================================ */

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


        /* ============================================================
           BODY
        ============================================================ */

        body {
            min-height: 100vh;

            background:
                linear-gradient(
                    135deg,
                    #fff8f2 0%,
                    #fff1eb 45%,
                    #e9faf7 100%
                );

            color: var(--text-dark);

            padding: 30px 50px;
        }


        /* ============================================================
           MAIN CONTAINER
        ============================================================ */

        .page-container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
        }


        /* ============================================================
           MAIN CARD
        ============================================================ */

        .glass-panel {
            background:
                rgba(255, 255, 255, 0.92);

            border-radius: 18px;

            padding: 32px;

            box-shadow:
                var(--card-shadow);

            border:
                1px solid rgba(255, 255, 255, 0.8);
        }


        /* ============================================================
           HEADER
        ============================================================ */

        .page-header {
            display: flex;

            align-items: center;

            gap: 15px;

            padding-bottom: 25px;

            margin-bottom: 25px;

            border-bottom:
                1px solid rgba(255, 127, 110, 0.15);
        }


        .header-icon {
            width: 58px;
            height: 58px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 15px;

            background:
                linear-gradient(
                    135deg,
                    var(--coral),
                    var(--coral-light)
                );

            color: white;

            font-size: 27px;

            box-shadow:
                0 6px 15px rgba(255, 127, 110, 0.25);
        }


        .page-header h1 {
            color: var(--text-dark);

            font-size: 1.9rem;

            margin-bottom: 5px;
        }


        .page-header p {
            color: var(--text-muted);

            font-size: 0.9rem;
        }


        /* ============================================================
           VISITOR BADGE
        ============================================================ */

        .visitor-badge {
            display: inline-flex;

            align-items: center;

            gap: 7px;

            margin-top: 8px;

            padding: 5px 11px;

            border-radius: 20px;

            background:
                rgba(45, 212, 191, 0.12);

            border:
                1px solid rgba(45, 212, 191, 0.25);

            color: var(--turquoise-dark);

            font-size: 0.75rem;

            font-weight: 600;
        }


        /* ============================================================
           INFORMATION NOTE
        ============================================================ */

        .info-note {
            display: flex;

            align-items: center;

            gap: 12px;

            padding: 13px 16px;

            margin-bottom: 25px;

            border-radius: 10px;

            background:
                rgba(45, 212, 191, 0.08);

            border:
                1px solid rgba(45, 212, 191, 0.18);

            color: var(--text-muted);

            font-size: 0.85rem;

            line-height: 1.5;
        }


        .info-icon {
            width: 32px;
            height: 32px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 9px;

            background:
                rgba(45, 212, 191, 0.15);

            color: var(--turquoise-dark);

            flex-shrink: 0;
        }


        /* ============================================================
           TABLE HEADING
        ============================================================ */

        .table-heading {
            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 15px;

            gap: 15px;
        }


        .table-heading h2 {
            color: var(--text-dark);

            font-size: 1.2rem;
        }


        .table-heading span {
            color: var(--text-muted);

            font-size: 0.8rem;
        }


        /* ============================================================
           TABLE WRAPPER
        ============================================================ */

        .table-wrapper {
            width: 100%;

            overflow-x: auto;

            border-radius: 12px;

            border:
                1px solid rgba(255, 127, 110, 0.15);

            background:
                rgba(255, 255, 255, 0.75);

            box-shadow:
                var(--soft-shadow);
        }


        /* ============================================================
           GRIDVIEW
        ============================================================ */

        .visitors-table {
            width: 100%;

            border-collapse: collapse;

            color: var(--text-dark);

            font-size: 0.88rem;
        }


        /* ============================================================
           TABLE HEADER
        ============================================================ */

        .visitors-table th {
            padding: 15px 14px;

            background:
                linear-gradient(
                    135deg,
                    var(--coral),
                    var(--coral-light)
                );

            color: #ffffff;

            font-weight: 600;

            text-align: left;

            border-bottom:
                1px solid rgba(255, 127, 110, 0.25);

            white-space: nowrap;
        }


        /* ============================================================
           TABLE CELLS
        ============================================================ */

        .visitors-table td {
            padding: 13px 14px;

            color: #4b5563;

            border-bottom:
                1px solid rgba(255, 127, 110, 0.10);

            background:
                rgba(255, 255, 255, 0.65);
        }


        /* ============================================================
           ALTERNATING ROWS
        ============================================================ */

        .visitors-table tr:nth-child(even) td {
            background:
                rgba(45, 212, 191, 0.035);
        }


        /* ============================================================
           HOVER
        ============================================================ */

        .visitors-table tr:hover td {
            background:
                rgba(255, 127, 110, 0.07);

            color: var(--text-dark);
        }


        /* ============================================================
           LAST ROW
        ============================================================ */

        .visitors-table tr:last-child td {
            border-bottom: none;
        }


        /* ============================================================
           EMPTY DATA
        ============================================================ */

        .visitors-table td:only-child {
            text-align: center;

            padding: 30px;

            color: var(--text-muted);
        }


        /* ============================================================
           REVENUE
        ============================================================ */

        .revenue-row {
            display: flex;

            justify-content: flex-end;

            align-items: center;

            gap: 12px;

            margin-top: 18px;

            padding: 16px 20px;

            border-radius: 10px;

            background:
                rgba(45, 212, 191, 0.08);

            border:
                1px solid rgba(45, 212, 191, 0.20);

            box-shadow:
                var(--soft-shadow);
        }


        .revenue-label {
            color: var(--text-muted);

            font-size: 0.95rem;

            font-weight: 600;
        }


        .revenue-value {
            color: var(--turquoise-dark);

            font-size: 1.25rem;

            font-weight: 700;
        }


        /* ============================================================
           BUTTON AREA
        ============================================================ */

        .button-row {
            display: flex;

            justify-content: center;

            align-items: center;

            gap: 15px;

            flex-wrap: wrap;

            margin-top: 25px;

            padding-top: 25px;

            border-top:
                1px solid rgba(255, 127, 110, 0.12);
        }


        /* ============================================================
           PRINT BUTTON
        ============================================================ */

        .print-button {
            min-width: 210px;

            padding: 11px 20px;

            border-radius: 10px;

            background:
                linear-gradient(
                    135deg,
                    var(--coral),
                    var(--coral-dark)
                );

            color: #ffffff;

            font-size: 0.9rem;

            font-weight: 600;

            border: none;

            cursor: pointer;

            transition: all 0.2s ease;
        }


        .print-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 6px 15px rgba(255, 127, 110, 0.25);
        }


        /* ============================================================
           DASHBOARD BUTTON
        ============================================================ */

        .dashboard-button {
            min-width: 210px;

            padding: 11px 20px;

            border-radius: 10px;

            background:
                linear-gradient(
                    135deg,
                    var(--turquoise),
                    var(--turquoise-dark)
                );

            color: #ffffff;

            font-size: 0.9rem;

            font-weight: 600;

            border: none;

            cursor: pointer;

            transition: all 0.2s ease;
        }


        .dashboard-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 6px 15px rgba(45, 212, 191, 0.25);
        }


        /* ============================================================
           FOOTER
        ============================================================ */

        .footer-note {
            background:
                rgba(255, 255, 255, 0.75);

            border-radius: 15px;

            padding: 18px 22px;

            text-align: center;

            color: var(--text-muted);

            font-size: 0.85rem;

            margin-top: 18px;

            border:
                1px solid rgba(255, 127, 110, 0.12);
        }


        /* ============================================================
           PRINT
        ============================================================ */

        @media print {

            body {
                background: white !important;

                padding: 0 !important;
            }


            .page-container {
                max-width: 100% !important;
            }


            .glass-panel {
                box-shadow: none !important;

                border: none !important;

                padding: 0 !important;
            }


            .button-row {
                display: none !important;
            }


            .info-note {
                display: none !important;
            }


            .footer-note {
                display: none !important;
            }
        }


        /* ============================================================
           MOBILE
        ============================================================ */

        @media (max-width: 700px) {

            body {
                padding: 20px;
            }


            .glass-panel {
                padding: 22px;
            }


            .page-header {
                align-items: flex-start;
            }


            .page-header h1 {
                font-size: 1.55rem;
            }


            .table-heading {
                align-items: flex-start;

                flex-direction: column;
            }


            .visitors-table {
                min-width: 700px;
            }


            .dashboard-button,
            .print-button {
                width: 100%;
            }


            .revenue-row {
                justify-content: space-between;

                padding: 14px 16px;
            }
        }

    </style>


    <!-- ============================================================
         PRINT JAVASCRIPT
    ============================================================ -->

    <script type="text/javascript">

        function printVisitors() {

            var table =
                document.getElementById(
                    '<%= gvVisitors.ClientID %>'
                );

            var revenue =
                document.getElementById(
                    '<%= lblTotalRevenue.ClientID %>'
                );


            if (!table) {

                alert(
                    "No visitor records are available to print."
                );

                return false;
            }


            var revenueText = "R 0.00";


            if (revenue) {

                revenueText =
                    revenue.innerText ||
                    revenue.textContent ||
                    "R 0.00";
            }


            var printWindow =
                window.open(
                    "",
                    "_blank",
                    "width=1100,height=750"
                );


            if (!printWindow) {

                alert(
                    "Please allow pop-ups in your browser to print the records."
                );

                return false;
            }


            printWindow.document.write(`

                <!DOCTYPE html>

                <html>

                <head>

                    <title>AquaCore - Visitor Records</title>

                    <style>

                        * {
                            box-sizing: border-box;
                        }

                        body {
                            font-family:
                                Arial,
                                Helvetica,
                                sans-serif;

                            color: #263238;

                            padding: 35px;

                            background: white;
                        }

                        .print-header {
                            text-align: center;

                            margin-bottom: 25px;

                            border-bottom:
                                3px solid #ff7f6e;

                            padding-bottom: 20px;
                        }

                        .print-header h1 {
                            color: #e86657;

                            font-size: 28px;

                            margin-bottom: 6px;
                        }

                        .print-header h2 {
                            color: #263238;

                            font-size: 20px;

                            margin-bottom: 8px;
                        }

                        .print-header p {
                            color: #6b7280;

                            font-size: 13px;
                        }

                        table {
                            width: 100%;

                            border-collapse: collapse;

                            margin-top: 20px;

                            font-size: 12px;
                        }

                        th {
                            background: #ff7f6e;

                            color: white;

                            padding: 11px;

                            border:
                                1px solid #e86657;

                            text-align: left;
                        }

                        td {
                            padding: 10px;

                            border:
                                1px solid #dddddd;

                            color: #374151;
                        }

                        tr:nth-child(even) td {
                            background: #f7faf9;
                        }

                        .revenue {
                            margin-top: 25px;

                            padding: 15px 20px;

                            text-align: right;

                            border:
                                1px solid #2dd4bf;

                            background: #e9faf7;

                            border-radius: 8px;

                            color: #263238;

                            font-size: 16px;

                            font-weight: bold;
                        }

                        .revenue-value {
                            color: #14b8a6;

                            margin-left: 8px;
                        }

                        .print-footer {
                            text-align: center;

                            margin-top: 40px;

                            padding-top: 15px;

                            border-top:
                                1px solid #dddddd;

                            color: #777777;

                            font-size: 11px;
                        }

                        @media print {

                            body {
                                padding: 10px;
                            }

                            table {
                                page-break-inside: auto;
                            }

                            tr {
                                page-break-inside: avoid;

                                page-break-after: auto;
                            }
                        }

                    </style>

                </head>

                <body>

                    <div class="print-header">

                        <h1>
                            AquaCore Aquarium
                        </h1>

                        <h2>
                            Visitor Records
                        </h2>

                        <p>
                            Generated on:
                            ${new Date().toLocaleString()}
                        </p>

                    </div>

                    ${table.outerHTML}

                    <div class="revenue">

                        Total Revenue From Ticket Sales:

                        <span class="revenue-value">
                            ${revenueText}
                        </span>

                    </div>

                    <div class="print-footer">

                        AquaCore • Visitor Management

                    </div>

                </body>

                </html>

            `);


            printWindow.document.close();

            printWindow.focus();


            setTimeout(function () {

                printWindow.print();

            }, 500);


            return false;
        }

    </script>

</head>


<body>

<form id="form1" runat="server">

    <div class="page-container">

        <div class="glass-panel">


            <!-- =====================================================
                 HEADER
            ====================================================== -->

            <div class="page-header">

                <div class="header-icon">
                    👥
                </div>

                <div>

                    <h1>
                        AquaCore Visitors
                    </h1>

                    <p>
                        View visitors registered within the
                        AquaCore system.
                    </p>

                    <div class="visitor-badge">
                        👤 Visitor Records
                    </div>

                </div>

            </div>


            <!-- =====================================================
                 INFORMATION
            ====================================================== -->

            <div class="info-note">

                <div class="info-icon">
                    💡
                </div>

                <div>
                    Review the visitors currently registered
                    in the AquaCore system. Scroll horizontally
                    on smaller screens to view all visitor details.
                </div>

            </div>


            <!-- =====================================================
                 TABLE HEADING
            ====================================================== -->

            <div class="table-heading">

                <h2>
                    📊 Visitor Records
                </h2>

                <span>
                    AquaCore Visitor Management
                </span>

            </div>


            <!-- =====================================================
                 VISITORS TABLE
            ====================================================== -->

            <div class="table-wrapper">

                <asp:GridView
                    ID="gvVisitors"
                    runat="server"
                    CssClass="visitors-table"
                    AutoGenerateColumns="true">

                </asp:GridView>

            </div>


            <!-- =====================================================
                 TOTAL REVENUE
            ====================================================== -->

            <div class="revenue-row">

                <span class="revenue-label">
                    💰 Total Revenue From Ticket Sales:
                </span>

                <asp:Label
                    ID="lblTotalRevenue"
                    runat="server"
                    CssClass="revenue-value"
                    Text="R 0.00">

                </asp:Label>

            </div>


            <!-- =====================================================
                 BUTTONS
            ====================================================== -->

            <div class="button-row">

                <asp:Button
                    ID="btnPrint"
                    runat="server"
                    Text="🖨 Print Visitor Records"
                    CssClass="print-button"
                    OnClientClick="return printVisitors();"
                    CausesValidation="false" />

                <asp:Button
                    ID="btnDashboard"
                    runat="server"
                    Text="← Visitors Dashboard"
                    CssClass="dashboard-button"
                    OnClick="btnDashboard_Click"
                    CausesValidation="false" />

            </div>

        </div>


        <!-- =========================================================
             FOOTER
        ========================================================== -->

        <div class="footer-note">

            AquaCore • Visitor Management

        </div>

    </div>

</form>

</body>

</html>
