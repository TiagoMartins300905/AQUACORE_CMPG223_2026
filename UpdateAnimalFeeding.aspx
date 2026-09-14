<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="UpdateAnimalFeeding.aspx.cs"
    Inherits="AQUACORE_CMPG223.UpdateAnimalFeeding" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - Update Feeding Schedule</title>

    <style>

        :root {
            --abyss-deep: #051329;
            --ocean-blue: #0b2545;
            --aqua-glow: #00d2ff;
            --card-glass: rgba(11, 37, 69, 0.75);
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
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
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
            border: 1px solid var(--card-border);
            border-radius: 16px;

            padding: 32px;

            width: 100%;
            max-width: 550px;

            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);

            backdrop-filter: blur(8px);
        }

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

        .form-group {
            margin-bottom: 16px;

            display: flex;
            flex-direction: column;
        }

        .divider {
            height: 1px;

            background: rgba(0, 210, 255, 0.2);

            margin: 24px 0;
        }

        .form-label {
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

        select.input-control option {
            background-color: #0b2545;
            color: #ffffff;
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
                0 5px 15px rgba(0, 210, 255, 0.25);
        }

        .btn-back {
            background: rgba(255, 255, 255, 0.08);

            color: var(--text-muted);

            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .btn-back:hover {
            background: rgba(255, 255, 255, 0.15);

            color: #ffffff;
        }

        .status-msg {
            display: block;

            margin-top: 16px;

            font-size: 0.9rem;

            font-weight: 600;

            text-align: center;

            color: var(--aqua-glow);
        }

        @media (max-width: 600px) {

            .form-card {
                padding: 24px;
            }

            .btn-group {
                flex-direction: column;
            }

        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="form-card">

        <!-- BACK BUTTON -->

        <div class="top-back">

            <asp:Button
                ID="btnTopBack"
                runat="server"
                Text="← Back"
                CssClass="top-back-btn"
                OnClick="btnBack_Click"
                CausesValidation="false" />

        </div>

        <!-- TITLE -->

        <h2>Modify Feeding Schedule</h2>

        <p>
            Select a feeding schedule from the dropdown below
            to load and update its aquarium feeding records.
        </p>

        <!-- SCHEDULE -->

        <div class="form-group">

            <asp:Label
                ID="lblSelectSchedule"
                runat="server"
                Text="Select Feeding Schedule to Edit"
                CssClass="form-label" />

            <asp:DropDownList
                ID="ddlScheduleID"
                runat="server"
                CssClass="input-control"
                AutoPostBack="True"
                OnSelectedIndexChanged="ddlScheduleID_SelectedIndexChanged">
            </asp:DropDownList>

        </div>

        <!-- MESSAGE -->

        <asp:Label
            ID="lblMessage"
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

                <asp:Label
                    ID="lblAnimal"
                    runat="server"
                    Text="Animal"
                    CssClass="form-label" />

                <asp:DropDownList
                    ID="ddlAnimal"
                    runat="server"
                    CssClass="input-control">
                </asp:DropDownList>

            </div>

            <!-- MARINE KEEPER -->

            <div class="form-group">

                <asp:Label
                    ID="lblKeeper"
                    runat="server"
                    Text="Marine Keeper"
                    CssClass="form-label" />

                <asp:DropDownList
                    ID="ddlKeeper"
                    runat="server"
                    CssClass="input-control">
                </asp:DropDownList>

            </div>

            <!-- FEEDING TIME -->

            <div class="form-group">

                <asp:Label
                    ID="lblTime"
                    runat="server"
                    Text="Feeding Time"
                    CssClass="form-label" />

                <asp:DropDownList
                    ID="ddlTime"
                    runat="server"
                    CssClass="input-control">

                    <asp:ListItem
                        Text="--Select a time--"
                        Value="" />

                    <asp:ListItem
                        Text="06:00 AM"
                        Value="06:00" />

                    <asp:ListItem
                        Text="07:00 AM"
                        Value="07:00" />

                    <asp:ListItem
                        Text="08:00 AM"
                        Value="08:00" />

                    <asp:ListItem
                        Text="09:00 AM"
                        Value="09:00" />

                    <asp:ListItem
                        Text="10:00 AM"
                        Value="10:00" />

                    <asp:ListItem
                        Text="11:00 AM"
                        Value="11:00" />

                    <asp:ListItem
                        Text="12:00 PM"
                        Value="12:00" />

                    <asp:ListItem
                        Text="01:00 PM"
                        Value="13:00" />

                    <asp:ListItem
                        Text="02:00 PM"
                        Value="14:00" />

                    <asp:ListItem
                        Text="03:00 PM"
                        Value="15:00" />

                    <asp:ListItem
                        Text="04:00 PM"
                        Value="16:00" />

                    <asp:ListItem
                        Text="05:00 PM"
                        Value="17:00" />

                    <asp:ListItem
                        Text="06:00 PM"
                        Value="18:00" />

                    <asp:ListItem
                        Text="07:00 PM"
                        Value="19:00" />

                    <asp:ListItem
                        Text="08:00 PM"
                        Value="20:00" />

                    <asp:ListItem
                        Text="09:00 PM"
                        Value="21:00" />

                </asp:DropDownList>

            </div>

            <!-- FOOD TYPE -->

            <div class="form-group">

                <asp:Label
                    ID="lblFoodType"
                    runat="server"
                    Text="Food Type"
                    CssClass="form-label" />

                <asp:DropDownList
                    ID="ddlFoodType"
                    runat="server"
                    CssClass="input-control">

                    <asp:ListItem
                        Text="--Select food type--"
                        Value="" />

                    <asp:ListItem
                        Text="Fish"
                        Value="Fish" />

                    <asp:ListItem
                        Text="Meat"
                        Value="Meat" />

                    <asp:ListItem
                        Text="Pellets"
                        Value="Pellets" />

                    <asp:ListItem
                        Text="Vegetables"
                        Value="Vegetables" />

                    <asp:ListItem
                        Text="Fruits"
                        Value="Fruits" />

                    <asp:ListItem
                        Text="Live Food"
                        Value="Live Food" />

                </asp:DropDownList>

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
