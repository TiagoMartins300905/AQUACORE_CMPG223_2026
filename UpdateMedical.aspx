<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="UpdateMedical.aspx.cs"
    Inherits="AQUACORE_CMPG223.UpdateMedical" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - Update Medical Record</title>

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

            --medical-red: #ff6b7a;
            --medical-red-dark: #d9364a;
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

        .form-card {

            background: var(--card-glass);

            border:
                1px solid var(--card-border);

            border-radius: 16px;

            padding: 32px;

            width: 100%;

            max-width: 550px;

            box-shadow:
                0 10px 30px rgba(0, 0, 0, 0.35);

            position: relative;
        }

        /* Top Back Button */

        .top-back {

            margin-bottom: 20px;
        }

        .top-back-btn {

            padding: 8px 14px;

            border-radius: 8px;

            font-weight: 600;

            font-size: 0.9rem;

            cursor: pointer;

            border:
                1px solid rgba(255, 255, 255, 0.15);

            background:
                rgba(255, 255, 255, 0.08);

            color: var(--text-muted);

            transition: all 0.2s ease;
        }

        .top-back-btn:hover {

            background:
                rgba(255, 255, 255, 0.15);

            color: #ffffff;
        }

        .form-card h2 {

            font-size: 1.8rem;

            margin-bottom: 8px;

            color: #ffffff;
        }

        .form-card > p {

            color: var(--text-muted);

            font-size: 0.95rem;

            margin-bottom: 20px;

            line-height: 1.5;
        }

        .medical-badge {

            display: inline-block;

            margin-bottom: 24px;

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

        .form-group {

            margin-bottom: 16px;

            display: flex;

            flex-direction: column;
        }

        .divider {

            height: 1px;

            background:
                rgba(0, 210, 255, 0.2);

            margin: 24px 0;
        }

        label {

            font-size: 0.85rem;

            font-weight: 600;

            color: var(--aqua-glow);

            margin-bottom: 6px;

            text-transform: uppercase;

            letter-spacing: 0.5px;
        }

        .input-control {

            width: 100%;

            padding: 10px 14px;

            border-radius: 8px;

            border:
                1px solid rgba(0, 210, 255, 0.25);

            background:
                rgba(5, 19, 41, 0.6);

            color: #ffffff;

            font-size: 0.95rem;

            outline: none;

            transition: all 0.2s ease;
        }

        .input-control:focus {

            border-color:
                var(--aqua-glow);

            box-shadow:
                0 0 8px rgba(0, 210, 255, 0.3);
        }

        .input-control:disabled {

            background:
                rgba(255, 255, 255, 0.05);

            color: var(--text-muted);

            cursor: not-allowed;
        }

        select.input-control option {

            background-color:
                #0b2545;

            color: #ffffff;
        }

        .radio-container {

            display: flex;

            gap: 25px;

            align-items: center;
        }

        .radio-option {

            color:
                var(--text-primary);

            font-size: 0.95rem;

            cursor: pointer;
        }

        .radio-option input {

            accent-color:
                var(--aqua-glow);
        }

        .status-msg {

            display: block;

            margin-top: 16px;

            font-size: 0.9rem;

            font-weight: 600;

            text-align: center;
        }

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
                0 5px 15px
                rgba(0, 210, 255, 0.2);
        }

        .btn-back {

            background:
                rgba(255, 255, 255, 0.08);

            color:
                var(--text-muted);

            border:
                1px solid rgba(255, 255, 255, 0.15);
        }

        .btn-back:hover {

            background:
                rgba(255, 255, 255, 0.15);

            color: #ffffff;
        }

        @media (max-width: 700px) {

            body {

                padding: 20px 10px;
            }

            .form-card {

                padding: 22px;
            }

            .btn-group {

                flex-direction: column;
            }

            .btn {

                width: 100%;
            }

            .radio-container {

                gap: 15px;
            }

        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="form-card">

        <!-- TOP BACK BUTTON -->

        <div class="top-back">

            <asp:Button
                ID="btnTopBack"
                runat="server"
                Text="← Back"
                CssClass="top-back-btn"
                OnClick="btnBack_Click"
                CausesValidation="false" />

        </div>


        <!-- PAGE HEADING -->

        <h2>
            Modify Medical Record
        </h2>


        <p>
            Select a medical record from the dropdown below
            to load and update its veterinary information.
        </p>


        <!-- MEDICAL BADGE -->

        <div class="medical-badge">

            🩺 Animal Health &amp; Veterinary Care

        </div>


        <!-- MEDICAL RECORD SELECTION -->

        <div class="form-group">

            <label>
                Select Medical Record to Edit
            </label>

            <asp:DropDownList
                ID="ddlMedical"
                runat="server"
                CssClass="input-control"
                AutoPostBack="True"
                OnSelectedIndexChanged="ddlMedical_SelectedIndexChanged">

            </asp:DropDownList>

        </div>


        <!-- STATUS -->

        <asp:Label
            ID="lblStatus"
            runat="server"
            CssClass="status-msg">
        </asp:Label>


        <!-- EDIT FORM -->

        <asp:Panel
            ID="pnlEditForm"
            runat="server"
            Visible="False">

            <div class="divider"></div>


            <!-- ANIMAL -->

            <div class="form-group">

                <label>
                    Animal
                </label>

                <asp:DropDownList
                    ID="ddlAnimal"
                    runat="server"
                    CssClass="input-control">

                </asp:DropDownList>

            </div>


            <!-- VETERINARIAN -->

            <div class="form-group">

                <label>
                    Veterinarian Name
                </label>

                <asp:TextBox
                    ID="txtVet"
                    runat="server"
                    CssClass="input-control"
                    placeholder="Enter veterinarian name">
                </asp:TextBox>

            </div>


            <!-- CHECK-UP DATE -->

            <div class="form-group">

                <label>
                    Date of Check-Up
                </label>

                <asp:TextBox
                    ID="txtCheckUp"
                    runat="server"
                    CssClass="input-control"
                    TextMode="Date">
                </asp:TextBox>

            </div>


            <!-- FOLLOW-UP -->

            <div class="form-group">

                <label>
                    Follow-Up Required?
                </label>

                <div class="radio-container">

                    <asp:RadioButton
                        ID="rdbYes"
                        runat="server"
                        GroupName="FollowUp"
                        Text="Yes"
                        CssClass="radio-option" />

                    <asp:RadioButton
                        ID="rdbNo"
                        runat="server"
                        GroupName="FollowUp"
                        Text="No"
                        CssClass="radio-option" />

                </div>

            </div>


            <!-- BUTTONS -->

            <div class="btn-group">

                <asp:Button
                    ID="btnUpdate"
                    runat="server"
                    Text="Save Changes"
                    CssClass="btn btn-submit"
                    OnClick="btnUpdate_Click" />

                <asp:Button
                    ID="btnBack"
                    runat="server"
                    Text="Cancel"
                    CssClass="btn btn-back"
                    CausesValidation="false"
                    OnClick="btnBack_Click" />

            </div>

        </asp:Panel>

    </div>

</form>

</body>

</html>
