<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Page</title>
    <link rel="stylesheet" href="styles.css">
    <script>
        function updatePaymentFields() {
            var selectedMethod = document.getElementById("paymentMethod").value;

            // Reset all fields
            document.getElementById("enterAmount").style.display = "none";
            document.getElementById("cardDetails").style.display = "none";
            document.getElementById("upiDetails").style.display = "none";
            document.getElementById("netBankingDetails").style.display = "none";
            document.getElementById("upiId").style.display = "none";  // Hide UPI ID initially

            // Show "Enter Amount" and relevant payment fields
            if (selectedMethod) {
                document.getElementById("enterAmount").style.display = "block";

                if (selectedMethod === "creditCard") {
                    document.getElementById("cardDetails").style.display = "block";
                } else if (selectedMethod === "upi") {
                    document.getElementById("upiDetails").style.display = "block";
                } else if (selectedMethod === "netBanking") {
                    document.getElementById("netBankingDetails").style.display = "block";
                }
            }
        }

        function updateAmountBasedOnPlan() {
            var plan = document.getElementById("paymentPlan").value;
            var amountField = document.getElementById("amount");

            // Set the amount based on the selected plan
            if (plan === "1") {
                amountField.value = "100"; // 1 month plan
            } else if (plan === "3") {
                amountField.value = "250"; // 3 months plan
            } else if (plan === "6") {
                amountField.value = "450"; // 6 months plan
            } else if (plan === "12") {
                amountField.value = "800"; // 1 year plan
            }

            // Disable the amount input field to prevent manual changes
            amountField.disabled = true;
        }

        function showUPIIdField() {
            // Show UPI ID input field when a UPI provider is selected
            var upiProvider = document.querySelector('input[name="upiProvider"]:checked');
            if (upiProvider) {
                document.getElementById("upiId").style.display = "block"; // Show UPI ID input field
            } else {
                document.getElementById("upiId").style.display = "none"; // Hide UPI ID input field if no provider selected
            }
        }

        function showLoadingAndRedirect() {
            // Show the loading indicator
            document.getElementById("loading").style.display = "block";

            // Simulate loading delay (2-3 seconds) before redirecting
            setTimeout(() => {
                document.getElementById("paymentForm").submit();
            }, 2500);

            return false; // Prevent immediate form submission
        }

        function validatePaymentForm() {
            var selectedMethod = document.getElementById("paymentMethod").value;
            var amount = document.getElementById("amount");
            var cardNumber = document.getElementById("cardNumber");
            var expiryDate = document.getElementById("expiryDate");
            var cvv = document.getElementById("cvv");
            var upiId = document.getElementById("upiId");
            var upiProvider = document.querySelector('input[name="upiProvider"]:checked');
            var accountNumber = document.getElementById("accountNumber");
            var ifscCode = document.getElementById("ifscCode");
            var branchName = document.getElementById("branchName");

            // Validate Amount
            if (amount.value === "" || isNaN(amount.value) || parseFloat(amount.value) <= 0) {
                alert("Please enter a valid amount to pay.");
                return false;
            }

            // Validate Payment Method Fields
            if (selectedMethod === "creditCard") {
                if (cardNumber.value === "" || expiryDate.value === "" || cvv.value === "") {
                    alert("Please fill in all card details.");
                    return false;
                }
            } else if (selectedMethod === "upi") {
                if (upiId.value === "") {
                    alert("Please enter your UPI ID.");
                    return false;
                }
                if (!upiProvider) {
                    alert("Please select a UPI provider.");
                    return false;
                }
            } else if (selectedMethod === "netBanking") {
                if (accountNumber.value === "" || ifscCode.value === "" || branchName.value === "") {
                    alert("Please fill in all Net Banking details.");
                    return false;
                }
            }

            return showLoadingAndRedirect();
        }
    </script>
</head>
<body>

    <div class="payment-container">
        <h1>Make a Payment</h1>
        <form id="paymentForm" action="processPayment.jsp" method="post" onsubmit="return validatePaymentForm()">
            
            <!-- Payment Plan Selection -->
            <div>
                <label for="paymentPlan">Select Payment Plan:</label>
                <select id="paymentPlan" name="paymentPlan" onchange="updateAmountBasedOnPlan()">
                    <option value="">-- Select Plan --</option>
                    <option value="1">1 Month - $100</option>
                    <option value="3">3 Months - $250</option>
                    <option value="6">6 Months - $450</option>
                    <option value="12">1 Year - $800</option>
                </select>
            </div>

            <!-- Enter Amount -->
            <div id="enterAmount" class="hidden">
                <label for="amount">Enter Amount:</label>
                <input type="text" id="amount" name="amount" placeholder="Enter Amount to Pay" disabled>
            </div>

            <!-- Payment Method Selection -->
            <div>
                <label for="paymentMethod">Select Payment Method:</label>
                <select id="paymentMethod" name="paymentMethod" onchange="updatePaymentFields()">
                    <option value="">-- Select --</option>
                    <option value="creditCard">Credit/Debit Card</option>
                    <option value="upi">UPI</option>
                    <option value="netBanking">Net Banking</option>
                </select>
            </div>

            <!-- Credit Card Details -->
            <div id="cardDetails" class="hidden">
                <label for="cardNumber">Card Number:</label>
                <input type="text" id="cardNumber" name="cardNumber" placeholder="Enter Card Number" maxlength="19">
                
                <label for="expiryDate">Expiry Date (MM/YYYY):</label>
                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YYYY">

                <label for="cvv">CVV:</label>
                <input type="text" id="cvv" name="cvv" placeholder="Enter CVV" maxlength="3">
            </div>

            <!-- UPI Payment Details -->
            <div id="upiDetails" class="hidden">
                <label>Select UPI Provider:</label>
                <div>
                    <label>
                        <input type="radio" name="upiProvider" value="PhonePe" onchange="showUPIIdField()">
                         <img src="images/phonepe-logo.png" alt="PhonePe" style="width: 30px; height: 30px;"> PhonePe
                    </label>
                    <label>
                        <input type="radio" name="upiProvider" value="GooglePay" onchange="showUPIIdField()">
                        <img src="images/googlepay-logo.jpg" alt="Google Pay" style="width: 30px; height: 30px;"> Google Pay
                    </label>
                    <label>
                        <input type="radio" name="upiProvider" value="Paytm" onchange="showUPIIdField()">
                        <img src="images/paytm-logo.png" alt="Paytm" style="width: 30px; height: 30px;"> Paytm
                    </label>
                    <label>
                        <input type="radio" name="upiProvider" value="AmazonPay" onchange="showUPIIdField()">
                        <img src="images/amazonpay-logo.png" alt="Amazon Pay" style="width: 30px; height: 30px;"> Amazon Pay
                    </label>
                </div>

                <!-- UPI ID input field (visible only when a provider is selected) -->
                <div id="upiId" style="display:none;">
                    <label for="upiId">Enter UPI ID:</label>
                    <input type="text" id="upiId" name="upiId" placeholder="Enter UPI ID">
                </div>
            </div>

            <!-- Net Banking Payment Details -->
            <div id="netBankingDetails" class="hidden">
                <label for="accountNumber">Account Number:</label>
                <input type="text" id="accountNumber" name="accountNumber" placeholder="Enter Account Number">
                
                <label for="ifscCode">IFSC Code:</label>
                <input type="text" id="ifscCode" name="ifscCode" placeholder="Enter IFSC Code">
                
                <label for="branchName">Branch Name:</label>
                <input type="text" id="branchName" name="branchName" placeholder="Enter Branch Name">
            </div>

            <!-- Loading Indicator -->
            <div id="loading" class="hidden">
                <p>Please wait, verifying payment...</p>
                <img src="images/loading.gif" alt="Loading" style="width: 50px; height: 50px;">
            </div>

            <button type="submit">Pay Now</button>
        </form>
    </div>

</body>
</html>