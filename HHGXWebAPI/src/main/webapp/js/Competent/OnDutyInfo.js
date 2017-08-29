(function () {

    var OnDutyName = sessionStorage.getItem("OnDutyName");
    $("#title_name").text(OnDutyName);

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
            orgid: sessionStorage.getItem("OnDutyId"),
            startTime: startTime,
            endTime: stopTime,
            pageIndex: nowNum
        };
        HH.post("/ManageOrgInfo/GetOnDutyRecordList", info, function (data) {

            var myJson = {data: data.DataBag.PageDatas};

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
        var maxNum = Math.ceil(parseInt(allNum) / 20);
        if (num != maxNum && maxNum!=0) {
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

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {

        var operationId = $(this).attr("data-id");

        HH.post("/ManageOrgInfo/GetOnDutyRecordDetail", {RecordID: operationId}, function (data) {
            var myJson = data.DataBag;

            render("#checkView", "#checkPage", myJson);
        });

    });

})();