<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="Delete_Medical_R.aspx.cs"
Inherits="AQUACORE_CMPG223.Delete" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<title>AquaCore - Delete Medical Record</title>

<style>

    :root {
        --abyss-deep: #051329;
        --ocean-blue: #0b2545;
        --aqua-glow: #00d2ff;

        --card-glass: rgba(11, 37, 69, 0.75);
        --card-border: rgba(0, 210, 255, 0.25);

        --text-primary: #eef4f8;
        --text-muted: #8da4be;

        --medical-red: #ff6b7a;
        --medical-red-dark: #d9364a;

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

        max-width: 850px;

        display: flex;

        flex-direction: column;

        gap: 24px;
    }

    /* Glass Panel */

    .glass-panel {

        background: var(--card-glass);

        border:
            1px solid var(--card-border);

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

        margin-bottom: 6px;
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

        margin-top: 12px;

        padding: 6px 12px;

        border-radius: 20px;

        background:
            rgba(255, 107, 122, 0.08);

        border:
            1px solid rgba(255, 107, 122, 0.2);

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

        background:
            rgba(255, 255, 255, 0.08);

        color: var(--text-primary);

        border:
            1px solid rgba(255, 255, 255, 0.15);
    }

    .btn-outline:hover {

        background:
            rgba(255, 255, 255, 0.15);

        color: #ffffff;

        transform: translateY(-1px);
    }

    /* Page Heading */

    .page-heading {

        margin-bottom: 28px;
    }

    .page-heading h2 {

        font-size: 1.4rem;

        color: var(--aqua-glow);

        margin-bottom: 7px;
    }

    .page-heading p {

        color: var(--text-muted);

        font-size: 0.9rem;

        line-height: 1.5;
    }

    /* Delete Card */

    .delete-card {

        padding: 30px;

        border-radius: 14px;

        background:
            var(--danger-soft);

        border:
            1px solid var(--danger-border);

        text-align: center;
    }

    /* Icon */

    .delete-icon {

        width: 65px;

        height: 65px;

        margin: 0 auto 18px;

        display: flex;

        align-items: center;

        justify-content: center;

        border-radius: 16px;

        background:
            rgba(255, 107, 122, 0.09);

        border:
            1px solid rgba(255, 107, 122, 0.25);

        font-size: 2rem;
    }

    .delete-card h3 {

        color: #ffffff;

        font-size: 1.2rem;

        margin-bottom: 8px;
    }

    .delete-card p {

        color: var(--text-muted);

        font-size: 0.88rem;

        line-height: 1.5;

        margin-bottom: 25px;
    }

    /* Form Area */

    .form-group {

        max-width: 430px;

        margin: 0 auto;

        text-align: left;
    }

    .form-label {

        display: block;

        margin-bottom: 8px;

        color: var(--text-primary);

        font-size: 0.9rem;

        font-weight: 600;
    }

    /* TextBox */

    .input-control {

        width: 100%;

        padding: 12px 14px;

        border-radius: 8px;

        border:
            1px solid rgba(255, 107, 122, 0.25);

        background:
            rgba(5, 19, 41, 0.75);

        color: #ffffff;

        font-size: 0.95rem;

        outline: none;

        transition: all 0.2s ease;
    }

    .input-control:focus {

        border-color: var(--medical-red);

        box-shadow:
            0 0 8px rgba(255, 107, 122, 0.2);
    }

    /* Delete Button */

    .delete-button {

        margin-top: 22px;

        min-width: 170px;

        padding: 11px 20px;

        border-radius: 8px;

        background:
            linear-gradient(
                135deg,
                var(--medical-red),
                var(--medical-red-dark)
            );

        color: #ffffff;

        font-weight: 600;

        font-size: 0.9rem;

        border: none;

        cursor: pointer;

        transition: all 0.2s ease;
    }

    .delete-button:hover {

        transform: translateY(-1px);

        box-shadow:
            0 6px 18px rgba(255, 92, 108, 0.25);
    }

    /* Warning */

    .warning-message {

        max-width: 600px;

        margin: 25px auto 0;

        padding: 12px 15px;

        border-radius: 8px;

        background:
            rgba(255, 107, 122, 0.06);

        border:
            1px solid rgba(255, 107, 122, 0.15);

        color: #ffb0b8;

        font-size: 0.8rem;

        line-height: 1.5;
    }

    /* Bottom Navigation */

    .bottom-row {

        display: flex;

        justify-content: flex-end;

        margin-top: 25px;
    }

    /* Footer */

    .footer-note {

        text-align: center;

        color: var(--text-muted);

        font-size: 0.78rem;

        opacity: 0.8;

        margin-top: 2px;
    }

    /* Mobile */

    @media (max-width: 700px) {

        body {

            padding: 20px 10px;
        }

        .glass-panel {

            padding: 22px;
        }

        .header-panel {

            align-items: flex-start;
        }

        .header-panel .btn {

            width: 100%;
        }

        .delete-button {

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


    <!-- HEADER -->

    <div class="glass-panel header-panel">

        <div class="header-title">

            <h1>AquaCore Operations</h1>

            <p>
                Medical Records Management
            </p>

            <div class="medical-badge">

                🩺 Animal Health &amp; Medical Care

            </div>

        </div>

        <div>

            <asp:Button
                ID="btnTopBack"
                runat="server"
                Text="← Go Back"
                CssClass="btn btn-outline"
                CausesValidation="false"
                OnClick="btnBack_Click" />

        </div>

    </div>


    <!-- DELETE SECTION -->

    <div class="glass-panel">

        <div class="page-heading">

            <h2>Delete Medical Record</h2>

            <p>
                Remove a medical record associated with an animal from
                the AquaCore system.
            </p>

        </div>


        <div class="delete-card">


            <div class="delete-icon">

                🗑️

            </div>


            <h3>
                Remove Animal Medical Record
            </h3>


            <p>
                Enter the Record ID of the medical record you wish to
                remove. This action should only be performed when the
                record is no longer required.
            </p>


            <div class="form-group">

                <asp:Label
                    ID="Label11"
                    runat="server"
                    Text="Record ID:"
                    CssClass="form-label" />

                <asp:TextBox
                    ID="txtRecordID"
                    runat="server"
                    CssClass="input-control" />

            </div>


            <asp:Button
                ID="btnDelete"
                runat="server"
                Text="🗑 Delete Record"
                CssClass="delete-button" />


            <div class="warning-message">

                ⚠️ <strong>Important:</strong>
                Deleting a medical record may permanently remove the
                animal's associated health information from the system.

            </div>

        </div>


        <!-- BACK -->

        <div class="bottom-row">

            <asp:Button
                ID="btnBack"
                runat="server"
                Text="← Medicals Menu"
                CssClass="btn btn-outline"
                CausesValidation="false"
                OnClick="btnBack_Click" />

        </div>

    </div>


    <div class="footer-note">

        AquaCore • Animal Health &amp; Medical Records

    </div>

</div>

</form> </body> </html>