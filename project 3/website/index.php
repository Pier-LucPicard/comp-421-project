<?php
session_start();
unset($_SESSION['authenticated']);
?>
<html>
<head>
    <script type="text/javascript" src="jquery-3.2.0.min.js"></script>
    <script type="text/javascript">
        $(document).on("submit", "#form_login", function login(e){
            e.preventDefault();
            var data=$(this).serialize()+"&type=login";
            $.ajax({
                type: "POST",
                url: "queries.php",
                data: data
            }).done(function(result){
                console.log(result);
                var json=$.parseJSON(result);
                if(json.success){
                    document.location.href="user.php?email=<?php echo $_SESSION['email']; ?>";
                }else alert(json.info);
            });
        });
    </script>
</head>
<body>
<div align="center">
    <form id="form_login" style="display: inline">
        <input type="email" name="email" placeholder="Email Address" maxlength="320" required><br>
        <input type="password" name="password" placeholder="Password" maxlength="20" required><br>
        <input type="hidden" name="type" value="login">
        <input type="submit" value="Login">
    </form>
    <a href="signup.php"><button>Sign Up</button></a>
</div>
</body>
</html>