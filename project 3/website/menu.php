<?php
session_start();
if(!isset($_SESSION['authenticated']))
    header("Location: index.php");
?>
<html>
<head>
    <script type="text/javascript" src="jquery-3.2.0.min.js"></script>
    <style type="text/css">
        .user_cell{
            margin:5px;
            border-style: solid;
            border-color: black;
            border-width: 2px;
            padding-bottom: 2px;
        }
        .user_cell .user_name{
            color:blue;
        }
    </style>
    <script>
        $(document).ready(function ready(){
            var data={type:"list_users"};
            $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
                console.log(result);
                var json=$.parseJSON(result);
                for(var i=0;i<json.length;i++){
                    var user=json[i];
                    var cell=$("#user_template").clone().removeAttr("id").show().appendTo($("#user_list"));
                    cell.data("email", user.email);
                    cell.find(".user_name").text(user.first_name+" "+user.last_name+" ("+user.email+")");
                }
            });
        });
        $(document).on("click", ".button_visit", function visitWall(){
            document.location.href="user.php?email="+$(this).closest(".user_cell").data("email");
        });
    </script>
</head>
<body>
<?php include "menubar.php"; ?>
<div align="center" id="user_list">
</div>
<div id="user_template" class="user_cell" style="display: none">
    <div class="user_name"></div>
    <button class="button_visit">Visit User Profile</button>
</div>
</body>
</html>
