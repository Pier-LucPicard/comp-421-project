<style type="text/css">
    #div_menu{
        position:relative;
        display: inline-block;
        margin:0px;
        background: blue;
        width: 100%;
    }
    #div_menu a{
        color:white;
    }
</style>
<div id="div_menu">
    <a href="user.php?email=<?php echo $_SESSION['email'] ?>">My profile</a>
    <a href="menu.php">Find users</a>
    <a id="link_logout" href="index.php">Logout</a>
</div>