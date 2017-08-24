(function () {

    var deleteId;

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
            orgid: sessionStorage.getItem("OrgID"),
            StartTime: startTime,
            EndTime: stopTime,
            PageIndex: nowNum
        };
        HH.post("/Patrol/FireSafetyCheckList", info, function (data) {

            var myJson = {data: data.DataBag.PageDatas};
            $.each(myJson.data, function (i, v) {
                v["num"] = i * 1 + 1 + nowNum * 20 - 20;
            });
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
        if (num != allNum) {
            num = num + 1;
            pageReload(num);
        }
    });

    dataPick("#startDate");
    dataPick("#stopDate");

    $("#startDate").find("input").val(myDate.getFullYear() + "/" + (myDate.getMonth() - 1) + "/" + myDate.getDate());
    $("#stopDate").find("input").val(myDate.getFullYear() + "/" + (myDate.getMonth() + 1) + "/" + myDate.getDate());

    $("#check_btn").click(function () {
        pageReload(1);
    });

    $("#check_btn").click();

    //添加处理方法
    $("#add_btn").click(function () {

        var myJson = getForm("#form_add");
        myJson["orgid"] = sessionStorage.getItem("OrgID");
        HH.post("/Patrol/AddFireSafetyCheck", myJson, function (data) {
            $('#addModal').modal('hide')
            document.getElementById("form_add").reset();
            pageReload();
        });

    });

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Patrol/FireSafetyCheckDetail", {FireSafetyCheckID: operationId}, function (data) {
            var myJson = data.DataBag;
            render("#checkView", "#checkPage", myJson);
        });

    });

    //操作修改
    $("#in_page").on("click", ".btn_edit", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Patrol/FireSafetyCheckDetail", {FireSafetyCheckID: operationId}, function (data) {
            var myJson = data.DataBag;
            render("#editView", "#editPage", myJson);

            $("#edit_btn").click(function () {
                var myJson = getForm("#form_edit");
                myJson["orgid"] = sessionStorage.getItem("OrgID");
                myJson["FireSafetyCheckID"] = operationId;
                HH.post("/Patrol/EditFireSafetyCheck", myJson, function (data) {
                    $('#editModal').modal('hide');
                    pageReload();
                });
            });
        });

    });

    //操作删除
    $("#in_page").on("click", ".btn_delete", function () {
        deleteId = $(this).attr("data-id");
    });
    $("#deleteModal").on("click", "#deleteModal_btn", function () {
        var info = {
            orgid: sessionStorage.getItem("OrgID"),
            FireSafetyCheckID: deleteId
        };
        HH.post("/Patrol/DeleteFireSafetyCheck", info, function (data) {
            $('#deleteModal').modal('hide');
            pageReload();
        });
    })


})();