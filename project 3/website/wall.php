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
      .post_cell {

      }
      
      .post_cell .post_title {

      }
      
      .post_cell .div_comments {

      }
      
      .comment_cell {

      }
      
      .comment_cell .comment_title {
 
      }
    </style>
  </head>

  <body>
    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
      <?php include "menubar.php"; ?>
        
        <script>
    $(document).ready(function ready(){
        var data={type:"wall", wall_id:<?php echo $wall; ?>};
        $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
            var json=$.parseJSON(result);
            if(!json.success){
                $("body").html("");
                $("<div></div>").attr("align", "center").text("Invalid wall.").appendTo($("body"));
                return;
            }
            $("#wall_owner").text(""+json.wall.first_name+" "+json.wall.last_name+" ("+json.wall.email+")");
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
        if(post.email!="<?php echo $_SESSION['email'];?>")
            cell.find(".delete_post").hide();
        if(post.url!="")
            $("<a></a>").attr("href", post.url).text(post.url).appendTo(cell.find(".post_url"));
        cell.find(".header_comments").text(post.comments.length+" comments");
        for(var j=0;j<post.comments.length;j++){
            insertComment(post.comments[j], cell);
        }
        updateReactionCount(cell, ".div_post_reaction");
        $("#post_list").prepend(cell);
    }

    function updateReactionCount(cell, componentClass){
        cell.find(componentClass+" .num_like").text(cell.data("like")+" Like");
        cell.find(componentClass+" .num_happy").text(cell.data("happy")+" Happy");
        cell.find(componentClass+" .num_sad").text(cell.data("sad")+" Sad");
        cell.find(componentClass+" .num_angry").text(cell.data("angry")+" Angry");
        cell.find(componentClass+" .num_excited").text(cell.data("excited")+" Excited");
    }

    function insertComment(comment, cell){
        var commentCell=$("#comment_template").clone().removeAttr("id").show();
        commentCell.data("like", comment.like);
        commentCell.data("happy", comment.happy);
        commentCell.data("angry", comment.angry);
        commentCell.data("sad", comment.sad);
        commentCell.data("excited", comment.excited);
        commentCell.data("cid", comment.cid);
        commentCell.find(".mock_profile_pick").css({
            'background': function() {
            return 'RGB(' + Math.floor(Math.random() * 255) + ', ' + Math.floor(Math.random() * 255) + ', ' + Math.floor(Math.random() * 255) + ')'; // Setting the random color on your div element.
            }()
        });
        commentCell.find(".comment_title").text(comment.first_name+" "+comment.last_name+" - "+comment.time.substring(0,19));
        commentCell.find(".comment_text").text(comment.text);
        commentCell.find(".check_like").prop("checked", comment.my_like);
        commentCell.find(".check_happy").prop("checked", comment.my_happy);
        commentCell.find(".check_sad").prop("checked", comment.my_sad);
        commentCell.find(".check_angry").prop("checked", comment.my_angry);
        commentCell.find(".check_excited").prop("checked", comment.my_excited);
        commentCell.prependTo(cell.find(".post_comments"));
        if(comment.email!="<?php echo $_SESSION['email']; ?>")
            commentCell.find(".delete_comment").hide();
        var numComments=cell.find(".post_comments").find(".comment_cell").length;
        cell.find(".header_comments").text(numComments+" comments");
        updateReactionCount(commentCell, ".div_comment_reaction");
    }

    $(document).on("change", ".post_cell .div_post_reaction input[type=checkbox]", function reactPost(e){
        var checked=$(this).is(":checked");
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
            updateReactionCount(cell, ".div_post_reaction");
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
            updateReactionCount(cell, ".div_comment_reaction");
        });
    });

    $(document).on("click", ".delete_comment", function deleteComment(){
        var cell=$(this).closest(".comment_cell");
        var data={type:"delete_comment", cid:cell.data("cid")};
        $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
            var post=cell.closest(".post_cell");
            var numComments=post.find(".post_comments").find(".comment_cell").length-1;
            post.find(".header_comments").text(numComments+" comments");
            cell.remove();
        });
    });

    $(document).on("click", ".delete_post", function deletePost(){
        var cell=$(this).closest(".post_cell");
        var data={type:"delete_post", pid:cell.data("pid")};
        console.log(data);
        $.ajax({method:"POST", url:"queries.php", data:data}).done(function(result){
            console.log(data);
            cell.remove();
        });
    });
</script>

        <div class="mdl-layout__content">
          <div align="center">
            <br>

            <div id="wall_description" class="mdl-layout-title"></div>
            <div>
              Owner
              <div id="wall_owner"></div>
            </div>
            <hr>
            <div align="center" class="mdl-cell mdl-cell--12-col">

              <div class=" mdl-card mdl-shadow--2dp" style="width:inherit">
                <div class="mdl-card__title">
                  <!--<h2 class="mdl-card__title-text ">Welcome</h2>-->
                  <div class="mdl-card__title-text" style="color:black;display: inline-block">New Post</div>
                </div>

                <form id="form_submit_post">
                  <div class="mdl-grid">
                    <div class="mdl-cell mdl-cell--9-col">
                      <div class="mdl-textfield mdl-js-textfield " style="width:inherit">
                        <textarea id="new-comment" name="text" class="mdl-textfield__input" maxlength="2000" required></textarea>
                        <label class="mdl-textfield__label" for="new-comment">Your post...</label>
                      </div>
                    </div>
                    <div class="mdl-cell mdl-cell--3-col">
                      <div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable">
                        <label class="mdl-button mdl-js-button mdl-button--icon" for="sample6">
                          <i class="material-icons">link</i>
                        </label>
                        <div class="mdl-textfield__expandable-holder">
                          <input class="mdl-textfield__input" name="url" maxlength="2000" type="text" id="sample6">
                          <label class="mdl-textfield__label" for="sample-expandable">Link (optional)</label>
                        </div>
                      </div>
                    </div>
                  </div>


                  <!--<input name="url" maxlength="2000" placeholder="Link (optional)"><br>-->

                  <div class="mdl-card__actions mdl-card--border">
                    <input class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect" type="submit" value="Post">
                  </div>
                </form>
              </div>
            </div>

          </div>
          <div align="center" class="mdl-grid" id="post_list">

          </div>
        </div>
        <div id="post_template" class="post_cell   mdl-list__item mdl-cell mdl-cell--12-col" style="display: none">
          <div class=" mdl-card mdl-shadow--2dp " style="width:inherit">
            <div class="mdl-card__title">
              <div class="post_title mdl-card__title-text" style="color:black;display: inline-block"></div>
            </div>
            <div class="post_url  mdl-card__supporting-text"></div>
            <div class="post_content mdl-card__supporting-text"></div>
            <div class="mdl-card__actions mdl-card--border">

              <div class="mdl-card__menu">
                <button id="del_post" class="mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect delete_post">
                  <i class="material-icons">delete</i>
                </button>

              </div>


              <div class="div_post_reaction">

                <input type="checkbox" name="like" class="check_like"><span class="num_like">0 Like</span>
                <input type="checkbox" name="happy" class="check_happy"><span class="num_happy">0 Happy</span>
                <input type="checkbox" name="sad" class="check_sad"><span class="num_sad">0 Sad</span>
                <input type="checkbox" name="angry" class="check_angry"><span class="num_angry">0 Angry</span>
                <input type="checkbox" name="excited" class="check_excited"><span class="num_excited">0 Excited</span>
              </div>
              <div class="div_comments">
                <div align="center">
                  <form class="form_comment mdl-grid">

                    <div class="mdl-textfield mdl-js-textfield mdl-cell mdl-cell--10-col">
                      <input class="mdl-textfield__input" type="text" name="text" placeholder="My comment" maxlength="500" required>

                    </div>
                    <div class="mdl-cell mdl-cell--2-col">
                      <input type="submit" class="button_comment mdl-button mdl-js-button  mdl-button--raised mdl-button--colored" style="display:flex" value="Comment">
                    </div>
                  </form>

                  <div class="header_comments " style="display: inline-block"></div>&nbsp;
                  <button class="post_show mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect">Show</button>
                  <div class="mdl-grid">
                    <div class="post_comments  mdl-cell mdl-cell--12-col" style="display: none"></div>
                  </div>

                </div>
              </div>
              <div id="comment_template" class="comment_cell mdl-list__item mdl-cell mdl-cell--12-col" style="display: none">

                <div class=" mdl-card mdl-shadow--2dp mdl-cell--12-col ">
                  <div class="mdl-card__title" style="padding-bottom: inherit">
                    <div style="padding-right:5px">
                      <i id="profile-image-mock" class="material-icons mock_profile_pick" style="color:white">person</i>
                    </div>
                    <h3 class="comment_title mdl-card__title-text"></h3>
                  </div>
                  <hr>
                  <div class="mdl-card__supporting-text comment_text">
                  </div>
                  <div class="div_comment_reaction">
                    <div>

                    </div>
                    <input type="checkbox" name="like" class="check_like"><span class="num_like">0 Like</span>
                    <input type="checkbox" name="happy" class="check_happy"><span class="num_happy">0 Happy</span>
                    <input type="checkbox" name="sad" class="check_sad"><span class="num_sad">0 Sad</span>
                    <input type="checkbox" name="angry" class="check_angry"><span class="num_angry">0 Angry</span>
                    <input type="checkbox" name="excited" class="check_excited"><span class="num_excited">0 Excited</span>
                  </div>

                  <div class="mdl-card__menu">
                    <button class="delete_comment mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect"><i class="material-icons">delete</i></button>

                  </div>
                </div>
              </div>
            </div>
  </body>

  </html>