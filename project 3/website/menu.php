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
        var offset=0;
        var filter=null;
        $(document).on("submit", "#form_search", function searchusers(e){
            e.preventDefault();
            filter=$(this).find("input[name=filter]").val();
            offset=0;
            executeUsersQuery();
        });
        function executeUsersQuery(){
            var data={type:"list_users", filter:filter, offset:offset};
            $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
                console.log(result);
                var json=$.parseJSON(result);
                if(json.length==0 && offset>0)
                    offset-=10;
                else
                    $("#user_list").html("");
                for(var i=0;i<json.length;i++){
                    var user=json[i];
                    var cell=$("#user_template").clone().removeAttr("id").show().appendTo($("#user_list"));
                    cell.data("email", user.email);
                    cell.find(".user_name").text(user.first_name+" "+user.last_name+" ("+user.email+")");
                }
            });
        }
        $(document).on("click", ".button_offset", function offsetResults(){
            var change=parseInt($(this).data("offset"));
            console.log(change);
            if(filter!=null && change>0 || (change<0 && offset>0)){
                offset+=change;
                executeUsersQuery();
            }
        });
        $(document).on("click", ".button_visit", function visitWall(){
            document.location.href="user.php?email="+$(this).closest(".user_cell").data("email");
        });
    </script>
</head>
<body>
<?php include "menubar.php"; ?>
<div align="center">
    <br>
    <form id="form_search">
        <input name="filter" placeholder="filter">&nbsp;
        <input type="submit" value="submit">
    </form>
    <div id="user_list">

    </div>
    <button class="button_offset" data-offset="-10">Previous results</button>
    <button class="button_offset" data-offset="10">Next results</button>
</div>
<div id="user_template" class="user_cell" style="display: none">
    <div class="user_name"></div>
    <button class="button_visit">Visit User Profile</button>
</div>
</body>
</html>
