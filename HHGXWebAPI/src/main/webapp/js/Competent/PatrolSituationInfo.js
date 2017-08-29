(function () {

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
            OrgID: sessionStorage.getItem("FireOrgID"),
            StartDate: startTime,
            EndDate: stopTime,
            PageIndex: nowNum
        };

        HH.post("/Patrol/GetPatrolRecordByOrg", info, function (data) {
            var myJson = {data: data.DataBag};
            $.each(myJson.data.PageDatas, function (i, v) {
                v["num"] = i * 1 + 1 + nowNum * 20 - 20;
            });
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

    $("#startDate").find("input").val(myDate.getFullYear() + "/" + (myDate.getMonth() - 1) + "/" + myDate.getDate());
    $("#stopDate").find("input").val(myDate.getFullYear() + "/" + (myDate.getMonth() + 1) + "/" + myDate.getDate());

    $("#check_btn").click(function () {
        pageReload(1);
    });

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Patrol/GetCheckRecord", {UserCheckId: operationId}, function (data) {
            var myJson = data.DataBag[0];
            var arr = [];

            $.each(myJson.Projects, function (i, v) {
                v["len"] = v.Content.length;
                for (var j = 0; j < v.Content.length; j++) {
                    arr.push(v.Content[j].PicInfo);
                }
                ;
            });

            var info = {
                data: myJson,
                pic: arr
            };

            //图片添加路径
            Handlebars.registerHelper("myTd", function (ng, options) {
                var node = "";
                for (var i = 0; i < ng.length; i++) {
                    for (var j = 0; j < ng[i].Content.length; j++) {
                        node = node + '<tr>';
                        if (j == 0) {
                            node = node + '<td rowspan="' + ng[i].len + '">' + ng[i].ProjectContent + '</td>';
                        }
                        node = node +
                            '<td>' + ng[i].Content[j].ProjectContent + '</td>' +
                            '<td>' + ng[i].Content[j].UserCheckResult + '</td>' +
                            '<td>' + ng[i].Content[j].FaultShow + '</td>' +
                            '<td>' + ng[i].Content[j].YnHanding + '</td>' +
                            '<td>' + ng[i].Content[j].Handingimmediately + '</td>' +
                            '</tr>';
                    }
                    ;
                }
                ;
                return node;
            });

            render("#checkView", "#checkPage", info);
        });

    });

    $("#check_btn").click();

})();