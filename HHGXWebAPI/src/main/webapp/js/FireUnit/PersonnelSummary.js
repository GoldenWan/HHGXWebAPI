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

        var userName = $("#userName").val();

        var info = {
            orgid: sessionStorage.getItem("OrgID"),
            peopleType: $("#peopleType").val(),
            peopleName: userName,
            PageIndex: nowNum
        };
        HH.post("/PersonInfo/SelectPeople", info, function (data) {

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
        if (num != allNum) {
            num = num + 1;
            pageReload(num);
        }
    });

    $("#check_btn").click(function () {
        pageReload(1);
    });

    getList("/PersonInfo/GetPeopleType", {}, "PeopleTypeName", "PeopleTypeName", "#peopleType", null, function () {
        $("#check_btn").click()
    });
    getList("/PersonInfo/GetPeopleType", {}, "PeopleTypeName", "PeopleTypeName", "#peopleType_add",null,null,true);

    $("#selectModal_btn").click(function () {
        var add_type = $("#peopleType_add").val();
        var myJson = people[add_type];

        myJson["orgid"] = sessionStorage.getItem("OrgID");
        myJson["PeopleTypeName"] = add_type;

        $("#selectModal").modal('hide');

        render("#addView", "#addPage", myJson);

        getList("/Common/GetDictionary", {TypeName: "文化程度"}, "", "", "#add_education");

        dataPick("#birthDate_add");
        dataPick("#entryDate_add");
        dataPick("#trainDate_add");
        dataPick("#issuingDate_add");
        dataPick("#licensingDate_add");

        setTimeout(function () {
            $("#addModal").modal('show');
            $("#select_type").get(0).reset();
        }, 500);

    });

    $("#peopleType").on("change", function () {
        pageReload();
    });

    //添加人员照片
    $("#addPage").on("change", "#people_portrait_add>input", function () {
        $("#portrait_img_add").attr("src", getObjectURL(this.files[0]));
    });

    //修改人员照片
    $("#editModal").on("change", "#people_portrait_edit>input", function () {
        $("#portrait_img_edit").attr("src", getObjectURL(this.files[0]));
    });

    //添加人员
    $("#addPage").on("click", "#add_btn", function () {

        var addList = [
            "#form_add input[name='PeopleName']",
            "#form_add input[name='identification']",
            "#form_add input[name='job']"
        ];

        var addState = inJudge(addList);

        if(addState){
            var options = {
                url: ApiUrl + "/Form/AddPeople", //默认是form的action， 如果申明，则会覆盖
                type: "post",               //默认是form的method（get or post），如果申明，则会覆盖
                dataType: "json",           //html(默认), xml, script, json...接受服务端返回的类型
                //clearForm: true,          //成功提交后，清除所有表单元素的值
                resetForm: true,          //成功提交后，重置所有表单元素的值
                //timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求
                //beforeSubmit: showRequest,  //提交前的回调函数
                success: function (data) {
                    if (data.StateMessage == 1000) {
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
            };
            $("#form_add").ajaxSubmit(options);

        }

    });

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/PersonInfo/PeopleDetail", {PeopleNo: operationId}, function (data) {

            var peopleInfo = data.DataBag[0];
            var myJson = people[peopleInfo.PeopleTypeName];

            myJson["data"] = peopleInfo;
            myJson["orgid"] = sessionStorage.getItem("OrgID");
            myJson["PeopleTypeName"] = peopleInfo.PeopleTypeName;

            render("#checkView", "#checkPage", myJson);

        });

    });

    //操作修改
    $("#in_page").on("click", ".btn_edit", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/PersonInfo/PeopleDetail", {PeopleNo: operationId}, function (data) {

            var peopleInfo = data.DataBag[0];
            var myJson = people[peopleInfo.PeopleTypeName];

            myJson["data"] = peopleInfo;
            myJson["orgid"] = sessionStorage.getItem("OrgID");
            myJson["PeopleNo"] = operationId;
            myJson["PeopleTypeName"] = peopleInfo.PeopleTypeName;

            render("#editView", "#editPage", myJson);

            $("#edit_sex").val(peopleInfo.sex);
            $("#edit_YnTraining").val(peopleInfo.YnTraining);
            $("#edit_YnEscapeLeader").val(peopleInfo.YnEscapeLeader);

            getList("/Common/GetDictionary", {TypeName: "文化程度"}, "", "", "#edit_education", peopleInfo.education);

            $("#edit_department").val(peopleInfo.department);

            dataPick("#birthDate_edit");
            dataPick("#entryDate_edit");
            dataPick("#trainDate_edit");
            dataPick("#issuingDate_edit");
            dataPick("#licensingDate_edit");

            $("#edit_btn").click(function () {

                var editList = [
                    "#form_edit input[name='PeopleName']",
                    "#form_edit input[name='identification']",
                    "#form_edit input[name='job']"
                ];

                var editState = inJudge(editList);

                if(editState){
                    var options = {
                        url: ApiUrl + "/Form/UpdatePeople", //默认是form的action， 如果申明，则会覆盖
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
                    };
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
        HH.post("/PersonInfo/DeletePeople", {PeopleNo: deleteId}, function (data) {
            $('#deleteModal').modal('hide');
            pageReload();
        });
    })


})();