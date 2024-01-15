<?php

// Database configuration
$servername = "localhost";
$username = "id21712835_webhost";
$password = "MMaa55@@";
$database = "id21712835_supermarke";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the form is submitted and the necessary keys exist in $_POST
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['phone_number']) && isset($_POST['city']) && isset($_POST['street'])) {
    // Retrieve data from the request
    $phoneNumber = $_POST['phone_number'];
    $city = $_POST['city'];
    $street = $_POST['street'];

    // Insert data into the database (using prepared statement to prevent SQL injection)
    $stmt = $conn->prepare("INSERT INTO addresses (phone_number, city, street) VALUES (?, ?, ?)");
    $stmt->bind_param("iss", $phoneNumber, $city, $street); // 'iss' corresponds to integer, string, string
    $stmt->execute();

    if ($stmt->affected_rows > 0) {
        echo "Address added successfully";
    } else {
        echo "Failed to add address to the database";
    }

    $stmt->close();
} else {
    echo "Invalid form submission or missing data.";
}

$conn->close();

?>
