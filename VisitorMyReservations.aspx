<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitorMyReservations.aspx.cs" Inherits="AQUACORE_CMPG223.VisitorMyReservations" %><html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Reservations</title>
    <link rel ="website icon" type ="png" href ="BRZLogo.png" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        body { 
            margin:0; font-family:'Poppins',sans-serif; background:#f0fdf4; }
        .navbar { 
            background:#14532d; color:white; padding:14px; display:flex; align-items:center; }
        
        .menu-btn { 
            font-size:24px; cursor:pointer; margin-right:15px; }
        .welcome { 
            flex-grow:1; font-weight:600; }
        .sidebar { 
            height:100%; width:0; position:fixed; top:0; left:0; background:#1e293b; overflow-x:hidden; transition:0.3s; padding-top:60px; }
        .sidebar a { 
            padding:12px 24px; text-decoration:none; font-size:18px; color:#f1f5f9; display:block; transition:0.2s; }
        .sidebar a:hover { 
            background:#334155; }
        .content { 
            padding:30px; }
        h2 { 
            color:#14532d; margin-bottom:20px; }
        .grid { 
            width:100%; border-collapse:collapse; }
        .grid th, .grid td { 
            padding:12px; border:1px solid #ccc; text-align:center; }
        .btn-cancel { 
            background:#ef4444; color:white; padding:6px 12px; border:none; border-radius:6px; cursor:pointer; }
        .btn-ticket { 
            background:#3b82f6; color:white; padding:6px 12px; border:none; border-radius:6px; cursor:pointer; }
    </style>
    <script>
        function openMenu() { document.getElementById("mySidebar").style.width = "220px"; }
        function closeMenu() { document.getElementById("mySidebar").style.width = "0"; }
    </script>
</head>
<body>
<form id="form1" runat="server">
    <div class="navbar">
        <span class="menu-btn" onclick="openMenu()">&#9776;</span>
        <div class="welcome">📋 My Reservations</div>
    </div>

    <div id="mySidebar" class="sidebar">
        <a href="javascript:void(0)" onclick="closeMenu()">✖ Close</a>
        <a href="VisitorDashboard.aspx">Home</a>
        <a href="VisitorReservations.aspx">Book Tickets</a>
        <!--<a href="VisitorMyReservations.aspx">My Reservations</a>-->
        
        <asp:LinkButton ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" />
    </div>

    <div class="content">
        <h2>📋 Your Reservations</h2>

        <asp:GridView ID="gvReservations" runat="server" AutoGenerateColumns="False" CssClass="grid" DataKeyNames="ReservationID" OnRowCommand="gvReservations_RowCommand" OnRowDataBound="gvReservations_RowDataBound">
            <Columns>
                <asp:BoundField DataField="ReservationID" HeaderText="ID" />
                <asp:BoundField DataField="TicketType" HeaderText="Ticket Type" />
                <asp:BoundField DataField="VisitDate" HeaderText="Visit Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="NumTickets" HeaderText="Tickets" />
                <asp:BoundField DataField="TotalCost" HeaderText="Total (R)" DataFormatString="{0:F2}" />
                <asp:BoundField DataField="PaymentMethod" HeaderText="Payment" />
                <asp:BoundField DataField="Status" HeaderText="Status" />

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnTicket" runat="server" Text="View Ticket" CssClass="btn-ticket" CommandName="ViewTicket" CommandArgument='<%# Eval("ReservationID") %>' />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel" CommandName="CancelRes" CommandArgument='<%# Eval("ReservationID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
    </div>
</form>
</body>
</html>