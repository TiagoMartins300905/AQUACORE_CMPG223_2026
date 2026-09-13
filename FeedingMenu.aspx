<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedingMenu.aspx.cs" Inherits="AQUACORE_CMPG223.FeedingMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - Feeding Schedule Menu</title>

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
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
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

            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
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

        /* Header Button */

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

        /* Menu Heading */

        .menu-heading {

            margin-bottom: 25px;
        }

        .menu-heading h2 {

            font-size: 1.4rem;

            color: var(--aqua-glow);

            margin-bottom: 5px;
        }

        .menu-heading p {

            color: var(--text-muted);

            font-size: 0.9rem;
        }

        /* Menu Grid */

        .menu-grid {

            display: grid;

            grid-template-columns: repeat(2, 1fr);

            gap: 20px;
        }

        /* Menu Cards */

        .menu-card {

            background: rgba(5, 19, 41, 0.55);

            border: 1px solid rgba(0, 210, 255, 0.18);

            border-radius: 12px;

            padding: 25px;

            text-align: center;

            transition: all 0.25s ease;
        }

        .menu-card:hover {

            transform: translateY(-4px);

            border-color: rgba(0, 210, 255, 0.55);

            background: rgba(0, 210, 255, 0.08);

            box-shadow: 0 8px 25px rgba(0, 210, 255, 0.12);
        }

        /* Icons */

        .menu-icon {

            font-size: 2rem;

            margin-bottom: 10px;
        }

        /* Card Titles */

        .menu-card h3 {

            color: #ffffff;

            font-size: 1.15rem;

            margin-bottom: 8px;
        }

        /* Card Description */

        .menu-card p {

            color: var(--text-muted);

            font-size: 0.88rem;

            line-height: 1.5;

            margin-bottom: 18px;
        }

        /* Menu Buttons */

        .menu-button {

            display: inline-block;

            min-width: 150px;

            padding: 10px 18px;

            border-radius: 8px;

            background: linear-gradient(
                135deg,
                #00d2ff,
                #0077b6
            );

            color: #ffffff;

            font-weight: 600;

            font-size: 0.9rem;

            border: none;

            cursor: pointer;

            transition: all 0.2s;
        }

        .menu-button:hover {

            opacity: 0.9;

            transform: translateY(-1px);

            box-shadow: 0 5px 15px rgba(0, 210, 255, 0.2);
        }

        /* Return Card */

        .return-card {

            grid-column: 1 / -1;

            background: rgba(255, 255, 255, 0.04);

            border: 1px solid rgba(255, 255, 255, 0.12);
        }

        .return-card .menu-button {

            background: rgba(255, 255, 255, 0.08);

            border: 1px solid rgba(255, 255, 255, 0.18);
        }

        .return-card .menu-button:hover {

            background: rgba(255, 255, 255, 0.15);
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
        }

    </style>

</head>

<body>

    <form id="form1" runat="server">

        <div class="dashboard-container">

            <!-- Header -->

            <div class="glass-panel header-panel">

                <div class="header-title">

                    <h1>AquaCore Operations</h1>

                    <p>
                        Feeding Schedule Management
                    </p>

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


            <!-- Menu -->

            <div class="glass-panel">

                <div class="menu-heading">

                    <h2>Feeding Schedule Menu</h2>

                    <p>
                        Select an option below to manage the aquarium feeding schedules.
                    </p>

                </div>


                <div class="menu-grid">


                    <!-- Add -->

                    <div class="menu-card">

                        <div class="menu-icon">
                            ➕
                        </div>

                        <h3>
                            Add Schedule
                        </h3>

                        <p>
                            Create a new feeding schedule for an animal.
                        </p>

                        <asp:Button
                            ID="btnAdd"
                            runat="server"
                            Text="Add Feeding"
                            CssClass="menu-button"
                            OnClick="btnAdd_Click1" />

                    </div>


                    <!-- Update -->

                    <div class="menu-card">

                        <div class="menu-icon">
                            ✏️
                        </div>

                        <h3>
                            Update Schedule
                        </h3>

                        <p>
                            Modify an existing feeding schedule.
                        </p>

                        <asp:Button
                            ID="btnUpdate"
                            runat="server"
                            Text="Update Feeding"
                            CssClass="menu-button"
                            OnClick="btnUpdate_Click" />

                    </div>


                    <!-- Delete -->

                    <div class="menu-card">

                        <div class="menu-icon">
                            🗑️
                        </div>

                        <h3>
                            Delete Schedule
                        </h3>

                        <p>
                            Remove an existing feeding schedule from the system.
                        </p>

                        <asp:Button
                            ID="btnDelete"
                            runat="server"
                            Text="Delete Feeding"
                            CssClass="menu-button"
                            OnClick="btnDelete_Click" />

                    </div>


                    <!-- View -->

                    <div class="menu-card">

                        <div class="menu-icon">
                            📋
                        </div>

                        <h3>
                            View Schedules
                        </h3>

                        <p>
                            View all existing feeding schedules.
                        </p>

                        <asp:Button
                            ID="btnView"
                            runat="server"
                            Text="View Feedings"
                            CssClass="menu-button"
                            OnClick="btnView_Click" />

                    </div>


                    <!-- Return -->

                    <div class="menu-card return-card">

                        <div class="menu-icon">
                            ↩️
                        </div>

                        <h3>
                            Return to Previous Menu
                        </h3>

                        <p>
                            Return to the previous AquaCore menu.
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

        </div>

    </form>

</body>

</html>
