(function () {

    var add_state = false;
    var user_type = sessionStorage.getItem("UserBelongTo");

    var allNum = 1;

    //局部刷新
    function pageReload(nowNum) {

        var nowNum = parseInt(nowNum);

        if (!nowNum) {
            nowNum = parseInt($("#in_paging").find(".pagination>.active").text());
            if (isNaN(nowNum)) {
                nowNum = 1;
            }
        }

        var userName = $("#userName").val();

        var info = {
            UserBelongTo: user_type,
            orgid: sessionStorage.getItem("OrgID"),
            userName: userName,
            PageIndex: nowNum
        };
        HH.post("/Users/GetUserList", info, function (data) {

            var myJson = {data: data.DataBag.PageDatas};
            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pageCount;

            createPaging("#in_paging", nowNum, allNum);

        });
    };

    //页码
    $("#in_paging").on("click", ".pagination>.pageNum", function () {
        var num = parseInt($(this).text());
        pageReload(num)
    });
    $("#in_paging").on("click", ".pagination>.upPage", function () {
        var num = parseInt($(".pagination>.active").text());
        if (num != 1) {
            num = num - 1;
            pageReload(num);
        }
    });
    $("#in_paging").on("click", ".pagination>.downPage", function () {
        var num = parseInt($(".pagination>.active").text());
        var maxNum = Math.ceil(parseInt(allNum) / 20);
        if (num != maxNum && maxNum!=0) {
            num = num + 1;
            pageReload(num);
        }
    });

    $("#check_btn").click(function () {
        pageReload(1);
    });

    $("#check_btn").click();

    //获取下拉列表
    getList("/Users/GetUserType", {UserBelongTo: user_type}, "UserTypeID", "UserTypeName", "#userType_add",null,null,true);

    //密码对比
    function pwdCompare(pwd, repwd) {
        var info_pwd = $(pwd).val();
        var info_repwd = $(repwd).val();
        info_pwd = info_pwd.replace(/(^\s+)|(\s+$)/g, "");
        info_pwd = info_pwd.replace(/\s/g, "");
        info_repwd = info_repwd.replace(/(^\s+)|(\s+$)/g, "");
        info_repwd = info_repwd.replace(/\s/g, "");
        if (info_pwd == info_repwd) {
            $(pwd).next().css("visibility", "hidden")
            $(pwd).css("border-color", "#ccc");
            $(repwd).next().css("visibility", "hidden")
            $(repwd).css("border-color", "#ccc");
            add_state = true;
        } else {
            $(pwd).next().css("visibility", "visible")
            $(pwd).css("border-color", "red");
            $(repwd).next().css("visibility", "visible")
            $(repwd).css("border-color", "red");
            add_state = false;
        }
    }

    $("#add_pwd").blur(function () {
        pwdCompare("#add_pwd", "#add_repwd");
    });
    $("#add_repwd").blur(function () {
        pwdCompare("#add_pwd", "#add_repwd")
    });

    //添加处理方法
    $("#add_btn").click(function () {

        if (add_state) {
            var myJson = getForm("#form_add");
            myJson["UserBelongTo"] = user_type;
            myJson["orgid"] = sessionStorage.getItem("OrgID");
            HH.post("/Users/AddUser", myJson, function (data) {
                $('#addModal').modal('hide')
                document.getElementById("form_add").reset();
                pageReload();
            });
        }

    });

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Users/GetUser", {Userid: operationId}, function (data) {
            if (data.DataBag) {
                var myJson = data.DataBag[0];
                render("#checkView", "#checkPage", myJson);
            } else {
                console.log("缺少dataBag参数！")
            }
        });

    });

    //操作修改
    $("#in_page").on("click", ".btn_edit", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Users/GetUser", {Userid: operationId}, function (data) {
            if (data.DataBag) {
                var myJson = data.DataBag[0];
                render("#editView", "#editPage", myJson);
                $("#status_edit").val(myJson.Status);

                getList("/Users/GetUserType", {UserBelongTo: user_type}, "UserTypeID", "UserTypeName", "#userType_edit", myJson.UserTypeID,null,true);

                $("#edit_btn").click(function () {
                    var myJson = getForm("#form_edit");
                    HH.post("/Users/UpdateUser", myJson, function (data) {
                        $('#editModal').modal('hide');
                        pageReload();
                    });
                });
            } else {
                console.log("缺少dataBag参数！")
            }
        });

    });

    //操作删除
    var deleteId;
    $("#in_page").on("click", ".btn_delete", function () {
        deleteId = $(this).attr("data-id");
    });
    $("#deleteModal").on("click", "#deleteModal_btn", function () {
        HH.post("/Users/DeleteUser", {Userid: deleteId}, function (data) {
            $('#deleteModal').modal('hide');
            pageReload();
        });
    })


})();