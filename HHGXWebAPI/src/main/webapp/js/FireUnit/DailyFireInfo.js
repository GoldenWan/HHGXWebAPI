(function () {

    var source;
    var imgNum = 0;
    var delList = [];

    $("#back_btn").click(function(){
        window.location.href = "./DailyFire.html";
    });

    //局部刷新
    function pageReload() {

        HH.post("/Patrol/GetCheckRecord", {UserCheckId: sessionStorage.getItem("UserCheckId")}, function (data) {
            var myJson = data.DataBag[0];
            source = myJson;
            var arr = [];

            $.each(myJson.Projects, function (i, v) {
                v["len"] = v.Content.length;
                for (var j = 0; j < v.Content.length; j++) {
                    arr.push(v.Content[j].PicInfo);
                }
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
                            '<td><a class="operation btn_edit" data-id="' + i + ',' + j + '" data-toggle="modal" data-target="#editModal">填写</a></td>' +
                            '</tr>';
                    }
                }
                return node;
            });

            render("#my_view", "#my_page", info);
        });

    };
    pageReload();

    //修改日期处理方法
    $("#my_page").on("click", ".btn_check", function () {
        dataPick("#patrolDate_add", $("#UserCheckTime").text());
        $("#patrolDate_add").find("input").val($("#UserCheckTime").text());

        $("#add_btn").click(function () {
            var myJson = {
                UserCheckId: sessionStorage.getItem("UserCheckId"),
                UserCheckTime: $("#patrolDate_add").find("input").val()
            };

            HH.post("/Patrol/UpdateUserCheckList", myJson, function (data) {
                $('#addModal').modal('hide');
                pageReload();
            });
        });
    });

    function radioInit(node, info) {
        var radioList = $(node).find("input");
        $.each(radioList, function (i, v) {
            if ($(v).val() == info) {
                v.checked = true;
                $(this).click();
            };
        });
    }

    //操作修改
    $("#my_page").on("click", ".btn_edit", function () {
        imgNum = 0;
        var operationId = $(this).attr("data-id").split(",");
        var i = operationId[0];
        var j = operationId[1];

        var myJson = source.Projects[i].Content[j];
        myJson["Pid"] = source.Projects[i].ProjectId;
        myJson["Pname"] = source.Projects[i].ProjectContent;
        myJson["UserCheckId"] = sessionStorage.getItem("UserCheckId");
        myJson["wbUserID"] = sessionStorage.getItem("RealName");

        render("#editView", "#editPage", myJson);

        $("#faultBlock").hide();

        createFile();

        radioInit("#UserCheckResult", myJson.UserCheckResult);
        radioInit("#YnHanding", myJson.YnHanding);

    });

    //创建新增图片节点
    function createFile() {
        imgNum++;
        var node =
            '<div class="img_new">' +
            '<a class="img_body" target="view_window"><img/></a>' +
            '<div type-id="2" class="new_del del_btn">删除</div>' +
            '<a class="up_new">添加图片<input type="file" name="imgFile'+ imgNum + '" accept="image/*"></a>' +
            '</div>';
        $("#upImg").append(node);
    }

    //添加图片
    $("#editModal").on("change", ".up_new>input", function () {
        var state = imgFileChange(this);
        if(state){
            var parent = $(this).parent().parent();

            parent.find("a").attr("href", getObjectURL(this.files[0]));
            parent.find("a>img").attr("src", getObjectURL(this.files[0]));
            parent.find(".up_new").css("z-index", "0");
            parent.find(".new_del").removeClass("new_del");

            createFile();
        }
    });

    //图片删除
    $("#editModal").on("click", ".del_btn", function () {
        var type = $(this).attr("type-id");
        if(type=="1"){
            var dataId = $(this).attr("data-id");
            delList.push(dataId);
        }
        var parent = $(this).parent();
        parent.remove();
        imgNum=imgNum-1;
        var imgNode = $("#upImg>div").find("a>input");
        if(imgNode.length!=0){
            $.each(imgNode,function(i,v){
                var nowNum = i*1+1;
                $(v).attr("name","imgFile"+nowNum);
            });
        };
    });

    //填写提交
    $("#editModal").on("click", "#edit_btn", function () {

        delList = delList.join(",");
        $("#listNum").val(imgNum-1);
        $("#delList").val(delList);

        var options = {
            url: ApiUrl + "/Form/AddOrUpdateCheckRecord", //默认是form的action， 如果申明，则会覆盖
            type: "post",               //默认是form的method（get or post），如果申明，则会覆盖
            dataType: "json",           //html(默认), xml, script, json...接受服务端返回的类型
            //clearForm: true,          //成功提交后，清除所有表单元素的值
            //resetForm: true,          //成功提交后，重置所有表单元素的值
            //timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求
            //beforeSubmit: showRequest,  //提交前的回调函数
            success: function (data) {
                if (data.StateMessage == 1000) {
                    $('#editModal').modal('hide');
                    imgNum = 0;
                    delList = [];
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

    });

    //radio点击
    $("#editModal").on("click", ".in_radio", function () {
        $(this).find("input").get(0).checked = true;
        var name = $(this).find("input").prop("name");
        var value = $(this).find("input").val();
        if(name=="UserCheckResult"){
            if(value=="正常"){
                $("#faultBlock").hide();
            }else if(value=="故障"){
                $("#faultBlock").show();
            }
        }else if(name=="YnHanding"){
            if(value=="是"){
                $("#handingBlock").show();
            }else if(value=="否"){
                $("#handingBlock").hide();
            }
        }

    });


})();