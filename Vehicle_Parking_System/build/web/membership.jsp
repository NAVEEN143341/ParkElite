<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Membership Page</title>
    
    <link rel="apple-touch-icon" href="https://i.imgur.com/QRAUqs9.png">
<link rel="shortcut icon" href="https://i.imgur.com/QRAUqs9.png">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/normalize.css@8.0.0/normalize.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/pixeden-stroke-7-icon@1.2.3/pe-icon-7-stroke/dist/pe-icon-7-stroke.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.2.0/css/flag-icon.min.css">
<link rel="stylesheet" href="assets/css/cs-skin-elastic.css">
<link rel="stylesheet" href="assets/css/style.css">

<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800'
	rel='stylesheet' type='text/css'>

    
    <link rel="stylesheet" href="styles.css">
    <script>
        function redirectToPayment() {
            window.location.href = "payment.jsp";
        }
    </script>
</head>
<body>

    <jsp:include page="includes/user-sidebar.jsp"></jsp:include>

	<jsp:include page="includes/user-header.jsp"></jsp:include>
        
        
        
        
        
    
    <div class="membership-container">
        <h1>Membership Details</h1>

        <%
            // Simulating user data (In real scenarios, fetch from the database)
            String memberName = "Raghu Vamsi"; // Replace with the actual member's name

            // Database connection using JDBC directly
            String dbUrl = "jdbc:mysql://localhost:3306/vpmsdb";
            String dbUsername = "root"; // Replace with your DB username
            String dbPassword = ""; // Replace with your DB password

            Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // Query to fetch the membership details for the specific member
            String selectQuery = "SELECT membership_card_number, membership_expiry FROM membership_card WHERE member_name = ?";
            PreparedStatement stmt = conn.prepareStatement(selectQuery);
            stmt.setString(1, memberName);  // Set the member name dynamically

            // Execute the query
            ResultSet rs = stmt.executeQuery();

            // Process the result
            if (rs.next()) {
                String cardNumber = rs.getString("membership_card_number");
                String expiryDateStr = rs.getString("membership_expiry");

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date expiryDate = null;

                // Parse the expiry date
                if (expiryDateStr != null) {
                    expiryDate = sdf.parse(expiryDateStr);
                }
                java.util.Date today = new java.util.Date(); // Corrected to java.util.Date

                // Check if the membership has expired
                boolean isExpired = expiryDate != null && expiryDate.before(today);
        %>

        <!-- Display Membership Information -->
        <div class="membership-card">
            <div class="member-info">
                <p><strong>Name:</strong> <%= memberName %></p>
                <p><strong>Membership Card Number:</strong> <%= cardNumber %></p>
                <p><strong>Membership Expiry Date:</strong> <%= new SimpleDateFormat("MMM dd, yyyy").format(expiryDate) %></p>
            </div>

            <!-- Conditional Display Based on Expiry -->
            <%
                if (isExpired) {
            %>
            <div class="membership-expired">
                <p style="color: red;">Your membership has expired. Please renew it to continue enjoying benefits.</p>
                <button onclick="redirectToPayment()">Renew Membership</button>
            </div>
            <%
                } else {
            %>
            <div class="membership-active">
                <p style="color: green;">Your membership is active. Thank you for staying with us!</p>
            </div>
            <br/>
            <!--<button><a href="user-dashboard.jsp">Go Back</a></button>-->
            <%
                }

                // Close the database connection
                conn.close();
            }
        %>
        </div>
    </div>

    <div class="clearfix"></div>

	<!--<jsp:include page="includes/footer.jsp"></jsp:include>-->

	</div>
	<!-- /#right-panel -->

	<!-- Right Panel -->

	<!-- Scripts -->
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery-match-height@0.7.2/dist/jquery.matchHeight.min.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>