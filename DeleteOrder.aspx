<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteOrder.aspx.cs" Inherits="AQUACORE_CMPG223.DeleteOrder" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
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

    /* Background Glow */

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

    /* Main Container */

    .page-container {

        width: 100%;

        max-width: 650px;

        position: relative;

        z-index: 1;
    }

    /* Glass Panel */

    .glass-panel {

        background: var(--card-glass);

        border: 1px solid var(--card-border);

        border-radius: 16px;

        padding: 35px;

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

        background: rgba(255, 107, 122, 0.08);

        border: 1px solid var(--danger-border);

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

    /* Badge */

    .delete-badge {

        display: inline-flex;

        align-items: center;

        gap: 7px;

        margin-top: 8px;

        padding: 5px 11px;

        border-radius: 20px;

        background: var(--danger-soft);

        border: 1px solid var(--danger-border);

        color: #ff9aa5;

        font-size: 0.75rem;

        font-weight: 600;
    }

    /* Warning */

    .warning-box {

        display: flex;

        align-items: flex-start;

        gap: 12px;

        padding: 15px 16px;

        margin-bottom: 25px;

        border-radius: 11px;

        background: var(--danger-soft);

        border: 1px solid var(--danger-border);

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

    /* Form */

    .form-section {

        background: rgba(4, 28, 32, 0.45);

        border: 1px solid rgba(0, 191, 166, 0.14);

        border-radius: 12px;

        padding: 22px;
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

        border: 1px solid rgba(0, 191, 166, 0.22);

        background: rgba(4, 28, 32, 0.7);

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

    /* Help Text */

    .help-text {

        margin-top: 8px;

        color: var(--text-muted);

        font-size: 0.76rem;
    }

    /* Buttons */

    .button-row {

        display: flex;

        justify-content: center;

        gap: 15px;

        margin-top: 25px;

        padding-top: 25px;

        border-top: 1px solid rgba(0, 191, 166, 0.12);
    }

    .action-button {

        min-width: 170px;

        padding: 11px 20px;

        border-radius: 8px;

        color: #ffffff;

        font-size: 0.9rem;

        font-weight: 600;

        cursor: pointer;

        border: none;

        transition: all 0.2s ease;
    }

    /* Delete */

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

    /* Dashboard */

    .dashboard-button {

        background: rgba(255, 255, 255, 0.07);

        border: 1px solid rgba(255, 255, 255, 0.16);
    }

    .dashboard-button:hover {

        background: rgba(255, 255, 255, 0.14);

        transform: translateY(-1px);
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

    }

</style>

</head> <body>
<form id="form1" runat="server">

    <div class="page-container">

        <div class="glass-panel">

            <!-- Header -->

            <div class="page-header">

                <div class="header-icon">
                    🗑️
                </div>

                <div>

                    <h1>Delete Restaurant Order</h1>

                    <p>
                        Remove an existing order from AquaCore.
                    </p>

                    <div class="delete-badge">
                        ⚠️ Order Removal
                    </div>

                </div>

            </div>

            <!-- Warning -->

            <div class="warning-box">

                <div class="warning-icon">
                    ⚠️
                </div>

                <div>
                    <strong>Important:</strong>
                    Deleting an order will remove it from the
                    restaurant order records. Please make sure
                    you have entered the correct Order ID before
                    continuing.
                </div>

            </div>

            <!-- Form -->

            <div class="form-section">

                <asp:Label
                    ID="Label3"
                    runat="server"
                    Text="Order ID"
                    CssClass="form-label">
                </asp:Label>

                <asp:TextBox
                    ID="TextBox1"
                    runat="server"
                    CssClass="form-input"
                    placeholder="Enter the Order ID to delete">
                </asp:TextBox>

                <div class="help-text">
                    Enter the unique Order ID associated with
                    the restaurant order you want to remove.
                </div>

            </div>

            <!-- Buttons -->

            <div class="button-row">

                <asp:Button
                    ID="btnDelete"
                    runat="server"
                    Text="🗑 Delete Order"
                    CssClass="action-button delete-button" />

                <asp:Button
                    ID="btnDashboard"
                    runat="server"
                    Text="← Order Dashboard"
                    CssClass="action-button dashboard-button" OnClick="btnDashboard_Click" />

            </div>

        </div>

        <div class="footer-note">
            AquaCore • Restaurant Orders Management
        </div>

    </div>

</form>

</body> </html>