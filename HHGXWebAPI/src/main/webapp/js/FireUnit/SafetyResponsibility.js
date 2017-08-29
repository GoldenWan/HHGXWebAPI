(function () {

    var deleteId;

    var add_state = false;

    var allNum = 1;

    dataPick("#startDate");
    dataPick("#stopDate");

    //局部刷新
    function pageReload(nowNum) {

        var nowNum = parseInt(nowNum);

        if (!nowNum) {
            nowNum = parseInt($("#in_paging").find(".pagination>.active").text());
            if (isNaN(nowNum)) {
                nowNum = 1;
            }
        }

        var info = {
            orgid: sessionStorage.getItem("OrgID"),
            PageIndex: nowNum
        };
        HH.post("/ManageRule/SearchSafeDuty", info, function (data) {

            var myJson = {
                api: ApiUrl,
                data: data.DataBag.PageDatas
            };
            $.each(myJson.data, function (i, v) {
                var name = v.filepath.split(".");
                v["filename"] = name[name.length - 1];
            });

            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pageCount;

            createPaging("#in_paging", nowNum, allNum);

        });
    };

    pageReload(1);

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

    //获取复选框列表
    function getCheck(api, info, node, arr) {
        HH.post(api, info, function (data) {

            var myJson = data.DataBag;
            var op = "";
            $.each(myJson, function (i, v) {
                op = op + "<div><input type='checkbox' value='" + v + "'/><span>" + v + "</span></div>"
            });

            $(node).html(op)

            if (arr) {
                var typeArr = arr;
                var inArr = $(node).find("input");
                $.each(inArr, function (i, v) {
                    for (var k = 0; k < typeArr.length; k++) {
                        if ($(v).val() == typeArr[k]) {
                            v.checked = true;
                            typeArr.splice(k, 1);
                        }
                        ;
                    }
                });
            }

        });
    }

    getCheck("/Common/GetDictionary", {TypeName: "安全职责"}, "#check_add");

    //制度名称判空
    function systemName(node) {
        var info = $(node).val();
        info = info.replace(/(^\s+)|(\s+$)/g, "");
        info = info.replace(/\s/g, "");
        if (info != "" && info != undefined && info != null) {
            $(node).next().css("visibility", "hidden")
            $(node).css("border-color", "#ccc");
            add_state = true;
        } else {
            $(node).next().css("visibility", "visible")
            $(node).css("border-color", "red");
            add_state = false;
        }
    }

    $("#sysName_add").blur(function () {
        systemName("#sysName_add");
    });

    //上传文件按钮
    $("#up_file_add").find("input").change(function () {
        fileUp(this, "file");
    });

    //添加处理方法
    $("#add_btn").click(function () {

        systemName("#sysName_add");

        if (add_state) {

            var ck = [];
            var arr = $("#check_add").find("input");

            $.each(arr, function (i, v) {
                if (v.checked == true) {
                    ck.push($(v).val());
                }
            });
            $("#checkIn_add").val(ck);
            $("#orgid_add").val(sessionStorage.getItem("OrgID"));

            var options = {
                url: ApiUrl + "/Form/AddSafeDuty", //默认是form的action， 如果申明，则会覆盖
                type: "post",               //默认是form的method（get or post），如果申明，则会覆盖
                dataType: "json",           //html(默认), xml, script, json...接受服务端返回的类型
                //clearForm: true,          //成功提交后，清除所有表单元素的值
                resetForm: true,          //成功提交后，重置所有表单元素的值
                //timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求
                //beforeSubmit: showRequest,  //提交前的回调函数
                success: function (data) {
                    if (data.StateMessage == 1000) {
                        $("#up_name_add").text("");
                        $('#addModal').modal('hide');
                        pageReload();
                    } else if (data.StateMessage == -1) {
                        window.location.href = "../index.html";
                    } else if (data.StateMessage == -2) {
                        console.log(data.DataBag);
                    } else if (data.StateMessage == -256) {
                        console.log(data.DataBag);
                    }
                }//提交后的回调函数
            }
            $("#form_add").ajaxSubmit(options);

        }

    });

    //操作修改
    $("#in_page").on("click", ".btn_edit", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/ManageRule/SafeDutyInfo", {SafeDutyID: operationId}, function (data) {

            var myJson = data.DataBag;

            render("#editView", "#editPage", myJson);

            $("#SafeDutyID").val(operationId);
            //上传文件按钮
            $("#up_file_edit").find("input").change(function () {
                fileUp(this, "file");
            });

            var typeArr = myJson.safedutytype.split(",");
            getCheck("/Common/GetDictionary", {TypeName: "安全职责"}, "#check_edit", typeArr);

            $("#sysName_edit").blur(function () {
                systemName("#sysName_edit");
            });

            $("#edit_btn").click(function () {

                systemName("#sysName_edit");

                if (add_state) {

                    var ck = [];
                    var arr = $("#check_edit").find("input");

                    $.each(arr, function (i, v) {
                        if (v.checked == true) {
                            ck.push($(v).val());
                        }
                    });
                    $("#checkIn_edit").val(ck);
                    $("#orgid_edit").val(sessionStorage.getItem("OrgID"));

                    var options = {
                        url: ApiUrl + "/Form/UpdateSafeDuty", //默认是form的action， 如果申明，则会覆盖
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
                            }
                        }//提交后的回调函数
                    }
                    $("#form_edit").ajaxSubmit(options);

                }
            });


        });

    });

    //操作删除
    $("#in_page").on("click", ".btn_delete", function () {
        deleteId = $(this).attr("data-id");
    });
    $("#deleteModal").on("click", "#deleteModal_btn", function () {
        HH.post("/ManageRule/DeleteSafeDuty", {SafeDutyID: deleteId}, function (data) {
            $('#deleteModal').modal('hide');
            pageReload();
        });
    })


})();