<?php
session_start();
$type=$_POST['type'];
try{
    $db = new PDO('pgsql:dbname=postgres;host=localhost;user=postgres;password=test');
}catch (PDOException $e) {
    exit();
}
if($type=="login")
    queryLogin();
else if(!isset($_SESSION['authenticated']))
    header("Location: index.php");
else if($type=="wall")
    queryWall();
else if($type=="list_walls")
    queryListWalls();
else if($type=="insert_post")
    queryInsertpost();
else if($type=="insert_comment")
    queryInsertComment();
else if($type=="react_post")
    queryReactPost();
else if($type=="react_comment")
    queryReactComment();

function queryListWalls(){
    global $db;
    $stmt=$db->query("SELECT wall_id, descr, permission, Wall.email AS email, first_name, last_name FROM Wall, Users WHERE Wall.email=Users.email LIMIT 50");
    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
}

function queryReactComment(){
    global $db;
    $cid=intval($_POST['cid']);
    $reaction=$_POST['reaction'];
    $delete=isset($_POST['delete']);
    $stmt=$db->prepare("DELETE FROM CommentReaction WHERE email=? AND cid=?");
    $stmt->execute(array($_SESSION['email'], $cid));
    if(!$delete){
        $stmt=$db->prepare("INSERT INTO CommentReaction(cid, email, type) VALUES (?, ?, ?)");
        $stmt->execute(array($cid, $_SESSION['email'], $reaction));
    }
}

function queryReactPost(){
    global $db;
    $pid=intval($_POST['pid']);
    $reaction=$_POST['reaction'];
    $delete=isset($_POST['delete']);
    $stmt=$db->prepare("DELETE FROM PostReaction WHERE email=? AND pid=?");
    $stmt->execute(array($_SESSION['email'], $pid));
    if(!$delete){
        $stmt=$db->prepare("INSERT INTO PostReaction(pid, email, type) VALUES (?, ?, ?)");
        $stmt->execute(array($pid, $_SESSION['email'], $reaction));
    }
}

function queryInsertComment(){
    global $db;
    $text=$_POST['text'];
    $pid=intval($_POST['pid']);
    $stmt=$db->prepare("INSERT INTO Comment (pid, email, text, time) VALUES (?, ?, ?, now())");
    $stmt->execute(array($pid, $_SESSION['email'], $text));
    $cid=$db->lastInsertId('comment_cid_seq');
    $stmt=$db->query("SELECT * FROM Comment WHERE cid=$cid");
    echo json_encode($stmt->fetch(PDO::FETCH_ASSOC));
}

function queryInsertPost(){
    global $db;
    $text=$_POST['text'];
    $url=$_POST['url'];
    $wall_id=intval($_POST['wall_id']);
    $stmt=$db->prepare("INSERT INTO Post (wall_id, email, date, text, url) VALUES (?, ?, now(), ?, ?)");
    $stmt->execute(array($wall_id, $_SESSION['email'], $text, $url));
    $pid=$db->lastInsertId('post_pid_seq');
    $stmt=$db->query("SELECT * FROM Post WHERE pid=$pid");
    echo json_encode($stmt->fetch(PDO::FETCH_ASSOC));
}

function queryLogin(){
    global $db;
    $email=$_POST['email'];
    $password=$_POST['password'];
    $stmt=$db->prepare("SELECT * FROM Users WHERE email=:email AND password=:password");
    $stmt->bindParam(":email", $email, PDO::PARAM_STR);
    $stmt->bindParam(":password", $password, PDO::PARAM_STR);
    $stmt->execute();
    $row=$stmt->fetch(PDO::FETCH_ASSOC);
    if($row==false){
        echo json_encode(array("success"=>false, "info"=>"Invalid credentials."));
    }else{
        $_SESSION['authenticated']=true;
        $_SESSION['email']=$row['email'];
        $_SESSION['first_name']=$row['first_name'];
        $_SESSION['last_name']=$row['last_name'];
        echo json_encode(array("success"=>true, "user"=>$row));
    }
}

function queryWall(){
    global $db;
    $wall_id=$_POST['wall_id'];
    $stmt=$db->prepare("SELECT * FROM Wall WHERE wall_id=:wall_id");
    $stmt->bindParam(":wall_id", $wall_id, PDO::PARAM_INT);
    $stmt->execute();
    $row=$stmt->fetch(PDO::FETCH_ASSOC);
    if($row==false){
        echo json_encode(array("success"=>false, "info"=>"This wall does not exist."));
    }else{
        $stmt=$db->prepare("SELECT pid, wall_id, Post.email AS email, date, text, url, first_name, last_name, (SELECT COUNT(*) FROM PostReaction WHERE PostReaction.pid=Post.pid AND type='like') AS like, 
(SELECT COUNT(*) FROM PostReaction WHERE PostReaction.pid=Post.pid AND type='happy') AS happy, (SELECT COUNT(*) FROM PostReaction WHERE PostReaction.pid=Post.pid AND type='sad') AS sad, 
(SELECT COUNT(*) FROM PostReaction WHERE PostReaction.pid=Post.pid AND type='angry') AS angry, (SELECT COUNT(*) FROM PostReaction WHERE PostReaction.pid=Post.pid AND type='excited') AS excited, 
EXISTS(SELECT * FROM PostReaction WHERE PostReaction.pid=Post.pid AND type='like' AND email=:email) AS my_like, EXISTS(SELECT * FROM PostReaction WHERE PostReaction.pid=Post.pid AND type='happy' AND email=:email) AS my_happy, 
EXISTS(SELECT * FROM PostReaction WHERE PostReaction.pid=Post.pid AND type='sad' AND email=:email) AS my_sad, EXISTS(SELECT * FROM PostReaction WHERE PostReaction.pid=Post.pid AND type='angry' AND email=:email) AS my_angry, 
EXISTS(SELECT * FROM PostReaction WHERE PostReaction.pid=Post.pid AND type='excited' AND email=:email) AS my_excited 
FROM Post, Users WHERE wall_id=:wall_id AND Post.email=Users.email ORDER BY date ASC");
        $stmt->bindParam(":wall_id", $wall_id, PDO::PARAM_INT);
        $stmt->bindparam(":email", $_SESSION['email'], PDO::PARAM_STR);
        $stmt->execute();
        $rows=$stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach($rows as &$row){
            $stmt=$db->prepare("SELECT cid, pid, Comment.email AS email, text, time, first_name, last_name, (SELECT COUNT(*) FROM CommentReaction WHERE CommentReaction.cid=Comment.cid AND type='like') AS like, 
(SELECT COUNT(*) FROM CommentReaction WHERE CommentReaction.cid=Comment.cid AND type='happy') AS happy, (SELECT COUNT(*) FROM CommentReaction WHERE CommentReaction.cid=Comment.cid AND type='sad') AS sad, 
(SELECT COUNT(*) FROM CommentReaction WHERE CommentReaction.cid=Comment.cid AND type='angry') AS angry, (SELECT COUNT(*) FROM CommentReaction WHERE CommentReaction.cid=Comment.cid AND type='excited') AS excited, 
EXISTS(SELECT * FROM CommentReaction WHERE CommentReaction.cid=Comment.cid AND type='like' AND email=:email) AS my_like, EXISTS(SELECT * FROM CommentReaction WHERE CommentReaction.cid=Comment.cid AND type='happy' AND email=:email) AS my_happy, 
EXISTS(SELECT * FROM CommentReaction WHERE CommentReaction.cid=Comment.cid AND type='sad' AND email=:email) AS my_sad, EXISTS(SELECT * FROM CommentReaction WHERE CommentReaction.cid=Comment.cid AND type='angry' AND email=:email) AS my_angry, 
EXISTS(SELECT * FROM CommentReaction WHERE CommentReaction.cid=Comment.cid AND type='excited' AND email=:email) AS my_excited 
FROM Comment, Users WHERE pid=:pid AND Users.email=Comment.email ORDER BY time ASC");
            $stmt->bindparam(":pid", $row['pid'], PDO::PARAM_INT);
            $stmt->bindparam(":email", $_SESSION['email'], PDO::PARAM_STR);
            $stmt->execute();
            $comments=$stmt->fetchAll(PDO::FETCH_ASSOC);
            $row['comments']=$comments;
        }
        echo json_encode(array("success"=>true, "posts"=>$rows));
    }
}