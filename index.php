<!DOCTYPE html>
<html>
<head>
    <title>Simple PHP Form</title>
</head>
<body>
    <h2>Enter Your Name</h2>
    <form method="post" action="">
        <input type="text" name="username" placeholder="Type your name" required>
        <button type="submit">Submit</button>
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $name = htmlspecialchars($_POST['username']); // sanitize input
        echo "<h3>Hello, " . $name . "!</h3>";
    }
    ?>
</body>
</html>
