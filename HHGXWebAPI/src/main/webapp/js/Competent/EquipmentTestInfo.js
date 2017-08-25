(function () {

    var CompanyName = sessionStorage.getItem("EquipmentName");
    $("#title_name").text(CompanyName);

    var allNum = 1;

    var imgList = {};

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
            orgid: sessionStorage.getItem("EquipmentId"),
            startTime: startTime,
            endTime: stopTime,
            PageIndex: nowNum
        };
        HH.post("/Orginfo/GetRepaireList", info, function (data) {
            var myJson = {data: data.DataBag.PageDatas};
            $.each(myJson.data, function (i, v) {
                v["num"] = i * 1 + 1 + nowNum * 20 - 20;
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

    //查询按钮
    $("#check_btn").click(function () {
        pageReload(1)
    });

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Orginfo/RepaireInfo", {wbRepaireListId: operationId}, function (data) {

            var myJson = data.DataBag[0];
            myJson["CompanyName"] = CompanyName;

            $.each(myJson.checkProjects, function (i, v) {
                v["len"] = v.Projects.length;
                for (var j = 0; j < v.Projects.length; j++) {
                    imgList[v.Projects[j].ProjectId] = v.Projects[j].Pics;
                }
            });

            //图片添加路径
            Handlebars.registerHelper("myTd", function (ng, options) {
                var node = "";
                for (var i = 0; i < ng.length; i++) {
                    for (var j = 0; j < ng[i].Projects.length; j++) {
                        node = node + '<tr>';
                        if (j == 0) {
                            node = node + '<td rowspan="' + ng[i].len + '">' + ng[i].vSysdesc + '</td>';
                        }
                        node = node +
                            '<td>' + ng[i].Projects[j].ProjectName + '</td>' +
                            '<td>' + ng[i].Projects[j].ProjectContent + '</td>' +
                            '<td>' + ng[i].Projects[j].IsGood + '</td>' +
                            '<td>' + ng[i].Projects[j].wbRepairedRemarks + '</td>' +
                            '<td>' + ng[i].Projects[j].YnHanding + '</td>' +
                            '<td>' + ng[i].Projects[j].Handingimmediately + '</td>' +
                            '<td>' + ng[i].Projects[j].wbRepairedNumber + '</td>';
                        if (ng[i].imgNum != 0) {
                            node = node + '<td><a class="operation img_btn" data-id="' + ng[i].Projects[j].ProjectId + '">查看详情</a></td>'
                        } else {
                            node = node + '<td><a class="noImg_btn">查看详情</a></td>'
                        }
                        node = node + "</tr>";
                    }
                }
                return node;
            });

            render("#checkView", "#checkPage", myJson);
        });

    });

    $("#check_btn").click();

    //操作查看图片
    $("#checkPage").on("click", ".img_btn", function () {
        var operationId = $(this).attr("data-id");

        var imgArr = imgList[operationId];
        var len = true;
        if (imgArr.length > 1) {
            len = true;
        } else {
            len = false;
        }

        var myJson = {
            data: imgArr,
            len: len
        };

        render("#imgView", ".imgPage", myJson);

        $(".imgContent").find("img:first").addClass("imgShow");

        $("#imgModal").modal("show");
    });

    //图片向左切换按钮
    $("#img_left").click(function () {
        var node = $(".imgShow");

        if (node.prev().length != 0) {
            node.prev().addClass("imgShow");
        } else {
            node.parent().find("img:last").addClass("imgShow");
        }

        node.removeClass("imgShow");
    });

    //图片向右切换按钮
    $("#img_right").click(function () {
        var node = $(".imgShow");

        if (node.next().length != 0) {
            node.next().addClass("imgShow");
        } else {
            node.parent().find("img:first").addClass("imgShow");
        }

        node.removeClass("imgShow");
    });

})();