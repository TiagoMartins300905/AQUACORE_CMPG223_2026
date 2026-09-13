<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Medicals_Dashboard.aspx.cs" Inherits="AQUACORE_CMPG223.Medicals_Dashboard" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<title>AquaCore - Animal Medical Records</title>

<style>

    :root {
        --abyss-deep: #051329;
        --ocean-blue: #0b2545;
        --aqua-glow: #00d2ff;
        --aqua-soft: #5de6ff;

        --card-glass: rgba(11, 37, 69, 0.75);
        --card-border: rgba(0, 210, 255, 0.25);

        --text-primary: #eef4f8;
        --text-muted: #8da4be;

        --medical-red: #ff6b7a;
        --medical-red-dark: #d9364a;
        --medical-soft: rgba(255, 107, 122, 0.08);
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

        position: relative;

        overflow-x: hidden;
    }

    /* Underwater Glow */

    body::before {

        content: "";

        position: fixed;

        width: 500px;

        height: 500px;

        border-radius: 50%;

        background: rgba(0, 210, 255, 0.04);

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

        background: rgba(0, 119, 182, 0.05);

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

        background: rgba(255, 107, 122, 0.08);

        border: 1px solid rgba(255, 107, 122, 0.22);

        font-size: 1.8rem;

        box-shadow:
            0 0 20px rgba(255, 107, 122, 0.06);
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

    /* Medical Badge */

    .medical-badge {

        display: inline-flex;

        align-items: center;

        gap: 7px;

        margin-top: 10px;

        padding: 6px 12px;

        border-radius: 20px;

        background: rgba(255, 107, 122, 0.08);

        border: 1px solid rgba(255, 107, 122, 0.2);

        color: #ff9aa5;

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

    .page-heading {

        margin-bottom: 20px;
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

    /* Animal Health Note */

    .health-note {

        display: flex;

        align-items: center;

        gap: 12px;

        margin-bottom: 25px;

        padding: 13px 16px;

        border-radius: 10px;

        background: rgba(0, 210, 255, 0.05);

        border: 1px solid rgba(0, 210, 255, 0.12);

        color: var(--text-muted);

        font-size: 0.85rem;
    }

    .health-note-icon {

        font-size: 1.2rem;

        color: var(--aqua-soft);
    }

    /* Medical Grid */

    .medical-grid {

        display: grid;

        grid-template-columns: repeat(2, 1fr);

        gap: 20px;
    }

    /* Medical Cards */

    .medical-card {

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

    .medical-card::before {

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

    .medical-card:hover {

        transform: translateY(-5px);

        border-color: rgba(0, 210, 255, 0.55);

        background: rgba(0, 210, 255, 0.07);

        box-shadow:
            0 10px 30px rgba(0, 210, 255, 0.12);
    }

    .medical-card:hover::before {

        opacity: 1;
    }

    /* Medical Delete Card */

    .medical-card.delete-card:hover {

        border-color: rgba(255, 107, 122, 0.45);

        background: var(--medical-soft);

        box-shadow:
            0 10px 30px rgba(255, 107, 122, 0.08);
    }

    .medical-card.delete-card::before {

        background:
            linear-gradient(
                90deg,
                transparent,
                var(--medical-red),
                transparent
            );
    }

    /* Medical Icons */

    .medical-icon {

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

    .medical-card:hover .medical-icon {

        background: rgba(0, 210, 255, 0.14);

        border-color: rgba(0, 210, 255, 0.4);

        transform: scale(1.05);
    }

    .delete-card .medical-icon {

        background: rgba(255, 107, 122, 0.07);

        border-color: rgba(255, 107, 122, 0.2);
    }

    /* Card Titles */

    .medical-card h3 {

        color: #ffffff;

        font-size: 1.15rem;

        margin-bottom: 8px;
    }

    /* Card Descriptions */

    .medical-card p {

        color: var(--text-muted);

        font-size: 0.88rem;

        line-height: 1.5;

        min-height: 42px;

        margin-bottom: 20px;
    }

    /* Card Buttons */

    .medical-button {

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

    .medical-button:hover {

        opacity: 0.92;

        transform: translateY(-1px);

        box-shadow:
            0 5px 15px rgba(0, 210, 255, 0.22);
    }

    /* Delete Button */

    .delete-button {

        background:
            linear-gradient(
                135deg,
                var(--medical-red),
                var(--medical-red-dark)
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

    .return-card .medical-button {

        background: rgba(255, 255, 255, 0.08);

        border: 1px solid rgba(255, 255, 255, 0.18);
    }

    .return-card .medical-button:hover {

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

        .medical-grid {

            grid-template-columns: 1fr;
        }

        .return-card {

            grid-column: auto;
        }

        .medical-button {

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

</head> <body> <form id="form1" runat="server">
<div class="dashboard-container">

    <!-- Header -->

    <div class="glass-panel header-panel">

        <div class="header-title">

            <div class="header-icon">
                🐾
            </div>

            <div>

                <h1>AquaCore Operations</h1>

                <p>
                    Animal Medical Records
                </p>

                <div class="medical-badge">
                    🩺 Animal Health &amp; Veterinary Care
                </div>

            </div>

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

    <!-- Medical Records -->

    <div class="glass-panel">

        <div class="page-heading">

            <h2>🩺 Animal Health Records</h2>

            <p>
                Maintain the medical history and health information
                of animals cared for within the AquaCore aquarium.
            </p>

        </div>

        <!-- Health Note -->

        <div class="health-note">

            <div class="health-note-icon">
                💙
            </div>

            <div>
                Healthy records help AquaCore staff monitor animal
                wellbeing, treatments, and ongoing veterinary care.
            </div>

        </div>

        <div class="medical-grid">

            <!-- Add Record -->

            <div class="medical-card">

                <div class="medical-icon">
                    🐠
                </div>

                <h3>
                    Add Medical Record
                </h3>

                <p>
                    Record a new health issue, examination, treatment,
                    or medical observation for an animal.
                </p>

                <asp:Button
                    ID="btnAdd"
                    runat="server"
                    Text="Add Record"
                    CssClass="medical-button"
                    OnClick="btnAdd_Click" />

            </div>

            <!-- Update Record -->

            <div class="medical-card">

                <div class="medical-icon">
                    🐬
                </div>

                <h3>
                    Update Medical Record
                </h3>

                <p>
                    Update existing health information as an animal's
                    condition or treatment changes.
                </p>

                <asp:Button
                    ID="btnUpdate"
                    runat="server"
                    Text="Update Record"
                    CssClass="medical-button"
                    OnClick="btnUpdate_Click" />

            </div>

            <!-- Delete Record -->

            <div class="medical-card delete-card">

                <div class="medical-icon">
                    🩹
                </div>

                <h3>
                    Delete Medical Record
                </h3>

                <p>
                    Remove an outdated or incorrect medical record
                    from the animal's history.
                </p>

                <asp:Button
                    ID="btnDelete"
                    runat="server"
                    Text="Delete Record"
                    CssClass="medical-button delete-button"
                    OnClick="btnDelete_Click" />

            </div>

            <!-- Display Records -->

            <div class="medical-card">

                <div class="medical-icon">
                    📋
                </div>

                <h3>
                    View Medical Records
                </h3>

                <p>
                    Browse the medical records and health history
                    of animals within the aquarium.
                </p>

                <asp:Button
                    ID="btnDisplay"
                    runat="server"
                    Text="Display Records"
                    CssClass="medical-button"
                    OnClick="btnDisplay_Click" />

            </div>

            <!-- Return -->

            <div class="medical-card return-card">

                <div class="medical-icon">
                    🐋
                </div>

                <h3>
                    Return to Animal Management
                </h3>

                <p>
                    Return to the previous AquaCore animal management menu.
                </p>

                <asp:Button
                    ID="btnReturn"
                    runat="server"
                    Text="Go Back"
                    CssClass="medical-button"
                    OnClick="btnBack_Click" />

            </div>

        </div>

    </div>

    <div class="footer-note">
        AquaCore • Animal Health &amp; Medical Records
    </div>

</div>

</form> </body> </html>