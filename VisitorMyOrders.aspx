<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorMyOrders.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorMyOrders" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Orders</title>
    <link rel="icon" type="image/png" href="BRZLogo.png" />
    <style>
        :root {
            --green-dark: #14532d;
            --teal: #0f766e;
            --shadow: 0 10px 30px rgba(15, 118, 110, 0.14);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Arial, sans-serif; }
        body {
            min-height: 100vh;
            background:
                radial-gradient(circle at 10% 10%, rgba(34, 197, 94, 0.16), transparent 30%),
                radial-gradient(circle at 90% 90%, rgba(20, 184, 166, 0.16), transparent 30%),
                linear-gradient(135deg, #dffff8 0%, #c9f8ed 50%, #b8eee4 100%);
            padding: 35px 20px;
            color: #16352f;
        }
        .main-container { max-width: 950px; margin: 0 auto; }
        .header {
            background: rgba(255, 255, 255, 0.80);
            border-radius: 20px;
            padding: 25px 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            margin-bottom: 25px;
            text-align: center;
        }
        .header h1 { color: var(--green-dark); font-size: 26px; }
        .header p { color: var(--teal); font-size: 14px; margin-top: 5px; }
        .card {
            background: rgba(255, 255, 255, 0.78);
            border-radius: 20px;
            padding: 25px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            overflow-x: auto;
        }
        .grid { width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; }
        .grid th {
            background: var(--teal);
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: 600;
        }
        .grid td {
            padding: 11px 12px;
            border-bottom: 1px solid #e0e0e0;
            color: #16352f;
            font-size: 14px;
        }
        .grid tr:hover td { background: #e0ffff; }
        .btn {
            display: inline-block;
            padding: 12px 28px;
            margin-top: 20px;
            background: linear-gradient(135deg, var(--teal), var(--green-dark));
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 8px 22px rgba(15, 118, 110, 0.25); }
        .empty { text-align: center; padding: 30px; color: #5f7771; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-container">

            <div class="header">
                <h1>My Restaurant Orders</h1>
                <p>AquaCore • Your order history</p>
            </div>

            <div class="card">
                <asp:GridView ID="gvMyOrders" runat="server" CssClass="grid" AutoGenerateColumns="False" EmptyDataText="You haven't placed any orders yet.">
                    <Columns>
                        <asp:BoundField DataField="OrderID" HeaderText="Order #" />
                        <asp:BoundField DataField="FoodItems" HeaderText="Items" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                        <asp:BoundField DataField="TotalPrice" HeaderText="Total (R)" DataFormatString="{0:F2}" />
                        <asp:BoundField DataField="OrderDate" HeaderText="Date" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                    </Columns>
                </asp:GridView>

                <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" CssClass="btn" OnClick="btnBack_Click" />
            </div>

        </div>
    </form>
</body>
</html>