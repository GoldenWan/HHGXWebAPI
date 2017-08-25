(function () {

    var allNum = 1;

    //局部刷新
    function pageReload(nowNum,name) {

        var nowNum = parseInt(nowNum);

        if (!nowNum) {
            nowNum = parseInt($("#in_paging").find(".pagination>.active").text());
            if (isNaN(nowNum)) {
                nowNum = 1;
            }
        }

        var info = {
            ManagerOrgID: sessionStorage.getItem("OrgID"),
            OrgName:name,
            PageIndex: nowNum
        };

        HH.post("/Orginfo/GetUnRegisterOrg", info, function (data) {
            var myJson = data.DataBag.PageDatas;
            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pageCount;

            createPaging("#in_paging", nowNum, allNum);
        });

    };

    $("#check_btn").click(function () {
        var company = $("#CompanyName").val();
        pageReload(1, company);
    });

    $("#check_btn").click();

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

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");

        sessionStorage.setItem("CompetentOrg", operationId);

        window.location.href = "RegistrationAuditInfo.html";

    });

})();