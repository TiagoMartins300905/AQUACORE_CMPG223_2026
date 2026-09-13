<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="View_Feeding.aspx.cs"
    Inherits="AQUACORE_CMPG223.View_Feeding" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AquaCore - View Feeding Schedules</title>

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

            max-width: 1100px;

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

            color: var(--aqua-glow);

            margin-bottom: 5px;
        }

        .page-heading p {

            color: var(--text-muted);

            font-size: 0.9rem;
        }

        /* Sorting Controls */

        .controls-panel {

            display: flex;

            align-items: end;

            gap: 25px;

            flex-wrap: wrap;

            margin-bottom: 25px;
        }

        .control-group {

            display: flex;

            flex-direction: column;

            gap: 8px;
        }

        .control-label {

            color: var(--text-primary);

            font-size: 0.9rem;

            font-weight: 600;
        }

        /* Dropdown */

        .input-control {

            min-width: 230px;

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

        .input-control option {

            background: #0b2545;

            color: white;
        }

        /* Radio Buttons */

        .radio-group {

            display: flex;

            gap: 18px;

            align-items: center;

            min-height: 40px;
        }

        .radio-group label {

            color: var(--text-primary);

            cursor: pointer;

            font-size: 0.9rem;
        }

        .radio-group input {

            accent-color: var(--aqua-glow);
        }

        /* Table */

        .table-responsive {

            width: 100%;

            overflow-x: auto;

            border-radius: 10px;

            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .aqua-grid {

            width: 100%;

            border-collapse: collapse;

            font-size: 0.9rem;

            text-align: left;
        }

        .aqua-grid th {

            background: rgba(0, 210, 255, 0.1);

            color: var(--aqua-glow);

            padding: 14px;

            font-weight: 600;

            border-bottom:
                1px solid var(--card-border);

            text-transform: uppercase;

            font-size: 0.8rem;

            letter-spacing: 0.5px;
        }

        .aqua-grid td {

            padding: 14px;

            border-bottom:
                1px solid rgba(255, 255, 255, 0.05);

            color: var(--text-primary);
        }

        .aqua-grid tr:hover td {

            background: rgba(255, 255, 255, 0.03);
        }

        /* Bottom Button */

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

            .controls-panel {

                flex-direction: column;

                align-items: stretch;
            }

            .input-control {

                width: 100%;

                min-width: 0;
            }

            .radio-group {

                flex-wrap: wrap;
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


            <!-- View Feeding Schedules -->

            <div class="glass-panel">

                <div class="page-heading">

                    <h2>View Feeding Schedules</h2>

                    <p>
                        View, sort and filter all existing feeding schedules.
                    </p>

                </div>


                <!-- Controls -->

                <div class="controls-panel">


                    <!-- Sort -->

                    <div class="control-group">

                        <asp:Label
                            ID="lblSort"
                            runat="server"
                            Text="Sort By:"
                            CssClass="control-label" />

                        <asp:DropDownList
                            ID="DropDownList1"
                            runat="server"
                            CssClass="input-control">

                            <asp:ListItem>
                                --Select Sort--
                            </asp:ListItem>

                        </asp:DropDownList>

                    </div>


                    <!-- Filter -->

                    <div class="control-group">

                        <asp:Label
                            ID="lblFilter"
                            runat="server"
                            Text="Order:"
                            CssClass="control-label" />

                        <div class="radio-group">

                            <asp:RadioButton
                                ID="rdoASC"
                                runat="server"
                                Text="Ascending"
                                GroupName="SortOrder" />

                            <asp:RadioButton
                                ID="rdoDESC"
                                runat="server"
                                Text="Descending"
                                GroupName="SortOrder" />

                        </div>

                    </div>


                </div>


                <!-- Feeding Table -->

                <div class="table-responsive">

                    <asp:GridView
                        ID="GridView1"
                        runat="server"
                        CssClass="aqua-grid"
                        GridLines="None">

                    </asp:GridView>

                </div>


                <!-- Bottom Back Button -->

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
