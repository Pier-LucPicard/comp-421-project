<?php
session_start();
if (isset($_SESSION['authenticated']))
    unset($_SESSION['authenticated']);
?>
<html>
<!-- This is the login page-->
<head>
    <link rel="stylesheet" href="./material.min.css">
    <script src="./material.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <script type="text/javascript" src="jquery-3.2.0.min.js"></script>
    <script type="text/javascript">
        // Send the login query, and go to user.php if it succeeds
        $(document).on("submit", "#form_login", function login(e) {
            e.preventDefault();
            var data = $(this).serialize() + "&type=login";
            $.ajax({
                type: "POST",
                url: "queries.php",
                data: data
            }).done(function (result) {
                var json = $.parseJSON(result);
                if (json.success) {
                    document.location.href = "user.php?email=" + json.user.email;
                } else alert(json.info);
            });
        });
    </script>
</head>
<body>
<div align="center">
    <br>

    <div class="mdl-card mdl-shadow--6dp">
        <div class="mdl-card__title mdl-color--primary mdl-color-text--white">
            <div class="mdl-card__supporting-text">
                <span class="mdl-layout-title" style="color:white">Comp 421 Project 3</span>
            </div>


        </div>
        <br>

        <form id="form_login" class="">
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <input class="mdl-textfield__input" type="email" name="email" maxlength="320" required>
                <label class="mdl-textfield__label">Email Address</label>
            </div>
            <br>

            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <input class="mdl-textfield__input" type="password" name="password" maxlength="20" required>
                <label class="mdl-textfield__label">Password</label>
            </div>
            <br>
            <br>
            <input type="hidden" name="type" value="login">
            <input class="mdl-button mdl-js-button  mdl-button--raised mdl-button--colored" type="submit" value="Login">
        </form>
        <br>
        <a href="signup.php">
            <button class="mdl-button mdl-js-button mdl-button--accent">Sign Up</button>
        </a>
        <br>
    </div>

</div>


</body>
</html>