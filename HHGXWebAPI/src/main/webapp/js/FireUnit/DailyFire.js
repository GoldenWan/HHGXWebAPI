(function () {

    var deleteId;
    var submitId;

    var myDate = new Date();

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

        var startTime = $("#startDate").find("input").val();
        var stopTime = $("#stopDate").find("input").val();

        var info = {
            OrgID: sessionStorage.getItem("OrgID"),
            StartDate: startTime,
            EndDate: stopTime,
            PageIndex: nowNum
        };
        HH.post("/Patrol/GetPatrolRecordByOrg", info, function (data) {
            var myJson = {data: data.DataBag.PageDatas};
            $.each(myJson.data, function (i, v) {
                v["num"] = i * 1 + 1 + nowNum * 20 - 20;
                if (v.SubmitFlag == "false") {
                    v.SubmitFlag = false;
                } else {
                    v.SubmitFlag = true;
                }
            });
            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pageCount;

            createPaging("#in_paging", nowNum, allNum);

        });

    };

    dataPick("#startDate");
    dataPick("#stopDate");
    dataPick("#patrolDate_add",null,null,new Date());

    $("#startDate").find("input").val(myDate.getFullYear() + "/" + (myDate.getMonth() - 1) + "/" + myDate.getDate());
    $("#stopDate").find("input").val(myDate.getFullYear() + "/" + (myDate.getMonth() + 1) + "/" + myDate.getDate());

    //查询按钮
    $("#check_btn").click(function () {
        pageReload(1)
    });

    //添加处理方法
    $("#add_btn").click(function () {

        var add_state = emptyTest("#safetyManager");
        add_state = emptyTest("#patrolDate_add>input");

        if (add_state) {
            var myJson = {
                OrgID: sessionStorage.getItem("OrgID"),
                UserCheckTime: $("#patrolDate_add").find("input").val(),
                OrgUser: sessionStorage.getItem("RealName"),
                OrgManagerId: $("#safetyManager").val()
            };
            HH.post("/Patrol/AddUserCheckList", myJson, function (data) {
                sessionStorage.setItem("UserCheckId", data.DataBag);
                window.location.href = "DailyFireInfo.html";
            });
        }

    });

    $("#safetyManager").blur(function () {
        emptyTest("#safetyManager");
    });

    //判空验证
    function emptyTest(node) {
        var value = $(node).val();

        value = value.replace(/(^\s+)|(\s+$)/g, "");
        value = value.replace(/\s/g, "");

        if (value) {
            $(node).next().css("visibility", "hidden");
            $(node).css("border-color", "#ccc");
            return true;
        } else {
            $(node).next().css("visibility", "visible");
            $(node).css("border-color", "red");
            return false;
        }

    }

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Patrol/GetCheckRecord", {UserCheckId: operationId}, function (data) {
            if (data.DataBag) {
                var myJson = data.DataBag[0];
                var arr = [];

                $.each(myJson.Projects, function (i, v) {
                    v["len"] = v.Content.length;
                    for (var j = 0; j < v.Content.length; j++) {
                        arr.push(v.Content[j].PicInfo);
                    }
                    ;
                });

                var info = {
                    data: myJson,
                    pic: arr
                };

                //图片添加路径
                Handlebars.registerHelper("myTd", function (ng, options) {
                    var node = "";
                    for (var i = 0; i < ng.length; i++) {
                        for (var j = 0; j < ng[i].Content.length; j++) {
                            node = node + '<tr>';
                            if (j == 0) {
                                node = node + '<td rowspan="' + ng[i].len + '">' + ng[i].ProjectContent + '</td>';
                            }
                            node = node +
                                '<td>' + ng[i].Content[j].ProjectContent + '</td>' +
                                '<td>' + ng[i].Content[j].UserCheckResult + '</td>' +
                                '<td>' + ng[i].Content[j].FaultShow + '</td>' +
                                '<td>' + ng[i].Content[j].YnHanding + '</td>' +
                                '<td>' + ng[i].Content[j].Handingimmediately + '</td>' +
                                '</tr>';
                        }
                        ;
                    }
                    ;
                    return node;
                });

                render("#checkView", "#checkPage", info);
            } else {
                console.log("缺少dataBag参数！")
            }
        });

    });

    //操作修改
    $("#in_page").on("click", ".btn_edit", function () {
        var operationId = $(this).attr("data-id");

        sessionStorage.setItem("UserCheckId", operationId);
        window.location.href = "DailyFireInfo.html";

    });

    //操作提交
    $("#in_page").on("click", ".btn_commit", function () {
        submitId = $(this).attr("data-id");
        $('#submitModal').modal('show');
    });

    $("#submitModal_btn").click(function(){
        HH.post("/Patrol/UpdateSubmitState", {UserCheckId: submitId}, function (data) {
            if (data.DataBag.flag) {
                pageReload();
                $('#submitModal').modal('hide');
            } else {
                $('#submitModal').modal('hide');
                $('#messageModal').modal('show');
            }
        });
    });

    //操作删除
    $("#in_page").on("click", ".btn_delete", function () {
        deleteId = $(this).attr("data-id");
    });
    $("#deleteModal").on("click", "#deleteModal_btn", function () {
        HH.post("/Patrol/DeleteCheckRecord", {UserCheckId: deleteId}, function (data) {
            $('#deleteModal').modal('hide');
            pageReload();
        });
    })

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
        if (num != allNum) {
            num = num + 1;
            pageReload(num);
        }
    });

    $("#check_btn").click();


})();