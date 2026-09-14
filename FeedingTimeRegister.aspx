<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedingTimeRegister.aspx.cs" Inherits="AQUACORE_CMPG223.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - Feeding Schedule</title>

    <style>

        :root {
            --abyss-deep: #051329;
            --ocean-blue: #0b2545;
            --aqua-glow: #00d2ff;
            --card-glass: rgba(11, 37, 69, 0.75);
            --card-border: rgba(0, 210, 255, 0.25);
            --text-primary: #eef4f8;
            --text-muted: #8da4be;
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

        .dashboard-container {

            width: 100%;

            max-width: 1000px;

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

            margin-bottom: 4px;
        }

        .header-title p {

            color: var(--text-muted);

            font-size: 0.95rem;
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

            transition: all 0.2s;
        }

        .btn-outline {

            background: rgba(255, 255, 255, 0.08);

            color: var(--text-primary);

            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .btn-outline:hover {

            background: rgba(255, 255, 255, 0.15);

            color: #ffffff;
        }

        /* Form Heading */

        .form-heading {

            margin-bottom: 25px;
        }

        .form-heading h2 {

            font-size: 1.4rem;

            color: var(--aqua-glow);

            margin-bottom: 5px;
        }

        .form-heading p {

            color: var(--text-muted);

            font-size: 0.9rem;
        }

        /* Form */

        .form-grid {

            display: grid;

            grid-template-columns: 180px 1fr;

            gap: 20px 25px;

            align-items: center;
        }

        .form-label {

            color: var(--text-primary);

            font-weight: 600;

            font-size: 0.95rem;
        }

        /* Dropdowns */

        .input-control {

            width: 100%;

            max-width: 500px;

            padding: 11px 14px;

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

        .input-control option {

            background: #0b2545;

            color: white;
        }

        /* Validators */

        .validator {

            color: #ff7b7b;

            font-size: 0.85rem;

            margin-left: 10px;
        }

        /* Buttons */

        .button-row {

            display: flex;

            gap: 12px;

            margin-top: 30px;

            justify-content: flex-end;
        }

        .btn-add {

            background:
                linear-gradient(
                    135deg,
                    #00d2ff,
                    #0077b6
                );

            color: #ffffff;
        }

        .btn-add:hover {

            opacity: 0.9;

            transform: translateY(-1px);
        }

        .btn-clear {

            background: rgba(255, 255, 255, 0.08);

            color: var(--text-primary);

            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .btn-clear:hover {

            background: rgba(255, 255, 255, 0.15);
        }

        /* Message */

        .message {

            display: block;

            margin-top: 20px;

            padding: 12px;

            border-radius: 8px;

            color: var(--aqua-glow);

            background: rgba(0, 210, 255, 0.08);

            border: 1px solid rgba(0, 210, 255, 0.15);

            text-align: center;

            font-weight: 600;
        }

        /* Mobile */

        @media (max-width: 700px) {

            body {

                padding: 20px 10px;
            }

            .glass-panel {

                padding: 22px;
            }

            .form-grid {

                grid-template-columns: 1fr;

                gap: 8px;
            }

            .input-control {

                max-width: 100%;
            }

            .button-row {

                flex-direction: column;
            }

            .button-row input {

                width: 100% !important;
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
                    Feeding Schedule Management
                </p>

            </div>

            <div>

                <asp:Button
                    ID="btnBack"
                    runat="server"
                    Text="← Go Back"
                    CssClass="btn btn-outline"
                    CausesValidation="false"
                    OnClick="btnBack_Click" />

            </div>

        </div>


        <!-- FEEDING SCHEDULE FORM -->

        <div class="glass-panel">

            <div class="form-heading">

                <h2>Add Feeding Schedule</h2>

                <p>
                    Assign an animal, marine keeper, feeding time and food type.
                </p>

            </div>


            <div class="form-grid">

                <!-- ANIMAL -->

                <asp:Label
                    ID="lblAnimal"
                    runat="server"
                    Text="Animal:"
                    CssClass="form-label" />

                <div>

                    <asp:DropDownList
                        ID="ddlAnimal"
                        runat="server"
                        CssClass="input-control">

                        <asp:ListItem
                            Text="--Select Animal--"
                            Value="">
                        </asp:ListItem>

                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1"
                        runat="server"
                        ControlToValidate="ddlAnimal"
                        ErrorMessage="Please select an animal!"
                        InitialValue=""
                        ValidationGroup="ScheduleValidation"
                        CssClass="validator">
                    </asp:RequiredFieldValidator>

                </div>


                <!-- KEEPER -->

                <asp:Label
                    ID="lblKeeper"
                    runat="server"
                    Text="Marine Keeper:"
                    CssClass="form-label" />

                <div>

                    <asp:DropDownList
                        ID="ddlKeeper"
                        runat="server"
                        CssClass="input-control">

                        <asp:ListItem
                            Text="--Select Keeper--"
                            Value="">
                        </asp:ListItem>

                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator2"
                        runat="server"
                        ControlToValidate="ddlKeeper"
                        ErrorMessage="Please select a keeper!"
                        InitialValue=""
                        ValidationGroup="ScheduleValidation"
                        CssClass="validator">
                    </asp:RequiredFieldValidator>

                </div>


                <!-- FEEDING TIME -->

                <asp:Label
                    ID="lblTime"
                    runat="server"
                    Text="Feeding Time:"
                    CssClass="form-label" />

                <div>

                    <asp:DropDownList
                        ID="ddlTime"
                        runat="server"
                        CssClass="input-control">

                        <asp:ListItem
                            Text="--Select a time--"
                            Value="">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="06:00 AM"
                            Value="06:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="07:00 AM"
                            Value="07:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="08:00 AM"
                            Value="08:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="09:00 AM"
                            Value="09:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="10:00 AM"
                            Value="10:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="11:00 AM"
                            Value="11:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="12:00 PM"
                            Value="12:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="01:00 PM"
                            Value="13:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="02:00 PM"
                            Value="14:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="03:00 PM"
                            Value="15:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="04:00 PM"
                            Value="16:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="05:00 PM"
                            Value="17:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="06:00 PM"
                            Value="18:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="07:00 PM"
                            Value="19:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="08:00 PM"
                            Value="20:00">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="09:00 PM"
                            Value="21:00">
                        </asp:ListItem>

                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator3"
                        runat="server"
                        ControlToValidate="ddlTime"
                        ErrorMessage="Please add a feeding time!"
                        InitialValue=""
                        ValidationGroup="ScheduleValidation"
                        CssClass="validator">
                    </asp:RequiredFieldValidator>

                </div>


                <!-- FOOD TYPE -->

                <asp:Label
                    ID="foodTypelbl"
                    runat="server"
                    Text="Food Type:"
                    CssClass="form-label" />

                <div>

                    <asp:DropDownList
                        ID="ddlFoodType"
                        runat="server"
                        CssClass="input-control">

                        <asp:ListItem
                            Text="--Select food type--"
                            Value="">
                        </asp:ListItem>

                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator4"
                        runat="server"
                        ControlToValidate="ddlFoodType"
                        ErrorMessage="Please add a food type!"
                        InitialValue=""
                        ValidationGroup="ScheduleValidation"
                        CssClass="validator">
                    </asp:RequiredFieldValidator>

                </div>

            </div>


            <!-- MESSAGE -->

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>


            <!-- BUTTONS -->

            <div class="button-row">

                <asp:Button
                    ID="btnAdd"
                    runat="server"
                    Text="Add Schedule"
                    CssClass="btn btn-add"
                    ValidationGroup="ScheduleValidation" OnClick="btnAdd_Click" />

                <asp:Button
                    ID="btnClear"
                    runat="server"
                    Text="Clear"
                    CssClass="btn btn-clear"
                    CausesValidation="false"
                    OnClick="btnClear_Click" />

            </div>

        </div>

    </div>

</form>

</body>

</html>
