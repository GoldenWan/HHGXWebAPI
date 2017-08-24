(function(){

    $("#Cancellation").click(function(){
        location.href = "../index.html";
        document.cookie="UserId=v; path=/; max-age=0";
    });

    $("#nav_list_1").on("click","li>div",function(){
        var childNum = 0;
        $("#nav_list_1").find("li").css("height","40px");
        $("#nav_list_1").find("div>.icon-shouhui").removeClass("icon-shouhui").addClass("icon-zhankai");
        childNum = $(this).parent().find("ul>li").length+1;

        if(parseInt($(this).parent().css("height"))==40){
            $(this).parent().css("height",childNum*40+"px");
            $(this).find(".icon-zhankai").removeClass("icon-zhankai").addClass("icon-shouhui");
        }
    });

    $("#nav_list_1").on("click",".nav_list_2>li",function(){
        $(".nav_list_2").find("li").css("background-color","");
        $(this).css("background-color","#4A90E2")
    });

    //获取用户模块列表
    HH.get("/UserManager/RetrieveZtreeNodes",function(data) {
        if (data.DataBag.ztree!=undefined) {
            var moduleData = data.DataBag.ztree;
            render("#nav_list", "#nav_list_1", moduleData);
        }
        if(data.DataBag.userInfo!=undefined){
            var userData = data.DataBag.userInfo;
            render("#userInfo", "#user_info", userData);
            sessionStorage.setItem("OrgID",userData.OrgID);
            sessionStorage.setItem("RealName",userData.RealName);
            sessionStorage.setItem("UserBelongTo",userData.UserBelongTo);
        }
        //1:防火单位
        //2:维保单位
        //3:主管部门
        //4:系统管理
        if(userData.UserBelongTo=="1"){
            $("#sjb").text("防火单位");
            $("#my_page").prop("src","./FireUnit/ProcessingAlarm.html");
            for(var i=0;i<moduleData.length;i++){
                for(var j=0;j<moduleData[i].DKZTree.length;j++){
                    if(moduleData[i].DKZTree[j].ModuleName=="警情管理"){
                        var lists1 = $("#nav_list_1>li>div").eq(i);
                        lists1.click();
                        lists1.parent().find("ul>li").eq(j).click();
                    }
                }
            }
        }else if(userData.UserBelongTo=="3"){
            $("#sjb").text("主管部门");
            $("#my_page").prop("src","./Competent/AlarmInformation.html");
            for(var i=0;i<moduleData.length;i++){
                for(var j=0;j<moduleData[i].DKZTree.length;j++){
                    if(moduleData[i].DKZTree[j].ModuleName=="报警信息处理情况"){
                        var lists1 = $("#nav_list_1>li>div").eq(i);
                        lists1.click();
                        lists1.parent().find("ul>li").eq(j).click();
                    }
                }
            }
        }else if(userData.UserBelongTo=="2"){
            $("#sjb").text("维保单位");
        }else if(userData.UserBelongTo=="4"){
            $("#sjb").text("系统管理");
        }

    });


})();