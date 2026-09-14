<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateOrder.aspx.cs" Inherits="AQUACORE_CMPG223.UpdateOrder" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
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

        --amber: #ffc857;
        --amber-soft: rgba(255, 200, 87, 0.08);
        --amber-border: rgba(255, 200, 87, 0.24);

        --danger: #ff6b7a;
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
                #0b5558 0%,
                var(--ocean-deep) 38%,
                var(--abyss-deep) 100%
            );

        color: var(--text-primary);

        min-height: 100vh;

        display: flex;

        justify-content: center;

        padding: 40px 20px;

        position: relative;

        overflow-x: hidden;
    }

    /* Background Glow */

    body::before {

        content: "";

        position: fixed;

        width: 500px;

        height: 500px;

        border-radius: 50%;

        background: rgba(0, 191, 166, 0.06);

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

        background: rgba(255, 200, 87, 0.035);

        filter: blur(80px);

        bottom: -150px;

        right: -100px;

        pointer-events: none;
    }

    /* Main Container */

    .page-container {

        width: 100%;

        max-width: 850px;

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
            0 10px 35px rgba(0, 0, 0, 0.4);

        backdrop-filter: blur(8px);
    }

    /* Header */

    .page-header {

        display: flex;

        align-items: center;

        gap: 16px;

        padding-bottom: 25px;

        margin-bottom: 25px;

        border-bottom: 1px solid rgba(0, 191, 166, 0.15);
    }

    .header-icon {

        width: 60px;

        height: 60px;

        display: flex;

        align-items: center;

        justify-content: center;

        border-radius: 15px;

        background: var(--amber-soft);

        border: 1px solid var(--amber-border);

        font-size: 1.9rem;

        box-shadow:
            0 0 20px rgba(255, 200, 87, 0.06);
    }

    .page-header h1 {

        color: #ffffff;

        font-size: 1.9rem;

        margin-bottom: 5px;
    }

    .page-header p {

        color: var(--text-muted);

        font-size: 0.9rem;
    }

    /* Badge */

    .update-badge {

        display: inline-flex;

        align-items: center;

        gap: 7px;

        margin-top: 8px;

        padding: 5px 11px;

        border-radius: 20px;

        background: var(--amber-soft);

        border: 1px solid var(--amber-border);

        color: var(--amber);

        font-size: 0.75rem;

        font-weight: 600;
    }

    /* Information Note */

    .info-note {

        display: flex;

        align-items: flex-start;

        gap: 12px;

        padding: 14px 16px;

        margin-bottom: 25px;

        border-radius: 10px;

        background: rgba(0, 191, 166, 0.05);

        border: 1px solid rgba(0, 191, 166, 0.13);

        color: var(--text-muted);

        font-size: 0.85rem;

        line-height: 1.5;
    }

    .info-icon {

        font-size: 1.2rem;

        color: var(--teal-soft);

        flex-shrink: 0;
    }

    /* Form Grid */

    .form-grid {

        display: grid;

        grid-template-columns: repeat(2, 1fr);

        gap: 22px;
    }

    /* Form Groups */

    .form-group {

        display: flex;

        flex-direction: column;

        gap: 8px;
    }

    .full-width {

        grid-column: 1 / -1;
    }

    /* Labels */

    .form-label {

        color: #d9f7f4;

        font-size: 0.88rem;

        font-weight: 600;
    }

    /* Inputs */

    .form-input {

        width: 100%;

        padding: 11px 13px;

        border-radius: 8px;

        border: 1px solid rgba(0, 191, 166, 0.2);

        background: rgba(4, 28, 32, 0.65);

        color: #ffffff;

        font-size: 0.9rem;

        outline: none;

        transition:
            border-color 0.2s ease,
            box-shadow 0.2s ease,
            background 0.2s ease;
    }

    .form-input:focus {

        border-color: var(--teal);

        background: rgba(0, 191, 166, 0.06);

        box-shadow:
            0 0 0 3px rgba(0, 191, 166, 0.08);
    }

    .form-input::placeholder {

        color: #607f7d;
    }

    /* Food Section */

    .food-section {

        grid-column: 1 / -1;

        padding: 20px;

        border-radius: 12px;

        background: rgba(4, 28, 32, 0.42);

        border: 1px solid rgba(0, 191, 166, 0.14);
    }

    .food-title {

        color: #ffffff;

        font-size: 1rem;

        font-weight: 600;

        margin-bottom: 15px;
    }

    .food-options {

        display: grid;

        grid-template-columns: repeat(2, 1fr);

        gap: 12px;
    }

    .food-options input {

        accent-color: var(--teal);
    }

    .food-options label {

        color: #d9f7f4;

        font-size: 0.88rem;

        cursor: pointer;
    }

    /* Validators */

    .validator {

        color: #ff9aa5;

        font-size: 0.75rem;

        line-height: 1.3;
    }

    /* Total */

    .total-box {

        grid-column: 1 / -1;

        display: flex;

        justify-content: space-between;

        align-items: center;

        padding: 17px 20px;

        border-radius: 12px;

        background:
            linear-gradient(
                135deg,
                rgba(0, 191, 166, 0.10),
                rgba(8, 127, 130, 0.08)
            );

        border: 1px solid rgba(0, 191, 166, 0.22);
    }

    .total-label {

        color: var(--text-muted);

        font-size: 0.9rem;

        font-weight: 600;
    }

    .total-price {

        color: var(--teal-glow);

        font-size: 1.35rem;

        font-weight: 700;
    }

    /* Buttons */

    .button-row {

        display: flex;

        justify-content: center;

        gap: 15px;

        margin-top: 28px;

        padding-top: 25px;

        border-top: 1px solid rgba(0, 191, 166, 0.12);
    }

    .action-button {

        min-width: 170px;

        padding: 11px 20px;

        border-radius: 8px;

        border: none;

        color: #ffffff;

        font-size: 0.9rem;

        font-weight: 600;

        cursor: pointer;

        transition: all 0.2s ease;
    }

    /* Update Button */

    .update-button {

        background:
            linear-gradient(
                135deg,
                var(--teal-glow),
                var(--teal-dark)
            );
    }

    .update-button:hover {

        transform: translateY(-1px);

        opacity: 0.93;

        box-shadow:
            0 5px 18px rgba(0, 191, 166, 0.22);
    }

    /* Dashboard Button */

    .dashboard-button {

        background: rgba(255, 255, 255, 0.07);

        border: 1px solid rgba(255, 255, 255, 0.16);
    }

    .dashboard-button:hover {

        background: rgba(255, 255, 255, 0.14);

        transform: translateY(-1px);

        box-shadow: none;
    }

    /* Footer */

    .footer-note {

        text-align: center;

        color: var(--text-muted);

        font-size: 0.78rem;

        margin-top: 18px;

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

        .form-grid {

            grid-template-columns: 1fr;
        }

        .full-width,

        .food-section,

        .total-box {

            grid-column: auto;
        }

        .food-options {

            grid-template-columns: 1fr;
        }

        .button-row {

            flex-direction: column;
        }

        .action-button {

            width: 100%;
        }

        .page-header h1 {

            font-size: 1.55rem;
        }

    }

</style>

</head> <body>
<form id="form1" runat="server">

    <div class="page-container">

        <div class="glass-panel">

            <!-- Header -->

            <div class="page-header">

                <div class="header-icon">
                    ✏️
                </div>

                <div>

                    <h1>Update Restaurant Order</h1>

                    <p>
                        Modify an existing AquaCore restaurant order.
                    </p>

                    <div class="update-badge">
                        ✏️ Order Information Update
                    </div>

                </div>

            </div>

            <!-- Information -->

            <div class="info-note">

                <div class="info-icon">
                    💡
                </div>

                <div>
                    Enter the Order ID and update the relevant
                    customer, table, food, quantity, date, or
                    status information.
                </div>

            </div>

            <!-- Form -->

            <div class="form-grid">

                <!-- Order ID -->

                <div class="form-group">

                    <asp:Label
                        ID="Label1"
                        runat="server"
                        Text="Order ID"
                        CssClass="form-label">
                    </asp:Label>

                    <asp:TextBox
                        ID="txtOrderID"
                        runat="server"
                        CssClass="form-input"
                        placeholder="Enter order ID">
                    </asp:TextBox>

                </div>

                <!-- Customer Name -->

                <div class="form-group">

                    <asp:Label
                        ID="Label2"
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

                <!-- Table Number -->

                <div class="form-group">

                    <asp:Label
                        ID="Label3"
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

                <!-- Quantity -->

                <div class="form-group">

                    <asp:Label
                        ID="Label4"
                        runat="server"
                        Text="Quantity"
                        CssClass="form-label">
                    </asp:Label>

                    <asp:TextBox
                        ID="txtQuantity"
                        runat="server"
                        CssClass="form-input"
                        placeholder="Enter quantity">
                    </asp:TextBox>

                </div>

                <!-- Food -->

                <div class="food-section">

                    <div class="food-title">
                        🍴 Select Food Items
                    </div>

                    <div class="food-options">

                        <asp:CheckBoxList
                            ID="cblFooditems"
                            runat="server">

                            <asp:ListItem Value="55">
                                🍔 Burger — R55
                            </asp:ListItem>

                            <asp:ListItem Value="85">
                                🍕 Pizza — R85
                            </asp:ListItem>

                            <asp:ListItem Value="65">
                                🍝 Pasta — R65
                            </asp:ListItem>

                            <asp:ListItem Value="25">
                                🥤 Drink — R25
                            </asp:ListItem>

                        </asp:CheckBoxList>

                    </div>

                </div>

                <!-- Order Date -->

                <div class="form-group">

                    <asp:Label
                        ID="Label5"
                        runat="server"
                        Text="Order Date"
                        CssClass="form-label">
                    </asp:Label>

                    <asp:TextBox
                        ID="txtDate"
                        runat="server"
                        CssClass="form-input"
                        placeholder="Enter order date">
                    </asp:TextBox>

                </div>

                <!-- Status -->

                <div class="form-group">

                    <asp:Label
                        ID="Label6"
                        runat="server"
                        Text="Order Status"
                        CssClass="form-label">
                    </asp:Label>

                    <asp:DropDownList
                        ID="DropDownList1"
                        runat="server"
                        CssClass="form-input">

                        <asp:ListItem Value="0">
                            --- Select Status ---
                        </asp:ListItem>

                        <asp:ListItem>
                            Pending
                        </asp:ListItem>

                        <asp:ListItem>
                            Completed
                        </asp:ListItem>

                    </asp:DropDownList>

                </div>

                <!-- Total -->

                <div class="total-box">

                    <asp:Label
                        ID="Label7"
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

            <!-- Buttons -->

            <div class="button-row">

                <asp:Button
                    ID="btnUpdate"
                    runat="server"
                    Text="✓ Update Order"
                    CssClass="action-button update-button" />

                <asp:Button
                    ID="btnDashboard"
                    runat="server"
                    Text="← Back to Dashboard"
                    CssClass="action-button dashboard-button" OnClick="btnDashboard_Click" />

            </div>

        </div>

        <div class="footer-note">
            AquaCore • Restaurant Orders Management
        </div>

    </div>

</form>

</body> </html>