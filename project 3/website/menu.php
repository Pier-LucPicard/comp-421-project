<?php
session_start();
if(!isset($_SESSION['authenticated']))
    header("Location: index.php");
?>
<html>
<head>
    <script type="text/javascript" src="jquery-3.2.0.min.js"></script>
    <style type="text/css">
        .wall_cell{
            margin:5px;
            border-style: solid;
            border-color: black;
            border-width: 2px;
            padding-bottom: 2px;
        }
        .wall_cell .wall_owner{
            color:blue;
        }
    </style>
    <script>
        $(document).ready(function ready(){
            var data={type:"list_walls"};
            $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
                console.log(result);
                var json=$.parseJSON(result);
                for(var i=0;i<json.length;i++){
                    var wall=json[i];
                    var cell=$("#wall_template").clone().removeAttr("id").show().appendTo($("#wall_list"));
                    cell.data("wall_id", wall.wall_id);
                    cell.find(".wall_owner").text(wall.first_name+" "+wall.last_name);
                    cell.find(".wall_description").text(wall.descr);
                }
            });
        });
        $(document).on("click", ".button_visit", function visitWall(){
            document.location.href="wall.php?wall_id="+$(this).closest(".wall_cell").data("wall_id");
        });
    </script>
</head>
<body>
<div align="center" id="wall_list">
</div>
<div id="wall_template" class="wall_cell" style="display: none">
    <div class="wall_owner"></div>
    <div class="wall_description"></div>
    <button class="button_visit">Visit Wall</button>
</div>
</body>
</html>
