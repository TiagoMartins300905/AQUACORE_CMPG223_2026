<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnimalManagementDashboard.aspx.cs" Inherits="AQUACORE_CMPG223.AnimalManagementDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - Animal Management System</title>

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

            max-width: 1000px;

            display: flex;

            flex-direction: column;

            gap: 24px;
        }

        /* Glass Panel */

        .glass-panel {

            background: var(--card-glass);

            border: 1px solid var(--card-border);

            border-radius: 16px;

            padding: 32px;

            box-shadow:
                0 10px 30px rgba(0, 0, 0, 0.35);
        }

        /* Welcome Header */

        .welcome-panel {

            text-align: center;

            padding: 45px 32px;
        }

        .welcome-icon {

            font-size: 3rem;

            margin-bottom: 15px;
        }

        .welcome-panel h1 {

            font-size: 2.2rem;

            color: #ffffff;

            margin-bottom: 5px;
        }

        .welcome-panel h2 {

            font-size: 1.35rem;

            color: var(--aqua-glow);

            font-weight: 600;

            margin-bottom: 12px;
        }

        .welcome-panel p {

            color: var(--text-muted);

            font-size: 0.95rem;

            line-height: 1.5;
        }

        /* Section Heading */

        .section-heading {

            margin-bottom: 25px;

            text-align: center;
        }

        .section-heading h2 {

            font-size: 1.4rem;

            color: var(--aqua-glow);

            margin-bottom: 6px;
        }

        .section-heading p {

            color: var(--text-muted);

            font-size: 0.9rem;
        }

        /* Menu Grid */

        .menu-grid {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;
        }

        /* Menu Cards */

        .menu-card {

            background: rgba(5, 19, 41, 0.55);

            border: 1px solid rgba(0, 210, 255, 0.18);

            border-radius: 12px;

            padding: 28px 20px;

            text-align: center;

            min-height: 220px;

            display: flex;

            flex-direction: column;

            justify-content: center;

            align-items: center;

            transition: all 0.25s ease;
        }

        .menu-card:hover {

            transform: translateY(-5px);

            border-color:
                rgba(0, 210, 255, 0.55);

            background:
                rgba(0, 210, 255, 0.08);

            box-shadow:
                0 8px 25px rgba(0, 210, 255, 0.12);
        }

        /* Icons */

        .menu-icon {

            width: 65px;

            height: 65px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 50%;

            background:
                rgba(0, 210, 255, 0.1);

            border:
                1px solid rgba(0, 210, 255, 0.2);

            font-size: 2rem;

            margin-bottom: 15px;
        }

        /* Card Titles */

        .menu-card h3 {

            color: #ffffff;

            font-size: 1.1rem;

            margin-bottom: 8px;
        }

        .menu-card p {

            color: var(--text-muted);

            font-size: 0.85rem;

            line-height: 1.4;

            margin-bottom: 18px;

            min-height: 38px;
        }

        /* ASP.NET Buttons */

        .menu-button {

            width: 100%;

            max-width: 190px;

            padding: 11px 18px;

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

            transition: all 0.2s;
        }

        .menu-button:hover {

            opacity: 0.9;

            transform: translateY(-1px);

            box-shadow:
                0 5px 15px
                rgba(0, 210, 255, 0.2);
        }

        /* Return Panel */

        .return-panel {

            text-align: center;

            background:
                rgba(255, 255, 255, 0.04);

            border:
                1px solid rgba(255, 255, 255, 0.12);
        }

        .return-panel p {

            color: var(--text-muted);

            font-size: 0.85rem;

            margin-bottom: 15px;
        }

        .return-button {

            padding: 10px 25px;

            border-radius: 8px;

            background:
                rgba(255, 255, 255, 0.08);

            color: var(--text-primary);

            border:
                1px solid rgba(255, 255, 255, 0.15);

            font-weight: 600;

            font-size: 0.9rem;

            cursor: pointer;

            transition: all 0.2s;
        }

        .return-button:hover {

            background:
                rgba(255, 255, 255, 0.15);

            color: #ffffff;
        }

        /* Mobile */

        @media (max-width: 800px) {

            body {

                padding: 20px 10px;
            }

            .glass-panel {

                padding: 25px 20px;
            }

            .menu-grid {

                grid-template-columns: 1fr;
            }

            .welcome-panel h1 {

                font-size: 1.8rem;
            }

        }

    </style>

</head>

<body>

    <form id="form1" runat="server">

        <div class="dashboard-container">


            <!-- Welcome -->

            <div class="glass-panel welcome-panel">

                <div class="welcome-icon">
                    🌊
                </div>

                <h1>
                    Welcome to AquaCore
                </h1>

                <h2>
                    Animal Management System
                </h2>

                <p>
                    Manage marine animals, feeding schedules and medical
                    records from one central dashboard.
                </p>

            </div>


            <!-- Management Options -->

            <div class="glass-panel">

                <div class="section-heading">

                    <h2>
                        Management Dashboard
                    </h2>

                    <p>
                        Select an area you would like to maintain.
                    </p>

                </div>


                <div class="menu-grid">


                    <!-- Marine Animals -->

                    <div class="menu-card">

                        <div class="menu-icon">
                            🐠
                        </div>

                        <h3>
                            Marine Animals
                        </h3>

                        <p>
                            Manage animal information and records.
                        </p>

                        <asp:Button
                            ID="btnAnimals"
                            runat="server"
                            Text="Marine Animals"
                            CssClass="menu-button" />

                    </div>


                    <!-- Feeding -->

                    <div class="menu-card">

                        <div class="menu-icon">
                            🥩
                        </div>

                        <h3>
                            Feeding Schedules
                        </h3>

                        <p>
                            Add, update, delete and view feeding schedules.
                        </p>

                        <asp:Button
                            ID="btnFeeding"
                            runat="server"
                            Text="Feeding Schedules"
                            CssClass="menu-button"
                            OnClick="btnFeeding_Click" />

                    </div>


                    <!-- Medical -->

                    <div class="menu-card">

                        <div class="menu-icon">
                            🩺
                        </div>

                        <h3>
                            Medical Records
                        </h3>

                        <p>
                            Manage medical information for marine animals.
                        </p>

                        <asp:Button
                            ID="btnMedical"
                            runat="server"
                            Text="Medical Records"
                            CssClass="menu-button" />

                    </div>


                </div>

            </div>


            <!-- Return -->

            <div class="glass-panel return-panel">

                <p>
                    Finished managing the AquaCore system?
                </p>

                <asp:Button
                    ID="btnReturn"
                    runat="server"
                    Text="↩ Return to Login"
                    CssClass="return-button" />

            </div>


        </div>

    </form>

</body>

</html>
