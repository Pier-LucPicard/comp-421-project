<?php
session_start();
if (!isset($_SESSION['authenticated']))
    header("Location: index.php");
?>
<html>
<!-- This page is to search for users !-->
<head>
    <script type="text/javascript" src="jquery-3.2.0.min.js"></script>
    <style type="text/css">
        .user_cell .user_name {
            color: blue;
        }
    </style>
    <script>
        var offset = 0;//offset of results
        var filter = null;//the filter (name or email) of current user search

        // This executes a new user query with the filter provided
        $(document).on("submit", "#form_search", function searchusers(e) {
            e.preventDefault();
            filter = $(this).find("input[name=filter]").val();
            offset = 0;
            executeUsersQuery();
        });

        //Execute a query with the given filter and offset
        function executeUsersQuery() {
            var data = {type: "list_users", filter: filter, offset: offset};
            $.ajax({method: "POST", url: "queries.php", data: data}).done(function (result) {
                console.log(result);
                var json = $.parseJSON(result);
                if (json.length == 0 && offset > 0)
                    offset -= 10;
                else
                    $("#user_list").html("");
                for (var i = 0; i < json.length; i++) {
                    var user = json[i];
                    var cell = $("#user_template").clone().removeAttr("id").show().appendTo($("#user_list"));
                    cell.data("email", user.email);
                    cell.find(".user_name").text(user.first_name + " " + user.last_name + " (" + user.email + ")");
                }
            });
        }

        //change the offset and redo users query with new offset
        $(document).on("click", ".button_offset", function offsetResults() {
            var change = parseInt($(this).data("offset"));
            console.log(change);
            if (filter != null && change > 0 || (change < 0 && offset > 0)) {
                offset += change;
                executeUsersQuery();
            }
        });

        //Visit a user's profile
        $(document).on("click", ".button_visit", function visitWall() {
            document.location.href = "user.php?email=" + $(this).closest(".user_cell").data("email");
        });
    </script>
</head>
<body>
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <?php include "menubar.php"; ?>
    <div align="center" class="mdl-layout__content">
        <br>

        <div class="mdl-layout-title">Find Users
            <hr>
        </div>
        <form id="form_search">

            <div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable">
                <label class="mdl-button mdl-js-button mdl-button--icon" for="sample6">
                    <i class="material-icons">search</i>
                </label>

                <div class="mdl-textfield__expandable-holder">


                    <input class="mdl-textfield__input" type="text" id="sample6" name="filter">
                    <label class="mdl-textfield__label" for="sample-expandable">Filter</label>

                </div>
            </div>

        </form>
        <div id="user_list">

        </div>
        <button class="button_offset mdl-button mdl-js-button mdl-button--accent" data-offset="-10"><i
                class="material-icons">arrow_back</i>Previous results
        </button>
        <button class="button_offset mdl-button mdl-js-button mdl-button--accent" data-offset="10">Next results <i
                class="material-icons">arrow_forward</i></button>
        <br>
    </div>
    <div id="user_template" class="user_cell mdl-grid" style="display: none">

        <div class="mdl-cell mdl-list__item mdl-cell--1-col"></div>
        <div class="user_name mdl-cell mdl-cell--6-col"></div>
        <button
            class="button_visit mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-cell  mdl-cell--3-col">
            Visit User Profile
        </button>
    </div>

</div>
</body>
</html>
