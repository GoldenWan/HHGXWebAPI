(function () {

    var deleteId;

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
            "orgid": sessionStorage.getItem("OrgID"),
            "startTime": startTime,
            "endTime": stopTime,
            "PageIndex": nowNum
        };
        HH.post("/Facility/GetManoeuvreList", info, function (data) {
            var myJson = {data: data.DataBag.PageDatas};

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
    dataPick("#fireDate_add");

    //上传文件按钮
    $("#form_add").find("input[type=file]").change(function () {
        fileUp(this, "file");
    });

    //添加处理方法
    $("#add_btn").click(function () {

        $("#orgid_add").val(sessionStorage.getItem("OrgID"));

        var options = {
            url: ApiUrl + "/Form/AddManoeuvre", //默认是form的action， 如果申明，则会覆盖
            type: "post",               //默认是form的method（get or post），如果申明，则会覆盖
            dataType: "json",           //html(默认), xml, script, json...接受服务端返回的类型
            //clearForm: true,          //成功提交后，清除所有表单元素的值
            resetForm: true,          //成功提交后，重置所有表单元素的值
            //timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求
            //beforeSubmit: showRequest,  //提交前的回调函数
            success: function (data) {
                if (data.StateMessage == 1000) {
                    $('#addModal').modal('hide');
                    $("#form_add").find("input[type=file]").parent().prev().text("");
                    pageReload();
                } else if (data.StateMessage == -1) {
                    window.location.href = "../index.html";
                } else if (data.StateMessage == -2) {
                    alert(data.DataBag);
                } else if (data.StateMessage == -256) {
                    console.log(data.DataBag);
                } else {
                    console.log("状态码不对，StateMessage=" + data.StateMessage);
                }
            }//提交后的回调函数
        };
        $("#form_add").ajaxSubmit(options);

    });

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Facility/GetManoeuvreDetail", {manoeuvreID: operationId}, function (data) {
            var myJson = data.DataBag;
            console.log(data)

            if (myJson.attendpersonfile) {
                myJson["attendpersonfileName"] = myJson.attendpersonfile.split("/").pop();
            }
            if (myJson.implementationfile) {
                myJson["implementationfileName"] = myJson.implementationfile.split("/").pop();
            }
            if (myJson.schemafile) {
                myJson["schemafileName"] = myJson.schemafile.split("/").pop();
            }

            myJson["api"] = ApiUrl;

            render("#checkView", "#checkPage", myJson);
        });

    });

    //操作修改
    $("#in_page").on("click", ".btn_edit", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Facility/GetManoeuvreDetail", {manoeuvreID: operationId}, function (data) {
            var myJson = data.DataBag;

            if (myJson.attendpersonfile) {
                myJson.attendpersonfile = myJson.attendpersonfile.split("/").pop();
            }
            if (myJson.implementationfile) {
                myJson.implementationfile = myJson.implementationfile.split("/").pop();
            }
            if (myJson.schemafile) {
                myJson.schemafile = myJson.schemafile.split("/").pop();
            }

            render("#editView", "#editPage", myJson);
            dataPick("#fireDate_edit");

            //上传文件按钮
            $("#form_edit").find("input[type=file]").change(function () {
                fileUp(this, "file");
            });

            $("#edit_btn").click(function () {

                var options = {
                    url: ApiUrl + "/Form/UpdateManoeuvre", //默认是form的action， 如果申明，则会覆盖
                    type: "post",               //默认是form的method（get or post），如果申明，则会覆盖
                    dataType: "json",           //html(默认), xml, script, json...接受服务端返回的类型
                    //clearForm: true,          //成功提交后，清除所有表单元素的值
                    //resetForm: true,          //成功提交后，重置所有表单元素的值
                    //timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求
                    //beforeSubmit: showRequest,  //提交前的回调函数
                    success: function (data) {
                        if (data.StateMessage == 1000) {
                            $('#editModal').modal('hide');
                            pageReload();
                        } else if (data.StateMessage == -1) {
                            window.location.href = "../index.html";
                        } else if (data.StateMessage == -2) {
                            console.log(data.DataBag);
                        } else if (data.StateMessage == -256) {
                            console.log(data.DataBag);
                        } else {
                            console.log("状态码不对，StateMessage=" + data.StateMessage);
                        }
                    }//提交后的回调函数
                };
                $("#form_edit").ajaxSubmit(options);

            });

        });

    });

    //操作删除
    $("#in_page").on("click", ".btn_delete", function () {
        deleteId = $(this).attr("data-id");
    });
    $("#deleteModal").on("click", "#deleteModal_btn", function () {
        HH.post("/Faclity/DeleteManoeuvre", {manoeuvreID: deleteId}, function (data) {
            $('#deleteModal').modal('hide');
            pageReload();
        });
    });

    //查询按钮
    $("#check_btn").click(function () {
        pageReload(1)
    });

    $("#check_btn").click();


})();