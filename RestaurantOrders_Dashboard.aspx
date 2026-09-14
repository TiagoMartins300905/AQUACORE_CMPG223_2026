<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RestaurantOrders_Dashboard.aspx.cs" Inherits="AQUACORE_CMPG223.RestaurantOrders_Dashboard" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server"> <title>AquaCore - Restaurant Orders</title>
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

        --danger: #ff6b7a;
        --danger-dark: #d9364a;
        --danger-soft: rgba(255, 107, 122, 0.08);
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

        flex-direction: column;

        align-items: center;

        padding: 40px 20px;

        position: relative;

        overflow-x: hidden;
    }

    /* Underwater Teal Glow */

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

    /* Main Container */

    .dashboard-container {

        width: 100%;

        max-width: 1000px;

        display: flex;

        flex-direction: column;

        gap: 24px;

        position: relative;

        z-index: 1;
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

    .header-title {

        display: flex;

        align-items: center;

        gap: 16px;
    }

    .header-icon {

        width: 58px;

        height: 58px;

        display: flex;

        align-items: center;

        justify-content: center;

        border-radius: 14px;

        background: rgba(0, 191, 166, 0.09);

        border: 1px solid rgba(0, 191, 166, 0.25);

        font-size: 1.8rem;

        box-shadow:
            0 0 20px rgba(0, 191, 166, 0.08);
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

    /* Restaurant Badge */

    .restaurant-badge {

        display: inline-flex;

        align-items: center;

        gap: 7px;

        margin-top: 10px;

        padding: 6px 12px;

        border-radius: 20px;

        background: rgba(0, 191, 166, 0.08);

        border: 1px solid rgba(0, 191, 166, 0.22);

        color: var(--teal-soft);

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

        text-decoration: none;

        text-align: center;

        transition: all 0.2s ease;
    }

    .btn-outline {

        background: rgba(255, 255, 255, 0.07);

        color: var(--text-primary);

        border: 1px solid rgba(255, 255, 255, 0.15);
    }

    .btn-outline:hover {

        background: rgba(255, 255, 255, 0.14);

        color: #ffffff;

        transform: translateY(-1px);
    }

    /* Page Heading */

    .page-heading {

        margin-bottom: 20px;
    }

    .page-heading h2 {

        font-size: 1.4rem;

        color: var(--teal-glow);

        margin-bottom: 6px;
    }

    .page-heading p {

        color: var(--text-muted);

        font-size: 0.9rem;

        line-height: 1.5;
    }

    /* Restaurant Note */

    .order-note {

        display: flex;

        align-items: center;

        gap: 12px;

        margin-bottom: 25px;

        padding: 13px 16px;

        border-radius: 10px;

        background: rgba(0, 191, 166, 0.05);

        border: 1px solid rgba(0, 191, 166, 0.13);

        color: var(--text-muted);

        font-size: 0.85rem;
    }

    .order-note-icon {

        font-size: 1.2rem;

        color: var(--teal-soft);
    }

    /* Orders Grid */

    .orders-grid {

        display: grid;

        grid-template-columns: repeat(2, 1fr);

        gap: 20px;
    }

    /* Order Cards */

    .order-card {

        position: relative;

        background: rgba(4, 28, 32, 0.58);

        border: 1px solid rgba(0, 191, 166, 0.18);

        border-radius: 14px;

        padding: 26px;

        text-align: center;

        overflow: hidden;

        transition:
            transform 0.25s ease,
            border-color 0.25s ease,
            background 0.25s ease,
            box-shadow 0.25s ease;
    }

    .order-card::before {

        content: "";

        position: absolute;

        top: 0;

        left: 0;

        width: 100%;

        height: 3px;

        background:
            linear-gradient(
                90deg,
                transparent,
                var(--teal-glow),
                transparent
            );

        opacity: 0;

        transition: opacity 0.25s ease;
    }

    .order-card:hover {

        transform: translateY(-5px);

        border-color: rgba(0, 191, 166, 0.55);

        background: rgba(0, 191, 166, 0.07);

        box-shadow:
            0 10px 30px rgba(0, 191, 166, 0.12);
    }

    .order-card:hover::before {

        opacity: 1;
    }

    /* Delete Card */

    .order-card.delete-card:hover {

        border-color: rgba(255, 107, 122, 0.45);

        background: var(--danger-soft);

        box-shadow:
            0 10px 30px rgba(255, 107, 122, 0.08);
    }

    .order-card.delete-card::before {

        background:
            linear-gradient(
                90deg,
                transparent,
                var(--danger),
                transparent
            );
    }

    /* Icons */

    .order-icon {

        width: 58px;

        height: 58px;

        margin: 0 auto 15px;

        display: flex;

        align-items: center;

        justify-content: center;

        border-radius: 14px;

        background: rgba(0, 191, 166, 0.08);

        border: 1px solid rgba(0, 191, 166, 0.2);

        font-size: 1.8rem;

        transition: all 0.25s ease;
    }

    .order-card:hover .order-icon {

        background: rgba(0, 191, 166, 0.14);

        border-color: rgba(0, 191, 166, 0.4);

        transform: scale(1.05);
    }

    .delete-card .order-icon {

        background: rgba(255, 107, 122, 0.07);

        border-color: rgba(255, 107, 122, 0.2);
    }

    /* Card Titles */

    .order-card h3 {

        color: #ffffff;

        font-size: 1.15rem;

        margin-bottom: 8px;
    }

    /* Card Descriptions */

    .order-card p {

        color: var(--text-muted);

        font-size: 0.88rem;

        line-height: 1.5;

        min-height: 42px;

        margin-bottom: 20px;
    }

    /* Order Buttons */

    .order-button {

        display: inline-block;

        min-width: 150px;

        padding: 10px 18px;

        border-radius: 8px;

        background:
            linear-gradient(
                135deg,
                var(--teal-glow),
                var(--teal-dark)
            );

        color: #ffffff;

        font-weight: 600;

        font-size: 0.9rem;

        border: none;

        cursor: pointer;

        transition: all 0.2s ease;
    }

    .order-button:hover {

        opacity: 0.92;

        transform: translateY(-1px);

        box-shadow:
            0 5px 15px rgba(0, 191, 166, 0.22);
    }

    /* Delete Button */

    .delete-button {

        background:
            linear-gradient(
                135deg,
                var(--danger),
                var(--danger-dark)
            );
    }

    .delete-button:hover {

        box-shadow:
            0 5px 15px rgba(255, 92, 108, 0.22);
    }

    /* Footer / Return */

    .return-card {

        grid-column: 1 / -1;

        background: rgba(255, 255, 255, 0.04);

        border-color: rgba(255, 255, 255, 0.12);
    }

    .return-card .order-button {

        background: rgba(255, 255, 255, 0.08);

        border: 1px solid rgba(255, 255, 255, 0.18);
    }

    .return-card .order-button:hover {

        background: rgba(255, 255, 255, 0.15);

        box-shadow: none;
    }

    /* Footer */

    .footer-note {

        text-align: center;

        color: var(--text-muted);

        font-size: 0.78rem;

        margin-top: 4px;

        opacity: 0.8;
    }

    /* Mobile */

    @media (max-width: 700px) {

        body {

            padding: 20px 10px;
        }

        .glass-panel {

            padding: 22px;
        }

        .orders-grid {

            grid-template-columns: 1fr;
        }

        .return-card {

            grid-column: auto;
        }

        .order-button {

            width: 100%;
        }

        .header-panel {

            align-items: flex-start;
        }

        .header-title h1 {

            font-size: 1.6rem;
        }

        .header-panel .btn {

            width: 100%;
        }
    }

</style>

</head> <body>
<form id="form1" runat="server">

    <div class="dashboard-container">

        <!-- Header -->

        <div class="glass-panel header-panel">

            <div class="header-title">

                <div class="header-icon">
                    🍽️
                </div>

                <div>

                    <h1>AquaCore Operations</h1>

                    <p>
                        Restaurant Orders Management
                    </p>

                    <div class="restaurant-badge">
                        🍴 Restaurant &amp; Food Service
                    </div>

                </div>

            </div>

            <div>

                <asp:Button
                    ID="btnBack"
                    runat="server"
                    Text="← Go Back"
                    CssClass="btn btn-outline" />

            </div>

        </div>

        <!-- Restaurant Orders -->

        <div class="glass-panel">

            <div class="page-heading">

                <h2>🍽️ Restaurant Orders</h2>

                <p>
                    Manage restaurant orders placed within the
                    AquaCore aquarium and keep order information
                    organised and up to date.
                </p>

            </div>

            <!-- Order Note -->

            <div class="order-note">

                <div class="order-note-icon">
                    🥗
                </div>

                <div>
                    Keep restaurant orders accurate so staff can
                    efficiently manage meals, customer requests,
                    and order information.
                </div>

            </div>

            <div class="orders-grid">

                <!-- Add Order -->

                <div class="order-card">

                    <div class="order-icon">
                        🛒
                    </div>

                    <h3>
                        Add New Order
                    </h3>

                    <p>
                        Create a new restaurant order and record
                        the required order information.
                    </p>

                    <asp:Button
                        ID="Button1"
                        runat="server"
                        Text="Add Order"
                        CssClass="order-button" OnClick="Button1_Click" />

                </div>

                <!-- Update Order -->

                <div class="order-card">

                    <div class="order-icon">
                        ✏️
                    </div>

                    <h3>
                        Update Order
                    </h3>

                    <p>
                        Modify an existing order when customer
                        details or order information changes.
                    </p>

                    <asp:Button
                        ID="btnUpdate"
                        runat="server"
                        Text="Update Order"
                        CssClass="order-button"
                        OnClick="btnUpdate_Click" />

                </div>

                <!-- Delete Order -->

                <div class="order-card delete-card">

                    <div class="order-icon">
                        🗑️
                    </div>

                    <h3>
                        Delete Order
                    </h3>

                    <p>
                        Remove an outdated or incorrect restaurant
                        order from the system.
                    </p>

                    <asp:Button
                        ID="btnDelete"
                        runat="server"
                        Text="Delete Order"
                        CssClass="order-button delete-button" OnClick="btnDelete_Click" />

                </div>

                <!-- Display Orders -->

                <div class="order-card">

                    <div class="order-icon">
                        📋
                    </div>

                    <h3>
                        View Orders
                    </h3>

                    <p>
                        Browse restaurant orders and review the
                        current order information stored in AquaCore.
                    </p>

                    <asp:Button
                        ID="btnDisplay"
                        runat="server"
                        Text="Display Orders"
                        CssClass="order-button" OnClick="btnDisplay_Click" />

                </div>

                <!-- Return -->

                <div class="order-card return-card">

                    <div class="order-icon">
                        🐠
                    </div>

                    <h3>
                        Return to Operations
                    </h3>

                    <p>
                        Return to the previous AquaCore operations
                        or management menu.
                    </p>

                    <asp:Button
                        ID="btnReturn"
                        runat="server"
                        Text="Go Back"
                        CssClass="order-button" />

                </div>

            </div>

        </div>

        <div class="footer-note">
            AquaCore • Restaurant Orders Management
        </div>

    </div>

</form>

</body> </html>