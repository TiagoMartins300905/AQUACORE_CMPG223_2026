<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="AdminDashBoard.aspx.cs"
    Inherits="AQUACORE_CMPG223.AdminDashBoard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - Admin Dashboard</title>

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

            min-height: 100vh;

            background:
                linear-gradient(
                    135deg,
                    #fff8f2 0%,
                    #fff1eb 45%,
                    #e9faf7 100%
                );

            color: var(--text-dark);
        }

        /* =====================================================
           MAIN CONTAINER
        ===================================================== */

        .dashboard-container {

            width: 100%;

            min-height: 100vh;

            padding: 30px 50px;
        }

        /* =====================================================
           HEADER
        ===================================================== */

        .header {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 35px;

            background: rgba(255, 255, 255, 0.88);

            padding: 20px 25px;

            border-radius: 18px;

            box-shadow: var(--soft-shadow);

            border:
                1px solid rgba(255, 127, 110, 0.15);
        }

        .brand {

            display: flex;

            align-items: center;

            gap: 15px;
        }

        .brand-icon {

            width: 52px;

            height: 52px;

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

            font-size: 25px;

            box-shadow:
                0 6px 15px rgba(255, 127, 110, 0.25);
        }

        .brand-text h1 {

            font-size: 1.6rem;

            color: var(--text-dark);

            margin-bottom: 3px;
        }

        .brand-text p {

            color: var(--text-muted);

            font-size: 0.9rem;
        }

        /* =====================================================
           LOGOUT
        ===================================================== */

        .logout-btn {

            border: none;

            background:
                rgba(255, 127, 110, 0.10);

            color: var(--coral-dark);

            padding: 10px 18px;

            border-radius: 10px;

            font-weight: 600;

            cursor: pointer;

            transition: all 0.2s ease;
        }

        .logout-btn:hover {

            background: var(--coral);

            color: white;

            transform: translateY(-1px);

            box-shadow:
                0 5px 15px rgba(255, 127, 110, 0.25);
        }

        /* =====================================================
           WELCOME
        ===================================================== */

        .welcome-section {

            margin-bottom: 30px;
        }

        .welcome-section h2 {

            font-size: 2rem;

            margin-bottom: 7px;

            color: var(--text-dark);
        }

        .welcome-section p {

            color: var(--text-muted);

            font-size: 1rem;

            max-width: 700px;

            line-height: 1.6;
        }

        /* =====================================================
           DASHBOARD CARDS
        ===================================================== */

        .dashboard-grid {

            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 22px;

            margin-bottom: 35px;
        }

        .dashboard-card {

            background: rgba(255, 255, 255, 0.92);

            border-radius: 18px;

            padding: 25px;

            min-height: 220px;

            display: flex;

            flex-direction: column;

            justify-content: space-between;

            box-shadow: var(--card-shadow);

            border:
                1px solid rgba(255, 255, 255, 0.8);

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease;
        }

        .dashboard-card:hover {

            transform: translateY(-6px);

            box-shadow:
                0 18px 35px rgba(0, 0, 0, 0.13);
        }

        /* =====================================================
           CARD ICONS
        ===================================================== */

        .card-icon {

            width: 58px;

            height: 58px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 16px;

            font-size: 27px;

            margin-bottom: 18px;
        }

        .visitor-icon {

            background: rgba(45, 212, 191, 0.15);

            color: var(--turquoise-dark);
        }

        .employee-icon {

            background: rgba(255, 127, 110, 0.15);

            color: var(--coral-dark);
        }

        .animal-icon {

            background: rgba(255, 190, 92, 0.18);

            color: #d99000;
        }

        .restaurant-icon {

            background: rgba(122, 162, 247, 0.15);

            color: #5279d8;
        }

        /* =====================================================
           CARD CONTENT
        ===================================================== */

        .dashboard-card h3 {

            font-size: 1.25rem;

            margin-bottom: 8px;

            color: var(--text-dark);
        }

        .dashboard-card p {

            color: var(--text-muted);

            font-size: 0.88rem;

            line-height: 1.5;

            margin-bottom: 20px;
        }

        /* =====================================================
           CARD BUTTON
        ===================================================== */

        .card-button {

            width: 100%;

            border: none;

            padding: 11px 15px;

            border-radius: 10px;

            font-weight: 600;

            font-size: 0.9rem;

            cursor: pointer;

            transition: all 0.2s ease;

            color: white;
        }

        .visitor-button {

            background:
                linear-gradient(
                    135deg,
                    #2dd4bf,
                    #14b8a6
                );
        }

        .employee-button {

            background:
                linear-gradient(
                    135deg,
                    #ff9b8c,
                    #e86657
                );
        }

        .animal-button {

            background:
                linear-gradient(
                    135deg,
                    #ffc96b,
                    #e5a72e
                );
        }

        .restaurant-button {

            background:
                linear-gradient(
                    135deg,
                    #8ba8f5,
                    #5279d8
                );
        }

        .card-button:hover {

            transform: translateY(-2px);

            filter: brightness(0.96);

            box-shadow:
                0 6px 15px rgba(0, 0, 0, 0.12);
        }

        /* =====================================================
           FOOTER
        ===================================================== */

        .footer {

            background:
                rgba(255, 255, 255, 0.75);

            border-radius: 15px;

            padding: 18px 22px;

            text-align: center;

            color: var(--text-muted);

            font-size: 0.85rem;

            border:
                1px solid rgba(255, 127, 110, 0.12);
        }

        .footer span {

            color: var(--coral-dark);

            font-weight: 600;
        }

        /* =====================================================
           RESPONSIVE
        ===================================================== */

        @media (max-width: 1100px) {

            .dashboard-grid {

                grid-template-columns:
                    repeat(2, 1fr);
            }

        }

        @media (max-width: 700px) {

            .dashboard-container {

                padding: 20px;
            }

            .header {

                flex-direction: column;

                align-items: flex-start;

                gap: 18px;
            }

            .dashboard-grid {

                grid-template-columns: 1fr;
            }

            .welcome-section h2 {

                font-size: 1.6rem;
            }

        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="dashboard-container">

        <!-- =================================================
             HEADER
        ================================================== -->

        <div class="header">

            <div class="brand">

                <div class="brand-icon">
                    🌊
                </div>

                <div class="brand-text">

                    <h1>AquaCore</h1>

                    <p>Administrator Dashboard</p>

                </div>

            </div>

            <asp:Button
                ID="btnLogout"
                runat="server"
                Text="Logout"
                CssClass="logout-btn"
                OnClick="btnLogout_Click"
                CausesValidation="false" />

        </div>


        <!-- =================================================
             WELCOME
        ================================================== -->

        <div class="welcome-section">

            <h2>Welcome, Administrator</h2>

            <p>
                Manage and monitor the different areas of
                AquaCore Aquarium from one central dashboard.
                Select a section below to access its dashboard.
            </p>

        </div>


        <!-- =================================================
             MAIN DASHBOARDS
        ================================================== -->

        <div class="dashboard-grid">

            <!-- VISITORS -->

            <div class="dashboard-card">

                <div>

                    <div class="card-icon visitor-icon">
                        👥
                    </div>

                    <h3>Visitors</h3>

                    <p>
                        View visitor information, bookings,
                        attendance and visitor activity.
                    </p>

                </div>

                <asp:Button
                    ID="btnVisitors"
                    runat="server"
                    Text="Open Visitors Dashboard"
                    CssClass="card-button visitor-button"
                    OnClick="btnVisitors_Click"
                    CausesValidation="false" />

            </div>


            <!-- EMPLOYEES -->

            <div class="dashboard-card">

                <div>

                    <div class="card-icon employee-icon">
                        👨‍💼
                    </div>

                    <h3>Employees</h3>

                    <p>
                        Manage staff members, roles,
                        departments and employee information.
                    </p>

                </div>

                <asp:Button
                    ID="btnEmployees"
                    runat="server"
                    Text="Open Employees Dashboard"
                    CssClass="card-button employee-button"
                    OnClick="btnEmployees_Click"
                    CausesValidation="false" />

            </div>


            <!-- ANIMALS -->

            <div class="dashboard-card">

                <div>

                    <div class="card-icon animal-icon">
                        🐠
                    </div>

                    <h3>Animals</h3>

                    <p>
                        View aquarium animals, species,
                        habitats and animal management records.
                    </p>

                </div>

                <asp:Button
                    ID="btnAnimals"
                    runat="server"
                    Text="Open Animals Dashboard"
                    CssClass="card-button animal-button"
                    OnClick="btnAnimals_Click"
                    CausesValidation="false" />

            </div>


            <!-- RESTAURANT -->

            <div class="dashboard-card">

                <div>

                    <div class="card-icon restaurant-icon">
                        🍽️
                    </div>

                    <h3>Restaurant</h3>

                    <p>
                        Manage restaurant information,
                        menu items, orders and restaurant activity.
                    </p>

                </div>

                <asp:Button
                    ID="btnRestaurant"
                    runat="server"
                    Text="Open Restaurant Dashboard"
                    CssClass="card-button restaurant-button"
                    OnClick="btnRestaurant_Click"
                    CausesValidation="false" />

            </div>

        </div>


        <!-- =================================================
             FOOTER
        ================================================== -->

        <div class="footer">

            AquaCore Aquarium Management System
            <span>• Administrator Portal</span>

        </div>

    </div>

</form>

</body>

</html>
