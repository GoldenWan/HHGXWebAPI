(function () {

    var allNum = 1;

    var img_num = 0;

    //�ֲ�ˢ��
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

        HH.post("/Orginfo/GetFireSystemList", info, function (data) {
            var myJson = {data: data.DataBag.PageDatas};
            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pageCount;

            createPaging("#in_paging", nowNum, allNum);
        });
    };

    //ҳ��
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

    pageReload(1);

    //��ȡ�������б�
    getList("/Orginfo/BriefsiteList", {orgid: sessionStorage.getItem("OrgID")}, "siteid", "sitename", "#build_add",null,null,true);
    //��ȡϵͳ�����б�
    getList("/Facility/GetAllSys", {}, "tiSysType", "vSysdesc", "#system_add",null,null,true);

    //����ϴ�ͼƬ��ť
    $("#up_file_add").find("input").change(function () {
        imgFileChange(this);
        var file = $(this).val().split("\\");
        file = file[file.length - 1];
        $("#up_name_add").text(file);
    });

    //��Ӵ�����
    $("#add_btn").click(function () {

        var options = {
            url: ApiUrl + "/Form/AddorgSys", //Ĭ����form��action�� �����������Ḳ��
            type: "post",               //Ĭ����form��method��get or post���������������Ḳ��
            dataType: "json",           //html(Ĭ��), xml, script, json...���ܷ���˷��ص�����
            //clearForm: true,          //�ɹ��ύ��������б�Ԫ�ص�ֵ
            resetForm: true,          //�ɹ��ύ���������б�Ԫ�ص�ֵ
            //timeout: 3000               //���������ʱ�䣬���������3�����������
            //beforeSubmit: showRequest,  //�ύǰ�Ļص�����
            success: function (data) {
                if (data.StateMessage == 1000) {
                    if (data.DataBag) {
                        $('#addModal').modal('hide');
                        $('#up_name_add').text("");
                        pageReload();
                    } else {
                        console.log("ȱ��DataBag����")
                    }
                } else if (data.StateMessage == -1) {
                    window.location.href = "../index.html";
                } else if (data.StateMessage == -2) {
                    alert(data.DataBag)
                } else if (data.StateMessage == -256) {
                    console.log(data.DataBag);
                } else {
                    console.log("״̬�벻�ԣ�StateMessage=" + data.StateMessage);
                }
            }//�ύ��Ļص�����
        };
        $("#form_add").ajaxSubmit(options);

    });

    //�����޸�
    $("#in_page").on("click", ".btn_edit", function () {
        var operationId = $(this).attr("data-sid");
        var operationId2 = $(this).attr("data-tid");

        var info = {
            siteid: operationId,
            tisystype: operationId2
        };

        HH.post("/Orginfo/GetOnlineFireSystem", info, function (data) {

            var myJson = data.DataBag[0];

            if (myJson.SysFlatpic) {
                var name = myJson.SysFlatpic.split("/");
                myJson["filename"] = name[name.length - 1];
            } else {
                myJson["filename"] = "";
            }

            render("#editView", "#editPage", myJson);
            $("#states_edit").val($.trim(myJson.states))
            $("#YnOnline_edit").val($.trim(myJson.YnOnline));

            //�޸��ϴ�ͼƬ��ť
            $("#up_file_edit").find("input").change(function () {
                imgFileChange(this);
                var file = $(this).val().split("\\");
                file = file[file.length - 1];
                $("#up_name_edit").text(file);
            });

            //��ȡ�������б�
            getList("/Orginfo/BriefsiteList", {orgid: sessionStorage.getItem("OrgID")}, "siteid", "sitename", "#build_edit", myJson.siteid);
            //��ȡϵͳ�����б�
            getList("/Facility/GetAllSys", {}, "tiSysType", "vSysdesc", "#system_edit", myJson.tiSysType);

            $("#edit_btn").click(function () {

                var options = {
                    url: ApiUrl + "/Form/UpdateFireSystemList", //Ĭ����form��action�� �����������Ḳ��
                    type: "post",               //Ĭ����form��method��get or post���������������Ḳ��
                    dataType: "json",           //html(Ĭ��), xml, script, json...���ܷ���˷��ص�����
                    //clearForm: true,          //�ɹ��ύ��������б�Ԫ�ص�ֵ
                    resetForm: true,          //�ɹ��ύ���������б�Ԫ�ص�ֵ
                    //timeout: 3000               //���������ʱ�䣬���������3�����������
                    //beforeSubmit: showRequest,  //�ύǰ�Ļص�����
                    success: function (data) {
                        if (data.StateMessage == 1000) {
                            if (data.DataBag) {
                                $('#editModal').modal('hide');
                                pageReload();
                            } else {
                                console.log("ȱ��DataBag����")
                            }
                        } else if (data.StateMessage == -1) {
                            window.location.href = "../index.html";
                        } else if (data.StateMessage == -2) {
                            $('#editModal').modal('hide');
                            alert(data.DataBag)
                        } else if (data.StateMessage == -256) {
                            console.log(data.DataBag);
                        } else {
                            console.log("״̬�벻�ԣ�StateMessage=" + data.StateMessage);
                        }
                    }//�ύ��Ļص�����
                };
                $("#form_edit").ajaxSubmit(options);

            });
        });

    });

    //�鿴ϵͳƽ��ͼ
    $("#in_page").on("click", ".btn_img", function () {
        $("#img_node").css({width: "600px", height: "600px", left: "0px", top: "0px"});
        var imgSrc = "url(" + ImgUrl + $(this).attr("data-id") + ")";
        $("#img_node").css("background-image", imgSrc);
    });

    $("#img_node").on({
        mousedown: function (e) {
            var el = $(this);
            var dx = e.clientX - parseInt(el.css("left"));
            var dy = e.clientY - parseInt(el.css("top"));
            $(document).on('mousemove.drag', function (e) {
                var newLeft = e.clientX - dx;
                var newTop = e.clientY - dy;

                if (newLeft >= 0) {
                    newLeft = 0;
                }
                if (newLeft <= 600 - parseInt(el.css("width"))) {
                    newLeft = 600 - parseInt(el.css("width"));
                }
                if (newTop >= 0) {
                    newTop = 0;
                }
                if (newTop <= 600 - parseInt(el.css("height"))) {
                    newTop = 600 - parseInt(el.css("height"));
                }

                el.css("left", newLeft + "px");
                el.css("top", newTop + "px");

            });
        },
        mouseup: function (e) {
            $(document).off('mousemove.drag');
        },
        mouseout:function(){
            $(document).off('mousemove.drag');
        },
        mousewheel:function(){
            imgChange(this);
            return false;
        }
    });
    function imgChange(i){
        var event = event || window.event;
        var dir = event.wheelDelta > 0 ? 'Up' : 'Down';

        if (dir == 'Up') {
            img_num = img_num + 1;
            var imgWidth = 600 + img_num * 20 + "px";
            var imgHeight = 600 + img_num * 20 + "px";
            var imgLeft = parseInt($("#img_node").css("left")) - 10 + "px";
            var imgTop = parseInt($("#img_node").css("top")) - 10 + "px";
            $("#img_node").css({width: imgWidth, height: imgHeight, left: imgLeft, top: imgTop});
        } else {
            if (img_num != 0) {
                img_num = img_num - 1;
                var imgWidth = 600 + img_num * 20 + "px";
                var imgHeight = 600 + img_num * 20 + "px";
                var imgLeft = parseInt($("#img_node").css("left")) + 10 + "px";
                var imgTop = parseInt($("#img_node").css("top")) + 10 + "px";
                $("#img_node").css({width: imgWidth, height: imgHeight, left: imgLeft, top: imgTop});
            }
        }
    }

    $("#img_up").click(function () {
        img_num = img_num + 1;
        var imgWidth = 600 + img_num * 20 + "px";
        var imgHeight = 600 + img_num * 20 + "px";
        var imgLeft = parseInt($("#img_node").css("left")) - 10 + "px";
        var imgTop = parseInt($("#img_node").css("top")) - 10 + "px";
        $("#img_node").css({width: imgWidth, height: imgHeight, left: imgLeft, top: imgTop});
    });
    $("#img_down").click(function () {
        if (img_num != 0) {
            img_num = img_num - 1;
            var imgWidth = 600 + img_num * 20 + "px";
            var imgHeight = 600 + img_num * 20 + "px";
            var imgLeft = parseInt($("#img_node").css("left")) + 10 + "px";
            var imgTop = parseInt($("#img_node").css("top")) + 10 + "px";
            $("#img_node").css({width: imgWidth, height: imgHeight, left: imgLeft, top: imgTop});
        }
    });

    var deleteId1;
    var deleteId2;
    //����ɾ��
    $("#in_page").on("click", ".btn_delete", function () {
        deleteId1 = $(this).attr("data-sid");
        deleteId2 = $(this).attr("data-tid");
    });
    $("#deleteModal").on("click", "#deleteModal_btn", function () {
        var info = {
            siteid: deleteId1,
            tiSysType: deleteId2
        };
        HH.post("/Orginfo/DeleteorgSys", info, function (data) {
            $('#deleteModal').modal('hide');
            pageReload();
        });
    })

})();