(function () {

    var allNum = 1;

    var myDate = new Date();

    //局部刷新
    function pageReload(nowNum) {

        //var nowNum = parseInt(nowNum);
        //
        //if (!nowNum) {
        //    nowNum = parseInt($("#in_paging").find(".pagination>.active").text());
        //    if (isNaN(nowNum)) {
        //        nowNum = 1;
        //    }
        //}

        var startTime = $("#startDate").find("input").val();
        var stopTime = $("#stopDate").find("input").val();

        var info = {
            ManagerOrgID: sessionStorage.getItem("OrgID"),
            StartTime: startTime,
            EndTime: stopTime
        };
        HH.post("/ManageOrgInfo/OnDutyRecord", info, function (data) {

            var myJson = {data: data.DataBag};

            render("#in_view", "#in_page", myJson);

            //allNum = Math.ceil(data.DataBag.PageCount/20);
            //
            //createPaging("#in_paging",nowNum,allNum);

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
        sessionStorage.setItem("OnDutyId", operationId);
        sessionStorage.setItem("OnDutyName", operationName);
        window.location.href = "./OnDutyInfo.html";
    });

})();