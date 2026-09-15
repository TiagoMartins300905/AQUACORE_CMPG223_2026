<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorDashboard.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorDashboard" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<title>AquaCore - Visitor Dashboard</title>

<style>

    :root {
        --green-dark: #14532d;
        --green: #15803d;
        --green-light: #22c55e;
        --teal: #0f766e;
        --teal-light: #14b8a6;

        --aqua-bg: #dffcf7;
        --aqua-soft: #ecfffc;

        --white: #ffffff;
        --text-dark: #16352f;
        --text-muted: #5f7771;

        --danger: #dc2626;

        --shadow: 0 10px 30px rgba(15, 118, 110, 0.12);
        --shadow-hover: 0 16px 35px rgba(15, 118, 110, 0.20);
    }


    /* =========================
       GLOBAL
    ========================= */

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;

        font-family: 'Segoe UI', Arial, sans-serif;
    }


    body {

        min-height: 100vh;

        color: var(--text-dark);

        background:
            radial-gradient(
                circle at 10% 10%,
                rgba(34, 197, 94, 0.16),
                transparent 30%
            ),

            radial-gradient(
                circle at 90% 85%,
                rgba(20, 184, 166, 0.16),
                transparent 30%
            ),

            linear-gradient(
                135deg,
                #dffff8 0%,
                #c9f8ed 45%,
                #b8eee4 100%
            );

        padding: 35px 20px;
    }


    /* =========================
       MAIN CONTAINER
    ========================= */

    .main-container {

        width: 100%;

        max-width: 1200px;

        margin: 0 auto;
    }


    /* =========================
       HEADER
    ========================= */

    .header {

        display: flex;

        justify-content: space-between;

        align-items: center;

        padding: 25px 30px;

        background: rgba(255, 255, 255, 0.80);

        border: 1px solid rgba(255, 255, 255, 0.85);

        border-radius: 20px;

        box-shadow: var(--shadow);

        backdrop-filter: blur(10px);

        margin-bottom: 25px;
    }


    .header-content {

        display: flex;

        align-items: center;

        gap: 16px;
    }


    /* =========================
       HEADER ICON
    ========================= */

    .header-icon {

        width: 55px;

        height: 55px;

        display: flex;

        align-items: center;

        justify-content: center;

        border-radius: 15px;

        background:
            linear-gradient(
                135deg,
                var(--teal),
                var(--green)
            );

        color: white;

        font-size: 1.7rem;

        box-shadow:
            0 8px 20px rgba(15, 118, 110, 0.20);
    }


    .header h2 {

        font-size: 27px;

        font-weight: 700;

        color: var(--green-dark);

        margin: 0;
    }


    .header h2 span {

        color: var(--teal);
    }


    .welcome-text {

        font-size: 14px;

        color: var(--text-muted);

        margin-top: 4px;
    }


    /* =========================
       LOGOUT BUTTON
    ========================= */

    .logout-btn {

        color: var(--danger);

        background: rgba(220, 38, 38, 0.05);

        text-decoration: none;

        font-weight: 600;

        cursor: pointer;

        padding: 9px 20px;

        border: 1px solid rgba(220, 38, 38, 0.25);

        border-radius: 9px;

        transition: all 0.25s ease;
    }


    .logout-btn:hover {

        background: var(--danger);

        color: white;

        transform: translateY(-1px);

        box-shadow:
            0 6px 15px rgba(220, 38, 38, 0.18);
    }


    /* =========================
       WELCOME PANEL
    ========================= */

    .welcome-panel {

        text-align: center;

        background: rgba(255, 255, 255, 0.70);

        border: 1px solid rgba(255, 255, 255, 0.80);

        border-radius: 18px;

        padding: 25px;

        margin-bottom: 22px;

        box-shadow: var(--shadow);
    }


    .welcome-panel h1 {

        color: var(--green-dark);

        font-size: 25px;

        margin-bottom: 7px;
    }


    .welcome-panel p {

        color: var(--text-muted);

        font-size: 14px;
    }


    /* =========================
       MENU
    ========================= */

    .menu {

        display: grid;

        grid-template-columns: repeat(2, 1fr);

        gap: 18px;

        margin-bottom: 30px;
    }


    .menu a {

        position: relative;

        display: flex;

        align-items: center;

        justify-content: center;

        min-height: 62px;

        padding: 15px 25px;

        background:
            linear-gradient(
                135deg,
                var(--teal),
                var(--green)
            );

        color: white;

        text-decoration: none;

        border-radius: 12px;

        font-weight: 600;

        font-size: 16px;

        box-shadow:
            0 7px 18px rgba(15, 118, 110, 0.18);

        transition:
            transform 0.25s ease,
            box-shadow 0.25s ease,
            opacity 0.25s ease;
    }


    .menu a:nth-child(1)::before {

        content: "🎟️";

        margin-right: 10px;
    }


    .menu a:nth-child(2)::before {

        content: "📋";

        margin-right: 10px;
    }


    .menu a:nth-child(3)::before {

        content: "🍽️";

        margin-right: 10px;
    }


    .menu a:nth-child(4)::before {

        content: "📖";

        margin-right: 10px;
    }


    .menu a:hover {

        transform: translateY(-3px);

        box-shadow: var(--shadow-hover);

        opacity: 0.95;
    }


    /* =========================
       GALLERY HEADING
    ========================= */

    .gallery-heading {

        text-align: center;

        margin: 30px 0 18px;
    }


    .gallery-heading h2 {

        color: var(--green-dark);

        font-size: 21px;

        margin-bottom: 5px;
    }


    .gallery-heading p {

        color: var(--text-muted);

        font-size: 13px;
    }


    /* =========================
       IMAGE GALLERY
       
       2 COLUMNS
       
       Row 1:
       Otter | Penguin
       
       Row 2:
          Jellyfish
    ========================= */

    .image-gallery {

        display: grid;

        grid-template-columns: repeat(2, 1fr);

        gap: 20px;

        width: 100%;
    }


    /* =========================
       IMAGE CARD
    ========================= */

    .image-card {

        position: relative;

        overflow: hidden;

        border-radius: 16px;

        background: white;

        padding: 8px;

        box-shadow: var(--shadow);

        transition:
            transform 0.3s ease,
            box-shadow 0.3s ease;

        display: flex;

        align-items: center;

        justify-content: center;
    }


    .image-card:hover {

        transform: translateY(-5px);

        box-shadow: var(--shadow-hover);
    }


    /* =========================
       JELLYFISH CENTERING
       
       Third card occupies both
       columns and is centered.
    ========================= */

    .image-card:nth-child(3) {

        grid-column: 1 / -1;

        width: 50%;

        justify-self: center;
    }


    /* =========================
       IMAGE
    ========================= */

    .image-card img {

        display: block;

        width: 100%;

        height: 400px;

        object-fit: contain;

        object-position: center;

        border-radius: 11px;

        background: #f4fffc;
    }


    /* =========================
       IMAGE LABEL
    ========================= */

    .image-label {

        position: absolute;

        left: 18px;

        bottom: 18px;

        padding: 8px 13px;

        background:
            rgba(20, 83, 45, 0.88);

        color: white;

        border-radius: 8px;

        font-size: 13px;

        font-weight: 600;

        backdrop-filter: blur(5px);

        box-shadow:
            0 4px 10px rgba(0, 0, 0, 0.12);
    }


    /* =========================
       FOOTER
    ========================= */

    .footer {

        text-align: center;

        color: var(--text-muted);

        font-size: 12px;

        margin-top: 25px;

        padding: 15px;
    }


    /* =========================
       MOBILE
    ========================= */

    @media (max-width: 650px) {

        body {

            padding: 20px 12px;
        }


        .header {

            padding: 20px;

            flex-direction: column;

            align-items: stretch;

            gap: 18px;
        }


        .header-content {

            align-items: flex-start;
        }


        .header h2 {

            font-size: 21px;
        }


        .logout-btn {

            text-align: center;

            display: block;
        }


        .welcome-panel {

            padding: 20px 15px;
        }


        .welcome-panel h1 {

            font-size: 21px;
        }


        .menu {

            grid-template-columns: 1fr;
        }


        /* One column on mobile */

        .image-gallery {

            grid-template-columns: 1fr;
        }


        /* Jellyfish becomes full width on mobile */

        .image-card:nth-child(3) {

            grid-column: auto;

            width: 100%;

            justify-self: stretch;
        }


        .image-card img {

            height: 400px;

            object-fit: contain;
        }


        .image-label {

            left: 15px;

            bottom: 15px;
        }

    }

</style>

</head> <body>
<form id="form1" runat="server">

    <div class="main-container">


        <!-- =========================
             HEADER
        ========================= -->

        <div class="header">

            <div class="header-content">

                <div class="header-icon">
                    🐠
                </div>


                <div>

                    <h2>

                        Welcome,

                        <span>

                            <asp:Label
                                ID="lblName"
                                runat="server" />

                        </span>

                        !

                    </h2>


                    <div class="welcome-text">

                        Explore, discover and enjoy the underwater world.

                    </div>

                </div>

            </div>


            <asp:LinkButton
                ID="btnLogout"
                runat="server"
                CssClass="logout-btn"
                Text="Logout"
                OnClick="btnLogout_Click" />

        </div>


        <!-- =========================
             WELCOME SECTION
        ========================= -->

        <div class="welcome-panel">

            <h1>

                Welcome to AquaCore

            </h1>


            <p>

                Your gateway to an unforgettable aquarium experience.
                Plan your visit or view your reservations below.

            </p>

        </div>


        <!-- =========================
             VISITOR MENU
        ========================= -->

        <div class="menu">

            <a href="VisitorReservations.aspx">

                Book Tickets

            </a>


            <a href="VisitorMyReservations.aspx">

                My Reservations

            </a>


            <a href="VisitorRestaurantOrder.aspx">

                Restaurant Order

            </a>


            <a href="VisitorMyOrders.aspx">

                My Orders

            </a>

        </div>


        <!-- =========================
             GALLERY HEADING
        ========================= -->

        <div class="gallery-heading">

            <h2>

                Discover AquaCore

            </h2>


            <p>

                Meet some of the amazing animals waiting to be discovered.

            </p>

        </div>


        <!-- =========================
             IMAGE GALLERY
        ========================= -->

        <div class="image-gallery">


            <!-- OTTER -->

            <div class="image-card">

                <asp:Image
                    ID="img1"
                    runat="server"
                    ImageUrl="~/AQUACORE_IMAGES/Otter.jpg" />

                <div class="image-label">

                    🦦 Otter

                </div>

            </div>


            <!-- PENGUIN -->

            <div class="image-card">

                <asp:Image
                    ID="img2"
                    runat="server"
                    ImageUrl="~/AQUACORE_IMAGES/Penguin.jpg" />

                <div class="image-label">

                    🐧 Penguin

                </div>

            </div>


            <!-- JELLYFISH -->

            <div class="image-card">

                <asp:Image
                    ID="img3"
                    runat="server"
                    ImageUrl="~/AQUACORE_IMAGES/20 Trendy Jellyfish.jpg" />

                <div class="image-label">

                    🪼 Jellyfish

                </div>

            </div>


        </div>


        <!-- =========================
             FOOTER
        ========================= -->

        <div class="footer">

            AquaCore • Discover the wonder beneath the surface

        </div>


    </div>

</form>

</body> </html>