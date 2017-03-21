<?php
session_start();
if(!isset($_SESSION['authenticated']))
    header("Location: index.php");
$wall=isset($_GET['wall_id'])?intval($_GET['wall_id']):-1;
if($wall==0)
    $wall=-1;
?>
<html>
<head>
    <script type="text/javascript" src="jquery-3.2.0.min.js"></script>
    <style type="text/css">
        .post_cell{
            background-color: rgba(25, 44, 255, 0.51);
            margin: 5px;
            padding-bottom: 2px;
        }
        .post_cell .post_title{
            color: white;
            font-size: 15pt;
            border-bottom: brown;
        }
        .post_cell .div_comments{
            margin: 5px;
        }
        .comment_cell{
            border-style: solid;
            border-width: 2px;
            margin:2px;
            padding: 5px;
        }
        .comment_cell .comment_title{
            color:white;
        }
    </style>
</head>
<body>
<?php include "menubar.php"; ?>
<script>
    $(document).ready(function ready(){
        var data={type:"wall", wall_id:<?php echo $wall; ?>};
        $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
            console.log(result);
            var json=$.parseJSON(result);
            if(!json.success){
                $("body").html("");
                $("<div></div>").attr("align", "center").text("Invalid wall.").appendTo($("body"));
                return;
            }
            $("#wall_owner").text("Wall owner: "+json.wall.first_name+" "+json.wall.last_name+" ("+json.wall.email+")");
            $("#wall_description").text("Description: "+json.wall.descr);
            for(var i=0;i<json.posts.length;i++){
                insertPost(json.posts[i]);
            }
        });
    });
    $(document).on("click", ".post_show", function showComments(){
        var cell=$(this).closest(".post_cell");
        cell.find(".post_comments").toggle();
        $(this).text(cell.find(".post_comments").is(":visible")?"Hide":"Show");
    });
    $(document).on("submit", "#form_submit_post", function submitPost(e){
        e.preventDefault();
        var _this=$(this)[0];
        var data=$(this).serialize()+"&type=insert_post&wall_id="+<?php echo $wall; ?>;
        $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
            _this.reset();
            var json=$.parseJSON(result);
            json.comments=[];
            json.first_name="<?php echo $_SESSION['first_name']; ?>";
            json.last_name="<?php echo $_SESSION['last_name']; ?>";
            json.like=0;json.happy=0;json.sad=0;json.angry=0;json.excited=0;
            json.my_like=false;json.my_happy=false;json.my_sad=false;json.my_angry=0;json.my_excited=0;
            insertPost(json);
        });
    });
    $(document).on("submit", ".form_comment", function submitComment(e){
        e.preventDefault();
        var _this=$(this)[0];
        var cell=$(this).closest(".post_cell");
        var data=$(this).serialize()+"&type=insert_comment&pid="+$(this).closest(".post_cell").data("pid");
        $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
            _this.reset();
            var json=$.parseJSON(result);
            json.first_name="<?php echo $_SESSION['first_name']; ?>";
            json.last_name="<?php echo $_SESSION['last_name']; ?>";
            json.like=0;json.happy=0;json.sad=0;json.angry=0;json.excited=0;
            json.my_like=false;json.my_happy=false;json.my_sad=false;json.my_angry=0;json.my_excited=0;
            insertComment(json, cell);
        });
    });

    function insertPost(post){
        var cell=$("#post_template").clone().removeAttr("id").show();
        cell.data("like", post.like);
        cell.data("happy", post.happy);
        cell.data("angry", post.angry);
        cell.data("sad", post.sad);
        cell.data("excited", post.excited);
        cell.find(".check_like").prop("checked", post.my_like);
        cell.find(".check_happy").prop("checked", post.my_happy);
        cell.find(".check_sad").prop("checked", post.my_sad);
        cell.find(".check_angry").prop("checked", post.my_angry);
        cell.find(".check_excited").prop("checked", post.my_excited);
        cell.find(".post_title").text(post.first_name+" "+post.last_name+" - "+post.date.substring(0,19));
        cell.find(".post_content").text(post.text);
        cell.data("pid", post.pid);
        if(post.url!="")
            $("<a></a>").attr("href", post.url).text(post.url).appendTo(cell.find(".post_url"));
        cell.find(".header_comments").text(post.comments.length+" comments");
        for(var j=0;j<post.comments.length;j++){
            insertComment(post.comments[j], cell);
        }
        updateReactionCount(cell);
        $("#post_list").prepend(cell);
    }

    function updateReactionCount(cell){
        cell.find(".num_like").text(cell.data("like")+" Like");
        cell.find(".num_happy").text(cell.data("happy")+" Happy");
        cell.find(".num_sad").text(cell.data("sad")+" Sad");
        cell.find(".num_angry").text(cell.data("angry")+" Angry");
        cell.find(".num_excited").text(cell.data("excited")+" Excited");
    }

    function insertComment(comment, cell){
        var commentCell=$("#comment_template").clone().removeAttr("id").show();
        commentCell.data("like", comment.like);
        commentCell.data("happy", comment.happy);
        commentCell.data("angry", comment.angry);
        commentCell.data("sad", comment.sad);
        commentCell.data("excited", comment.excited);
        commentCell.data("cid", comment.cid);
        commentCell.find(".comment_title").text(comment.first_name+" "+comment.last_name+" - "+comment.time.substring(0,19));
        commentCell.find(".comment_text").text(comment.text);
        commentCell.find(".check_like").prop("checked", comment.my_like);
        commentCell.find(".check_happy").prop("checked", comment.my_happy);
        commentCell.find(".check_sad").prop("checked", comment.my_sad);
        commentCell.find(".check_angry").prop("checked", comment.my_angry);
        commentCell.find(".check_excited").prop("checked", comment.my_excited);
        commentCell.prependTo(cell.find(".post_comments"));
    }

    $(document).on("change", ".post_cell .div_post_reaction input[type=checkbox]", function reactPost(e){
        var checked=$(this).is(":checked");
        console.log("trigger);"+checked);
        var current=$(this);
        var cell=$(this).closest(".post_cell");
        if(checked){
            cell.find(".div_post_reaction :checkbox").each(function(){
                if($(this).attr("name")!=current.attr("name") && $(this).is(":checked")){
                    $(this).prop("checked", false);
                    cell.data($(this).attr("name"), cell.data($(this).attr("name"))-1);
                }
            });
        }
        var count=parseInt(cell.data($(this).attr("name")));
        cell.data($(this).attr("name"), checked?count+1:count-1);
        var name=$(this).attr("name");
        var data={type:"react_post", reaction:name, pid:cell.data("pid")};
        if(!$(this).is(":checked"))
            data["delete"]=true;
        $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
            updateReactionCount(cell);
        });
    });

    $(document).on("change", ".comment_cell .div_comment_reaction input[type=checkbox]", function reactComment(e){
        var checked=$(this).is(":checked");
        var current=$(this);
        var cell=$(this).closest(".comment_cell");
        if(checked){
            cell.find(".div_comment_reaction input[type=checkbox]").each(function(){
                if($(this).attr("name")!=current.attr("name") && $(this).is(":checked")){
                    $(this).prop("checked", false);
                    cell.data($(this).attr("name"), cell.data($(this).attr("name"))-1);
                }
            });
        }
        var count=parseInt(cell.data($(this).attr("name")));
        cell.data($(this).attr("name"), checked?count+1:count-1);
        var name=$(this).attr("name");
        var data={type:"react_comment", reaction:name, cid:cell.data("cid")};
        if(!$(this).is(":checked"))
            data["delete"]=true;
        $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
            updateReactionCount(cell);
        });
    });

</script>
<div align="center">
    <div id="wall_owner"></div>
    <div id="wall_description"></div>
    <form id="form_submit_post">
        <input name="url" maxlength="2000" placeholder="Link (optional)"><br>
        <textarea name="text" placeholder="Your post..." maxlength="2000" required></textarea><br>
        <input type="submit" value="Post">
    </form>
</div>
<div align="center" id="post_list">

</div>
<div id="post_template" class="post_cell" style="display: none">
    <div class="post_title"></div>
    <div class="post_url"></div>
    <div class="post_content"></div>
    <div class="div_post_reaction">
        <input type="checkbox" name="like" class="check_like"><span class="num_like">0 Like</span>
        <input type="checkbox" name="happy" class="check_happy"><span class="num_happy">0 Happy</span>
        <input type="checkbox" name="sad" class="check_sad"><span class="num_sad">0 Sad</span>
        <input type="checkbox" name="angry" class="check_angry"><span class="num_angry">0 Angry</span>
        <input type="checkbox" name="excited" class="check_excited""><span class="num_excited">0 Excited</span>
    </div>
    <div class="div_comments">
        <div align="center">
            <form class="form_comment">
                <input name="text" placeholder="My comment" maxlength="500" required><input type="submit" class="button_comment" value="Comment">
            </form>
            <div class="header_comments" style="display: inline-block"></div>&nbsp;<button class="post_show">Show</button>
        </div>
        <div class="post_comments" style="display: none"></div>
    </div>
</div>
<div id="comment_template" class="comment_cell" style="display: none">
    <div class="comment_title"></div>
    <div class="comment_text"></div>
    <div class="div_comment_reaction">
        <input type="checkbox" name="like" class="check_like"><span class="num_like">0 Like</span>
        <input type="checkbox" name="happy" class="check_happy"><span class="num_happy">0 Happy</span>
        <input type="checkbox" name="sad" class="check_sad"><span class="num_sad">0 Sad</span>
        <input type="checkbox" name="angry" class="check_angry"><span class="num_angry">0 Angry</span>
        <input type="checkbox" name="excited" class="check_excited"><span class="num_excited">0 Excited</span>
    </div>
</div>
</body>
</html>
