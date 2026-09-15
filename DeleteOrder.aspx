<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteOrder.aspx.cs" Inherits="AQUACORE_CMPG223.DeleteOrder" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>AquaCore - Delete Restaurant Order</title>

    <style>

        :root {
            --abyss-deep: #041c20;
            --ocean-deep: #063b40;

            --teal: #00bfa6;
            --teal-glow: #19e6cc;
            --teal-soft: #70f2df;

            --card-glass: rgba(6, 59, 64, 0.72);
            --card-border: rgba(0, 191, 166, 0.25);

            --text-primary: #eefcfb;
            --text-muted: #91b8b5;

            --danger: #ff6b7a;
            --danger-dark: #d9364a;
            --danger-soft: rgba(255, 107, 122, 0.08);
            --danger-border: rgba(255, 107, 122, 0.25);
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

            align-items: center;

            padding: 30px 20px;

            position: relative;

            overflow-x: hidden;
        }

        body::before {

            content: "";

            position: fixed;

            width: 500px;

            height: 500px;

            border-radius: 50%;

            background: rgba(0, 191, 166, 0.06);

            filter: blur(80px);

            top: -120px;

            left: -150px;

            pointer-events: none;
        }

        body::after {

            content: "";

            position: fixed;

            width: 450px;

            height: 450px;

            border-radius: 50%;

            background: rgba(255, 107, 122, 0.035);

            filter: blur(80px);

            bottom: -150px;

            right: -100px;

            pointer-events: none;
        }

        .page-container {

            width: 100%;

            max-width: 700px;

            position: relative;

            z-index: 1;
        }

        .glass-panel {

            background: var(--card-glass);

            border: 1px solid var(--card-border);

            border-radius: 16px;

            padding: 35px;

            box-shadow:
                0 10px 35px rgba(0, 0, 0, 0.4);

            backdrop-filter: blur(8px);
        }

        .page-header {

            display: flex;

            align-items: center;

            gap: 16px;

            padding-bottom: 25px;

            margin-bottom: 25px;

            border-bottom:
                1px solid rgba(0, 191, 166, 0.15);
        }

        .header-icon {

            width: 60px;

            height: 60px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 15px;

            background:
                rgba(255, 107, 122, 0.08);

            border:
                1px solid var(--danger-border);

            font-size: 1.9rem;

            box-shadow:
                0 0 20px rgba(255, 107, 122, 0.07);
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

        .delete-badge {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            margin-top: 8px;

            padding: 5px 11px;

            border-radius: 20px;

            background: var(--danger-soft);

            border:
                1px solid var(--danger-border);

            color: #ff9aa5;

            font-size: 0.75rem;

            font-weight: 600;
        }

        .warning-box {

            display: flex;

            align-items: flex-start;

            gap: 12px;

            padding: 15px 16px;

            margin-bottom: 25px;

            border-radius: 11px;

            background: var(--danger-soft);

            border:
                1px solid var(--danger-border);

            color: #d9c1c5;

            font-size: 0.85rem;

            line-height: 1.5;
        }

        .warning-icon {

            font-size: 1.25rem;

            color: var(--danger);

            flex-shrink: 0;
        }

        .warning-box strong {

            color: #ff9aa5;
        }

        .form-section {

            background:
                rgba(4, 28, 32, 0.45);

            border:
                1px solid rgba(0, 191, 166, 0.14);

            border-radius: 12px;

            padding: 22px;

            margin-bottom: 20px;
        }

        .form-label {

            display: block;

            color: #d9f7f4;

            font-size: 0.9rem;

            font-weight: 600;

            margin-bottom: 9px;
        }

        .form-input {

            width: 100%;

            padding: 12px 14px;

            border-radius: 8px;

            border:
                1px solid rgba(0, 191, 166, 0.22);

            background:
                rgba(4, 28, 32, 0.7);

            color: #ffffff;

            font-size: 0.9rem;

            outline: none;
        }

        .form-input:focus {

            border-color: var(--teal);

            box-shadow:
                0 0 0 3px rgba(0, 191, 166, 0.08);
        }

        select.form-input option {

            background-color: #063b40;

            color: #ffffff;
        }

        .help-text {

            margin-top: 8px;

            color: var(--text-muted);

            font-size: 0.76rem;
        }

        .details-box {

            background:
                rgba(0, 191, 166, 0.05);

            border:
                1px solid rgba(0, 191, 166, 0.18);

            border-radius: 10px;

            padding: 18px;

            margin-top: 20px;
        }

        .detail-row {

            display: flex;

            justify-content: space-between;

            gap: 20px;

            margin-bottom: 10px;

            font-size: 0.9rem;
        }

        .detail-row:last-child {

            margin-bottom: 0;
        }

        .detail-label {

            color: var(--text-muted);

            font-weight: 500;
        }

        .detail-value {

            color: #ffffff;

            font-weight: 600;

            text-align: right;
        }

        .warning-text {

            color: #ff9aa5;

            font-size: 0.85rem;

            font-weight: 600;

            text-align: center;

            margin-top: 20px;

            margin-bottom: 15px;
        }

        .status-msg {

            display: block;

            margin-top: 16px;

            font-size: 0.9rem;

            font-weight: 600;

            text-align: center;
        }

        .button-row {

            display: flex;

            justify-content: center;

            gap: 15px;

            margin-top: 25px;

            padding-top: 25px;

            border-top:
                1px solid rgba(0, 191, 166, 0.12);
        }

        .action-button {

            min-width: 190px;

            padding: 11px 20px;

            border-radius: 8px;

            color: #ffffff;

            font-size: 0.9rem;

            font-weight: 600;

            cursor: pointer;

            border: none;

            transition: all 0.2s ease;
        }

        .delete-button {

            background:
                linear-gradient(
                    135deg,
                    var(--danger),
                    var(--danger-dark)
                );
        }

        .delete-button:hover {

            transform: translateY(-1px);

            opacity: 0.93;

            box-shadow:
                0 5px 18px rgba(255, 92, 108, 0.22);
        }

        .dashboard-button {

            background:
                rgba(255, 255, 255, 0.07);

            border:
                1px solid rgba(255, 255, 255, 0.16);
        }

        .dashboard-button:hover {

            background:
                rgba(255, 255, 255, 0.14);

            transform: translateY(-1px);
        }

        .return-directory {

            display: block;

            width: 100%;

            margin-top: 15px;

            padding: 11px;

            border-radius: 8px;

            text-align: center;

            text-decoration: none;

            color: var(--text-muted);

            background:
                rgba(255, 255, 255, 0.05);

            border:
                1px solid rgba(255, 255, 255, 0.12);

            font-size: 0.88rem;

            font-weight: 600;
        }

        .return-directory:hover {

            color: #ffffff;

            background:
                rgba(255, 255, 255, 0.10);
        }

        .footer-note {

            text-align: center;

            color: var(--text-muted);

            font-size: 0.78rem;

            margin-top: 18px;

            opacity: 0.8;
        }

        @media (max-width: 600px) {

            body {

                padding: 20px 10px;

                align-items: flex-start;
            }

            .glass-panel {

                padding: 22px;
            }

            .page-header h1 {

                font-size: 1.55rem;
            }

            .button-row {

                flex-direction: column;
            }

            .action-button {

                width: 100%;
            }

            .detail-row {

                flex-direction: column;

                gap: 3px;
            }

            .detail-value {

                text-align: left;
            }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="page-container">

        <div class="glass-panel">

            <!-- HEADER -->

            <div class="page-header">

                <div class="header-icon">
                    🗑️
                </div>

                <div>

                    <h1>Delete Restaurant Order</h1>

                    <p>
                        Select an existing order to remove it from AquaCore.
                    </p>

                    <div class="delete-badge">
                        ⚠️ Order Removal
                    </div>

                </div>

            </div>


            <!-- WARNING -->

            <div class="warning-box">

                <div class="warning-icon">
                    ⚠️
                </div>

                <div>

                    <strong>Important:</strong>

                    Select the correct order before deleting it.
                    Once the order is deleted, it cannot be recovered.

                </div>

            </div>


            <!-- ORDER SELECTION -->

            <div class="form-section">

                <asp:Label
                    ID="Label3"
                    runat="server"
                    Text="Select Restaurant Order"
                    CssClass="form-label">
                </asp:Label>

                <asp:DropDownList
                    ID="ddlSelectOrder"
                    runat="server"
                    CssClass="form-input"
                    AutoPostBack="True"
                    OnSelectedIndexChanged="ddlSelectOrder_SelectedIndexChanged">

                </asp:DropDownList>

                <div class="help-text">

                    Select an order from the list to view its details.

                </div>


                <!-- ORDER DETAILS -->

                <asp:Panel
                    ID="pnlOrderDetails"
                    runat="server"
                    Visible="False">

                    <div class="details-box">

                        <div class="detail-row">

                            <span class="detail-label">
                                Order ID:
                            </span>

                            <asp:Label
                                ID="lblOrderID"
                                runat="server"
                                CssClass="detail-value">
                            </asp:Label>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Customer:
                            </span>

                            <asp:Label
                                ID="lblCustomerName"
                                runat="server"
                                CssClass="detail-value">
                            </asp:Label>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Table:
                            </span>

                            <asp:Label
                                ID="lblTableNumber"
                                runat="server"
                                CssClass="detail-value">
                            </asp:Label>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Food Items:
                            </span>

                            <asp:Label
                                ID="lblFoodItems"
                                runat="server"
                                CssClass="detail-value">
                            </asp:Label>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Quantity:
                            </span>

                            <asp:Label
                                ID="lblQuantity"
                                runat="server"
                                CssClass="detail-value">
                            </asp:Label>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Total Price:
                            </span>

                            <asp:Label
                                ID="lblTotalPrice"
                                runat="server"
                                CssClass="detail-value">
                            </asp:Label>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Order Date:
                            </span>

                            <asp:Label
                                ID="lblOrderDate"
                                runat="server"
                                CssClass="detail-value">
                            </asp:Label>

                        </div>


                        <div class="detail-row">

                            <span class="detail-label">
                                Status:
                            </span>

                            <asp:Label
                                ID="lblStatus"
                                runat="server"
                                CssClass="detail-value">
                            </asp:Label>

                        </div>

                    </div>


                    <p class="warning-text">

                        ⚠️ Are you sure you want to permanently delete
                        this restaurant order?

                    </p>


                    <asp:Button
                        ID="btnDelete"
                        runat="server"
                        Text="🗑 Permanently Delete Order"
                        CssClass="action-button delete-button"
                        OnClick="btnDelete_Click"
                        OnClientClick="return confirm('Are you sure you want to delete this order? This action cannot be undone.');" />

                </asp:Panel>

            </div>


            <!-- STATUS -->

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="status-msg">
            </asp:Label>


            <!-- BUTTONS -->

            <div class="button-row">

                <asp:Button
                    ID="btnDashboard"
                    runat="server"
                    Text="← Order Dashboard"
                    CssClass="action-button dashboard-button"
                    CausesValidation="false"
                    OnClick="btnDashboard_Click" />

            </div>

        </div>


        <div class="footer-note">

            AquaCore • Restaurant Orders Management

        </div>

    </div>

</form>

</body>
</html>
