(function () {

    var allNum = 1;
    var siteList = {};

    //局部刷新
    function pageReload(nowNum) {

        var nowNum = parseInt(nowNum);

        if (!nowNum) {
            nowNum = parseInt($("#in_paging").find(".pagination>.active").text());
            if (isNaN(nowNum)) {
                nowNum = 1;
            }
        }

        var building = $("#select_building").val();
        var system = $("#select_system").val();

        if (system != "" && system != " " && system != null && system != undefined) {
            var info = {
                "siteid": building,
                "tiSysType": system,
                "PageIndex": nowNum
            };
            HH.post("/Orginfo/DataMonitor", info, function (data) {

                var myJson = {data: data.DataBag.PageDatas};

                render("#in_view", "#in_page", myJson);

                allNum = data.DataBag.PageCount;

                createPaging("#in_paging", nowNum, allNum);

            });
        }

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

    //查询按钮
    $("#check_btn").click(function () {
        pageReload(1)
    });

    //获取建筑物、系统列表
    HH.post("/Orginfo/OrgSiteSys", {orgid: sessionStorage.getItem("OrgID")}, function (data) {
        $.each(data.DataBag, function (i, v) {
            siteList[v.siteid] = v;
        });
        var node = "";
        $.each(siteList, function (i, v) {
            node = node + "<option value='" + v.siteid + "'>" + v.sitename + "</option>";
        });

        $("#select_building").html(node);

        $("#select_building").change(function () {
            var site = $(this).val();

            var sys = siteList[site];
            if (sys) {
                sys = sys.Sys;

                var node = "";
                $.each(sys, function (i, v) {
                    node = node + "<option value='" + v.tiSysType + "'>" + v.vSysdesc + "</option>";
                });
                $("#select_system").html(node);
            }

        });

        $("#select_building").change();

        $("#check_btn").click();


    });

})();