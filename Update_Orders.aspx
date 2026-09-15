<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Update_Orders.aspx.cs" Inherits="AQUACORE_CMPG223.Update_Orders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <meta charset="utf-8" />

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0" />

    <title>AquaCore - Update Restaurant Order</title>

    <style>

        :root {
            --bg-base: #030a16;
            --surface: rgba(8, 22, 44, 0.70);
            --border-glow: rgba(0, 210, 255, 0.22);

            --text-main: #f8fafc;
            --text-sub: #94a3b8;

            --accent-cyan: #00f0ff;
            --accent-teal: #00bfa6;

            --accent-warning: #ffd166;
            --accent-orange: #f77f00;

            --danger: #ff6b6b;
            --success: #80ffdb;

            --font-family:
                'Segoe UI',
                Arial,
                Helvetica,
                sans-serif;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: var(--font-family);
        }

        body {
            background-color: var(--bg-base);

            min-height: 100vh;

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 40px 20px;

            position: relative;

            overflow-x: hidden;

            color: var(--text-main);
        }

        /* =========================================================
           BACKGROUND
           ========================================================= */

        .ambient-orb {
            position: fixed;

            border-radius: 50%;

            pointer-events: none;

            filter: blur(100px);

            opacity: 0.35;

            z-index: 0;
        }

        .orb-1 {
            width: 450px;

            height: 450px;

            background:
                radial-gradient(
                    circle,
                    #0284c7,
                    #003e74
                );

            top: -100px;

            left: -120px;
        }

        .orb-2 {
            width: 550px;

            height: 550px;

            background:
                radial-gradient(
                    circle,
                    #0d9488,
                    #002b48
                );

            bottom: -180px;

            right: -130px;
        }

        /* =========================================================
           MAIN CONTAINER
           ========================================================= */

        .portal-wrapper {
            position: relative;

            z-index: 1;

            width: 100%;

            max-width: 750px;
        }

        /* =========================================================
           CARD
           ========================================================= */

        .glass-card {
            background:
                var(--surface);

            backdrop-filter:
                blur(24px)
                saturate(180%);

            -webkit-backdrop-filter:
                blur(24px)
                saturate(180%);

            border:
                1px solid var(--border-glow);

            border-radius: 24px;

            padding: 42px 40px;

            box-shadow:
                0 30px 60px -12px
                rgba(0, 0, 0, 0.65);
        }

        /* =========================================================
           HEADER
           ========================================================= */

        .card-header {
            text-align: center;

            margin-bottom: 30px;
        }

        .header-icon {
            width: 65px;

            height: 65px;

            margin:
                0 auto 16px auto;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 18px;

            background:
                rgba(255, 209, 102, 0.10);

            border:
                1px solid
                rgba(255, 209, 102, 0.25);

            font-size: 1.9rem;
        }

        .card-header h1 {
            font-size: 2rem;

            font-weight: 700;

            background:
                linear-gradient(
                    135deg,
                    #ffffff 40%,
                    #bae6fd 100%
                );

            -webkit-background-clip: text;

            background-clip: text;

            -webkit-text-fill-color: transparent;

            margin-bottom: 8px;
        }

        .card-header p {
            color: var(--text-sub);

            font-size: 0.9rem;

            line-height: 1.5;
        }

        .update-badge {
            display: inline-block;

            margin-top: 12px;

            padding: 6px 12px;

            border-radius: 20px;

            background:
                rgba(255, 209, 102, 0.08);

            border:
                1px solid
                rgba(255, 209, 102, 0.24);

            color: var(--accent-warning);

            font-size: 0.75rem;

            font-weight: 600;
        }

        /* =========================================================
           INFO MESSAGE
           ========================================================= */

        .info-note {
            display: flex;

            align-items: flex-start;

            gap: 12px;

            padding: 15px 16px;

            margin-bottom: 25px;

            border-radius: 12px;

            background:
                rgba(0, 240, 255, 0.04);

            border:
                1px solid
                rgba(0, 240, 255, 0.12);

            color: var(--text-sub);

            font-size: 0.84rem;

            line-height: 1.5;
        }

        .info-icon {
            font-size: 1.2rem;

            color: var(--accent-cyan);

            flex-shrink: 0;
        }

        /* =========================================================
           FORM
           ========================================================= */

        .form-grid {
            display: grid;

            grid-template-columns:
                1fr 1fr;

            gap: 18px;
        }

        .form-group {
            display: flex;

            flex-direction: column;

            gap: 7px;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            color: #cbd5e1;

            font-size: 0.8rem;

            font-weight: 600;
        }

        .form-input {
            width: 100%;

            padding: 12px 14px;

            background:
                rgba(3, 10, 22, 0.60);

            border:
                1px solid
                rgba(148, 163, 184, 0.18);

            border-radius: 12px;

            color: #ffffff;

            font-size: 0.9rem;

            outline: none;

            transition: 0.2s ease;
        }

        .form-input:focus {
            border-color:
                var(--accent-cyan);

            box-shadow:
                0 0 0 3px
                rgba(0, 240, 255, 0.12);
        }

        select.form-input option {
            background-color: #08162c;

            color: #ffffff;
        }

        /* =========================================================
           FOOD SECTION
           ========================================================= */

        .food-section {
            grid-column: 1 / -1;

            padding: 20px;

            margin-top: 5px;

            border-radius: 14px;

            background:
                rgba(3, 10, 22, 0.40);

            border:
                1px solid
                rgba(0, 210, 255, 0.14);
        }

        .food-title {
            color: #ffffff;

            font-size: 0.95rem;

            font-weight: 600;

            margin-bottom: 15px;
        }

        .food-options {
            width: 100%;
        }

        .food-options table {
            width: 100%;
        }

        .food-options td {
            padding: 8px 5px;
        }

        .food-options input {
            accent-color:
                var(--accent-cyan);

            margin-right: 7px;
        }

        .food-options label {
            color: #d9f7f4;

            font-size: 0.87rem;

            cursor: pointer;
        }

        /* =========================================================
           TOTAL
           ========================================================= */

        .total-box {
            grid-column: 1 / -1;

            display: flex;

            justify-content: space-between;

            align-items: center;

            padding: 17px 20px;

            margin-top: 5px;

            border-radius: 13px;

            background:
                linear-gradient(
                    135deg,
                    rgba(0, 191, 166, 0.10),
                    rgba(8, 127, 130, 0.08)
                );

            border:
                1px solid
                rgba(0, 191, 166, 0.22);
        }

        .total-label {
            color: var(--text-sub);

            font-size: 0.9rem;

            font-weight: 600;
        }

        .total-price {
            color:
                var(--accent-cyan);

            font-size: 1.35rem;

            font-weight: 700;
        }

        /* =========================================================
           BUTTONS
           ========================================================= */

        .button-row {
            display: flex;

            justify-content: center;

            gap: 12px;

            margin-top: 28px;

            padding-top: 25px;

            border-top:
                1px solid
                rgba(0, 210, 255, 0.12);
        }

        .action-button {
            min-width: 180px;

            padding: 13px 20px;

            border-radius: 12px;

            border: none;

            font-size: 0.9rem;

            font-weight: 700;

            cursor: pointer;

            transition: 0.2s ease;
        }

        .update-button {
            background:
                linear-gradient(
                    135deg,
                    var(--accent-warning),
                    var(--accent-orange)
                );

            color:
                #030a16;
        }

        .update-button:hover {
            transform:
                translateY(-1px);

            filter:
                brightness(1.08);

            box-shadow:
                0 6px 20px
                rgba(255, 209, 102, 0.18);
        }

        .dashboard-button {
            background:
                transparent;

            border:
                1px solid
                rgba(148, 163, 184, 0.22);

            color:
                var(--text-sub);
        }

        .dashboard-button:hover {
            background:
                rgba(255, 255, 255, 0.05);

            color:
                #ffffff;

            transform:
                translateY(-1px);
        }

        /* =========================================================
           STATUS
           ========================================================= */

        .status-msg {
            display: block;

            text-align: center;

            margin-top: 20px;

            font-size: 0.85rem;

            font-weight: 600;

            line-height: 1.5;
        }

        /* =========================================================
           FOOTER
           ========================================================= */

        .footer-note {
            text-align: center;

            color:
                var(--text-sub);

            font-size: 0.75rem;

            margin-top: 16px;

            opacity: 0.75;
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
                    28px 20px;
            }

            .form-grid {
                grid-template-columns:
                    1fr;
            }

            .full-width,
            .food-section,
            .total-box {
                grid-column:
                    auto;
            }

            .button-row {
                flex-direction:
                    column;
            }

            .action-button {
                width:
                    100%;
            }

            .card-header h1 {
                font-size:
                    1.55rem;
            }
        }

    </style>

</head>

<body>

    <!-- Background effects -->

    <div class="ambient-orb orb-1"></div>

    <div class="ambient-orb orb-2"></div>


    <form id="form1" runat="server">

        <div class="portal-wrapper">

            <div class="glass-card">


                <!-- =================================================
                     HEADER
                     ================================================= -->

                <div class="card-header">

                    <div class="header-icon">
                        ✏️
                    </div>

                    <h1>
                        Update Restaurant Order
                    </h1>

                    <p>
                        Select an existing order below
                        to load and update its information.
                    </p>

                    <div class="update-badge">
                        ✏️ Order Information Update
                    </div>

                </div>


                <!-- =================================================
                     INFORMATION
                     ================================================= -->

                <div class="info-note">

                    <div class="info-icon">
                        💡
                    </div>

                    <div>
                        Select an existing order from the
                        dropdown. The order information will
                        automatically load below for editing.
                    </div>

                </div>


                <!-- =================================================
                     ORDER SELECTION
                     ================================================= -->

                <div class="form-grid">

                    <div class="form-group full-width">

                        <asp:Label
                            ID="lblSelectOrder"
                            runat="server"
                            Text="Select Order"
                            CssClass="form-label">
                        </asp:Label>

                        <asp:DropDownList
                            ID="ddlSelectOrder"
                            runat="server"
                            CssClass="form-input"
                            AutoPostBack="True"
                            OnSelectedIndexChanged="ddlSelectOrder_SelectedIndexChanged">
                        </asp:DropDownList>

                    </div>

                </div>


                <!-- =================================================
                     EDIT FORM
                     ================================================= -->

                <asp:Panel
                    ID="pnlEditForm"
                    runat="server"
                    Visible="False">


                    <div class="form-grid">


                        <!-- CUSTOMER -->

                        <div class="form-group">

                            <asp:Label
                                ID="lblCustomerName"
                                runat="server"
                                Text="Customer Name"
                                CssClass="form-label">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtCustomerName"
                                runat="server"
                                CssClass="form-input"
                                placeholder="Enter customer name">
                            </asp:TextBox>

                        </div>


                        <!-- TABLE -->

                        <div class="form-group">

                            <asp:Label
                                ID="lblTable"
                                runat="server"
                                Text="Table Number"
                                CssClass="form-label">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtTable"
                                runat="server"
                                CssClass="form-input"
                                placeholder="Enter table number">
                            </asp:TextBox>

                        </div>


                        <!-- QUANTITY -->

                        <div class="form-group">

                            <asp:Label
                                ID="lblQuantity"
                                runat="server"
                                Text="Quantity"
                                CssClass="form-label">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtQuantity"
                                runat="server"
                                CssClass="form-input"
                                TextMode="Number"
                                min="1"
                                placeholder="Enter quantity">
                            </asp:TextBox>

                        </div>


                        <!-- DATE -->

                        <div class="form-group">

                            <asp:Label
                                ID="lblDate"
                                runat="server"
                                Text="Order Date"
                                CssClass="form-label">
                            </asp:Label>

                            <asp:TextBox
                                ID="txtDate"
                                runat="server"
                                CssClass="form-input"
                                TextMode="Date">
                            </asp:TextBox>

                        </div>


                        <!-- =================================================
                             FOOD ITEMS
                             ================================================= -->

                        <div class="food-section">

                            <div class="food-title">
                                🍴 Select Food Items
                            </div>

                            <div class="food-options">

                                <asp:CheckBoxList
                                    ID="cblFooditems"
                                    runat="server">

                                    <asp:ListItem
                                        Value="55">
                                        🍔 Burger — R55
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Value="85">
                                        🍕 Pizza — R85
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Value="65">
                                        🍝 Pasta — R65
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Value="25">
                                        🥤 Drink — R25
                                    </asp:ListItem>

                                </asp:CheckBoxList>

                            </div>

                        </div>


                        <!-- =================================================
                             STATUS
                             ================================================= -->

                        <div class="form-group">

                            <asp:Label
                                ID="lblOrderStatus"
                                runat="server"
                                Text="Order Status"
                                CssClass="form-label">
                            </asp:Label>

                            <asp:DropDownList
                                ID="ddlStatus"
                                runat="server"
                                CssClass="form-input">

                                <asp:ListItem
                                    Text="-- Select Status --"
                                    Value="">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="Pending"
                                    Value="Pending">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="Completed"
                                    Value="Completed">
                                </asp:ListItem>

                            </asp:DropDownList>

                        </div>


                        <!-- =================================================
                             TOTAL
                             ================================================= -->

                        <div class="total-box">

                            <asp:Label
                                ID="lblTotalLabel"
                                runat="server"
                                Text="Total Price"
                                CssClass="total-label">
                            </asp:Label>

                            <asp:Label
                                ID="lblPrize"
                                runat="server"
                                Text="R0.00"
                                CssClass="total-price">
                            </asp:Label>

                        </div>


                    </div>


                    <!-- =================================================
                         BUTTONS
                         ================================================= -->

                    <div class="button-row">

                        <asp:Button
                            ID="btnUpdate"
                            runat="server"
                            Text="✓ Save Changes"
                            CssClass="action-button update-button"
                            OnClick="btnUpdate_Click" />

                        <asp:Button
                            ID="btnDashboard"
                            runat="server"
                            Text="← Back to Orders"
                            CssClass="action-button dashboard-button"
                            CausesValidation="false"
                            OnClick="btnDashboard_Click" />

                    </div>

                </asp:Panel>


                <!-- =================================================
                     STATUS MESSAGE
                     ================================================= -->

                <asp:Label
                    ID="lblStatus"
                    runat="server"
                    CssClass="status-msg">
                </asp:Label>


            </div>


            <!-- FOOTER -->

            <div class="footer-note">
                AquaCore • Restaurant Orders Management
            </div>

        </div>

    </form>

</body>

</html>
