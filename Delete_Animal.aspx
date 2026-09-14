<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Delete_Animal.aspx.cs" Inherits="AQUACORE_CMPG223.Delete_Animal" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<title>AquaCore - Delete Animal</title>

<style>

    :root {
        --abyss-deep: #051329;
        --ocean-blue: #0b2545;
        --aqua-glow: #00d2ff;
        --card-glass: rgba(11, 37, 69, 0.78);
        --card-border: rgba(0, 210, 255, 0.25);
        --text-primary: #eef4f8;
        --text-muted: #8da4be;
        --danger: #ff6b7a;
        --danger-dark: #d9364a;
    }

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', sans-serif;
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
        justify-content: center;

        padding: 40px 20px;
    }

    .dashboard-container {
        width: 100%;
        max-width: 850px;

        display: flex;
        flex-direction: column;
        gap: 24px;
    }

    .glass-panel {
        background: var(--card-glass);

        border: 1px solid var(--card-border);

        border-radius: 16px;

        padding: 32px;

        box-shadow:
            0 10px 30px rgba(0, 0, 0, 0.35);

        backdrop-filter: blur(8px);
    }

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

        margin-bottom: 5px;
    }

    .header-title p {
        color: var(--text-muted);

        font-size: 0.95rem;
    }

    .animal-badge {
        display: inline-flex;

        align-items: center;

        gap: 7px;

        margin-top: 12px;

        padding: 6px 12px;

        border-radius: 20px;

        background: rgba(255, 107, 122, 0.08);

        border: 1px solid rgba(255, 107, 122, 0.2);

        color: #ff9aa5;

        font-size: 0.78rem;

        font-weight: 600;
    }

    .page-heading {
        margin-bottom: 25px;
    }

    .page-heading h2 {
        font-size: 1.4rem;

        color: var(--danger);

        margin-bottom: 6px;
    }

    .page-heading p {
        color: var(--text-muted);

        font-size: 0.9rem;

        line-height: 1.5;
    }

    .delete-box {
        background: rgba(255, 107, 122, 0.05);

        border: 1px solid rgba(255, 107, 122, 0.18);

        border-radius: 14px;

        padding: 25px;
    }

    .form-group {
        display: flex;

        flex-direction: column;

        gap: 8px;
    }

    .form-label {
        color: #dcebf5;

        font-size: 0.9rem;

        font-weight: 600;
    }

    .input-control {
        width: 100%;

        padding: 12px 13px;

        border-radius: 8px;

        border: 1px solid rgba(0, 210, 255, 0.2);

        background: rgba(5, 19, 41, 0.8);

        color: #ffffff;

        font-size: 0.9rem;

        outline: none;
    }

    .input-control:focus {
        border-color: var(--aqua-glow);

        box-shadow:
            0 0 0 3px rgba(0, 210, 255, 0.08);
    }

    .input-control option {
        background: #0b2545;

        color: #ffffff;
    }

    .validator {
        color: #ff7f8c !important;

        font-size: 0.8rem;
    }

    .warning {
        margin-top: 15px;

        color: #ff9aa5;

        font-size: 0.82rem;

        line-height: 1.5;
    }

    .button-row {
        display: flex;

        justify-content: flex-end;

        gap: 12px;

        margin-top: 25px;

        padding-top: 22px;

        border-top: 1px solid rgba(255, 255, 255, 0.08);
    }

    .delete-button {
        min-width: 150px;

        padding: 11px 20px;

        border-radius: 8px;

        background:
            linear-gradient(
                135deg,
                var(--danger),
                var(--danger-dark)
            );

        color: #ffffff;

        font-weight: 600;

        border: none;

        cursor: pointer;

        transition: all 0.2s ease;
    }

    .delete-button:hover {
        transform: translateY(-1px);

        box-shadow:
            0 6px 18px rgba(255, 107, 122, 0.25);
    }

    .menu-button {
        min-width: 140px;

        padding: 11px 20px;

        border-radius: 8px;

        background: rgba(255, 255, 255, 0.08);

        color: var(--text-primary);

        border: 1px solid rgba(255, 255, 255, 0.15);

        font-weight: 600;

        cursor: pointer;
    }

    .menu-button:hover {
        background: rgba(255, 255, 255, 0.15);
    }

    .footer-note {
        text-align: center;

        color: var(--text-muted);

        font-size: 0.78rem;

        opacity: 0.8;
    }

    @media (max-width: 700px) {

        body {
            padding: 20px 10px;
        }

        .glass-panel {
            padding: 22px;
        }

        .button-row {
            flex-direction: column;
        }

        .delete-button,
        .menu-button {
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

            <p>Animal Management</p>

            <div class="animal-badge">
                🗑️ Remove Aquarium Animal
            </div>

        </div>

    </div>


    <!-- DELETE FORM -->

    <div class="glass-panel">

        <div class="page-heading">

            <h2>🗑️ Delete Animal</h2>

            <p>
                Select the Animal ID of the animal you want to remove
                from the AquaCore system.
            </p>

        </div>


        <div class="delete-box">

            <div class="form-group">

                <asp:Label
                    ID="Label2"
                    runat="server"
                    Text="Select Animal ID"
                    CssClass="form-label" />

                <asp:DropDownList
                    ID="ddlAnimalID"
                    runat="server"
                    CssClass="input-control">

                    <asp:ListItem Value="">
                        -- Select Animal ID --
                    </asp:ListItem>

                </asp:DropDownList>

                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1"
                    runat="server"
                    ControlToValidate="ddlAnimalID"
                    InitialValue=""
                    ErrorMessage="Please select an Animal ID."
                    ForeColor="Red"
                    CssClass="validator" />

            </div>

            <div class="warning">
                ⚠️ The selected animal and its associated records may be
                affected by this deletion. Please make sure you have
                selected the correct Animal ID.
            </div>

        </div>


        <div class="button-row">

            <asp:Button
                ID="btnDeleteAnimal"
                runat="server"
                Text="🗑 Delete Animal"
                CssClass="delete-button"
                OnClick="btnDeleteAnimal_Click" />

            <asp:Button
                ID="btnMenu"
                runat="server"
                Text="← Animal Menu"
                CssClass="menu-button"
                CausesValidation="false"
                OnClick="btnMenu_Click" />

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblOutput" runat="server"></asp:Label>

        </div>

    </div>


    <div class="footer-note">
        AquaCore • Animal Registry &amp; Aquarium Management
    </div>

</div>

</form> </body> </html>