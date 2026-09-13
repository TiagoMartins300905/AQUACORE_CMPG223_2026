<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateAnimalFeeding.aspx.cs" Inherits="AQUACORE_CMPG223.UpdateAnimalFeeding" %>

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

            background: radial-gradient(
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

        /* Glass Panel */

        .glass-panel {

            background: var(--card-glass);

            border: 1px solid var(--card-border);

            border-radius: 16px;

            padding: 32px;

            box-shadow:
                0 10px 30px rgba(0, 0, 0, 0.35);
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

        .btn-add {

            background: linear-gradient(
                135deg,
                #00d2ff,
                #0077b6
            );

            color: #ffffff;
        }

        .btn-add:hover {

            opacity: 0.9;

            transform: translateY(-1px);

            box-shadow:
                0 5px 15px rgba(0, 210, 255, 0.2);
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

        /* Page Heading */

        .page-heading {

            margin-bottom: 25px;
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

        /* Schedule ID Section */

        .schedule-section {

            background: rgba(0, 210, 255, 0.05);

            border: 1px solid rgba(0, 210, 255, 0.18);

            border-radius: 12px;

            padding: 22px;

            margin-bottom: 25px;
        }

        .section-label {

            display: block;

            color: #ffffff;

            font-weight: 600;

            font-size: 0.95rem;

            margin-bottom: 10px;
        }

        .section-help {

            display: block;

            color: var(--text-muted);

            font-size: 0.85rem;

            margin-bottom: 15px;
        }

        /* Form Grid */

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

        /* Inputs */

        .input-control {

            width: 100%;

            max-width: 500px;

            padding: 11px 14px;

            border-radius: 8px;

            border: 1px solid rgba(0, 210, 255, 0.25);

            background: rgba(5, 19, 41, 0.65);

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

            color: #ffffff;
        }

        /* Validation */

        .validator {

            display: block;

            color: #ff7b7b;

            font-size: 0.85rem;

            margin-top: 8px;
        }

        /* Message */

        .message {

            display: block;

            margin-top: 25px;

            padding: 12px;

            border-radius: 8px;

            background: rgba(0, 210, 255, 0.07);

            border: 1px solid rgba(0, 210, 255, 0.15);

            color: var(--aqua-glow);

            text-align: center;

            font-weight: 600;

            min-height: 20px;
        }

        /* Buttons Row */

        .button-row {

            display: flex;

            justify-content: flex-end;

            gap: 12px;

            margin-top: 25px;
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

            .schedule-section {

                padding: 18px;
            }

            .button-row {

                flex-direction: column;
            }

            .button-row input {

                width: 100%;
            }
        }

    </style>

</head>

<body>

    <form id="form1" runat="server">

        <div class="dashboard-container">


            <!-- Header -->

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


            <!-- Update Form -->

            <div class="glass-panel">

                <div class="page-heading">

                    <h2>Update Feeding Schedule</h2>

                    <p>
                        Select an existing schedule and update its feeding details.
                    </p>

                </div>


                <!-- Schedule ID -->

                <div class="schedule-section">

                    <asp:Label
                        ID="lblHeading"
                        runat="server"
                        Text="Select a schedule ID to update:"
                        CssClass="section-label" />

                    <asp:Label
                        runat="server"
                        Text="Choose the feeding schedule you want to modify."
                        CssClass="section-help" />

                    <asp:DropDownList
                        ID="ddlScheduleID"
                        runat="server"
                        CssClass="input-control">

                        <asp:ListItem>
                            --Select a schedule ID--
                        </asp:ListItem>

                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1"
                        runat="server"
                        ControlToValidate="ddlScheduleID"
                        ErrorMessage="A schedule ID is required!"
                        InitialValue="--Select a schedule ID--"
                        ValidationGroup="UpdateValidation"
                        CssClass="validator" />

                </div>


                <!-- Feeding Details -->

                <div class="form-grid">


                    <!-- Animal -->

                    <asp:Label
                        ID="lblAnimal"
                        runat="server"
                        Text="Animal:"
                        CssClass="form-label" />

                    <asp:DropDownList
                        ID="ddlAnimal"
                        runat="server"
                        CssClass="input-control">

                        <asp:ListItem>
                            --Select Animal--
                        </asp:ListItem>

                    </asp:DropDownList>


                    <!-- Marine Keeper -->

                    <asp:Label
                        ID="lblKeeper"
                        runat="server"
                        Text="Marine Keeper:"
                        CssClass="form-label" />

                    <asp:DropDownList
                        ID="ddlKeeper"
                        runat="server"
                        CssClass="input-control">

                        <asp:ListItem>
                            --Select Keeper--
                        </asp:ListItem>

                    </asp:DropDownList>


                    <!-- Time -->

                    <asp:Label
                        ID="lblTime"
                        runat="server"
                        Text="Feeding Time:"
                        CssClass="form-label" />

                    <asp:DropDownList
                        ID="ddlTime"
                        runat="server"
                        CssClass="input-control">

                        <asp:ListItem>
                            --Select a time--
                        </asp:ListItem>

                    </asp:DropDownList>


                    <!-- Food -->

                    <asp:Label
                        ID="foodTypelbl"
                        runat="server"
                        Text="Food Type:"
                        CssClass="form-label" />

                    <asp:DropDownList
                        ID="ddlFoodType"
                        runat="server"
                        CssClass="input-control">

                        <asp:ListItem>
                            --Select food type--
                        </asp:ListItem>

                    </asp:DropDownList>

                </div>


                <!-- Message -->

                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="message" />


                <!-- Buttons -->

                <div class="button-row">

                    <asp:Button
                        ID="btnUpdate"
                        runat="server"
                        Text="✏️ Update Schedule"
                        CssClass="btn btn-add"
                        ValidationGroup="UpdateValidation" />

                    <asp:Button
                        ID="btnBackBottom"
                        runat="server"
                        Text="← Cancel"
                        CssClass="btn btn-outline"
                        CausesValidation="false"
                        OnClick="btnBack_Click" />

                </div>

            </div>

        </div>

    </form>

</body>

</html>
