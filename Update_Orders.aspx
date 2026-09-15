<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Update_Orders.aspx.cs" Inherits="AQUACORE_CMPG223.Update_Orders" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<meta charset="utf-8" />

<meta name="viewport"
      content="width=device-width, initial-scale=1.0" />

<title>AquaCore - Update Restaurant Order</title>

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

        --warning: #ffd166;
        --warning-dark: #f77f00;

        --danger: #ff6b7a;

        --font-family:
            'Segoe UI',
            -apple-system,
            BlinkMacSystemFont,
            sans-serif;
    }


    * {
        box-sizing: border-box;

        margin: 0;

        padding: 0;

        font-family: var(--font-family);
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

        align-items: center;

        justify-content: center;

        padding: 40px 20px;

        position: relative;

        overflow-x: hidden;
    }


    /* =========================================================
       BACKGROUND GLOW
       ========================================================= */

    body::before {

        content: "";

        position: fixed;

        width: 500px;

        height: 500px;

        border-radius: 50%;

        background:
            rgba(0, 191, 166, 0.06);

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

        background:
            rgba(25, 230, 204, 0.04);

        filter: blur(80px);

        bottom: -150px;

        right: -100px;

        pointer-events: none;
    }


    /* =========================================================
       CONTAINER
       ========================================================= */

    .portal-wrapper {

        width: 100%;

        max-width: 700px;

        position: relative;

        z-index: 1;
    }


    /* =========================================================
       GLASS CARD
       ========================================================= */

    .glass-card {

        background:
            var(--card-glass);

        border:
            1px solid
            var(--card-border);

        border-radius: 16px;

        padding: 36px;

        box-shadow:
            0 10px 30px
            rgba(0, 0, 0, 0.35);

        backdrop-filter:
            blur(8px);

        -webkit-backdrop-filter:
            blur(8px);
    }


    /* =========================================================
       HEADER
       ========================================================= */

    .card-header {

        text-align: center;

        margin-bottom: 30px;
    }


    .header-icon {

        width: 62px;

        height: 62px;

        margin:
            0 auto 16px;

        display: flex;

        align-items: center;

        justify-content: center;

        border-radius: 15px;

        background:
            rgba(0, 191, 166, 0.09);

        border:
            1px solid
            rgba(0, 191, 166, 0.25);

        font-size: 1.9rem;

        box-shadow:
            0 0 20px
            rgba(0, 191, 166, 0.08);
    }


    .card-header h1 {

        font-size: 2rem;

        color: #ffffff;

        margin-bottom: 7px;
    }


    .card-header p {

        color:
            var(--text-muted);

        font-size: 0.9rem;

        line-height: 1.5;
    }


    .update-badge {

        display: inline-block;

        margin-top: 12px;

        padding: 6px 12px;

        border-radius: 20px;

        background:
            rgba(0, 191, 166, 0.08);

        border:
            1px solid
            rgba(0, 191, 166, 0.22);

        color:
            var(--teal-soft);

        font-size: 0.78rem;

        font-weight: 600;
    }


    /* =========================================================
       INFO NOTE
       ========================================================= */

    .info-note {

        display: flex;

        align-items: flex-start;

        gap: 12px;

        padding: 14px 16px;

        margin-bottom: 25px;

        border-radius: 10px;

        background:
            rgba(0, 191, 166, 0.05);

        border:
            1px solid
            rgba(0, 191, 166, 0.13);

        color:
            var(--text-muted);

        font-size: 0.84rem;

        line-height: 1.5;
    }


    .info-icon {

        font-size: 1.2rem;

        color:
            var(--teal-soft);

        flex-shrink: 0;
    }


    /* =========================================================
       FORM
       ========================================================= */

    .form-row {

        display: grid;

        grid-template-columns:
            1fr 1fr;

        gap: 16px;
    }


    .form-field {

        display: flex;

        flex-direction: column;

        margin-bottom: 18px;
    }


    .form-label {

        color:
            #cce8e5;

        font-size: 0.8rem;

        font-weight: 600;

        margin-bottom: 7px;
    }


    .input-box {

        width: 100%;

        padding: 12px 14px;

        background:
            rgba(4, 28, 32, 0.65);

        border:
            1px solid
            rgba(0, 191, 166, 0.18);

        border-radius: 10px;

        color:
            #ffffff;

        font-size: 0.9rem;

        outline: none;

        transition:
            all 0.2s ease;
    }


    .input-box:focus {

        border-color:
            var(--teal-glow);

        box-shadow:
            0 0 0 3px
            rgba(0, 191, 166, 0.12);
    }


    select.input-box option {

        background:
            #063b40;

        color:
            #ffffff;
    }


    /* =========================================================
       DIVIDER
       ========================================================= */

    .divider {

        height: 1px;

        background:
            rgba(0, 191, 166, 0.18);

        margin:
            25px 0;
    }


    /* =========================================================
       FOOD SECTION
       ========================================================= */

    .food-box {

        padding: 18px;

        margin-bottom: 18px;

        border-radius: 12px;

        background:
            rgba(4, 28, 32, 0.45);

        border:
            1px solid
            rgba(0, 191, 166, 0.15);
    }


    .food-title {

        color:
            #ffffff;

        font-size: 0.9rem;

        font-weight: 600;

        margin-bottom: 12px;
    }


    .food-options table {

        width: 100%;
    }


    .food-options td {

        padding:
            7px 4px;
    }


    .food-options input {

        accent-color:
            var(--teal-glow);

        margin-right: 7px;
    }


    .food-options label {

        color:
            #d9f7f4;

        font-size:
            0.85rem;

        cursor:
            pointer;
    }


    /* =========================================================
       TOTAL
       ========================================================= */

    .total-box {

        display: flex;

        justify-content:
            space-between;

        align-items:
            center;

        padding:
            15px 18px;

        margin-bottom:
            20px;

        border-radius:
            12px;

        background:
            rgba(0, 191, 166, 0.08);

        border:
            1px solid
            rgba(0, 191, 166, 0.22);
    }


    .total-label {

        color:
            var(--text-muted);

        font-size:
            0.9rem;

        font-weight:
            600;
    }


    .total-price {

        color:
            var(--teal-glow);

        font-size:
            1.3rem;

        font-weight:
            700;
    }


    /* =========================================================
       BUTTONS
       ========================================================= */

    .actions-wrapper {

        display: flex;

        flex-direction: column;

        gap: 10px;

        margin-top: 8px;
    }


    .btn-update {

        width: 100%;

        padding:
            13px;

        border:
            none;

        border-radius:
            9px;

        background:
            linear-gradient(
                135deg,
                var(--teal-glow),
                var(--teal-dark)
            );

        color:
            #ffffff;

        font-size:
            0.9rem;

        font-weight:
            700;

        cursor:
            pointer;

        transition:
            all 0.2s ease;
    }


    .btn-update:hover {

        transform:
            translateY(-1px);

        box-shadow:
            0 5px 15px
            rgba(0, 191, 166, 0.22);
    }


    .btn-secondary {

        display:
            block;

        width:
            100%;

        padding:
            11px;

        border-radius:
            9px;

        background:
            rgba(255, 255, 255, 0.06);

        border:
            1px solid
            rgba(255, 255, 255, 0.15);

        color:
            var(--text-primary);

        font-size:
            0.88rem;

        font-weight:
            600;

        text-align:
            center;

        text-decoration:
            none;

        transition:
            all 0.2s ease;
    }


    .btn-secondary:hover {

        background:
            rgba(255, 255, 255, 0.13);

        color:
            #ffffff;

        transform:
            translateY(-1px);
    }


    /* =========================================================
       STATUS
       ========================================================= */

    .status-alert {

        display:
            block;

        margin-top:
            18px;

        text-align:
            center;

        font-size:
            0.85rem;

        font-weight:
            600;

        line-height:
            1.5;
    }


    /* =========================================================
       FOOTER
       ========================================================= */

    .footer-note {

        text-align:
            center;

        color:
            var(--text-muted);

        font-size:
            0.75rem;

        margin-top:
            14px;

        opacity:
            0.8;
    }


    /* =========================================================
       MOBILE
       ========================================================= */

    @media (max-width: 650px) {

        body {

            padding:
                20px 12px;
        }


        .glass-card {

            padding:
                26px 20px;
        }


        .form-row {

            grid-template-columns:
                1fr;
        }


        .card-header h1 {

            font-size:
                1.55rem;
        }
    }

</style>

</head> <body>
<form id="form1" runat="server">

    <div class="portal-wrapper">

        <div class="glass-card">

            <!-- HEADER -->

            <div class="card-header">

                <div class="header-icon">
                    ✏️
                </div>

                <h1>
                    Update Restaurant Order
                </h1>

                <p>
                    Select an existing restaurant order
                    to load and update its information.
                </p>

                <div class="update-badge">
                    ✏️ Order Information Update
                </div>

            </div>


            <!-- INFORMATION -->

            <div class="info-note">

                <div class="info-icon">
                    💡
                </div>

                <div>
                    Select an order below. Its existing
                    information will automatically load
                    into the edit form.
                </div>

            </div>


            <!-- SELECT ORDER -->

            <div class="form-field">

                <asp:Label
                    ID="lblSelectOrder"
                    runat="server"
                    Text="Select Order"
                    CssClass="form-label">
                </asp:Label>

                <asp:DropDownList
                    ID="ddlSelectOrder"
                    runat="server"
                    CssClass="input-box"
                    AutoPostBack="True"
                    OnSelectedIndexChanged="ddlSelectOrder_SelectedIndexChanged">
                </asp:DropDownList>

            </div>


            <!-- RETURN TO DASHBOARD -->

            <a
                href="RestaurantOrders_Dashboard.aspx"
                class="btn-secondary">

                ← Return to Restaurant Orders

            </a>


            <!-- STATUS -->

            <asp:Label
                ID="lblStatus"
                runat="server"
                CssClass="status-alert">
            </asp:Label>


            <!-- EDIT FORM -->

            <asp:Panel
                ID="pnlEditForm"
                runat="server"
                Visible="False">

                <div class="divider"></div>


                <!-- CUSTOMER + TABLE -->

                <div class="form-row">

                    <div class="form-field">

                        <asp:Label
                            ID="lblCustomerName"
                            runat="server"
                            Text="Customer Name"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtCustomerName"
                            runat="server"
                            CssClass="input-box">
                        </asp:TextBox>

                    </div>


                    <div class="form-field">

                        <asp:Label
                            ID="lblTable"
                            runat="server"
                            Text="Table Number"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtTable"
                            runat="server"
                            CssClass="input-box">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- QUANTITY + DATE -->

                <div class="form-row">

                    <div class="form-field">

                        <asp:Label
                            ID="lblQuantity"
                            runat="server"
                            Text="Quantity"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtQuantity"
                            runat="server"
                            CssClass="input-box"
                            TextMode="Number">
                        </asp:TextBox>

                    </div>


                    <div class="form-field">

                        <asp:Label
                            ID="lblDate"
                            runat="server"
                            Text="Order Date"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:TextBox
                            ID="txtDate"
                            runat="server"
                            CssClass="input-box"
                            TextMode="Date">
                        </asp:TextBox>

                    </div>

                </div>


                <!-- FOOD -->

                <div class="food-box">

                    <div class="food-title">
                        🍴 Select Food Items
                    </div>

                    <div class="food-options">

                        <asp:CheckBoxList
                            ID="cblFooditems"
                            runat="server">

                            <asp:ListItem
                                Text="🍔 Burger — R55"
                                Value="Burger" />

                            <asp:ListItem
                                Text="🍕 Pizza — R85"
                                Value="Pizza" />

                            <asp:ListItem
                                Text="🍝 Pasta — R65"
                                Value="Pasta" />

                            <asp:ListItem
                                Text="🥤 Drink — R25"
                                Value="Drink" />

                        </asp:CheckBoxList>

                    </div>

                </div>


                <!-- STATUS + TOTAL -->

                <div class="form-row">

                    <div class="form-field">

                        <asp:Label
                            ID="lblOrderStatus"
                            runat="server"
                            Text="Order Status"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:DropDownList
                            ID="ddlStatus"
                            runat="server"
                            CssClass="input-box">

                            <asp:ListItem
                                Text="-- Select Status --"
                                Value="" />

                            <asp:ListItem
                                Text="Pending"
                                Value="Pending" />

                            <asp:ListItem
                                Text="Completed"
                                Value="Completed" />

                        </asp:DropDownList>

                    </div>


                    <div class="form-field">

                        <asp:Label
                            ID="lblTotalLabel"
                            runat="server"
                            Text="Total Price"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:Label
                            ID="lblPrize"
                            runat="server"
                            Text="R0.00"
                            CssClass="input-box total-price">
                        </asp:Label>

                    </div>

                </div>


                <!-- BUTTON -->

                <div class="actions-wrapper">

                    <asp:Button
                        ID="btnUpdate"
                        runat="server"
                        Text="✓ Save Changes"
                        CssClass="btn-update"
                        OnClick="btnUpdate_Click" />

                </div>

            </asp:Panel>

        </div>


        <div class="footer-note">

            AquaCore • Restaurant Orders Management

        </div>

    </div>

</form>

</body> </html>