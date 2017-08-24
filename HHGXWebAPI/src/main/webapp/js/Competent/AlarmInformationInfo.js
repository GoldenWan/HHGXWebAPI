(function () {

    var allNum = 1;

    var handleType = "";
    var isFire = true;

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
        var handle = $("#select_handle").val();
        var category = $("#select_category").val();

        handleType = handle;

        if (category == "火警") {
            isFire = true;
        } else if (category == "故障") {
            isFire = false;
        }

        var info = {
            "orgid": sessionStorage.getItem("AlarmInfoId"),
            "startTime": startTime,
            "endTime": stopTime,
            "isHandle": handle,
            "cAlarmType": category,
            "PageIndex": nowNum
        };
        HH.post("/ManageOrgInfo/GetOrgAlarmInfos", info, function (data) {
            var myJson = {data: data.DataBag.PageDatas};

            $.each(myJson.data, function (i, v) {
                v["handleType"] = handleType;
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


    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");

        var info = {
            Firealarmid: operationId,
            isHandle: handleType
        };

        HH.post("/ManageOrgInfo/AlarmInfo", info, function (data) {

            var myJson = data.DataBag[0];
            if (handleType == "已处理") {
                var Handle = false;
                myJson["isFire"] = isFire;
                if (myJson.YnRequest == "是") {
                    Handle = true;
                    myJson["Handle"] = Handle;
                }
                ;
                render("#checkView_true", "#checkPage", myJson);
            } else if (handleType == "未处理") {
                render("#checkView_false", "#checkPage", myJson);
            }

        });

    });

    //建筑物详情
    $("#in_page").on("click", ".btn_Building", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Orginfo/GetSite", {siteid: operationId}, function (data) {
            var myJson = data.DataBag[0];
            render("#buildingView", "#buildingPage", myJson);
        });

    });

    //故障处理单
    $("#checkPage").on("click", ".btn_accident", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/AlarmData/GetRepaireInfo", {Firealarmid: operationId}, function (data) {
            var myJson = data.DataBag[0];
            render("#accidentView", "#accidentPage", myJson);
        });

    });

    //查询按钮
    $("#check_btn").click(function () {
        pageReload(1)
    });

    $("#check_btn").click();

})();