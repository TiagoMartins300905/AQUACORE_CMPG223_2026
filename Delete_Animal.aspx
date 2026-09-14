<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Delete_Animal.aspx.cs" Inherits="AQUACORE_CMPG223.Delete_Animal" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - Delete Animal</title>

    <style>

        :root {
            --abyss-deep: #051329;
            --ocean-blue: #0b2545;
            --aqua-glow: #00d2ff;

            --card-glass: rgba(11, 37, 69, 0.75);
            --card-border: rgba(0, 210, 255, 0.25);

            --text-primary: #eef4f8;
            --text-muted: #8da4be;

            --accent-danger: #ff4d4d;
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

            border: 1px solid rgba(255, 255, 255, 0.15);

            background: rgba(255, 255, 255, 0.08);

            color: var(--text-muted);

            transition: all 0.2s ease;
        }

        .top-back-btn:hover {

            background: rgba(255, 255, 255, 0.15);

            color: #ffffff;
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

        /* Form */

        .form-group {

            margin-bottom: 16px;

            display: flex;

            flex-direction: column;
        }

        /* Labels */

        label {

            font-size: 0.85rem;

            font-weight: 600;

            color: var(--aqua-glow);

            margin-bottom: 6px;

            text-transform: uppercase;

            letter-spacing: 0.5px;
        }

        /* Dropdown */

        .input-control {

            width: 100%;

            padding: 10px 14px;

            border-radius: 8px;

            border: 1px solid rgba(0, 210, 255, 0.25);

            background: rgba(5, 19, 41, 0.6);

            color: #ffffff;

            font-size: 0.95rem;

            outline: none;
        }

        .input-control:focus {

            border-color: var(--aqua-glow);

            box-shadow:
                0 0 8px rgba(0, 210, 255, 0.3);
        }

        select.input-control option {

            background-color: #0b2545;

            color: #ffffff;
        }

        /* Divider */

        .divider {

            height: 1px;

            background:
                rgba(255, 77, 77, 0.3);

            margin: 24px 0;
        }

        /* Warning */

        .warning-text {

            color: var(--accent-danger);

            font-size: 0.85rem;

            font-weight: 600;

            text-align: center;

            margin-bottom: 15px;

            line-height: 1.4;
        }

        /* Animal Details */

        .details-box {

            background:
                rgba(255, 77, 77, 0.05);

            border:
                1px solid rgba(255, 77, 77, 0.2);

            border-radius: 8px;

            padding: 16px;

            margin-bottom: 20px;
        }

        .detail-row {

            display: flex;

            justify-content: space-between;

            margin-bottom: 10px;

            font-size: 0.95rem;

            gap: 20px;
        }

        .detail-row:last-child {

            margin-bottom: 0;
        }

        .detail-label {

            color: var(--text-muted);
        }

        .detail-value {

            font-weight: 600;

            color: #ffffff;

            text-align: right;
        }

        /* Buttons */

        .btn-group {

            display: flex;

            gap: 12px;
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
        }

        /* Delete */

        .btn-danger {

            background:
                linear-gradient(
                    135deg,
                    #ff4d4d,
                    #c92a2a
                );

            color: #ffffff;
        }

        .btn-danger:hover {

            opacity: 0.9;

            box-shadow:
                0 0 12px rgba(255, 77, 77, 0.4);
        }

        /* Back */

        .btn-back {

            background:
                rgba(255, 255, 255, 0.08);

            color: var(--text-muted);

            border:
                1px solid rgba(255, 255, 255, 0.15);
        }

        .btn-back:hover {

            background:
                rgba(255, 255, 255, 0.15);

            color: #ffffff;
        }

        /* Status */

        .status-msg {

            display: block;

            margin-top: 16px;

            font-size: 0.9rem;

            font-weight: 600;

            text-align: center;
        }

        /* Mobile */

        @media (max-width: 600px) {

            .form-card {

                padding: 22px;
            }

            .btn-group {

                flex-direction: column;
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

    <div class="form-card">

        <!-- TOP BACK BUTTON -->

        <div class="top-back">

            <asp:Button
                ID="btnTopBack"
                runat="server"
                Text="← Back"
                CssClass="top-back-btn"
                OnClick="btnMenu_Click"
                CausesValidation="false" />

        </div>


        <h2>Delete Animal</h2>

        <p>
            Select an animal from the dropdown below to view its
            information before permanently deleting it.
        </p>


        <!-- Animal Selection -->

        <div class="form-group">

            <label>
                Select Animal to Delete
            </label>

            <asp:DropDownList
                ID="ddlAnimalID"
                runat="server"
                CssClass="input-control"
                AutoPostBack="True"
                OnSelectedIndexChanged="ddlAnimalID_SelectedIndexChanged">

            </asp:DropDownList>

        </div>


        <!-- Status -->

        <asp:Label
            ID="lblOutput"
            runat="server"
            CssClass="status-msg">
        </asp:Label>


        <!-- Confirmation Panel -->

        <asp:Panel
            ID="pnlConfirmForm"
            runat="server"
            Visible="False">

            <div class="divider"></div>


            <p class="warning-text">

                ⚠️ Are you sure you want to delete this animal?
                This action cannot be undone.

            </p>


            <!-- Animal Details -->

            <div class="details-box">

                <div class="detail-row">

                    <span class="detail-label">
                        Animal ID:
                    </span>

                    <asp:Label
                        ID="lblAnimalID"
                        runat="server"
                        CssClass="detail-value">
                    </asp:Label>

                </div>


                <div class="detail-row">

                    <span class="detail-label">
                        Name:
                    </span>

                    <asp:Label
                        ID="lblName"
                        runat="server"
                        CssClass="detail-value">
                    </asp:Label>

                </div>


                <div class="detail-row">

                    <span class="detail-label">
                        Species:
                    </span>

                    <asp:Label
                        ID="lblSpecies"
                        runat="server"
                        CssClass="detail-value">
                    </asp:Label>

                </div>


                <div class="detail-row">

                    <span class="detail-label">
                        Gender:
                    </span>

                    <asp:Label
                        ID="lblGender"
                        runat="server"
                        CssClass="detail-value">
                    </asp:Label>

                </div>


                <div class="detail-row">

                    <span class="detail-label">
                        Habitat:
                    </span>

                    <asp:Label
                        ID="lblHabitat"
                        runat="server"
                        CssClass="detail-value">
                    </asp:Label>

                </div>

            </div>


            <!-- Buttons -->

            <div class="btn-group">

                <asp:Button
                    ID="btnDeleteAnimal"
                    runat="server"
                    Text="Permanently Delete"
                    CssClass="btn btn-danger"
                    OnClick="btnDeleteAnimal_Click"
                    OnClientClick="return confirm('Final warning: Delete this animal?');" />

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

</form>

</body>

</html>
