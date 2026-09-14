<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Update_Animal.aspx.cs" Inherits="AQUACORE_CMPG223.Update_Animal" %>

<!DOCTYPE html> <html xmlns="http://www.w3.org/1999/xhtml"> <head runat="server">
<title>AquaCore - Update Animal</title>

<style>

    :root {
        --abyss-deep: #051329;
        --ocean-blue: #0b2545;
        --aqua-glow: #00d2ff;
        --card-glass: rgba(11, 37, 69, 0.75);
        --card-border: rgba(0, 210, 255, 0.25);

        --text-primary: #eef4f8;
        --text-muted: #8da4be;

        --accent-warning: #ffd166;
        --danger: #ff6b7a;
        --success: #4ade80;
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

        align-items: center;

        justify-content: center;

        padding: 20px;
    }

    /* Main Card */

    .form-card {

        background: var(--card-glass);

        border: 1px solid var(--card-border);

        border-radius: 16px;

        padding: 32px;

        width: 100%;

        max-width: 550px;

        box-shadow:
            0 10px 30px rgba(0, 0, 0, 0.35);

        backdrop-filter: blur(8px);
    }

    /* Heading */

    .form-card h2 {

        font-size: 1.8rem;

        margin-bottom: 8px;

        color: #ffffff;
    }

    .form-card > p {

        color: var(--text-muted);

        font-size: 0.95rem;

        margin-bottom: 24px;

        line-height: 1.5;
    }

    /* Form Groups */

    .form-group {

        margin-bottom: 16px;

        display: flex;

        flex-direction: column;
    }

    /* Divider */

    .divider {

        height: 1px;

        background: rgba(0, 210, 255, 0.2);

        margin: 24px 0;
    }

    /* Labels */

    .form-label {

        font-size: 0.85rem;

        font-weight: 600;

        color: var(--aqua-glow);

        margin-bottom: 6px;

        text-transform: uppercase;

        letter-spacing: 0.5px;
    }

    /* Inputs */

    .input-control {

        width: 100%;

        padding: 10px 14px;

        border-radius: 8px;

        border: 1px solid rgba(0, 210, 255, 0.25);

        background: rgba(5, 19, 41, 0.6);

        color: #ffffff;

        font-size: 0.95rem;

        outline: none;

        transition: all 0.2s ease;
    }

    .input-control:focus {

        border-color: var(--aqua-glow);

        box-shadow:
            0 0 8px rgba(0, 210, 255, 0.3);
    }

    .input-control::placeholder {

        color: #617993;
    }

    /* Disabled Inputs */

    .input-control:disabled {

        background: rgba(255, 255, 255, 0.05);

        color: var(--text-muted);

        cursor: not-allowed;
    }

    /* Dropdown */

    select.input-control option {

        background-color: #0b2545;

        color: #ffffff;
    }

    /* Gender */

    .gender-options {

        display: flex;

        gap: 10px;
    }

    .gender-option {

        flex: 1;

        padding: 10px;

        border-radius: 8px;

        background: rgba(0, 210, 255, 0.05);

        border: 1px solid rgba(0, 210, 255, 0.2);

        text-align: center;

        cursor: pointer;

        color: var(--text-primary);
    }

    .gender-option:hover {

        background: rgba(0, 210, 255, 0.1);

        border-color: rgba(0, 210, 255, 0.4);
    }

    .gender-option input {

        accent-color: var(--aqua-glow);

        margin-right: 6px;
    }

    /* Buttons */

    .btn-group {

        display: flex;

        gap: 12px;

        margin-top: 24px;
    }

    .btn {

        padding: 12px 20px;

        border-radius: 8px;

        font-weight: 600;

        font-size: 0.95rem;

        cursor: pointer;

        border: none;

        flex: 1;

        text-align: center;

        text-decoration: none;

        transition: all 0.2s ease;
    }

    /* Update Button */

    .btn-submit {

        background:
            linear-gradient(
                135deg,
                #00d2ff,
                #0077b6
            );

        color: #ffffff;
    }

    .btn-submit:hover {

        opacity: 0.9;

        transform: translateY(-1px);

        box-shadow:
            0 5px 15px rgba(0, 210, 255, 0.25);
    }

    /* Back Button */

    .btn-back {

        background: rgba(255, 255, 255, 0.08);

        color: var(--text-muted);

        border: 1px solid rgba(255, 255, 255, 0.15);
    }

    .btn-back:hover {

        background: rgba(255, 255, 255, 0.15);

        color: #ffffff;
    }

    /* Status */

    .status-msg {

        display: block;

        margin-top: 16px;

        font-size: 0.9rem;

        font-weight: 600;

        text-align: center;

        color: var(--aqua-glow);
    }

    /* Mobile */

    @media (max-width: 600px) {

        .form-card {

            padding: 24px;

        }

        .btn-group {

            flex-direction: column;

        }

        .gender-options {

            flex-direction: column;

        }

    }

</style>

</head> <body> <form id="form1" runat="server">
<div class="form-card">

    <h2>Modify Animal</h2>

    <p>
        Select an animal from the dropdown below to load and update
        its aquarium records.
    </p>


    <!-- Animal Selection -->

    <div class="form-group">

        <asp:Label
            ID="lblSelectAnimal"
            runat="server"
            Text="Select Animal to Edit"
            CssClass="form-label">
        </asp:Label>

        <asp:DropDownList
            ID="ddlSelectAnimal"
            runat="server"
            CssClass="input-control"
            AutoPostBack="True"
            OnSelectedIndexChanged="ddlSelectAnimal_SelectedIndexChanged">
        </asp:DropDownList>

    </div>


    <!-- Status -->

    <asp:Label
        ID="lblOutput"
        runat="server"
        CssClass="status-msg">
    </asp:Label>


    <!-- Edit Form -->

    <asp:Panel
        ID="pnlEditForm"
        runat="server"
        Visible="False">

        <div class="divider"></div>


        <!-- Animal Name -->

        <div class="form-group">

            <asp:Label
                ID="lblName"
                runat="server"
                Text="Animal Name"
                CssClass="form-label">
            </asp:Label>

            <asp:TextBox
                ID="txtName"
                runat="server"
                CssClass="input-control">
            </asp:TextBox>

        </div>


        <!-- Species -->

        <div class="form-group">

            <asp:Label
                ID="lblSpecies"
                runat="server"
                Text="Species"
                CssClass="form-label">
            </asp:Label>

            <asp:TextBox
                ID="txtSpecies"
                runat="server"
                CssClass="input-control">
            </asp:TextBox>

        </div>


        <!-- Date of Birth -->

        <div class="form-group">

            <asp:Label
                ID="lblDOB"
                runat="server"
                Text="Date of Birth"
                CssClass="form-label">
            </asp:Label>

            <asp:TextBox
                ID="txtDOB"
                runat="server"
                CssClass="input-control"
                TextMode="Date">
            </asp:TextBox>

        </div>


        <!-- Gender -->

        <div class="form-group">

            <asp:Label
                ID="lblGenderTitle"
                runat="server"
                Text="Gender"
                CssClass="form-label">
            </asp:Label>

            <div class="gender-options">

                <label class="gender-option">

                    <asp:RadioButton
                        ID="rdbMale"
                        runat="server"
                        GroupName="Gender"
                        Text="Male" />

                </label>

                <label class="gender-option">

                    <asp:RadioButton
                        ID="rdbFemale"
                        runat="server"
                        GroupName="Gender"
                        Text="Female" />

                </label>

            </div>

        </div>


        <!-- Habitat -->

        <div class="form-group">

            <asp:Label
                ID="lblHabitat"
                runat="server"
                Text="Habitat Location"
                CssClass="form-label">
            </asp:Label>

            <asp:DropDownList
                ID="ddHabitat"
                runat="server"
                CssClass="input-control">

                <asp:ListItem
                    Text="-- Select Habitat --"
                    Value="">
                </asp:ListItem>

                <asp:ListItem
                    Text="Open Ocean Tank"
                    Value="Open Ocean Tank">
                </asp:ListItem>

                <asp:ListItem
                    Text="Coral Reef Display"
                    Value="Coral Reef Display">
                </asp:ListItem>

                <asp:ListItem
                    Text="Kelp Forest"
                    Value="Kelp Forest">
                </asp:ListItem>

                <asp:ListItem
                    Text="Tidal Touch Pool"
                    Value="Tidal Touch Pool">
                </asp:ListItem>

                <asp:ListItem
                    Text="Mangrove Estuary"
                    Value="Mangrove Estuary">
                </asp:ListItem>

            </asp:DropDownList>

        </div>


        <!-- Buttons -->

        <div class="btn-group">

            <asp:Button
                ID="btnUpdate"
                runat="server"
                Text="Save Changes"
                CssClass="btn btn-submit"
                OnClick="btnUpdate_Click" />

            <asp:Button
                ID="btnMenu"
                runat="server"
                Text="Cancel"
                CssClass="btn btn-back"
                CausesValidation="false"
                OnClick="btnMenu_Click" />

        </div>

    </asp:Panel>

</div>

</form> </body> </html>