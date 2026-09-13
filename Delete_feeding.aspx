<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveFeeding.aspx.cs" Inherits="AQUACORE_CMPG223.RemoveFeeding" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - Delete Feeding Schedule</title>

    <style>

        :root {
            --abyss-deep: #051329;
            --ocean-blue: #0b2545;
            --aqua-glow: #00d2ff;
            --card-glass: rgba(11, 37, 69, 0.75);
            --card-border: rgba(0, 210, 255, 0.25);
            --text-primary: #eef4f8;
            --text-muted: #8da4be;
            --danger: #ff5c6c;
            --danger-dark: #d9364a;
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

            color: var(--danger);

            margin-bottom: 6px;
        }

        .page-heading p {

            color: var(--text-muted);

            font-size: 0.9rem;

            line-height: 1.5;
        }

        /* Delete Box */

        .delete-box {

            max-width: 650px;

            margin: 0 auto;

            padding: 28px;

            background: rgba(255, 92, 108, 0.05);

            border: 1px solid rgba(255, 92, 108, 0.2);

            border-radius: 12px;

            text-align: center;
        }

        /* Warning Icon */

        .warning-icon {

            font-size: 2.5rem;

            margin-bottom: 12px;
        }

        /* Heading Label */

        .delete-heading {

            display: block;

            color: #ffffff;

            font-size: 1.05rem;

            font-weight: 600;

            margin-bottom: 15px;
        }

        /* Dropdown */

        .input-control {

            width: 100%;

            max-width: 500px;

            padding: 12px 14px;

            border-radius: 8px;

            border: 1px solid rgba(0, 210, 255, 0.25);

            background: rgba(5, 19, 41, 0.8);

            color: #ffffff;

            font-size: 0.95rem;

            outline: none;

            margin-bottom: 18px;
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

        /* Message */

        .message {

            display: block;

            min-height: 24px;

            margin: 10px 0 20px;

            color: var(--aqua-glow);

            font-size: 0.9rem;

            font-weight: 600;
        }

        /* Buttons */

        .button-row {

            display: flex;

            justify-content: center;

            gap: 12px;

            flex-wrap: wrap;
        }

        .btn-delete {

            background: linear-gradient(
                135deg,
                var(--danger),
                var(--danger-dark)
            );

            color: #ffffff;

            min-width: 120px;
        }

        .btn-delete:hover {

            opacity: 0.9;

            transform: translateY(-1px);

            box-shadow:
                0 5px 15px rgba(255, 92, 108, 0.25);
        }

        /* Bottom Navigation */

        .bottom-row {

            display: flex;

            justify-content: flex-end;

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

            .delete-box {

                padding: 22px;
            }

            .input-control {

                max-width: 100%;
            }

            .button-row {

                flex-direction: column;
            }

            .button-row input {

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
                        OnClick="btnBack_Click" />

                </div>

            </div>


            <!-- Delete Panel -->

            <div class="glass-panel">

                <div class="page-heading">

                    <h2>Delete Feeding Schedule</h2>

                    <p>
                        Select a feeding schedule below to permanently remove it
                        from the system.
                    </p>

                </div>


                <!-- Delete Box -->

                <div class="delete-box">

                    <div class="warning-icon">
                        ⚠️
                    </div>

                    <asp:Label
                        ID="lblHeading"
                        runat="server"
                        Text="Select a schedule ID to delete:"
                        CssClass="delete-heading" />


                    <asp:DropDownList
                        ID="DropDownList1"
                        runat="server"
                        CssClass="input-control">

                    </asp:DropDownList>


                    <!-- Status Message -->

                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        CssClass="message" />


                    <!-- Action Buttons -->

                    <div class="button-row">

                        <asp:Button
                            ID="btnDelete"
                            runat="server"
                            Text="🗑️ Delete"
                            CssClass="btn btn-delete"
                            OnClick="btnDelete_Click" />

                    </div>

                </div>


                <!-- Bottom Navigation -->

                <div class="bottom-row">

                    <asp:Button
                        ID="btnBackBottom"
                        runat="server"
                        Text="← Back"
                        CssClass="btn btn-outline"
                        OnClick="btnBack_Click" />

                </div>

            </div>

        </div>

    </form>

</body>

</html>
