(function () {

    //实例化省市区
    var myArea_add = new areaObj("#shen_add", "#shi_add", "#qu_add");

    var add_state_name = false;
    var add_state_mobile = false;

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

        var info = {
            MID: $("#MID").val(),
            managerorgname: $("#managerorgname").val(),
            PageIndex: nowNum
        };
        HH.post("/playwithrole/GetManagersSubs", info, function (data) {

            var myJson = {
                MID: $("#MID").val(),
                data: data.DataBag
            };
            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pageCount;

            createPaging("#in_paging", nowNum, allNum);

        });

        //获取组织节点树
        HH.get("/PlayWithRole/GetManagerOrgAll", function (data) {
            var setting = {
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                callback: {
                    onClick: treeClick
                }
            };
            if (data.DataBag) {
                showZtree("#middleZtree", data.DataBag, setting);
            } else {
                console.log("缺少dataBag参数！")
            }

        })

    };

    //页码
    $("#in_page").on("click", ".pagination>.pageNum", function () {
        var num = parseInt($(this).text());
        pageReload(num)
    });
    $("#in_page").on("click", ".pagination>.upPage", function () {
        var num = parseInt($(".pagination>.active").text());
        if (num != 1) {
            num = num - 1;
            pageReload(num);
        }
    });
    $("#in_page").on("click", ".pagination>.downPage", function () {
        var num = parseInt($(".pagination>.active").text());
        var maxNum = Math.ceil(parseInt(allNum) / 20);
        if (num != maxNum && maxNum!=0) {
            num = num + 1;
            pageReload(num);
        }
    });

    $("#in_page").on("click", "#check_btn", function () {
        pageReload(1);
    });

    //添加处理方法
    $("#add_btn").click(function () {
        $("input[name='ManagerOrgName']").blur();
        $("input[name='ContactTel']").blur();
        if (add_state_name == true && add_state_mobile == true) {
            var myJson = getForm("#form_add");
            myJson["ParentID"] = $("#MID").val();
            HH.post("/PlayWithRole/AddManagerSubs", myJson, function (data) {
                $('#addModal').modal('hide')
                document.getElementById("form_add").reset();

                pageReload();
            });
        }
    });

    //部门名称判空
    $("input[name='ManagerOrgName']").blur(function () {
        var info = $(this).val();
        info = info.replace(/(^\s+)|(\s+$)/g, "");
        info = info.replace(/\s/g, "");
        if (info != "" && info != " " && info != null && info != undefined) {
            $(this).next().css("visibility", "hidden")
            $(this).css("border-color", "#ccc");
            add_state_name = true;
        } else {
            $(this).next().css("visibility", "visible")
            $(this).css("border-color", "red");
            add_state_name = false;
        }
    });
    //手机号判断
    $("input[name='ContactTel']").blur(function () {
        var info = $(this).val();
        var state = checkMobile(info);
        if (state) {
            $(this).next().css("visibility", "hidden")
            $(this).css("border-color", "#ccc");
            add_state_mobile = true;
        } else {
            $(this).val("");
            $(this).next().css("visibility", "visible")
            $(this).css("border-color", "red");
            add_state_mobile = false;
        }
    });

    //节点树点击方法
    function treeClick(event, treeId, treeNode) {
        var info = {
            MID: treeNode.id,
            managerorgname: "",
            PageIndex: 1
        };
        HH.post("/playwithrole/GetManagersSubs", info, function (data) {

            var myJson = {
                MID: treeNode.id,
                data: data.DataBag
            };

            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pageCount;

            createPaging("#in_paging", 1, allNum);

        });
    };

    //获取组织节点树
    HH.get("/PlayWithRole/GetManagerOrgAll", function (data) {
        var setting = {
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                onClick: treeClick
            }
        };
        if (data.DataBag) {
            showZtree("#middleZtree", data.DataBag, setting);
        } else {
            console.log("缺少dataBag参数！")
        }

    })

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/PlayWithRole/ManagerDetail", {ManagerOrgID: operationId}, function (data) {

            var myJson = data.DataBag;
            render("#checkView", "#checkPage", myJson);

        });

    });

    //操作修改
    $("#in_page").on("click", ".btn_edit", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/PlayWithRole/ManagerDetail", {ManagerOrgID: operationId}, function (data) {

            var myJson = data.DataBag;
            render("#editView", "#editPage", myJson);

            //部门名称判空
            $("input[name='ManagerOrgName']").blur(function () {
                var info = $(this).val();
                info = info.replace(/(^\s+)|(\s+$)/g, "");
                info = info.replace(/\s/g, "");
                if (info != "" && info != " " && info != null && info != undefined) {
                    $(this).next().css("visibility", "hidden")
                    $(this).css("border-color", "#ccc");
                    add_state_name = true;
                } else {
                    $(this).next().css("visibility", "visible")
                    $(this).css("border-color", "red");
                    add_state_name = false;
                }
            });
            //手机号判断
            $("input[name='ContactTel']").blur(function () {
                var info = $(this).val();
                var state = checkMobile(info);
                if (state) {
                    $(this).next().css("visibility", "hidden")
                    $(this).css("border-color", "#ccc");
                    add_state_mobile = true;
                } else {
                    $(this).val("");
                    $(this).next().css("visibility", "visible")
                    $(this).css("border-color", "red");
                    add_state_mobile = false;
                }
            });

            var areaId = myJson.AreaId.split(",");
            var myArea_edit = new areaObj("#shen_edit", "#shi_edit", "#qu_edit", areaId);

            $("#ManageOrgGrade").val(myJson.ManageOrgGrade);
            $("#Status").val(myJson.Status);

            $("#edit_btn").click(function () {
                $("input[name='ManagerOrgName']").blur();
                $("input[name='ContactTel']").blur();
                if (add_state_name == true && add_state_mobile == true) {
                    var myJson = getForm("#form_edit");
                    myJson["ManagerOrgID"] = operationId;

                    HH.post("/PlayWithRole/UpdateManagerSubs", myJson, function (data) {
                        $('#editModal').modal('hide')
                        pageReload();
                    });
                }
            });

        });


    });

    //操作删除
    var deleteId;
    $("#in_page").on("click", ".btn_delete", function () {
        deleteId = $(this).attr("data-id");
    });
    $("#deleteModal").on("click", "#deleteModal_btn", function () {
        HH.post("/PlayWithRole/RemoveManagerSubs", {ManagerOrgID: deleteId}, function (data) {
            $('#deleteModal').modal('hide');
            pageReload();
        });
    })

    //操作账号
    $("#in_page").on("click", ".btn_user", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/PlayWithRole/GetManagerUsers", {managerOrgID: operationId}, function (data) {
            var myJson = data.DataBag;
            render("#userView", "#userPage", myJson);
        });

    });


})();