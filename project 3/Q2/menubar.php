<!-- This file is the menubar that is included in every page of the website-->
<style type="text/css">
    #div_menu {
        position: relative;
        display: inline-block;
        margin: 0px;
        background: blue;
        width: 100%;
    }

    #div_menu a {
        color: white;
    }
</style>
<link rel="stylesheet" href="./material.min.css">
<script src="./material.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">


<header class="mdl-layout__header">
    <div class="mdl-layout__header-row">
        <!-- Title -->
        <span class="mdl-layout-title">COMP 421 Project 3</span>
        <!-- Add spacer, to align navigation to the right -->
        <div class="mdl-layout-spacer"></div>
        <!-- Navigation. We hide it in small screens. -->
        <nav class="mdl-navigation mdl-layout--large-screen-only">
            <a class="mdl-navigation__link" href="menu.php">Find users</a>
            <a class="mdl-navigation__link" href="user.php?email=<?php echo $_SESSION['email'] ?>">My profile</a>

            <a class="mdl-navigation__link" id="link_logout" href="index.php">Logout</a>

        </nav>
    </div>
</header>
<div class="mdl-layout__drawer">
    <span class="mdl-layout-title">COMP 421 Project 3</span>
    <nav class="mdl-navigation">
        <a class="mdl-navigation__link" href="menu.php">Find users</a>
        <a class="mdl-navigation__link" href="user.php?email=<?php echo $_SESSION['email'] ?>">My profile</a>

        <a class="mdl-navigation__link" id="link_logout" href="index.php">Logout</a>
    </nav>
</div>