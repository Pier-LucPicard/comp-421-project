<html>
<head>
    <script src="jquery-3.2.0.min.js"></script>
    <script>
        $(document).ready(function ready(){
            $("#form_signup input[name=birthday]").val('2000-01-01');
        });
        $(document).on("click", "#terms", function displayTerms(){
            alert("I agree that all my data will be sent to the NSA. I agree that this is the free version of the application, " +
                "and therefore the visibility of every wall is public.");
        });
        $(document).on("submit", "#form_signup", function signup(e){
            e.preventDefault();
            if(verifyForm()){
                var data=$(this).serialize()+"&type=signup";
                console.log(data);
                $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
                    console.log("result "+result);
                    var json=$.parseJSON(result);
                    if(json.success){
                        document.location.href="user.php?email=<?php echo $_SESSION['email']; ?>";
                    }else{
                        alert(json.info);
                    }
                });
            }
        });
        function verifyForm() {
            if (!$("#form_signup .check_agree").is(":checked"))
                alert("You need to agree with the terms and conditions!");
            else if ($("#form_signup input[name=password]").val() != $("#form_signup .repeat_password").val())
                alert("Your passwords do not match.");
            else if(!/^[a-zA-Z0-9\-_]{6,}$/.test($("#form_signup input[name=password]").val()))
                alert("Password must be 6 characters long and can only contain letters, numbers, hyphens and underscores.");
            else return true;
            return false;
        }
        $(document).on("change", "#form_signup .check_location", function toggleLocation(){
            if($(this).is(":checked")){
                $("#form_signup input[name=city]").removeAttr("disabled");
                $("#form_signup input[name=country]").removeAttr("disabled");
            }else{
                $("#form_signup input[name=city]").attr("disabled", "");
                $("#form_signup input[name=country]").attr("disabled", "");
            }
        });
    </script>
</head>
<body>
<div align="center">
    <form id="form_signup" style="display: inline">
        <input name="first_name" placeholder="First name" maxlength="50" required><br>
        <input name="last_name" placeholder="Last name" maxlength="50" required><br>
        <input type="radio" name="gender" value="m" checked="true">Male<br>
        <input type="radio" name="gender" value="f">Female<br>
        <input type="date" name="birthday" required><br>
        <input type="checkbox" class="check_location" checked="checked">Share location<br>
        <input name="city" placeholder="City" maxlength="50" required><br>
        <input name="country" placeholder="Country" maxlength="50" required><br>
        <input type="email" name="email" placeholder="Email" maxlength="320" required><br>
        <input type="password" name="password" placeholder="Password" maxlength="20" required><br>
        <input type="password" class="repeat_password" placeholder="Repeat password" maxlength="20" required><br>
        <input type="checkbox" class="check_agree">I agree with the <a id="terms" href="#">Terms and Conditions</a><br>
        <input type="submit" value="Sign Up">
    </form>
    <a href="index.php"><button>Back to login</button></a>
</div>
</body>
</html>