<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add_Medical_R.aspx.cs" Inherits="AQUACORE_CMPG223.Add_Medical_R" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - Add Medical Record</title>

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

            --input-bg: rgba(5, 19, 41, 0.65);
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

            margin-bottom: 6px;
        }

        .header-title p {

            color: var(--text-muted);

            font-size: 0.95rem;
        }

        .medical-badge {

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

            margin-bottom: 6px;
        }

        .page-heading p {

            color: var(--text-muted);

            font-size: 0.9rem;

            line-height: 1.5;
        }

        /* Medical Form */

        .medical-form {

            display: flex;

            flex-direction: column;

            gap: 20px;
        }

        .form-row {

            display: grid;

            grid-template-columns: 200px 1fr;

            align-items: center;

            gap: 20px;

            padding: 16px;

            border-radius: 12px;

            background: rgba(5, 19, 41, 0.4);

            border: 1px solid rgba(0, 210, 255, 0.12);

            transition: all 0.2s ease;
        }

        .form-row:hover {

            border-color: rgba(0, 210, 255, 0.3);

            background: rgba(0, 210, 255, 0.04);
        }

        /* Labels */

        .field-label {

            color: var(--text-primary);

            font-size: 0.9rem;

            font-weight: 600;
        }

        .field-label::after {

            content: "";
        }

        /* Inputs */

        .input-control {

            width: 100%;

            padding: 11px 14px;

            border-radius: 8px;

            border: 1px solid rgba(0, 210, 255, 0.22);

            background: var(--input-bg);

            color: #ffffff;

            font-size: 0.9rem;

            outline: none;

            transition: all 0.2s ease;
        }

        .input-control:focus {

            border-color: var(--aqua-glow);

            box-shadow:
                0 0 10px rgba(0, 210, 255, 0.2);

            background: rgba(5, 19, 41, 0.8);
        }

        .input-control::placeholder {

            color: #607995;
        }

        /* Validation */

        .validator {

            color: var(--medical-red);

            font-size: 0.78rem;

            display: block;

            margin-top: 5px;
        }

        .input-area {

            width: 100%;
        }

        /* Radio Buttons */

        .radio-container {

            display: flex;

            align-items: center;

            gap: 20px;

            flex-wrap: wrap;
        }

        .radio-option {

            color: var(--text-primary);

            font-size: 0.9rem;

            cursor: pointer;
        }

        .radio-option input {

            accent-color: var(--aqua-glow);
        }

        .followup-warning {

            color: var(--medical-red);

            font-size: 0.78rem;

            margin-left: 5px;
        }

        /* Medical Icons */

        .field-icon {

            margin-right: 7px;

            opacity: 0.9;
        }

        /* Form Actions */

        .form-actions {

            display: flex;

            justify-content: flex-end;

            gap: 12px;

            margin-top: 10px;

            padding-top: 24px;

            border-top:
                1px solid rgba(255, 255, 255, 0.08);
        }

        .primary-button {

            min-width: 150px;

            padding: 11px 20px;

            border-radius: 8px;

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

        .primary-button:hover {

            transform: translateY(-1px);

            opacity: 0.92;

            box-shadow:
                0 5px 18px rgba(0, 210, 255, 0.25);
        }

        /* Back Button */

        .back-button {

            min-width: 150px;

            padding: 11px 20px;

            border-radius: 8px;

            background: rgba(255, 255, 255, 0.08);

            color: var(--text-primary);

            border:
                1px solid rgba(255, 255, 255, 0.16);

            font-weight: 600;

            font-size: 0.9rem;

            cursor: pointer;

            transition: all 0.2s ease;
        }

        .back-button:hover {

            background: rgba(255, 255, 255, 0.15);

            transform: translateY(-1px);
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

            .form-row {

                grid-template-columns: 1fr;

                gap: 10px;
            }

            .form-actions {

                flex-direction: column;
            }

            .primary-button,
            .back-button {

                width: 100%;
            }

            .header-panel {

                align-items: flex-start;
            }

            .header-panel .btn {

                width: 100%;
            }

            .radio-container {

                gap: 14px;
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
                        Animal Medical Records
                    </p>

                    <div class="medical-badge">
                        🩺 Animal Health &amp; Veterinary Care
                    </div>

                </div>

                <div>

                    <asp:Button
                        ID="btnTopBack"
                        runat="server"
                        Text="← Medicals Menu"
                        CssClass="btn btn-outline"
                        CausesValidation="false"
                        OnClick="btnBack_Click" />

                </div>

            </div>


            <!-- FORM PANEL -->

            <div class="glass-panel">

                <div class="page-heading">

                    <h2>➕ Add Medical Record</h2>

                    <p>
                        Enter the required information to create a medical
                        record for an animal in the AquaCore system.
                    </p>

                </div>


                <div class="medical-form">


                    <!-- Record ID -->

                    <div class="form-row">

                        <div class="field-label">
                            🆔 Record ID
                        </div>

                        <div class="input-area">

                            <asp:TextBox
                                ID="txtRecordID"
                                runat="server"
                                CssClass="input-control"
                                placeholder="Enter medical record ID">
                            </asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator1"
                                runat="server"
                                ControlToValidate="txtRecordID"
                                ErrorMessage="Record ID is required."
                                CssClass="validator"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>

                        </div>

                    </div>


                    <!-- Animal ID -->

                    <div class="form-row">

                        <div class="field-label">
                            🐠 Animal ID
                        </div>

                        <div class="input-area">

                            <asp:TextBox
                                ID="txtAnimalID"
                                runat="server"
                                CssClass="input-control"
                                placeholder="Enter the animal ID">
                            </asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator2"
                                runat="server"
                                ControlToValidate="txtAnimalID"
                                ErrorMessage="Animal ID is required."
                                CssClass="validator"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>

                        </div>

                    </div>


                    <!-- Veterinarian -->

                    <div class="form-row">

                        <div class="field-label">
                            🩺 Veterinarian Name
                        </div>

                        <div class="input-area">

                            <asp:TextBox
                                ID="txtVet"
                                runat="server"
                                CssClass="input-control"
                                placeholder="Enter veterinarian name">
                            </asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator3"
                                runat="server"
                                ControlToValidate="txtVet"
                                ErrorMessage="Veterinarian name is required."
                                CssClass="validator"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>

                        </div>

                    </div>


                    <!-- Check-Up Date -->

                    <div class="form-row">

                        <div class="field-label">
                            📅 Date of Check-Up
                        </div>

                        <div class="input-area">

                            <asp:TextBox
                                ID="txtCheckUp"
                                runat="server"
                                CssClass="input-control"
                                TextMode="Date">
                            </asp:TextBox>

                            <asp:RequiredFieldValidator
                                ID="RequiredFieldValidator4"
                                runat="server"
                                ControlToValidate="txtCheckUp"
                                ErrorMessage="Date of check-up is required."
                                CssClass="validator"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>

                        </div>

                    </div>


                    <!-- Follow Up -->

                    <div class="form-row">

                        <div class="field-label">
                            🔄 Follow-Up Required?
                        </div>

                        <div class="input-area">

                            <div class="radio-container">

                                <asp:RadioButton
                                    ID="rdbYes"
                                    runat="server"
                                    GroupName="FollowUp"
                                    Text="Yes"
                                    CssClass="radio-option"
                                    OnCheckedChanged="rdbYes_CheckedChanged" />

                                <asp:RadioButton
                                    ID="rdbNo"
                                    runat="server"
                                    GroupName="FollowUp"
                                    Text="No"
                                    CssClass="radio-option"
                                    OnCheckedChanged="rdbYes_CheckedChanged" />

                                <asp:Label
                                    ID="lblValidate"
                                    runat="server"
                                    CssClass="followup-warning"
                                    Text="Please choose an option">
                                </asp:Label>

                            </div>

                        </div>

                    </div>


                    <!-- ACTIONS -->

                    <div class="form-actions">

                        <asp:Button
                            ID="btnBack"
                            runat="server"
                            Text="← Medicals Menu"
                            CssClass="back-button"
                            CausesValidation="false"
                            OnClick="btnBack_Click" />

                        <asp:Button
                            ID="btnAdd"
                            runat="server"
                            Text="Add Medical Record"
                            CssClass="primary-button" />

                    </div>

                </div>

            </div>


            <!-- FOOTER -->

            <div class="footer-note">

                AquaCore • Animal Health &amp; Medical Records

            </div>


        </div>

    </form>

</body>

</html>
