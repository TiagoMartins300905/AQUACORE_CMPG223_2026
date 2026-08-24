<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorReservations.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorReservations" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Book Tickets</title>
    
    <link rel="website icon" type="png" href="BRZLogo.png" />
   
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        body{ 
            margin:0; font-family:'Poppins',sans-serif; background:#f0fdf4; }
        .navbar{ 
            background:#B1FFFF; color:white; padding:14px; display:flex; align-items:center; }
        .menu-btn{ 
            font-size:24px; cursor:pointer; margin-right:15px; }
        .sidebar{ 
            height:100%; width:0; position:fixed; top:0; left:0; background:#1e293b; overflow-x:hidden; transition:0.3s; padding-top:60px; }
        
        .sidebar a, .sidebar asp\:LinkButton{ padding:12px 24px; text-decoration:none; font-size:18px; color:#f1f5f9; display:block; transition:0.2s; }
        .sidebar a:hover{ 
            background:#334155; }
        
        .content{ 
            padding:30px; text-align:center; }
        .box{ 
            background:#fff; max-width:500px; margin:auto; padding:26px; border-radius:14px; box-shadow:0 4px 12px rgba(0,0,0,0.2); }
        
        label{ 
            font-weight:600; display:block; margin-top:10px; text-align:left; }
        select,input{ 
            width:100%; padding:10px; border:1px solid #ccc; border-radius:8px; margin-top:6px; }
        
        .total{ 
            margin-top:12px; font-weight:700; color:#14532d; }
        .btn{ 
            width:100%; padding:12px; margin-top:16px; background:#3b82f6; color:white; border:none; border-radius:10px; font-weight:600; cursor:pointer; }
        .btn:hover{ 
            background:#2563eb; }
        
        .msg{ 
            margin-top:12px; font-weight:600; }
    </style>
    <script type="text/javascript">
        function openMenu() { document.getElementById("mySidebar").style.width = "220px"; }
        function closeMenu() { document.getElementById("mySidebar").style.width = "0"; }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="navbar">
            <span class="menu-btn" onclick="openMenu()">&#9776;</span>
            <div>Book Your Visit</div>
        </div>

        
        <div id="mySidebar" class="sidebar">
            <a href="javascript:void(0)" onclick="closeMenu()">Close</a>
            <a href="VisitorDashboard.aspx">Home</a>
            <a href="VisitorMyReservations.aspx">My Reservations</a>
            
            <asp:LinkButton ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" />
        </div>

        <div class="content">
            <div class="box">
                <h2>Reserve Your Tickets</h2>

                <label>Ticket Type</label>
                <asp:DropDownList ID="ddlTicketType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Recalculate">
                    <asp:ListItem Text="Adult - R150" Value="150"></asp:ListItem>
                    <asp:ListItem Text="Child - R100" Value="100"></asp:ListItem>
                    <asp:ListItem Text="Family Pass - R400" Value="400"></asp:ListItem>
                    <asp:ListItem Text="Group (10+) - R1000" Value="1000"></asp:ListItem>
                </asp:DropDownList>

                <label>Visit Date</label>
                <asp:Calendar ID="calVisitDate" runat="server" OnDayRender="calVisitDate_DayRender"></asp:Calendar>

                <label>Number of Tickets</label>
                <asp:TextBox ID="txtTickets" runat="server" TextMode="Number" AutoPostBack="true" OnTextChanged="Recalculate" placeholder="Enter number of tickets" />
                <asp:RequiredFieldValidator ID="rfvTickets" runat="server" ControlToValidate="txtTickets" ErrorMessage="Number of tickets required" ForeColor="Red" Display="Dynamic" />
                <asp:RangeValidator ID="rvTickets" runat="server" ControlToValidate="txtTickets" MinimumValue="1" MaximumValue="20" Type="Integer" ErrorMessage="Enter tickets between 1 and 20" ForeColor="Red" Display="Dynamic" />

                <label>Payment Method</label>
                <asp:DropDownList ID="ddlPayment" runat="server">
                    <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
                    <asp:ListItem Text="Credit/Debit Card" Value="Card"></asp:ListItem>
                    <asp:ListItem Text="EFT" Value="EFT"></asp:ListItem>
                </asp:DropDownList>

                <div class="total">Total Cost: <asp:Label ID="lblTotal" runat="server" Text="R0"></asp:Label></div>

                <asp:Button ID="btnReserve" runat="server" Text="Confirm Booking" CssClass="btn" OnClick="btnReserve_Click" />

                <div class="msg"><asp:Label ID="lblMsg" runat="server" /></div>
            </div>
        </div>
    </form>
</body>
</html>