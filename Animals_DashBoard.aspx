<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Animals_DashBoard.aspx.cs" Inherits="AQUACORE_CMPG223.Animals_Intro" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<title>AquaCore - Animal Management</title>

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
        --danger: #ff5c6c;
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

        position: relative;

        overflow-x: hidden;
    }

    /* Subtle underwater glow */

    body::before {

        content: "";

        position: fixed;

        width: 500px;

        height: 500px;

        border-radius: 50%;

        background: rgba(0, 210, 255, 0.04);

        filter: blur(80px);

        top: 10%;

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

    .dashboard-container {

        width: 100%;

        max-width: 1000px;

        display: flex;

        flex-direction: column;

        gap: 24px;

        position: relative;

        z-index: 1;
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

    .header-title {

        display: flex;

        align-items: center;

        gap: 16px;
    }

    .header-icon {

        width: 55px;

        height: 55px;

        border-radius: 14px;

        display: flex;

        align-items: center;

        justify-content: center;

        font-size: 1.8rem;

        background: rgba(0, 210, 255, 0.10);

        border: 1px solid rgba(0, 210, 255, 0.25);

        box-shadow:
            0 0 20px rgba(0, 210, 255, 0.08);
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

        transform: translateY(-1px);
    }

    /* Page Heading */

    .page-heading {

        margin-bottom: 25px;
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

    /* Aquarium Status */

    .aquarium-note {

        display: flex;

        align-items: center;

        gap: 12px;

        margin-bottom: 25px;

        padding: 12px 16px;

        border-radius: 10px;

        background: rgba(0, 210, 255, 0.05);

        border: 1px solid rgba(0, 210, 255, 0.12);

        color: var(--text-muted);

        font-size: 0.85rem;
    }

    .aquarium-note span {

        color: var(--aqua-soft);

        font-size: 1.1rem;
    }

    /* Animal Grid */

    .animal-grid {

        display: grid;

        grid-template-columns: repeat(2, 1fr);

        gap: 20px;
    }

    /* Animal Cards */

    .animal-card {

        background: rgba(5, 19, 41, 0.55);

        border: 1px solid rgba(0, 210, 255, 0.18);

        border-radius: 12px;

        padding: 25px;

        text-align: center;

        transition: all 0.25s ease;

        position: relative;

        overflow: hidden;
    }

    .animal-card::before {

        content: "";

        position: absolute;

        width: 100px;

        height: 100px;

        border-radius: 50%;

        background: rgba(0, 210, 255, 0.04);

        top: -50px;

        right: -50px;
    }

    .animal-card:hover {

        transform: translateY(-4px);

        border-color: rgba(0, 210, 255, 0.55);

        background: rgba(0, 210, 255, 0.08);

        box-shadow:
            0 8px 25px rgba(0, 210, 255, 0.12);
    }

    /* Icons */

    .animal-icon {

        font-size: 2.2rem;

        margin-bottom: 10px;

        filter:
            drop-shadow(
                0 0 8px rgba(0, 210, 255, 0.15)
            );
    }

    /* Card Titles */

    .animal-card h3 {

        color: #ffffff;

        font-size: 1.15rem;

        margin-bottom: 8px;
    }

    /* Card Description */

    .animal-card p {

        color: var(--text-muted);

        font-size: 0.88rem;

        line-height: 1.5;

        margin-bottom: 18px;
    }

    /* Card Buttons */

    .animal-button {

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

    .animal-button:hover {

        opacity: 0.9;

        transform: translateY(-1px);

        box-shadow:
            0 5px 15px rgba(0, 210, 255, 0.2);
    }

    /* Delete Card */

    .delete-card {

        background: rgba(255, 92, 108, 0.05);

        border: 1px solid rgba(255, 92, 108, 0.2);
    }

    .delete-card:hover {

        border-color: rgba(255, 92, 108, 0.45);

        background: rgba(255, 92, 108, 0.08);

        box-shadow:
            0 8px 25px rgba(255, 92, 108, 0.10);
    }

    /* Delete Button */

    .delete-button {

        background: linear-gradient(
            135deg,
            var(--danger),
            var(--danger-dark)
        );
    }

    .delete-button:hover {

        box-shadow:
            0 5px 15px rgba(255, 92, 108, 0.25);
    }

    /* Bottom Navigation */

    .bottom-row {

        display: flex;

        justify-content: flex-end;

        margin-top: 25px;
    }

    /* Mobile */

    @media (max-width: 700px) {

        body {

            padding: 20px 10px;
        }

        .glass-panel {

            padding: 22px;
        }

        .header-title h1 {

            font-size: 1.6rem;
        }

        .header-panel {

            align-items: flex-start;
        }

        .animal-grid {

            grid-template-columns: 1fr;
        }

        .animal-button {

            width: 100%;
        }

        .bottom-row {

            justify-content: stretch;
        }

        .bottom-row input {

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
                🐠
            </div>

            <div>

                <h1>AquaCore Operations</h1>

                <p>
                    Animal Management
                </p>

            </div>

        </div>

        <div>

            <asp:Button
                ID="btnTopBack"
                runat="server"
                Text="← Go Back"
                CssClass="btn btn-outline"
                OnClick="btnPrevMenu_Click" />

        </div>

    </div>


    <!-- Animal Management -->

    <div class="glass-panel">

        <div class="page-heading">

            <h2>🐟 Animal Management</h2>

            <p>
                Manage the animals living within the AquaCore aquarium system.
                Keep their records organised, up to date, and easy to access.
            </p>

        </div>


        <!-- Aquarium Note -->

        <div class="aquarium-note">

            <span>🌊</span>

            <div>
                Aquarium records help staff keep track of every animal
                under AquaCore's care.
            </div>

        </div>


        <!-- Animal Cards -->

        <div class="animal-grid">


            <!-- Add Animal -->

            <div class="animal-card">

                <div class="animal-icon">
                    🐠
                </div>

                <h3>
                    Add New Animal
                </h3>

                <p>
                    Welcome a new animal into the aquarium system
                    and create its record.
                </p>

                <asp:Button
                    ID="btnAdd"
                    runat="server"
                    Text="Add Animal"
                    CssClass="animal-button"
                    OnClick="btnAdd_Click" />

            </div>


            <!-- Update Animal -->

            <div class="animal-card">

                <div class="animal-icon">
                    🐬
                </div>

                <h3>
                    Change Animal Details
                </h3>

                <p>
                    Update information about an animal already
                    registered in the aquarium.
                </p>

                <asp:Button
                    ID="btnUpdate"
                    runat="server"
                    Text="Update Animal"
                    CssClass="animal-button"
                    OnClick="Button2_Click" />

            </div>


            <!-- Delete Animal -->

            <div class="animal-card delete-card">

                <div class="animal-icon">
                    🦈
                </div>

                <h3>
                    Delete Animal
                </h3>

                <p>
                    Remove an animal record that is no longer
                    required in the system.
                </p>

                <asp:Button
                    ID="btnDelete"
                    runat="server"
                    Text="Remove Animal"
                    CssClass="animal-button delete-button"
                    OnClick="btnDelete_Click" />

            </div>


            <!-- Display Animals -->

            <div class="animal-card">

                <div class="animal-icon">
                    🐢
                </div>

                <h3>
                    Display Animals
                </h3>

                <p>
                    Browse the animals currently registered
                    and view their aquarium records.
                </p>

                <asp:Button
                    ID="btnDisplay"
                    runat="server"
                    Text="Show Animals"
                    CssClass="animal-button"
                    OnClick="btnDisplay_Click" />

            </div>


        </div>


        <!-- Bottom Back -->

        <div class="bottom-row">

            <asp:Button
                ID="btnPrevMenu"
                runat="server"
                Text="← Back"
                CssClass="btn btn-outline"
                OnClick="btnPrevMenu_Click" />

        </div>

    </div>

</div>

</form> </body> </html>