<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Update_Animal.aspx.cs" Inherits="AQUACORE_CMPG223.Update_Animal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - Update Animal</title>

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

            flex-direction: column;

            align-items: center;

            padding: 40px 20px;
        }

        /* Main Container */

        .dashboard-container {

            width: 100%;

            max-width: 900px;

            display: flex;

            flex-direction: column;

            gap: 24px;
        }

        /* Glass Panels */

        .glass-panel {

            background: var(--card-glass);

            border: 1px solid var(--card-border);

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

            background: rgba(0, 210, 255, 0.08);

            border: 1px solid rgba(0, 210, 255, 0.2);

            color: #8eeaff;

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

            text-align: center;

            transition: all 0.2s ease;
        }

        .btn-outline {

            background: rgba(255, 255, 255, 0.08);

            color: var(--text-primary);

            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .btn-outline:hover {

            background: rgba(255, 255, 255, 0.15);

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

        /* Form */

        .animal-form {

            display: grid;

            grid-template-columns: 1fr 1fr;

            gap: 22px;
        }

        .form-group {

            display: flex;

            flex-direction: column;

            gap: 8px;

            padding: 20px;

            background: rgba(5, 19, 41, 0.5);

            border: 1px solid rgba(0, 210, 255, 0.15);

            border-radius: 12px;

            transition: all 0.2s ease;
        }

        .form-group:hover {

            border-color: rgba(0, 210, 255, 0.35);

            background: rgba(0, 210, 255, 0.04);
        }

        .field-label {

            color: #ffffff;

            font-size: 0.9rem;

            font-weight: 600;
        }

        .field-description {

            color: var(--text-muted);

            font-size: 0.78rem;

            margin-bottom: 3px;
        }

        /* Inputs */

        .input-control {

            width: 100%;

            padding: 11px 13px;

            border-radius: 8px;

            border: 1px solid rgba(0, 210, 255, 0.2);

            background: rgba(5, 19, 41, 0.8);

            color: #ffffff;

            font-size: 0.9rem;

            outline: none;

            transition: all 0.2s ease;
        }

        .input-control:focus {

            border-color: var(--aqua-glow);

            box-shadow:
                0 0 0 3px rgba(0, 210, 255, 0.08);
        }

        .input-control::placeholder {

            color: #617993;
        }

        /* Date */

        input[type="date"] {

            color-scheme: dark;

            cursor: pointer;
        }

        input[type="date"]::-webkit-calendar-picker-indicator {

            filter: invert(1);

            cursor: pointer;

            opacity: 0.85;
        }

        input[type="date"]::-webkit-calendar-picker-indicator:hover {

            opacity: 1;
        }

        /* Dropdown */

        .dropdown-control {

            width: 100%;

            padding: 11px 13px;

            border-radius: 8px;

            border: 1px solid rgba(0, 210, 255, 0.2);

            background: rgba(5, 19, 41, 0.8);

            color: #ffffff;

            font-size: 0.9rem;

            outline: none;

            cursor: pointer;
        }

        .dropdown-control:focus {

            border-color: var(--aqua-glow);

            box-shadow:
                0 0 0 3px rgba(0, 210, 255, 0.08);
        }

        /* Gender */

        .gender-options {

            display: flex;

            gap: 12px;

            flex-wrap: wrap;

            margin-top: 3px;
        }

        .gender-option {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding: 10px 15px;

            border-radius: 8px;

            background: rgba(0, 210, 255, 0.05);

            border: 1px solid rgba(0, 210, 255, 0.15);

            color: var(--text-primary);

            cursor: pointer;
        }

        .gender-option:hover {

            background: rgba(0, 210, 255, 0.10);

            border-color: rgba(0, 210, 255, 0.30);
        }

        .gender-option input {

            accent-color: var(--aqua-glow);
        }

        /* Validation / Output */

        .validator {

            color: var(--danger) !important;

            font-size: 0.78rem;

            line-height: 1.3;

            margin-top: 10px;

            display: block;

            text-align: center;
        }

        .gender-validator {

            margin-top: 5px;

            color: var(--danger) !important;

            font-size: 0.78rem;
        }

        /* Form Actions */

        .form-actions {

            grid-column: 1 / -1;

            display: flex;

            justify-content: center;

            gap: 15px;

            margin-top: 8px;

            padding-top: 25px;

            border-top: 1px solid rgba(255, 255, 255, 0.08);
        }

        .action-button {

            min-width: 170px;

            padding: 12px 20px;

            border-radius: 9px;

            background:
                linear-gradient(
                    135deg,
                    #00d2ff,
                    #0077b6
                );

            color: #ffffff;

            font-weight: 600;

            font-size: 0.9rem;

            border: none;

            cursor: pointer;

            transition: all 0.2s ease;
        }

        .action-button:hover {

            transform: translateY(-2px);

            box-shadow:
                0 6px 18px rgba(0, 210, 255, 0.25);
        }

        .menu-button {

            min-width: 170px;

            padding: 12px 20px;

            border-radius: 9px;

            background: rgba(255, 255, 255, 0.07);

            color: var(--text-primary);

            font-weight: 600;

            font-size: 0.9rem;

            border: 1px solid rgba(255, 255, 255, 0.17);

            cursor: pointer;

            transition: all 0.2s ease;
        }

        .menu-button:hover {

            background: rgba(255, 255, 255, 0.14);

            transform: translateY(-2px);
        }

        /* Animal Info */

        .animal-note {

            margin-top: 22px;

            padding: 15px 18px;

            border-radius: 10px;

            background: rgba(0, 210, 255, 0.05);

            border: 1px solid rgba(0, 210, 255, 0.12);

            color: var(--text-muted);

            font-size: 0.8rem;

            line-height: 1.5;

            text-align: center;
        }

        .animal-note span {

            color: #8eeaff;

            font-weight: 600;
        }

        /* Footer */

        .footer-note {

            text-align: center;

            color: var(--text-muted);

            font-size: 0.78rem;

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

            .animal-form {

                grid-template-columns: 1fr;
            }

            .form-actions {

                flex-direction: column;
            }

            .action-button,
            .menu-button {

                width: 100%;
            }

            .header-panel {

                align-items: flex-start;
            }

            .header-panel .btn {

                width: 100%;
            }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="dashboard-container">

        <!-- HEADER -->

        <div class="glass-panel header-panel">

            <div class="header-title">

                <h1>AquaCore Operations</h1>

                <p>
                    Animal Management
                </p>

                <div class="animal-badge">
                    🐠 Animal Profile &amp; Aquarium Records
                </div>

            </div>

            <div>

                <asp:Button
                    ID="btnTopMenu"
                    runat="server"
                    Text="← Animals Menu"
                    CssClass="btn btn-outline"
                    OnClick="btnMenu_Click"
                    CausesValidation="false" />

            </div>

        </div>


        <!-- UPDATE PANEL -->

        <div class="glass-panel">

            <div class="page-heading">

                <h2>Update Animal Details</h2>

                <p>
                    Enter the Animal ID and provide only the information
                    you want to change. Any field left blank will remain
                    unchanged.
                </p>

            </div>


            <div class="animal-form">


                <!-- Animal ID -->

                <div class="form-group">

                    <asp:Label
                        ID="Label1"
                        runat="server"
                        Text="Animal ID"
                        CssClass="field-label">
                    </asp:Label>

                    <span class="field-description">
                        Enter the ID of the animal you want to update.
                    </span>

                    <asp:TextBox
                        ID="txtID"
                        runat="server"
                        CssClass="input-control"
                        placeholder="Animal ID">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1"
                        runat="server"
                        ControlToValidate="txtID"
                        ErrorMessage="Animal ID cannot be empty!"
                        CssClass="validator"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>

                </div>


                <!-- Animal Name -->

                <div class="form-group">

                    <asp:Label
                        ID="Label2"
                        runat="server"
                        Text="Animal Name"
                        CssClass="field-label">
                    </asp:Label>

                    <span class="field-description">
                        Leave blank if you do not want to change the name.
                    </span>

                    <asp:TextBox
                        ID="txtName"
                        runat="server"
                        CssClass="input-control"
                        placeholder="New animal name">
                    </asp:TextBox>

                </div>


                <!-- Species -->

                <div class="form-group">

                    <asp:Label
                        ID="Label3"
                        runat="server"
                        Text="Species"
                        CssClass="field-label">
                    </asp:Label>

                    <span class="field-description">
                        Leave blank if you do not want to change the species.
                    </span>

                    <asp:TextBox
                        ID="txtSpecies"
                        runat="server"
                        CssClass="input-control"
                        placeholder="New animal species">
                    </asp:TextBox>

                </div>


                <!-- Date of Birth -->

                <div class="form-group">

                    <asp:Label
                        ID="Label4"
                        runat="server"
                        Text="Date of Birth"
                        CssClass="field-label">
                    </asp:Label>

                    <span class="field-description">
                        Leave blank if you do not want to change the DOB.
                    </span>

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
                        ID="Label5"
                        runat="server"
                        Text="Gender"
                        CssClass="field-label">
                    </asp:Label>

                    <span class="field-description">
                        Select a gender only if you want to change it.
                    </span>

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
                        ID="Label6"
                        runat="server"
                        Text="Habitat Location"
                        CssClass="field-label">
                    </asp:Label>

                    <span class="field-description">
                        Select a habitat only if you want to change it.
                    </span>

                    <asp:DropDownList
                        ID="ddHabitat"
                        runat="server"
                        CssClass="dropdown-control">

                        <asp:ListItem
                            Text="---Choose Habitat----"
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


                <!-- OUTPUT MESSAGE -->

                <div class="form-actions">

                    <asp:Button
                        ID="btnUpdate"
                        runat="server"
                        Text="Update Animal"
                        CssClass="action-button"
                        OnClick="btnUpdate_Click" />

                    <asp:Button
                        ID="btnMenu"
                        runat="server"
                        Text="Animals Menu"
                        CssClass="menu-button"
                        OnClick="btnMenu_Click"
                        CausesValidation="false" />

                </div>

                <asp:Label
                    ID="lblOutput"
                    runat="server"
                    CssClass="validator">
                </asp:Label>

            </div>


            <!-- Helpful Note -->

            <div class="animal-note">

                🐋 <span>Animal Care Record:</span>
                Enter only the information you want to change.
                Fields that are left blank will remain unchanged in
                the database.

            </div>

        </div>


        <div class="footer-note">

            AquaCore • Animal Management &amp; Aquarium Operations

        </div>

    </div>

</form>

</body>

</html>
