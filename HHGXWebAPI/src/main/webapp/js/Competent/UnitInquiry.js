(function () {

    var allNum = 1;

    //局部刷新
    function pageReload(nowNum, name) {

        var nowNum = parseInt(nowNum);

        if (!nowNum) {
            nowNum = parseInt($("#in_paging").find(".pagination>.active").text());
            if (isNaN(nowNum)) {
                nowNum = 1;
            }
        }

        var info = {
            managerorgid: sessionStorage.getItem("OrgID"),
            orgname: name,
            PageIndex: nowNum
        };
        HH.post("/ManageOrgInfo/ManagerOrgList", info, function (data) {
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

    $("#check_btn").click(function () {
        var company = $("#CompanyName").val();
        pageReload(1, company);
    });

    $("#check_btn").click();

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");
        sessionStorage.setItem("UnitInquiryId", operationId);
        window.location.href = "UnitInquiryInfo.html"
    });

})();