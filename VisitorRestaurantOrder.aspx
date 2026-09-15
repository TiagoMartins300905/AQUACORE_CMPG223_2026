<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorRestaurantOrder.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorRestaurantOrder" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Place Restaurant Order</title>
    <link rel="icon" type="image/png" href="BRZLogo.png" />
    <style>
        :root {
            --green-dark: #14532d;
            --teal: #0f766e;
            --text-muted: #5f7771;
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
        .main-container { max-width: 700px; margin: 0 auto; }
        .header {
            background: rgba(255, 255, 255, 0.80);
            border: 1px solid rgba(255, 255, 255, 0.85);
            border-radius: 20px;
            padding: 25px 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            margin-bottom: 25px;
            text-align: center;
        }
        .header h1 { color: var(--green-dark); font-size: 28px; }
        .header p { color: var(--teal); font-size: 14px; margin-top: 5px; font-style: italic; }
        .card {
            background: rgba(255, 255, 255, 0.78);
            border: 1px solid rgba(255, 255, 255, 0.85);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
        }
        label { display: block; font-weight: 600; margin-top: 15px; margin-bottom: 6px; color: var(--green-dark); }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #c9d8d4;
            border-radius: 10px;
            font-size: 15px;
            outline: none;
        }
        input:focus { border-color: var(--teal); box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.12); }
        .food-list { margin-top: 10px; }
        .food-list label { font-weight: 500; margin: 8px 0; color: #16352f; display: flex; align-items: center; gap: 8px; }
        .food-list input { width: auto; }
        .btn {
            width: 100%;
            padding: 14px;
            margin-top: 22px;
            background: linear-gradient(135deg, var(--teal), var(--green-dark));
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 8px 22px rgba(15, 118, 110, 0.25); }
        .btn-secondary {
            background: rgba(255, 255, 255, 0.7);
            color: var(--green-dark);
            border: 1px solid #c9d8d4;
            margin-top: 10px;
        }
        .btn-secondary:hover { background: white; box-shadow: none; }
        .msg { display: block; margin-top: 18px; padding: 14px; border-radius: 10px; font-weight: 600; text-align: center; }
        .msg-success { background: rgba(15, 118, 110, 0.10); color: var(--green-dark); border-left: 4px solid var(--teal); }
        .msg-error { background: rgba(220, 38, 38, 0.08); color: #b91c1c; border-left: 4px solid #dc2626; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-container">

            <div class="header">
                <h1>Place Your Restaurant Order</h1>
                <p>AquaCore • Restaurant Service</p>
            </div>

            <div class="card">
                <label>Table Number</label>
                <asp:TextBox ID="txtTable" runat="server" placeholder="Enter your table number" />

                <label>Quantity</label>
                <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" placeholder="Enter quantity" />

                <label>Select Food Items</label>
                <div class="food-list">
                    <asp:CheckBoxList ID="cblFooditems" runat="server">
                        <asp:ListItem Value="55">Burger — R55</asp:ListItem>
                        <asp:ListItem Value="85">Pizza — R85</asp:ListItem>
                        <asp:ListItem Value="65">Pasta — R65</asp:ListItem>
                        <asp:ListItem Value="25">Drink — R25</asp:ListItem>
                    </asp:CheckBoxList>
                </div>

                <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn" OnClick="btnPlaceOrder_Click" />
                <asp:Button ID="btnMyOrders" runat="server" Text="View My Orders" CssClass="btn btn-secondary" OnClick="btnMyOrders_Click" CausesValidation="false" />
                <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" CssClass="btn btn-secondary" OnClick="btnBack_Click" CausesValidation="false" />

                <asp:Label ID="lblMsg" runat="server" CssClass="msg" />
            </div>

        </div>
    </form>
</body>
</html>