<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Status</title>
    <script>
        function redirectToPage(url) {
            setTimeout(() => {
                window.location.href = url;
            }, 3000); // Redirect after 3 seconds
        }
    </script>
</head>
<body>

    <div class="payment-container">
        <h1>Payment Status</h1>

        <%
            String paymentMethod = request.getParameter("paymentMethod");
            String errorMessage = "";
            boolean isValidPayment = false;

            // Validate payment based on selected method
            if ("creditCard".equals(paymentMethod)) {
                String cardNumber = request.getParameter("cardNumber");
                String expiryDate = request.getParameter("expiryDate");
                String cvv = request.getParameter("cvv");
                if ("4111111111111111".equals(cardNumber) && "12/2025".equals(expiryDate) && "123".equals(cvv)) {
                    isValidPayment = true;
                } else {
                    errorMessage = "Invalid Card Details.";
                }
            } else if ("upi".equals(paymentMethod)) {
                String upiId = request.getParameter("upiId");
                if ("test@upi".equals(upiId)) {
                    isValidPayment = true;
                } else {
                    errorMessage = "Invalid UPI ID.";
                }
            } else if ("netBanking".equals(paymentMethod)) {
                String accountNumber = request.getParameter("accountNumber");
                if (accountNumber != null && !accountNumber.isEmpty()) {
                    isValidPayment = true;
                } else {
                    errorMessage = "Invalid Net Banking details.";
                }
            }

            // If payment is valid, update membership expiry date in the database
            if (isValidPayment) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Calendar calendar = Calendar.getInstance();
                calendar.add(Calendar.YEAR, 1); // Extend membership by 1 year
                String newExpiryDate = sdf.format(calendar.getTime());

                try {
                    // Database connection
                    String dbURL = "jdbc:mysql://localhost:3306/vpmsdb";  // Your database URL
                    String dbUser = "root";  // Your database username
                    String dbPassword = "";  // Your database password

                    // Establish connection
                    Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String memberName = "Raghu Vamsi"; // Replace with the actual member's name (can be retrieved from session)

                    // Update membership expiry date in the database
                    String updateQuery = "UPDATE membership_card SET membership_expiry = ? WHERE member_name = ?";
                    PreparedStatement stmt = conn.prepareStatement(updateQuery);
                    stmt.setString(1, newExpiryDate);
                    stmt.setString(2, memberName);  // Update for the logged-in user

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.println("<div class='success-message' style='color: green;'>Payment Successful! Your membership has been renewed.</div>");
                        out.println("<p>New Expiry Date: " + newExpiryDate + "</p>");
                        out.println("<script>redirectToPage('membership.jsp');</script>");
                    } else {
                        out.println("<div class='error-message' style='color: red;'>Error updating membership details.</div>");
                        out.println("<script>redirectToPage('membership.jsp');</script>");
                    }
                    conn.close();
                } catch (SQLException e) {
                    out.println("<div class='error-message' style='color: red;'>Database connection error: " + e.getMessage() + "</div>");
                    out.println("<script>redirectToPage('membership.jsp');</script>");
                }
            } else {
                // Payment failed, display error message
                out.println("<div class='error-message' style='color: red;'>" + errorMessage + " If the money was deducted, it will be refunded.</div>");
                out.println("<script>redirectToPage('membership.jsp');</script>");
            }
        %>
    </div>

</body>
</html>