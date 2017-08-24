(function () {

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
            ManagerOrgID:sessionStorage.getItem("OrgID"),
            startTime:startTime,
            endTime:stopTime,
            PageIndex:nowNum
        };

        HH.post("/ManageOrgInfo/GetAlarmHandleInfo", info, function (data) {
            var myJson = {data: data.DataBag.PageDatas};
            $.each(myJson.data, function (i, v) {
                v["num"] = i * 1 + 1 + nowNum * 20 - 20;

                if ((v.alaramCount * 1) != 0) {
                    var num1 = (v.alaramHandleCount * 1) / (v.alaramCount * 1) * 100;
                    v["FireAlarm"] = num1.toFixed(2) + "%";
                } else {
                    v["FireAlarm"] = "0%";
                }

                if ((v.faultCount * 1) != 0) {
                    var num2 = (v.faultHandleCoutn * 1) / (v.faultCount * 1) * 100;
                    v["Fault"] = num2.toFixed(2) + "%";
                } else {
                    v["Fault"] = "0%";
                }
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

        sessionStorage.setItem("AlarmInfoId", operationId);
        window.location.href = "AlarmInformationInfo.html";
    });

    //查询按钮
    $("#check_btn").click(function () {
        pageReload(1)
    });

    $("#check_btn").click();

})();