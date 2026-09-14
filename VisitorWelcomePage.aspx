<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorWelcomePage.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorWelcomePage" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<title>AquaCore Aquarium</title>

<link rel="website icon" type="png" href="BRZLogo.png" />

<style>

    :root {
        --green-dark: #14532d;
        --green: #15803d;
        --teal: #0f766e;
        --teal-light: #14b8a6;

        --aqua-light: #dffcf7;
        --aqua-mid: #c9f8ed;

        --text-dark: #16352f;
        --text-muted: #5f7771;

        --orange: #f97316;
        --blue: #2563eb;
        --gray: #6b7280;

        --white: #ffffff;

        --shadow: 0 10px 30px rgba(15, 118, 110, 0.14);
        --shadow-hover: 0 16px 35px rgba(15, 118, 110, 0.22);
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
                circle at 90% 90%,
                rgba(20, 184, 166, 0.16),
                transparent 30%
            ),

            linear-gradient(
                135deg,
                #dffff8 0%,
                #c9f8ed 50%,
                #b8eee4 100%
            );

        padding: 35px 20px;
    }


    /* =========================
       MAIN CONTAINER
    ========================= */

    .main-container {

        width: 100%;

        max-width: 1250px;

        margin: 0 auto;
    }


    /* =========================
       HEADER
    ========================= */

    .hero {

        text-align: center;

        background: rgba(255, 255, 255, 0.78);

        border: 1px solid rgba(255, 255, 255, 0.85);

        border-radius: 24px;

        padding: 30px 25px;

        box-shadow: var(--shadow);

        backdrop-filter: blur(10px);

        margin-bottom: 25px;
    }


    .hero-icon {

        width: 65px;

        height: 65px;

        margin: 0 auto 15px;

        display: flex;

        align-items: center;

        justify-content: center;

        border-radius: 18px;

        background:
            linear-gradient(
                135deg,
                var(--teal),
                var(--green)
            );

        color: white;

        font-size: 2rem;

        box-shadow:
            0 8px 20px rgba(15, 118, 110, 0.20);
    }


    h1 {

        color: var(--green-dark);

        font-size: 38px;

        font-weight: 750;

        letter-spacing: -0.5px;

        margin-bottom: 8px;
    }


    .subtext {

        color: var(--teal);

        font-size: 17px;

        font-style: italic;

        margin: 0;
    }


    .intro-text {

        max-width: 650px;

        margin: 12px auto 0;

        color: var(--text-muted);

        font-size: 14px;

        line-height: 1.6;
    }


    /* =========================
       GALLERY
    ========================= */

    .gallery-section {

        background: rgba(255, 255, 255, 0.62);

        border: 1px solid rgba(255, 255, 255, 0.75);

        border-radius: 22px;

        padding: 25px;

        box-shadow: var(--shadow);

        margin-bottom: 25px;
    }


    .gallery-title {

        text-align: center;

        margin-bottom: 20px;
    }


    .gallery-title h2 {

        color: var(--green-dark);

        font-size: 22px;

        margin-bottom: 5px;
    }


    .gallery-title p {

        color: var(--text-muted);

        font-size: 13px;
    }


    /* =========================
       IMAGE GALLERY
    ========================= */

    .image-gallery {

        display: grid;

        grid-template-columns: repeat(3, 1fr);

        gap: 20px;

        align-items: stretch;
    }


    /* =========================
       IMAGE CARD
    ========================= */

    .image-card {

        background: white;

        padding: 8px;

        border-radius: 17px;

        box-shadow:
            0 7px 20px rgba(15, 118, 110, 0.10);

        transition:
            transform 0.3s ease,
            box-shadow 0.3s ease;

        overflow: hidden;
    }


    .image-card:hover {

        transform: translateY(-5px);

        box-shadow: var(--shadow-hover);
    }


    /* =========================
       IMAGE
    ========================= */

    .image-card img {

        display: block;

        width: 100%;

        height: 390px;

        object-fit: contain;

        object-position: center;

        border-radius: 12px;

        background: #f1fffb;
    }


    /* =========================
       IMAGE CAPTION
    ========================= */

    .image-caption {

        text-align: center;

        padding: 12px 5px 7px;

        color: var(--green-dark);

        font-size: 14px;

        font-weight: 650;
    }


    /* =========================
       BUTTON SECTION
    ========================= */

    .button-section {

        background: rgba(255, 255, 255, 0.72);

        border: 1px solid rgba(255, 255, 255, 0.8);

        border-radius: 20px;

        padding: 23px;

        box-shadow: var(--shadow);

        text-align: center;
    }


    .button-title {

        color: var(--green-dark);

        font-size: 17px;

        font-weight: 600;

        margin-bottom: 15px;
    }


    .button-container {

        display: flex;

        justify-content: center;

        align-items: center;

        gap: 14px;

        flex-wrap: wrap;
    }


    /* =========================
       BUTTONS
    ========================= */

    .btn {

        min-width: 140px;

        padding: 12px 25px;

        border: none;

        border-radius: 10px;

        cursor: pointer;

        font-size: 15px;

        font-weight: 650;

        color: white;

        transition:
            transform 0.25s ease,
            box-shadow 0.25s ease,
            background-color 0.25s ease;
    }


    .btn:hover {

        transform: translateY(-2px);

        box-shadow:
            0 7px 16px rgba(0, 0, 0, 0.15);
    }


    .login-btn {

        background:
            linear-gradient(
                135deg,
                #f97316,
                #ea580c
            );
    }


    .login-btn:hover {

        background:
            linear-gradient(
                135deg,
                #ea580c,
                #c2410c
            );
    }


    .signup-btn {

        background:
            linear-gradient(
                135deg,
                var(--teal),
                var(--green)
            );
    }


    .signup-btn:hover {

        background:
            linear-gradient(
                135deg,
                #0f766e,
                #166534
            );
    }


    .back-btn {

        background:
            linear-gradient(
                135deg,
                #6b7280,
                #4b5563
            );
    }


    .back-btn:hover {

        background:
            linear-gradient(
                135deg,
                #4b5563,
                #374151
            );
    }


    /* =========================
       FOOTER
    ========================= */

    .footer {

        text-align: center;

        color: var(--text-muted);

        font-size: 12px;

        margin-top: 20px;

        padding: 10px;
    }


    /* =========================
       TABLET
    ========================= */

    @media (max-width: 900px) {

        .image-gallery {

            grid-template-columns: repeat(2, 1fr);
        }


        .image-card:last-child {

            grid-column: 1 / -1;

            max-width: 50%;

            width: 100%;

            margin: 0 auto;
        }

    }


    /* =========================
       MOBILE
    ========================= */

    @media (max-width: 600px) {

        body {

            padding: 20px 12px;
        }


        .hero {

            padding: 25px 18px;

            border-radius: 18px;
        }


        h1 {

            font-size: 29px;
        }


        .subtext {

            font-size: 16px;
        }


        .gallery-section {

            padding: 17px;

            border-radius: 18px;
        }


        .image-gallery {

            grid-template-columns: 1fr;

            gap: 15px;
        }


        .image-card:last-child {

            grid-column: auto;

            max-width: none;
        }


        .image-card img {

            height: 350px;
        }


        .button-section {

            padding: 20px 15px;
        }


        .button-container {

            flex-direction: column;

            width: 100%;
        }


        .btn {

            width: 100%;

            max-width: 300px;
        }

    }

</style>

</head> <body>
<form id="form1" runat="server">

    <div class="main-container">


        <!-- =========================
             HEADER
        ========================= -->

        <div class="hero">

            <div class="hero-icon">
                🐠
            </div>


            <h1>
                WELCOME TO AQUACORE
            </h1>


            <p class="subtext">
                Water awaits!
            </p>


            <p class="intro-text">

                Discover an unforgettable underwater experience
                and explore the fascinating creatures that call
                AquaCore home.

            </p>

        </div>


        <!-- =========================
             GALLERY
        ========================= -->

        <div class="gallery-section">

            <div class="gallery-title">

                <h2>
                    Discover Our Underwater World
                </h2>

                <p>
                    Meet some of the amazing animals waiting for you at AquaCore.
                </p>

            </div>


            <div class="image-gallery">


                <!-- OTTER -->

                <div class="image-card">

                    <img
                        src="AQUACORE_IMAGES/Otter.jpg"
                        alt="Otter" />

                    <div class="image-caption">
                        🦦 Otter
                    </div>

                </div>


                <!-- PENGUIN -->

                <div class="image-card">

                    <img
                        src="AQUACORE_IMAGES/Penguin.jpg"
                        alt="Penguin" />

                    <div class="image-caption">
                        🐧 Penguin
                    </div>

                </div>


                <!-- JELLYFISH -->

                <div class="image-card">

                    <img
                        src="AQUACORE_IMAGES/20 Trendy Jellyfish.jpg"
                        alt="Jellyfish" />

                    <div class="image-caption">
                        🪼 Jellyfish
                    </div>

                </div>


            </div>

        </div>


        <!-- =========================
             BUTTONS
        ========================= -->

        <div class="button-section">

            <div class="button-title">
                Ready to explore?
            </div>


            <div class="button-container">


                <asp:Button
                    ID="Button1"
                    runat="server"
                    CssClass="btn login-btn"
                    Text="Login"
                    OnClick="Button1_Click" />


                <asp:Button
                    ID="Button2"
                    runat="server"
                    CssClass="btn signup-btn"
                    Text="Sign Up"
                    OnClick="Button2_Click" />


                <asp:Button
                    ID="Button3"
                    runat="server"
                    CssClass="btn back-btn"
                    Text="Back"
                    OnClick="Button3_Click" />


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