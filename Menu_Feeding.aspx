<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="Menu_Feeding.aspx.cs"
Inherits="AQUACORE_CMPG223.Menu_Feeding" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<title>AquaCore - Feeding Management</title>

<style>

    :root {
        --abyss-deep: #051329;
        --ocean-blue: #0b2545;
        --aqua-glow: #00d2ff;
        --aqua-light: #55e6ff;

        --card-glass: rgba(11, 37, 69, 0.75);
        --card-border: rgba(0, 210, 255, 0.25);

        --text-primary: #eef4f8;
        --text-muted: #8da4be;

        --feeding-green: #54e38e;
        --feeding-green-dark: #159957;

        --danger: #ff6b7a;
        --danger-dark: #d9364a;
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

        max-width: 1000px;

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

        margin-bottom: 5px;
    }

    .header-title p {

        color: var(--text-muted);

        font-size: 0.95rem;
    }

    /* Feeding Badge */

    .feeding-badge {

        display: inline-flex;

        align-items: center;

        gap: 7px;

        margin-top: 12px;

        padding: 6px 13px;

        border-radius: 20px;

        background: rgba(84, 227, 142, 0.08);

        border: 1px solid rgba(84, 227, 142, 0.22);

        color: #7df0a8;

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

        background: rgba(255, 255, 255, 0.08);

        color: var(--text-primary);

        border: 1px solid rgba(255, 255, 255, 0.15);
    }

    .btn-outline:hover {

        background: rgba(255, 255, 255, 0.15);

        color: #ffffff;

        transform: translateY(-1px);
    }

    /* Page Heading */

    .menu-heading {

        margin-bottom: 25px;
    }

    .menu-heading h2 {

        font-size: 1.4rem;

        color: var(--aqua-glow);

        margin-bottom: 6px;
    }

    .menu-heading p {

        color: var(--text-muted);

        font-size: 0.9rem;

        line-height: 1.5;
    }

    /* Feeding Grid */

    .menu-grid {

        display: grid;

        grid-template-columns: repeat(2, 1fr);

        gap: 20px;
    }

    /* Feeding Cards */

    .menu-card {

        position: relative;

        background: rgba(5, 19, 41, 0.55);

        border: 1px solid rgba(0, 210, 255, 0.18);

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

    /* Animated top glow */

    .menu-card::before {

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
                var(--aqua-glow),
                transparent
            );

        opacity: 0;

        transition: opacity 0.25s ease;
    }

    .menu-card:hover {

        transform: translateY(-5px);

        border-color: rgba(0, 210, 255, 0.55);

        background: rgba(0, 210, 255, 0.07);

        box-shadow:
            0 10px 30px rgba(0, 210, 255, 0.12);
    }

    .menu-card:hover::before {

        opacity: 1;
    }

    /* Feeding Icon */

    .menu-icon {

        width: 58px;

        height: 58px;

        margin: 0 auto 15px;

        display: flex;

        align-items: center;

        justify-content: center;

        border-radius: 14px;

        background: rgba(0, 210, 255, 0.08);

        border: 1px solid rgba(0, 210, 255, 0.2);

        font-size: 1.8rem;

        transition: all 0.25s ease;
    }

    .menu-card:hover .menu-icon {

        background: rgba(0, 210, 255, 0.14);

        border-color: rgba(0, 210, 255, 0.4);

        transform: scale(1.05);
    }

    /* Card Titles */

    .menu-card h3 {

        color: #ffffff;

        font-size: 1.15rem;

        margin-bottom: 8px;
    }

    /* Card Descriptions */

    .menu-card p {

        color: var(--text-muted);

        font-size: 0.88rem;

        line-height: 1.5;

        min-height: 42px;

        margin-bottom: 20px;
    }

    /* Card Buttons */

    .menu-button {

        display: inline-block;

        min-width: 150px;

        padding: 10px 18px;

        border-radius: 8px;

        background:
            linear-gradient(
                135deg,
                #00d2ff,
                #0077b6
            );

        color: #ffffff;

        font-weight: 600;

        font-size: 0.9rem;

        border: none;

        cursor: pointer;

        transition: all 0.2s ease;
    }

    .menu-button:hover {

        opacity: 0.92;

        transform: translateY(-1px);

        box-shadow:
            0 5px 15px rgba(0, 210, 255, 0.22);
    }

    /* Delete Card */

    .delete-card {

        background: rgba(255, 107, 122, 0.04);

        border-color: rgba(255, 107, 122, 0.16);
    }

    .delete-card:hover {

        border-color: rgba(255, 107, 122, 0.45);

        background: rgba(255, 107, 122, 0.07);

        box-shadow:
            0 10px 30px rgba(255, 107, 122, 0.08);
    }

    .delete-card .menu-icon {

        background: rgba(255, 107, 122, 0.07);

        border-color: rgba(255, 107, 122, 0.2);
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

    /* Return Card */

    .return-card {

        grid-column: 1 / -1;

        background: rgba(255, 255, 255, 0.04);

        border-color: rgba(255, 255, 255, 0.12);
    }

    .return-card:hover {

        border-color: rgba(255, 255, 255, 0.25);

        background: rgba(255, 255, 255, 0.06);

        box-shadow:
            0 10px 30px rgba(255, 255, 255, 0.04);
    }

    .return-card .menu-button {

        background: rgba(255, 255, 255, 0.08);

        border: 1px solid rgba(255, 255, 255, 0.18);
    }

    .return-card .menu-button:hover {

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

        .menu-grid {

            grid-template-columns: 1fr;
        }

        .return-card {

            grid-column: auto;
        }

        .menu-button {

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
                Feeding Schedule Management
            </p>

            <div class="feeding-badge">
                🐟 Daily Nutrition &amp; Feeding Care
            </div>

        </div>

        <div>

            <asp:Button
                ID="Button5"
                runat="server"
                Text="← Go Back"
                CssClass="btn btn-outline"
                OnClick="Button5_Click" />

        </div>

    </div>


    <!-- FEEDING MENU -->

    <div class="glass-panel">

        <div class="menu-heading">

            <h2>Feeding Schedule</h2>

            <p>
                Manage feeding schedules and ensure every animal receives
                the right care at the right time.
            </p>

        </div>


        <div class="menu-grid">


            <!-- ADD -->

            <div class="menu-card">

                <div class="menu-icon">
                    🐠
                </div>

                <h3>
                    Add Feeding Schedule
                </h3>

                <p>
                    Create a new feeding schedule for an aquarium animal.
                </p>

                <asp:Button
                    ID="btnAdd"
                    runat="server"
                    Text="Add Feeding"
                    CssClass="menu-button"
                    OnClick="btnAdd_Click" />

            </div>


            <!-- UPDATE -->

            <div class="menu-card">

                <div class="menu-icon">
                    ⏰
                </div>

                <h3>
                    Update Schedule
                </h3>

                <p>
                    Adjust feeding times or details for an existing schedule.
                </p>

                <asp:Button
                    ID="btnUpdate"
                    runat="server"
                    Text="Update Feeding"
                    CssClass="menu-button"
                    OnClick="btnUpdate_Click" />

            </div>


            <!-- DELETE -->

            <div class="menu-card delete-card">

                <div class="menu-icon">
                    🗑️
                </div>

                <h3>
                    Delete Schedule
                </h3>

                <p>
                    Remove an outdated or unnecessary feeding schedule.
                </p>

                <asp:Button
                    ID="btnDelete"
                    runat="server"
                    Text="Delete Feeding"
                    CssClass="menu-button delete-button"
                    OnClick="btnDelete_Click" />

            </div>


            <!-- VIEW -->

            <div class="menu-card">

                <div class="menu-icon">
                    📋
                </div>

                <h3>
                    View Schedules
                </h3>

                <p>
                    View the feeding routines currently registered for animals.
                </p>

                <asp:Button
                    ID="btnView"
                    runat="server"
                    Text="View Feedings"
                    CssClass="menu-button"
                    OnClick="btnView_Click" />

            </div>


            <!-- RETURN -->

            <div class="menu-card return-card">

                <div class="menu-icon">
                    🌊
                </div>

                <h3>
                    Return to Previous Menu
                </h3>

                <p>
                    Return to the previous AquaCore animal management menu.
                </p>

                <asp:Button
                    ID="btnReturn"
                    runat="server"
                    Text="Go Back"
                    CssClass="menu-button"
                    OnClick="Button5_Click" />

            </div>

        </div>

    </div>


    <div class="footer-note">
        AquaCore • Aquarium Animal Nutrition &amp; Feeding Care
    </div>

</div>

</form> </body> </html>