<html>
<!-- This page is to create a user account -->
<head>

    <link rel="stylesheet" href="./material.min.css">
    <script src="./material.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <script src="jquery-3.2.0.min.js"></script>
    <script>
        $(document).ready(function ready() {
            $("#form_signup input[name=birthday]").val('2000-01-01');
        });

        //Display terms and conditions of website
        $(document).on("click", "#terms", function displayTerms() {
            alert("I agree that all my data will be sent to the NSA. I agree that this is the free version of the application, " +
            "and therefore the visibility of every wall is public.");
        });

        //Send signup query, and go to user.php if signup is successfull
        $(document).on("submit", "#form_signup", function signup(e) {
            e.preventDefault();
            if (verifyForm()) {
                var email = $(this).find("input[name=email]").val();
                var data = $(this).serialize() + "&type=signup";
                console.log(data);
                $.ajax({method: "POST", url: "queries.php", data: data}).done(function (result) {
                    console.log("result " + result);
                    var json = $.parseJSON(result);
                    if (json.success) {
                        document.location.href = "user.php?email=" + email;
                    } else {
                        alert(json.info);
                    }
                });
            }
        });

        //Verify if the information in the signup form has the correct format
        function verifyForm() {
            if (!$("#form_signup .check_agree").is(":checked"))
                alert("You need to agree with the terms and conditions!");
            else if ($("#form_signup input[name=password]").val() != $("#form_signup .repeat_password").val())
                alert("Your passwords do not match.");
            else if (!/^[a-zA-Z0-9\-_]{6,}$/.test($("#form_signup input[name=password]").val()))
                alert("Password must be 6 characters long and can only contain letters, numbers, hyphens and underscores.");
            else return true;
            return false;
        }

        //Toggle (enable or disable) the location fields in the signup form
        $(document).on("change", "#form_signup .check_location", function toggleLocation() {
            if ($(this).is(":checked")) {
                $("#form_signup input[name=city]").removeAttr("disabled");
                $("#form_signup input[name=country]").removeAttr("disabled");
                $("#form_signup input[name=city]").css("background", "");
                $("#form_signup input[name=country]").css("background", "");
            } else {
                $("#form_signup input[name=city]").attr("disabled", "");
                $("#form_signup input[name=city]").css("background", "lightgrey");
                $("#form_signup input[name=country]").attr("disabled", "");
                $("#form_signup input[name=country]").css("background", "lightgrey");
            }
        });
    </script>
</head>
<body>
<div align="center">
    <br>

    <div class="mdl-card mdl-shadow--4dp">
        <div class="mdl-card__title mdl-color--primary mdl-color-text--white" align="center">
            <h2 class="mdl-card__title-text" align="center">Sign Up</h2>
        </div>
        <form id="form_signup" style="display: inline">

            <div class="mdl-grid">
                <div class="mdl-textfield mdl-js-textfield mdl-cell mdl-cell--6-col">

                    <input class="mdl-textfield__input" name="first_name" maxlength="50" required>
                    <label class="mdl-textfield__label" for="sample1">First name</label>


                </div>
                <div class="mdl-textfield mdl-js-textfield mdl-cell mdl-cell--6-col">
                    <input class="mdl-textfield__input" name="last_name" maxlength="50" required>
                    <label class="mdl-textfield__label" for="sample1">Last name</label>
                </div>
            </div>

            <div>
                <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="option-1">
                    <input id="option-1" class="mdl-radio__button" type="radio" name="gender" value="m" checked>
                    <span class="mdl-radio__label">Male</span>
                </label>
                <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="option-2">
                    <input id="option-2" class="mdl-radio__button" type="radio" name="gender" value="f">
                    <span class="mdl-radio__label">Female</span>
                </label>
            </div>
            <div class="mdl-textfield mdl-js-textfield">
                <input class="" type="date" name="birthday" required><br>
            </div>
            <div align="center">
                <label style="display:inline" class="mdl-switch mdl-js-switch mdl-js-ripple-effect"
                       style="padding-left:40px" for="checkbox-1">
                    <span class="mdl-switch__label">Share location</span>
                    <input type="checkbox" id="checkbox-1" class="mdl-switch__input check_location" checked="checked">
                </label>
            </div>
            <div class="mdl-grid">
                <div class="mdl-textfield mdl-js-textfield  mdl-cell mdl-cell--6-col">
                    <input class="mdl-textfield__input" name="city" maxlength="50" required>
                    <label class="mdl-textfield__label">City</label>
                </div>
                <div class="mdl-textfield mdl-js-textfield  mdl-cell mdl-cell--6-col">
                    <input class="mdl-textfield__input" name="country" maxlength="50" required>
                    <label class="mdl-textfield__label">Country</label>
                </div>
            </div>
            <hr>
            <div class="mdl-textfield mdl-js-textfield">
                <input class="mdl-textfield__input" type="email" name="email" maxlength="320" required>
                <label class="mdl-textfield__label">Email</label>
            </div>
            <div class="mdl-textfield mdl-js-textfield">
                <input class="mdl-textfield__input" type="password" name="password" maxlength="20" required>
                <label class="mdl-textfield__label">Password</label>
            </div>
            <div class="mdl-textfield mdl-js-textfield">
                <input class="mdl-textfield__input repeat_password" type="password" name="password" maxlength="20"
                       required>
                <label class="mdl-textfield__label">Repeat password</label>
            </div>

            <div class="mdl-textfield mdl-js-textfield">
                <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="check_agree">
                    <input type="checkbox" id="check_agree" class="mdl-checkbox__input check_agree">
                    <span class="mdl-checkbox__label">I agree with the <a id="terms" href="#">Terms and
                            Conditions</a></span>
                </label>
            </div>
            <hr>
            <input class="mdl-button mdl-js-button  mdl-button--raised mdl-button--colored" type="submit"
                   value="Sign Up">
        </form>
        <a href="index.php">
            <button class="mdl-button mdl-js-button mdl-button--accent">Back to login</button>
        </a>
        <br>
    </div>
</div>
</body>
</html>