(function () {

    var allNum = 1;

    var myDate = new Date();

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
            ManagerOrgID: sessionStorage.getItem("OrgID"),
            startTime: startTime,
            endTime: stopTime,
            PageIndex: nowNum
        };
        HH.post("/ManageOrgInfo/ManageTestState", info, function (data) {

            var myJson = {data: data.DataBag.PageDatas};

            $.each(myJson.data, function (i, v) {
                v["num"] = i * 1 + 1 + nowNum * 20 - 20;
                if (v.ration) {
                    v.ration = v.ration * 100 + "%"
                }
            });

            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pagecount;

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

    $("#startDate").find("input").val(myDate.getFullYear() + "/" + (myDate.getMonth() - 1) + "/" + myDate.getDate());
    $("#stopDate").find("input").val(myDate.getFullYear() + "/" + (myDate.getMonth() + 1) + "/" + myDate.getDate());

    $("#check_btn").click(function () {
        pageReload(1);
    });

    $("#check_btn").click();

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");
        var operationName = $(this).attr("data-name");
        sessionStorage.setItem("EquipmentId", operationId);
        sessionStorage.setItem("EquipmentName", operationName);
        window.location.href = "./EquipmentTestInfo.html";
    });

})();