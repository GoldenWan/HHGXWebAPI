(function () {

    var allNum = 1;

    var wbId = "";
    var source = "";

    var allJson = "";

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

        var HandingState = $("#HandingState").val();

        var info = {
            MaintenanceId: sessionStorage.getItem("OrgID"),
            HandingState: HandingState,
            startTime: startTime,
            endTime: stopTime,
            PageIndex: 1
        };
        HH.post("/Maintenance/GetOrgRepaireList", info, function (data) {

            var myJson = {data: data.DataBag.PageDatas};
            $.each(myJson.data, function (i, v) {
                v["num"] = i * 1 + 1 + nowNum * 20 - 20;
                if (HandingState == "未处理") {
                    v["state"] = true;
                } else if (HandingState == "已处理") {
                    v["state"] = false;
                }
            });
            allJson = myJson.data;

            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pageCount;

            createPaging("#in_paging", nowNum, allNum);

        });
    }

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

    $("#check_btn").click(function () {
        pageReload(1);
    });

    $("#check_btn").click();

    //处理
    $("#in_page").on("click", ".btn_check", function () {
        wbId = $(this).attr("data-id");
        var myJson;
        $.each(allJson, function (i, v) {
            if (v.wbRepairInfoId == wbId) {
                myJson = v;
            }
        });
        source = myJson.source;
        render("#checkView", "#checkPage", myJson);
    });

    $("#checkPage").on("click", "#submit_btn", function () {
        var info = {
            wbRepaireInfoId: wbId,
            source: source,
            DealResult: $("#result").val()
        };
        HH.post("/Maintenance/RepaireDeal", info, function (data) {
            pageReload();
            $('#checkModal').modal('hide');
        })
    });


})();