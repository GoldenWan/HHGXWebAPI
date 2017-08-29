(function () {

    var deleteId;
    var submitId;
    var checkId;

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
            OrgID: sessionStorage.getItem("OrgID"),
            StartDate: startTime,
            EndDate: stopTime,
            PageIndex: nowNum
        };
        HH.post("/Patrol/GetPatrolRecordByOrg", info, function (data) {
            var myJson = {data: data.DataBag.PageDatas};
            $.each(myJson.data, function (i, v) {
                v["num"] = i * 1 + 1 + nowNum * 20 - 20;
            });

            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pageCount;

            createPaging("#in_paging", nowNum, allNum);

        });

    }

    dataPick("#startDate");
    dataPick("#stopDate");
    dataPick("#patrolDate_add", null, null, new Date());

    $("#startDate").find("input").val(myDate.getFullYear() + "/" + (myDate.getMonth() - 1) + "/" + myDate.getDate());
    $("#stopDate").find("input").val(myDate.getFullYear() + "/" + (myDate.getMonth() + 1) + "/" + myDate.getDate());

    //查询按钮
    $("#check_btn").click(function () {
        pageReload(1)
    });

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

    $("#check_btn").click();

    ////添加处理方法
    //$("#add_btn").click(function () {
    //
    //    var add_state = emptyTest("#safetyManager");
    //    add_state = emptyTest("#patrolDate_add>input");
    //
    //    if (add_state) {
    //        var myJson = {
    //            OrgID: sessionStorage.getItem("OrgID"),
    //            UserCheckTime: $("#patrolDate_add").find("input").val(),
    //            OrgUser: sessionStorage.getItem("RealName"),
    //            OrgManagerId: $("#safetyManager").val()
    //        };
    //        HH.post("/Patrol/AddUserCheckList", myJson, function (data) {
    //            sessionStorage.setItem("UserCheckId", data.DataBag);
    //            window.location.href = "DailyFireInfo.html";
    //        });
    //    }
    //
    //});

    //$("#safetyManager").blur(function () {
    //    emptyTest("#safetyManager");
    //});

    ////判空验证
    //function emptyTest(node) {
    //    var value = $(node).val();
    //
    //    value = value.replace(/(^\s+)|(\s+$)/g, "");
    //    value = value.replace(/\s/g, "");
    //
    //    if (value) {
    //        $(node).next().css("visibility", "hidden");
    //        $(node).css("border-color", "#ccc");
    //        return true;
    //    } else {
    //        $(node).next().css("visibility", "visible");
    //        $(node).css("border-color", "red");
    //        return false;
    //    }
    //
    //}

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        checkId = $(this).attr("data-id");

        HH.post("/Patrol/GetCheckRecordBase", {UserCheckId: checkId}, function (data) {
            var myJson = data.DataBag[0];
            render("#checkView", "#checkPage", myJson);
            $("#checkPage").find("#site").change();

            //Handlebars.registerHelper("myTd", function (ng, options) {
            //    var node = "";
            //
            //    return node;
            //});

        });

    });

    $("#checkPage").on("change", "#site", function () {
        var info = {
            UserCheckId: checkId,
            siteid: $(this).val()
        };
        HH.post("/Patrol/GetCheckRecord", info, function (data) {
            var myJson = data.DataBag;
            var arr = [];

            $.each(myJson, function (i, v) {
                var len = 0;
                for(var s=0;s<v.vSysContent.length;s++){
                    v.vSysContent[s]["len"] = v.vSysContent[s].Content.length;
                    len = len + v.vSysContent[s].Content.length;

                    for (var j = 0; j < v.vSysContent[s].Content.length; j++) {
                        arr.push(v.vSysContent[s].Content[j].PicInfo);
                    }
                }
                v["len"] = len;

                //v["len"] = v.vSysContent.Content.length*v.vSysContent.length;

            });
            var table = '<div class="col-sm-12">' +
                '<table class="table table-striped table-hover main_table"> ' +
                '<thead> ' +
                '<tr> ' +
                '<td>建筑物</td> ' +
                '<td>巡查项目</td> ' +
                '<td>巡查内容</td> ' +
                '<td>巡查结果</td> ' +
                '<td>故障现象</td> ' +
                '<td>是否当场处理</td> ' +
                '<td>现场处理情况</td> ' +
                '</tr> ' +
                '</thead> ' +
                '<tbody>';
            for (var n = 0; n < myJson.length; n++) {
                table = table + '<tr>';
                table = table + '<td rowspan="' + myJson[n].len + '">' + myJson[n].sitename + '</td>';
                for(var i=0;i<myJson[n].vSysContent.length;i++){
                    for (var j = 0; j < myJson[n].vSysContent[i].Content.length; j++) {
                        if (j == 0) {
                            table = table + '<td rowspan="' + myJson[n].vSysContent[i].len + '">' + myJson[n].vSysContent[i].vSysdesc + '</td>';
                        }
                        table = table +
                            '<td>' + myJson[n].vSysContent[i].Content[j].ProjectContent + '</td>' +
                            '<td>' + myJson[n].vSysContent[i].Content[j].UserCheckResult + '</td>' +
                            '<td>' + myJson[n].vSysContent[i].Content[j].FaultShow + '</td>' +
                            '<td>' + myJson[n].vSysContent[i].Content[j].YnHanding + '</td>' +
                            '<td>' + myJson[n].vSysContent[i].Content[j].Handingimmediately + '</td>' +
                            '</tr>';
                    }
                }

            }
            table = table + '</tbody></table></div>';
            var image = '<div class="col-sm-12"> ' +
                '<label>巡查现场照片：</label> ' +
                '<div class="scene_img">';
            for(var k=0;k<arr.length;k++){
                for(var o=0;o<arr[k].Picture.length;o++){
                    image = image + '<div> ' +
                        '<a href="'+ImgUrl+arr[k].Picture[o].PicPath+'" target="view_window"><img src="'+ImgUrl+arr[k].Picture[o].PicPath+'"/></a> ' +
                        '<span>巡查项目：'+arr[k].PicProject+'</span> ' +
                        '<span>巡查内容：'+arr[k].PicContent+'</span> ' +
                        '</div>';
                }
            }
            image = image + '</div></div>';

            $("#myTable").html(table + image)

        })
    });

    ////操作修改
    //$("#in_page").on("click", ".btn_edit", function () {
    //    var operationId = $(this).attr("data-id");
    //
    //    sessionStorage.setItem("UserCheckId", operationId);
    //    window.location.href = "DailyFireInfo.html";
    //
    //});

    ////操作提交
    //$("#in_page").on("click", ".btn_commit", function () {
    //    submitId = $(this).attr("data-id");
    //    $('#submitModal').modal('show');
    //});

    //$("#submitModal_btn").click(function(){
    //    HH.post("/Patrol/UpdateSubmitState", {UserCheckId: submitId}, function (data) {
    //        if (data.DataBag.flag) {
    //            pageReload();
    //            $('#submitModal').modal('hide');
    //        } else {
    //            $('#submitModal').modal('hide');
    //            $('#messageModal').modal('show');
    //        }
    //    });
    //});

    //操作删除
    $("#in_page").on("click", ".btn_delete", function () {
        deleteId = $(this).attr("data-id");
    });
    $("#deleteModal").on("click", "#deleteModal_btn", function () {
        HH.post("/Patrol/DeleteCheckRecord", {UserCheckId: deleteId}, function (data) {
            $('#deleteModal').modal('hide');
            pageReload();
        });
    })

})();