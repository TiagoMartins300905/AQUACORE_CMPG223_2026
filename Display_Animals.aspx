<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Display_Animals.aspx.cs" Inherits="AQUACORE_CMPG223.Display_Animals" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<title>AquaCore - Animals</title>

<style type="text/css">

    :root {
        --abyss-deep: #051329;
        --ocean-blue: #0b2545;
        --aqua-glow: #00d2ff;
        --card-glass: rgba(11, 37, 69, 0.78);
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

    /* Glass Panel */

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

    /* Animal Badge */

    .animal-badge {

        display: inline-flex;

        align-items: center;

        gap: 8px;

        margin-top: 12px;

        padding: 6px 13px;

        border-radius: 20px;

        background: rgba(0, 210, 255, 0.08);

        border: 1px solid rgba(0, 210, 255, 0.2);

        color: #7eeaff;

        font-size: 0.78rem;

        font-weight: 600;
    }

    /* Page Heading */

    .page-heading {

        margin-bottom: 25px;

        text-align: center;
    }

    .page-heading h2 {

        font-size: 1.5rem;

        color: var(--aqua-glow);

        margin-bottom: 7px;
    }

    .page-heading p {

        color: var(--text-muted);

        font-size: 0.9rem;

        line-height: 1.5;
    }

    /* Animal Display */

    .animal-display {

        background: rgba(5, 19, 41, 0.55);

        border: 1px solid rgba(0, 210, 255, 0.18);

        border-radius: 14px;

        padding: 25px;

        overflow-x: auto;

        box-shadow:
            inset 0 1px 0 rgba(255, 255, 255, 0.03);
    }

    /* GridView */

    .animal-grid {

        width: 100% !important;

        border-collapse: collapse;

        color: var(--text-primary);

        border: none !important;

    }

    .animal-grid th {

        background:
            linear-gradient(
                135deg,
                #00a8cc,
                #006b9a
            );

        color: #ffffff;

        padding: 13px 15px;

        text-align: left;

        font-size: 0.88rem;

        font-weight: 600;

        border: none;
    }

    .animal-grid td {

        background: rgba(5, 19, 41, 0.65);

        color: #dceaf3;

        padding: 12px 15px;

        border-bottom: 1px solid rgba(0, 210, 255, 0.10);

        font-size: 0.88rem;
    }

    .animal-grid tr:nth-child(even) td {

        background: rgba(11, 37, 69, 0.55);
    }

    .animal-grid tr:hover td {

        background: rgba(0, 210, 255, 0.09);

        color: #ffffff;

    }

    /* Empty / Info Area */

    .table-caption {

        display: flex;

        align-items: center;

        gap: 10px;

        color: var(--text-muted);

        font-size: 0.82rem;

        margin-bottom: 15px;
    }

    .table-caption-icon {

        font-size: 1.25rem;
    }

    /* Buttons */

    .button-row {

        display: flex;

        justify-content: center;

        margin-top: 25px;
    }

    .menu-button {

        min-width: 160px;

        padding: 11px 20px;

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

        transform: translateY(-2px);

        box-shadow:
            0 6px 18px rgba(0, 210, 255, 0.25);
    }

    /* Decorative Aquarium Bubbles */

    .bubble {

        position: fixed;

        border-radius: 50%;

        border: 1px solid rgba(255, 255, 255, 0.08);

        background: rgba(0, 210, 255, 0.025);

        pointer-events: none;

        z-index: -1;
    }

    .bubble-one {

        width: 90px;

        height: 90px;

        left: 5%;

        bottom: 12%;

    }

    .bubble-two {

        width: 35px;

        height: 35px;

        right: 10%;

        top: 20%;

    }

    .bubble-three {

        width: 55px;

        height: 55px;

        right: 4%;

        bottom: 15%;

    }

    /* Footer */

    .footer-note {

        text-align: center;

        color: var(--text-muted);

        font-size: 0.78rem;

        opacity: 0.75;
    }

    /* Mobile */

    @media (max-width: 700px) {

        body {

            padding: 20px 10px;
        }

        .glass-panel {

            padding: 22px;
        }

        .animal-display {

            padding: 15px;

        }

        .animal-grid th,
        .animal-grid td {

            padding: 10px;

            white-space: nowrap;
        }

        .menu-button {

            width: 100%;
        }
    }

</style>

</head> <body>
<!-- Decorative bubbles -->

<div class="bubble bubble-one"></div>
<div class="bubble bubble-two"></div>
<div class="bubble bubble-three"></div>


<form id="form1" runat="server">

    <div class="dashboard-container">


        <!-- Header -->

        <div class="glass-panel header-panel">

            <div class="header-title">

                <h1>AquaCore Operations</h1>

                <p>
                    Animal Management
                </p>

                <div class="animal-badge">

                    🐠 Aquarium Animal Records

                </div>

            </div>

        </div>


        <!-- Animal Records -->

        <div class="glass-panel">

            <div class="page-heading">

                <h2>🐬 AquaCore Animals</h2>

                <p>
                    View and monitor all animals currently registered
                    within the aquarium system.
                </p>

            </div>


            <div class="animal-display">

                <div class="table-caption">

                    <span class="table-caption-icon">🌊</span>

                    <span>
                        Registered aquarium animals
                    </span>

                </div>


                <asp:GridView
                    ID="GridView1"
                    runat="server"
                    CssClass="animal-grid"
                    Height="343px"
                    Width="384px">

                </asp:GridView>

            </div>


            <!-- Back Button -->

            <div class="button-row">

                <asp:Button
                    ID="btnMenu"
                    runat="server"
                    OnClick="btnMenu_Click"
                    Text="← Animal Menu"
                    CssClass="menu-button" />

            </div>

        </div>


        <div class="footer-note">

            AquaCore • Aquarium Animal Management

        </div>


    </div>

</form>

</body> </html>