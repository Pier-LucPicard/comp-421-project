<?php
session_start();
if(!isset($_SESSION['authenticated']))
    header("Location: index.php");
$email=isset($_GET['email'])?$_GET['email']:"";
?>
<html>
<head>
    <script src="jquery-3.2.0.min.js"></script>
    <script>
        var numWalls=0;
        $(document).ready(function(ready){
            var data={type:"user", email:"<?php echo $email; ?>"};
            $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
                console.log(result);
                var json=$.parseJSON(result);
                if(!json.success){
                    $("body").html("");
                    $("<div></div>").attr("align", "center").text("This user does not exist.").appendTo($("body"));
                }else{
                    var user=json.user;
                    $("#user_name").text("Name: "+user.first_name+" "+user.last_name);
                    $("#user_email").text("Email: "+user.email);
                    $("#user_birthday").text("Birthday: "+user.birthday.substr(0,19));
                    $("#user_gender").text(user.gender=='m'?"Male":"Female");
                    if(user.city=="" || user.city==null)
                        $("#user_location").text("This user has chosen not to disclose his location");
                    else $("#user_location").text("Location: "+user.city+", "+user.country);
                    var walls=user.walls;
                    var isMyWall=user.email=="<?php echo $_SESSION['email'] ?>";
                    if(isMyWall){
                        $("#my_profile").show();
                        $("#form_add_wall").show();
                    }
                    if(walls.length==0)
                        $("#wall_info").text("This user has no walls.");
                    else{
                        numWalls=walls.length;
                        $("#wall_info").text("Walls:");
                        for(var i=0;i<walls.length;i++){
                            var wall=walls[i];
                            var wallCell=$("#wall_cell_template").clone().removeAttr("id").show().data("wall_id", wall.wall_id).prependTo("#wall_list");
                            wallCell.find(".wall_link").attr("href", "wall.php?wall_id="+wall.wall_id).text(wall.descr);
                            if(!isMyWall)
                                wallCell.find(".wall_delete").hide();
                        }
                    }
                }
            });
        });
        $(document).on("submit", "#form_add_wall", function addWall(e){
            e.preventDefault();
            var _this=$(this);
            var descr=$("#form_add_wall textarea[name=descr]").val();
            var data={type:"insert_wall", descr:descr};
            console.log(data);
            $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
                var json=$.parseJSON(result);
                if(numWalls==0)
                    $("#wall_info").text("Walls:");
                numWalls++;
                var wallCell=$("#wall_cell_template").clone().removeAttr("id").show().data("wall_id", json.wall_id).prependTo("#wall_list");
                wallCell.find(".wall_link").attr("href", "wall.php?wall_id="+json.wall_id).text(descr);
                _this[0].reset();
            });
        });

        $(document).on("click", ".wall_delete", function deleteWall(){
            var _this=$(this);
            var data={type:"delete_wall", wall_id:$(this).closest(".wall_cell").data("wall_id")};
            $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
                console.log(result);
                _this.closest(".wall_cell").remove();
                numWalls--;
                if(numWalls==0)
                    $("#wall_info").text("This user has no walls.");
            });
            return;
        });

    </script>
    <style type="text/css">
        .wall_cell a{
            color:blue;
        }
        .wall_cell .wall_delete{
            color:red;
        }
        #my_profile{
            display: none;
            font-size: 20pt;
            color:gray;
        }
    </style>
</head>
<body>
<?php include "menubar.php"; ?>
<div id="wall_cell_template" class="wall_cell" style="display: none">
    <a class="wall_link"></a>
    <a class="wall_delete" href="#">Delete</a>
</div>
<div id="div_user" align="center">
    <div id="my_profile">My Profile</div>
    <div id="user_name"></div>
    <div id="user_email"></div>
    <div id="user_birthday"></div>
    <div id="user_gender"></div>
    <div id="user_location"></div>
    <form id="form_add_wall" style="display: none">
        <br>
        <textarea name="descr" placeholder="description" maxlength="500" required></textarea><br>
        <input type="submit" value="Create wall">
    </form>
    <div id="wall_info"></div>
    <div id="wall_list">

    </div>
</div>
</body>
</html>
