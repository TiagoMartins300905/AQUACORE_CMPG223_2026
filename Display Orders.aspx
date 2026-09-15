<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Display Orders.aspx.cs" Inherits="AQUACORE_CMPG223.Display_Orders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - Display Restaurant Orders</title>

    <style>

        :root {

            --abyss-deep: #041c20;
            --ocean-deep: #063b40;

            --teal-dark: #087f82;
            --teal: #00bfa6;
            --teal-glow: #19e6cc;
            --teal-soft: #70f2df;

            --card-glass: rgba(6, 59, 64, 0.72);
            --card-border: rgba(0, 191, 166, 0.25);

            --text-primary: #eefcfb;
            --text-muted: #91b8b5;
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
                    #0b5558 0%,
                    var(--ocean-deep) 38%,
                    var(--abyss-deep) 100%
                );

            color: var(--text-primary);

            min-height: 100vh;

            display: flex;

            justify-content: center;

            padding: 40px 20px;

            position: relative;

            overflow-x: hidden;
        }


        /* ============================================================
           BACKGROUND GLOW
           ============================================================ */

        body::before {

            content: "";

            position: fixed;

            width: 500px;

            height: 500px;

            border-radius: 50%;

            background: rgba(0, 191, 166, 0.06);

            filter: blur(80px);

            top: 5%;

            left: -150px;

            pointer-events: none;
        }


        body::after {

            content: "";

            position: fixed;

            width: 450px;

            height: 450px;

            border-radius: 50%;

            background: rgba(25, 230, 204, 0.04);

            filter: blur(80px);

            bottom: -150px;

            right: -100px;

            pointer-events: none;
        }


        /* ============================================================
           MAIN CONTAINER
           ============================================================ */

        .page-container {

            width: 100%;

            max-width: 1100px;

            position: relative;

            z-index: 1;
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

        .page-header {

            display: flex;

            align-items: center;

            gap: 16px;

            padding-bottom: 25px;

            margin-bottom: 25px;

            border-bottom: 1px solid rgba(0, 191, 166, 0.15);
        }


        .header-icon {

            width: 60px;

            height: 60px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 15px;

            background: rgba(0, 191, 166, 0.09);

            border: 1px solid rgba(0, 191, 166, 0.25);

            font-size: 1.9rem;

            box-shadow:
                0 0 20px rgba(0, 191, 166, 0.08);
        }


        .page-header h1 {

            color: #ffffff;

            font-size: 1.9rem;

            margin-bottom: 5px;
        }


        .page-header p {

            color: var(--text-muted);

            font-size: 0.9rem;
        }


        /* ============================================================
           RESTAURANT BADGE
           ============================================================ */

        .restaurant-badge {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            margin-top: 8px;

            padding: 5px 11px;

            border-radius: 20px;

            background: rgba(0, 191, 166, 0.08);

            border: 1px solid rgba(0, 191, 166, 0.2);

            color: var(--teal-soft);

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

            background: rgba(0, 191, 166, 0.05);

            border: 1px solid rgba(0, 191, 166, 0.13);

            color: var(--text-muted);

            font-size: 0.85rem;

            line-height: 1.5;
        }


        .info-icon {

            font-size: 1.2rem;

            color: var(--teal-soft);

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

            color: var(--teal-glow);

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

            border: 1px solid rgba(0, 191, 166, 0.18);

            background: rgba(4, 28, 32, 0.5);

            box-shadow:
                0 8px 25px rgba(0, 0, 0, 0.2);
        }


        /* ============================================================
           GRIDVIEW
           ============================================================ */

        .orders-table {

            width: 100%;

            border-collapse: collapse;

            color: var(--text-primary);

            font-size: 0.88rem;
        }


        /* ============================================================
           TABLE HEADER
           ============================================================ */

        .orders-table th {

            padding: 15px 14px;

            background:
                linear-gradient(
                    135deg,
                    var(--teal-dark),
                    #075e61
                );

            color: #ffffff;

            font-weight: 600;

            text-align: left;

            border-bottom: 1px solid rgba(25, 230, 204, 0.35);

            white-space: nowrap;
        }


        /* ============================================================
           TABLE CELLS
           ============================================================ */

        .orders-table td {

            padding: 13px 14px;

            color: #cde7e4;

            border-bottom: 1px solid rgba(0, 191, 166, 0.10);

            background: rgba(4, 28, 32, 0.35);
        }


        /* ============================================================
           ALTERNATING ROWS
           ============================================================ */

        .orders-table tr:nth-child(even) td {

            background: rgba(0, 191, 166, 0.035);
        }


        /* ============================================================
           HOVER
           ============================================================ */

        .orders-table tr:hover td {

            background: rgba(0, 191, 166, 0.09);

            color: #ffffff;
        }


        /* ============================================================
           LAST ROW
           ============================================================ */

        .orders-table tr:last-child td {

            border-bottom: none;
        }


        /* ============================================================
           EMPTY DATA
           ============================================================ */

        .orders-table td:only-child {

            text-align: center;

            padding: 30px;

            color: var(--text-muted);
        }


        /* ============================================================
           TOTAL REVENUE
           ============================================================ */

        .revenue-row {

            display: flex;

            justify-content: flex-end;

            align-items: center;

            gap: 12px;

            margin-top: 18px;

            padding: 16px 20px;

            border-radius: 10px;

            background: rgba(0, 191, 166, 0.06);

            border: 1px solid rgba(0, 191, 166, 0.18);

            box-shadow:
                0 5px 15px rgba(0, 0, 0, 0.12);
        }


        .revenue-label {

            color: var(--text-muted);

            font-size: 0.95rem;

            font-weight: 600;
        }


        .revenue-value {

            color: var(--teal-glow);

            font-size: 1.25rem;

            font-weight: 700;

            text-shadow:
                0 0 10px rgba(25, 230, 204, 0.2);
        }


        /* ============================================================
           BUTTON AREA
           ============================================================ */

        .button-row {

            display: flex;

            justify-content: center;

            margin-top: 25px;

            padding-top: 25px;

            border-top: 1px solid rgba(0, 191, 166, 0.12);
        }


        .dashboard-button {

            min-width: 190px;

            padding: 11px 20px;

            border-radius: 8px;

            background:
                linear-gradient(
                    135deg,
                    var(--teal-glow),
                    var(--teal-dark)
                );

            color: #ffffff;

            font-size: 0.9rem;

            font-weight: 600;

            border: none;

            cursor: pointer;

            transition: all 0.2s ease;
        }


        .dashboard-button:hover {

            transform: translateY(-1px);

            opacity: 0.93;

            box-shadow:
                0 5px 15px rgba(0, 191, 166, 0.22);
        }


        /* ============================================================
           FOOTER
           ============================================================ */

        .footer-note {

            text-align: center;

            color: var(--text-muted);

            font-size: 0.78rem;

            margin-top: 18px;

            opacity: 0.8;
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


            .page-header h1 {

                font-size: 1.55rem;
            }


            .table-heading {

                align-items: flex-start;

                flex-direction: column;
            }


            .orders-table {

                min-width: 700px;
            }


            .dashboard-button {

                width: 100%;
            }


            .revenue-row {

                justify-content: space-between;

                padding: 14px 16px;
            }

        }

    </style>

</head>


<body>

<form id="form1" runat="server">

    <div class="page-container">

        <div class="glass-panel">


            <!-- =====================================================
                 HEADER
                 ===================================================== -->

            <div class="page-header">

                <div class="header-icon">
                    📋
                </div>


                <div>

                    <h1>
                        Restaurant Orders
                    </h1>


                    <p>
                        View and manage orders recorded within AquaCore.
                    </p>


                    <div class="restaurant-badge">

                        🍴 Restaurant Order Records

                    </div>

                </div>

            </div>


            <!-- =====================================================
                 INFORMATION
                 ===================================================== -->

            <div class="info-note">

                <div class="info-icon">
                    💡
                </div>


                <div>

                    Review the restaurant orders currently stored
                    in the AquaCore system. Scroll horizontally
                    on smaller screens to view all order details.

                </div>

            </div>


            <!-- =====================================================
                 TABLE HEADING
                 ===================================================== -->

            <div class="table-heading">

                <h2>
                    📊 Order Records
                </h2>


                <span>
                    AquaCore Restaurant Management
                </span>

            </div>


            <!-- =====================================================
                 ORDERS TABLE
                 ===================================================== -->

            <div class="table-wrapper">

                <asp:GridView
                    ID="gvOrders"
                    runat="server"
                    CssClass="orders-table"
                    AutoGenerateColumns="true">

                </asp:GridView>

            </div>


            <!-- =====================================================
                 TOTAL REVENUE
                 ===================================================== -->

            <div class="revenue-row">

                <span class="revenue-label">
                    💰 Total Revenue:
                </span>


                <asp:Label
                    ID="lblTotalRevenue"
                    runat="server"
                    CssClass="revenue-value"
                    Text="R 0.00">
                </asp:Label>

            </div>


            <!-- =====================================================
                 DASHBOARD BUTTON
                 ===================================================== -->

            <div class="button-row">

                <asp:Button
                    ID="btnDashboard"
                    runat="server"
                    Text="← Orders Dashboard"
                    CssClass="dashboard-button"
                    OnClick="btnDashboard_Click" />

            </div>


        </div>


        <!-- =========================================================
             FOOTER
             ========================================================= -->

        <div class="footer-note">

            AquaCore • Restaurant Orders Management

        </div>

    </div>

</form>

</body>

</html>
