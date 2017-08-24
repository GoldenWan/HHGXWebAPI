/**
 * Created by Qiu on 2017/8/6.
 */
(function(){


    var flagNum = 0;
    //判断显示隐藏维保单位
    function showOrHideCompany(trLength,tbId,hId){
        if(trLength==1){
            $(tbId).css("display","none");
            $(hId).css("display","none");
            flagNum++;
            if(flagNum==4){
                //alert(flagNum);
                $("#alertUser").css("display","block");
            }
        }
        /*var tbs = $(".fourTb");
        alert(tbs.eq(0).css("display"));
        for(var i=0; i<tbs.length; i++){
            /!*if(tbs.eq(i).css("display")){

            }*!/
        }*/

    }
    //获取已签约维保单位
    function getAlreayMaintenance(){
        HH.post("/WBSign/GetMaintenanceOrgList",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
            console.log("后台返回已签约信息");
            console.log(data);
            var myJson = {data: data.DataBag.MaintenanceOrgList};
            $.each(myJson.data,function(i,v){
                v["number"]=i*1+1;
            });
            render("#signAlreadyData", "#signAlready", myJson);
            var trLength = $("#tb1").find("tr").length;
            showOrHideCompany(trLength,"#tb1","#tbh1");
        });
    }
    getAlreayMaintenance();

    //获取待解约维保单位
    function getWaitBreakOff(){
        HH.post("/WBSign/GetMaintenanceWaitingEnd",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
            console.log("返回待解约信息");
            console.log(data);
            var myJson = {data: data.DataBag.MaintenanceOrgList};
            $.each(myJson.data,function(i,v){
                v["number"]=i*1+1;
            });
            render("#waitBreakOffData", "#waitBreakOff", myJson);

            var trLength = $("#tb3").find("tr").length;
            showOrHideCompany(trLength,"#tb3","#tbh3");
        });

    }
    getWaitBreakOff();

    //获取已解约维保单位
    function getBreakOff(){
        HH.post("/WBSign/GetMaintenanceEnd",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
            console.log("返回已经解约信息");
            console.log(data);
            var myJson = {data: data.DataBag.MaintenanceOrgList};
            $.each(myJson.data,function(i,v){
                v["number"]=i*1+1;
            });
            render("#breakOffData", "#breakOff", myJson);

            var trLength = $("#tb4").find("tr").length;
            showOrHideCompany(trLength,"#tb4","#tbh4");
        });
    }
    getBreakOff();


    //获取待通过维保单位
    function getWaitingMaintenance(){
        HH.post("/WBSign/GetWaitingMaintenanceOrgList",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
            console.log("后台返回待通过信息");
            console.log(data);
            if(data.DataBag && data.StateMessage==1000){
                var myJson = {data: data.DataBag.MaintenanceOrgList};
                $.each(myJson.data,function(i,v){
                    v["number"]=i*1+1;
                });
                render("#signWaitData", "#signWait", myJson);

                var trLength = $("#tb2").find("tr").length;
                showOrHideCompany(trLength,"#tb2","#tbh2");
            }
        });
    }
    getWaitingMaintenance();

    //点击取消申请
    $("#signWait").on("click",".cancelAsk",function(){
        $('#cancelAskModal').modal({"backdrop":"static"});
        var MaintenaceId = $(this).attr("MaintenanceId");
        $("#companyName").text($(this).attr("UnitName"));
        //确定取消申请
        $("#cancelAskModalConfirm").click(function(){
            var myJSon = {
                "MaintenaceId":MaintenaceId,
                "orgid":sessionStorage.getItem("OrgID")
            };
            HH.post("/WBSign/CancelSign",myJSon,function(data) {
                console.log("后台返回取消信息");
                console.log(data);
                if(data.DataBag=="操作成功" && data.StateMessage==1000){
                    $('#cancelAskModal').modal("hide");
                    getWaitingMaintenance();
                }
            });
        })
    });

    //待通过维保单位详情
    $("#signWait").on("click",".unPassDetail",function(){
        $("#signWaitDetailModal").modal({backdrop:"static"});
        var myJson = {
            "orgid":sessionStorage.getItem("OrgID"),
            "MaintenanceId":$(this).attr("MaintenanceId"),
            "ReviewState":"待审批"
        };
        HH.post("/WBSign/getMaintenanceDetail",myJson,function(data) {
            console.log("返回待通过详情信息");
            console.log(data);
            $("#signWaitWeibaoName").text(data.DataBag.UnitName);
            var myJson = {data: data.DataBag.vSysList};
            $.each(myJson.data,function(i,v){
                v["number"]=i*1+1;
            });
            render("#signWaitDetailData","#signWaitDetailBody",data);
        });

    });


    //签约维保单位跳转
    $("#signCompany").click(function(){
        location.href="./SignMaintenanceDetail.html";
    });

    //已签约维保单位详情
    $("#signAlready").on("click",".operation",function(){
        if($(this).text()=="详情"){
            $("#alreadySignDetailModal").modal({backdrop:"static"});
            var myJson = {
                "orgid":sessionStorage.getItem("OrgID"),
                "MaintenanceId":$(this).attr("MaintenanceId"),
                "ReviewState":"已签约"
            };
            HH.post("/WBSign/getMaintenanceDetail",myJson,function(data) {
                console.log("返回已签约详情信息");
                console.log(data);
                $("#weibaoName").text(data.DataBag.UnitName);
                var myJson = {data: data.DataBag.vSysList};
                $.each(myJson.data,function(i,v){
                    v["number"]=i*1+1;
                });
                render("#alreadySignDetailData","#alreadySignDetailBody",data);
            });
        }else if($(this).text()=="编辑"){
            editFunc(this);
        }else if($(this).text()=="解约"){
            $("#breakOffModal").modal({backdrop:"static"});
            $("#breakOffCompanyName").text($(this).attr("UnitName"));

            var MaintenanceId = $(this).attr("MaintenanceId");
            //点击确定解约
            $("#breakOffModalConfirm").get(0).onclick=function(){
                var myJson = {
                    "orgid":sessionStorage.getItem("OrgID"),
                    "MaintenanceId":MaintenanceId,
                    "terminateman":sessionStorage.getItem("RealName")
                };
                //console.log(myJson);
                HH.post("/WBSign/EndMaintenance",myJson,function(data) {
                    console.log("返回已签约详情信息");
                    console.log(data);
                    if(data.DataBag && data.StateMessage==1000){
                        $("#breakOffModal").modal("hide");
                       /* getAlreayMaintenance();
                         getWaitBreakOff();*/
                        getAlreayMaintenance();
                        getWaitBreakOff();
                        getBreakOff();
                        getWaitingMaintenance();

                    }
                });
            }
        }

    });
    function editFunc(obj){
        $("#alreadySignEditModal").modal({backdrop:"static"});
        var MaintenanceId = $.trim($(obj).attr("MaintenanceId"));
        var myJson = {
            "orgid":sessionStorage.getItem("OrgID"),
            "MaintenanceId": MaintenanceId,
            "ReviewState":"已签约"
        };
        HH.post("/WBSign/getMaintenanceDetail",myJson,function(data) {
            console.log("返回已签约编辑信息");
            console.log(data);
            $("#editWeibaoName").text(data.DataBag.UnitName);
            var myJsons = {data: data.DataBag.vSysList};
            $.each(myJsons.data,function(i,v){
                v["number"]=i*1+1;
            });
            render("#alreadySignEditData","#alreadySignEditBody",data);

            //$("#alreadySignEditBody").on("click",".operation",function(){
            $(".operation").click(function(){
                var trLength = $("#alreadySignEditTb").find("tr").length;
                if($(this).text()=="撤销维保"){
                    var tr = $(this).parent().parent("tr");
                    if(trLength==2){
                        alert("维保单位系统数不得为零");
                        return;
                    }
                    var myJson = {
                        "MaintenanceId":data.DataBag.MaintenanceId,
                        "siteid":$(this).attr("siteid"),
                        "tiSysType":$(this).attr("tiSysType")
                    };
                    HH.post("/WBSign/AnnulWB",myJson,function(data) {
                        console.log("返回撤销维保信息");
                        console.log(data);
                        if(data.StateMessage==1000 && data.DataBag=="撤销成功"){
                            //刷新已签约单位表格
                            //getAlreayMaintenance();
                            getAlreayMaintenance();
                            getWaitBreakOff();
                            getBreakOff();
                            getWaitingMaintenance();
                            tr.remove();
                        }
                    });
                }
            });
            //点击新增维保系统
           /* $("#addSystemBtn").get(0).onclick=function(){
                addBuildingFunc(myJson,MaintenanceId);
            }*/
        });
        //点击新增维保系统
        addBuildingFunc(myJson,MaintenanceId);

    }

    //绑定建筑物数据
    function addBuildingFunc(myJson,MaintenanceId){
        $("#buildingSelect").html("");
        HH.post("/WBSign/OrgUnMaintenSiteSys",myJson,function(data) {
            console.log("新增维保信息");
            console.log(data);
            if(data.DataBag.length==0){
                $("#addSystemBtn").css("disabled",true);
                return;
            }else{
                //点击新增维保系统
                 $("#addSystemBtn").get(0).onclick=function(){
                     $("#addSystemModal").modal({backdrop:"static"});
                 }
            }

            //$("#addSystemModal").modal({backdrop:"static"});
            var strBuilding = "";
            for(var i=0; i<data.DataBag.length; i++){
                strBuilding+="<option value='"+data.DataBag[i].siteid+"'>"+data.DataBag[i].sitename+"</option>";
            }
            $("#buildingSelect").append(strBuilding);

            var buildingId = $("#buildingSelect").val();
            //根据建筑物来选择系统
            addSystemFunc(buildingId,data,MaintenanceId);
            $("#buildingSelect").get(0).onchange=function(){
                var buildingId = $("#buildingSelect").val();
                addSystemFunc(buildingId,data,MaintenanceId);
            }
        });
    }
    //根据建筑物绑定系统
    function addSystemFunc(buildingId,data,MaintenanceId){
        $("#systemSelect").html("");
        for(var i=0; i<data.DataBag.length; i++){
            if(buildingId==data.DataBag[i].siteid){
                var sys = data.DataBag[i].Sys;
                var sysStr = "";
                for(var j=0; j<sys.length; j++){
                    sysStr+="<option value='"+sys[j].tiSysType+"'>"+sys[j].vSysdesc+"</option>";
                }
                $("#systemSelect").append(sysStr);
                break;
            }
        }
        //点击新增维保单位的确定
        $("#addSystemModalConfirm").click(function(){
            var arr = [];
            var obj = {
                "tisystype":$("#systemSelect").val(),
                "siteid":$("#buildingSelect").val()
            };
            arr.push(obj);
            var myJson = {
                "MaintenaceId":MaintenanceId,
                "SysList":arr,
                "orgid":sessionStorage.getItem("OrgID"),
                "RegistUser":sessionStorage.getItem("RealName")
            };
            HH.post("/WBSign/SetOrgMaintenanceSys",myJson,function(data) {
                console.log("新增维保系统确定返回");
                console.log(data);
                if(data.DataBag=="修改成功" && data.StateMessage==1000){
                    $("#addSystemModal").modal("hide");
                    $("#alreadySignEditModal").modal("hide");
                   /* getAlreayMaintenance();
                    getWaitingMaintenance();*/
                    getAlreayMaintenance();
                    getWaitBreakOff();
                    getBreakOff();
                    getWaitingMaintenance();
                }
            });

        });
    }

})();