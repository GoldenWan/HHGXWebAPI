(function () {

    var fireAlarm_timer;
    var fault_timer;

    var allNum = 1;

    dataPick("#fireAlarm_startDate");
    dataPick("#fireAlarm_stopDate");
    dataPick("#fault_startDate");
    dataPick("#fault_stopDate");

    //局部刷新
    function pageReload(type, view, page, nowNum) {
        //获取建筑物
       /* HH.post("/Orginfo/GetSiteName", {"orgid":sessionStorage.getItem("OrgID")}, function (datas) {
            console.log(datas);
            console.log(view+"==="+page);*/
            //alert($("#firebuildingSelect").val());
            var nowNum = parseInt(nowNum);

            if (!nowNum) {
                nowNum = parseInt($("#in_paging").find(".pagination>.active").text());
                if (isNaN(nowNum)) {
                    nowNum = 1;
                }
            }

            if(!nowNum){
                if(type=="火警"){
                    nowNum = parseInt($("#fireAlarm_page>.in_paging").find(".pagination>.active").text());
                }else if(type=="故障"){
                    nowNum = parseInt($("#fault_page>.in_paging").find(".pagination>.active").text());
                }
            };

            var startTime;
            var stopTime;

            var siteid="";

            if(type=="火警"){
                startTime = $("#fireAlarm_startDate").find("input").val();
                stopTime = $("#fireAlarm_stopDate").find("input").val();
               /* HH.post("/Orginfo/GetSiteName", {"orgid":sessionStorage.getItem("OrgID")}, function (datas) {
                    console.log(datas);
                    console.log(view + "===" + page);
                    render()
                });*/
                siteid = $("#firebuildingSelect").val();
            }else if(type=="故障"){
                startTime = $("#fault_startDate").find("input").val();
                stopTime = $("#fault_stopDate").find("input").val();
               /* HH.post("/Orginfo/GetSiteName", {"orgid":sessionStorage.getItem("OrgID")}, function (datas) {
                    console.log(datas);
                    console.log(view + "===" + page);
                });*/
                siteid = $("#faultbuildingSelect").val()
            }
            var info = {
                orgid: sessionStorage.getItem("OrgID"),
                cAlarmtype: type,
                StartTime: startTime,
                EndTime: stopTime,
                PageIndex: nowNum,
                "siteid":siteid
            };

            HH.post("/AlarmData/FireAlarm", info, function (data) {
              /*  console.log("下面是首页数据");
                console.log(data);*/
                var myJson = {data: data.DataBag.PageDatas};
                $.each(myJson.data,function(i,v){
                    v["number"]=i*1+1+nowNum*20-20;
                });

                render(view, page, myJson);
                latestImFlatPic(false);
                //设置点击楼层
                $(".floor").click(function(){
                    $("#imFlatPicModal").modal({backdrop:"static"});
                    $("#imFlatPicImg").attr("xlink:href","");
                    $("#imFlatPicImg").attr("src","");
                    $("#imFlatPicImg").attr("xlink:href",ImgUrl+""+$(this).attr("imFlatPic"));
                    $("#imFlatPicImg").attr("src",ImgUrl+$(this).attr("imFlatPic"));

                    //点击放大和缩小按钮事件
                    var big = $("#big");
                    var small = $("#small");
                    big.click(function(){
                        showBig("imFlatPicSvg");
                    });
                    small.click(function(){
                        showSmall("imFlatPicSvg");
                    });
                    posMove("imFlatPicSvg","imFlatPicImgDiv");
                })

                allNum = data.DataBag.pageCount;
                if(type=="火警"){
                    createPaging("#fireAlarmPaging",nowNum,allNum);
                }else if(type=="故障"){
                    createPaging("#faultPaging",nowNum,allNum);
                }

            });
        //})
    };

    //页码
    $(".in_paging").on("click", ".pagination>.pageNum", function () {
        var num = parseInt($(this).text());
        var typeNum = $(".Pro_tab").attr("data-on");
        if(typeNum=="1"){
            pageReload("火警", "#fireAlarm_view", "#fireAlarm_table",num);
        }else if(typeNum=="2"){
            pageReload("故障", "#fault_view", "#fault_table",num);
        }
    });
    $(".in_paging").on("click", ".pagination>.upPage", function () {
        var num = parseInt($(this).parent().find(".active").text());
        var typeNum = $(".Pro_tab").attr("data-on");
        if(num!=1){
            num = num-1;
            if(typeNum=="1"){
                pageReload("火警", "#fireAlarm_view", "#fireAlarm_table",num);
            }else if(typeNum=="2"){
                pageReload("故障", "#fault_view", "#fault_table",num);
            }
        }
    });
    $(".in_paging").on("click", ".pagination>.downPage", function () {

        var num = parseInt($(this).parent().find(".active").text());
        var typeNum = $(".Pro_tab").attr("data-on");
        if(num!=allNum){
            num = num+1;
            if(typeNum=="1"){
                pageReload("火警", "#fireAlarm_view", "#fireAlarm_table",num);
            }else if(typeNum=="2"){
                pageReload("故障", "#fault_view", "#fault_table",num);
            }
        }
    });
    //火警查询
    $("#fireAlarm_check").click(function(){
        pageReload("火警", "#fireAlarm_view", "#fireAlarm_table",1);
    });
    //故障查询
    $("#fault_check").click(function(){
        pageReload("故障", "#fault_view", "#fault_table",1);
    });

    //选项卡，火警按钮
    $("#fireAlarm_btn").click(function () {
        $(".Pro_tab>div").css({"border-bottom": "transparent", "color": "#333"});
        $(this).css({"border-bottom": "3px solid #4A90E2", "color": "#5E9DE6"});
        $(".Pro_tab").attr("data-on", "1");
        $("#fireAlarm_page").css("display", "block");
        $("#fault_page").css("display", "none");
        sessionStorage.setItem("AlarmType","fire");
        getBuilding("#building_view","#firebuildingSelect","fire");
       // pageReload("火警", "#fireAlarm_view", "#fireAlarm_table",1);
    });

    //选项卡，故障按钮
    $("#fault_btn").click(function () {
        $(".Pro_tab>div").css({"border-bottom": "transparent", "color": "#333"});
        $(this).css({"border-bottom": "3px solid #4A90E2", "color": "#5E9DE6"});
        $(".Pro_tab").attr("data-on", "2");
        $("#fireAlarm_page").css("display", "none");
        $("#fault_page").css("display", "block");
        sessionStorage.setItem("AlarmType","fault");
        getBuilding("#building_view","#faultbuildingSelect","fault");
        //pageReload("故障", "#fault_view", "#fault_table",1);
    });

    //选项卡，屏蔽按钮
    $("#cover_btn").click(function () {
        $(".Pro_tab>div").css({"border-bottom": "transparent", "color": "#333"});
        $(this).css({"border-bottom": "3px solid #4A90E2", "color": "#5E9DE6"});

    });

    //选项卡，监管按钮
    $("#watch_btn").click(function () {
        $(".Pro_tab>div").css({"border-bottom": "transparent", "color": "#333"});
        $(this).css({"border-bottom": "3px solid #4A90E2", "color": "#5E9DE6"});
    });

    //选项卡，启动按钮
    $("#start_btn").click(function () {
        $(".Pro_tab>div").css({"border-bottom": "transparent", "color": "#333"});
        $(this).css({"border-bottom": "3px solid #4A90E2", "color": "#5E9DE6"});
    });

    //选项卡，反馈按钮
    $("#backInfo_btn").click(function () {
        $(".Pro_tab>div").css({"border-bottom": "transparent", "color": "#333"});
        $(this).css({"border-bottom": "3px solid #4A90E2", "color": "#5E9DE6"});
    });


    //火警列表，处理按钮
    $("#fireAlarm_page").on("click", ".handle_btn", function () {
        var Firealarmid = $(this).attr("data-id");
        sessionStorage.setItem("Firealarmid",Firealarmid);
        sessionStorage.setItem("AlarmType","fire");
        if($(this).text()=="查看详情"){
            window.location.href="./AlarmHandle.html";
        }else if($(this).text()=="处理"){
            doDealFunc();
        }
    });
    //故障列表，处理按钮
    $("#fault_page").on("click", ".handle_btn", function () {
        var Firealarmid = $(this).attr("data-id");
        sessionStorage.setItem("Firealarmid",Firealarmid);
        sessionStorage.setItem("AlarmType","fault");
        if($(this).text()=="查看详情"){
            window.location.href="./AlarmHandle.html";
        }else if($(this).text()=="处理"){
            doDealFunc();
        }
        //window.location.href="./AlarmHandle.html";
    });

    //刷新按钮
    $("#my_page").on("click", ".matic", function () {
        if ($(".Pro_tab").attr("data-on") == "1") {
            pageReload("火警", "#fireAlarm_view", "#fireAlarm_table");
        } else if ($(".Pro_tab").attr("data-on") == "2") {
            pageReload("故障", "#fault_view", "#fault_table");
        };
    });

    //火警自动刷新
    $("#fireAlarm_automatic").find("input").change(function(){
        var check = $(this).get(0).checked;
        if(check){
            fireAlarm_timer = window.setInterval(function(){
               // render("#building_view","#firebuildingSelect",buildingData);
                pageReload("火警", "#fireAlarm_view", "#fireAlarm_table")
            },5000);
        }else{
            clearInterval(fireAlarm_timer);
        }
    });

    //故障自动刷新
    $("#fault_automatic").find("input").change(function(){
        var check = $(this).get(0).checked;
        if(check){
            fault_timer = window.setInterval(function(){
               // render("#building_view","#faultbuildingSelect",buildingData);
                pageReload("故障", "#fault_view", "#fault_table")
            },5000);
        }else{
            clearInterval(fault_timer);
        }
    });

    var nowType = sessionStorage.getItem("AlarmType");
    if(nowType=="fault"){
        //getBuilding("#building_view","#faultbuildingSelect",nowType);
        $("#fault_btn").click();

    }else{
        //getBuilding("#building_view","#firebuildingSelect",nowType);
        $("#fireAlarm_btn").click();
    }

   /* fireAlarm_timer = window.setInterval(function(){
        render("#building_view","#firebuildingSelect",buildingData);
        pageReload("火警", "#fireAlarm_view", "#fireAlarm_table")
    },5000);
    fault_timer = window.setInterval(function(){
        render("#building_view","#faultbuildingSelect",buildingData);
        pageReload("故障", "#fault_view", "#fault_table")
    },5000);*/

    var buildingData = "";
    function getBuilding(view,target,nowType){
         HH.post("/Orginfo/GetSiteName", {"orgid":sessionStorage.getItem("OrgID")}, function (datas) {
             buildingData = datas;
             console.log("====");
             console.log(datas);
             datas.DataBag.unshift({
                 "siteid":"",
                 "sitename":"全部"
             })
             render(view,target,datas);
             if(nowType=="fault"){
                 pageReload("故障", "#fault_view", "#fault_table",1);
             }else{
                 pageReload("火警", "#fireAlarm_view", "#fireAlarm_table",1);
             }
         });
    }

    //点击最新警情平面图
    $(".alarmImgBtn").click(function(){
        latestImFlatPic(true);
    });
})();

function latestImFlatPic(autoUpdate){
    var nowType = sessionStorage.getItem("AlarmType");
    var cAlarmtype = "";
    //判断此时是火警还是故障状态
    if(nowType=="fault"){
        cAlarmtype="故障";
        var trs = $("#faultTb tr").length;
        console.log(trs);
        if(trs<=1){
            console.log('<=1');
            sessionStorage.setItem("imFlatPicStatus","default");
        }else{
            console.log('>=1');
            sessionStorage.setItem("imFlatPicStatus","haveImg");
        }
    }else{
        cAlarmtype="火警";
        var trs = $("#fireTb tr").length;
        if(trs<=1){
            console.log('火警<=1');
            sessionStorage.setItem("imFlatPicStatus","default");
        }else{
            console.log('火警>=1');
            sessionStorage.setItem("imFlatPicStatus","haveImg");
        }
    }
    var myJson = {
        "orgid":sessionStorage.getItem("OrgID"),
        "cAlarmtype":cAlarmtype
    };

    HH.post("/AlarmData/RecentAlarmInfo", myJson, function (datas) {
        console.log("最新平面图");
        console.log(datas);
        sessionStorage.setItem("imFlatPic",datas.DataBag[0].imFlatPic);
        if(autoUpdate==true){//说明是点击跳转到新页面
            //window.open("./AlarmImg.html");
        }
    });
}
var latestInterval = window.setInterval(function(){
    latestImFlatPic(false);
},5000)



//点击处理
function doDealFunc(){
    $("#alarmHandleModal").modal({"backdrop":"static"});
    //清空处理状况
    $(".alarm").attr('checked',false);
    $("#statementInfo").val("");

    if(sessionStorage.getItem("AlarmType")=="fire") {

        $(".buildingForm:nth-of-type(2)").css("display", "none");
        $(".alarmDiv:nth-of-type(2)").css("display", "inline-block");
        $(".alarmDiv:nth-of-type(2) span").text("真实火警");
        $(".alarmDiv:nth-of-type(2) input").val("真实火警");
    }else if(sessionStorage.getItem("AlarmType")=="fault") {
        //alert('asdf');
        $(".buildingForm:nth-of-type(2)").css("display", "inline-block");
        $(".alarmDiv:nth-of-type(2) span").text("真实故障");
        $(".alarmDiv:nth-of-type(2) input").val("真实故障");
    }
    var myData;
    //点击警情处理的确定
    $("#doAlarmHandleModal").get(0).onclick=function(){
        if(sessionStorage.getItem("AlarmType")=="fire"){
            //$(".buildingForm:nth-of-type(2)").css("display","none");
            var alarm = $(".alarm:checked").val();
            var statementInfo = $("#statementInfo").val();
            myData={
                "username":sessionStorage.getItem("RealName"),
                "Firealarmid":sessionStorage.getItem("Firealarmid"),
                //"AlarmType":sessionStorage.getItem("AlarmType"),
                "checkresult":alarm,
                "checkdesc":statementInfo
            };
            //console.log(myData);
        }else if(sessionStorage.getItem("AlarmType")=="fault"){
            //$(".buildingForm:nth-of-type(2)").css("display","block");
            var alarm = $(".alarm:checked").val();
            var isWrite = $(".isWrite:checked").val();
            var statementInfo = $("#statementInfo").val();
            myData={
                "username":sessionStorage.getItem("RealName"),
                "Firealarmid": $.trim(sessionStorage.getItem("Firealarmid")),
                //"AlarmType":sessionStorage.getItem("AlarmType"),
                "checkresult":alarm,
                "YnRequest":isWrite,
                "checkdesc":statementInfo
            };
        }
        console.log(myData);
        HH.post("/AlarmData/FireDetail",myData,function(data) {
             console.log("后台返回的警情处理信息");
              console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                $("#alarmHandleModal").modal("hide");
                if(sessionStorage.getItem("AlarmType")=="fault"){
                    sessionStorage.setItem("AlarmType","fault");
                }else if(sessionStorage.getItem("AlarmType")=="fire"){
                    sessionStorage.setItem("AlarmType","fire");
                }
                $("#alarmHandleModal").modal("hide");
                var nowType = sessionStorage.getItem("AlarmType");
                if(nowType=="fault"){
                    //getBuilding("#building_view","#faultbuildingSelect",nowType);
                    $("#fault_btn").click();
                }else{
                    //getBuilding("#building_view","#firebuildingSelect",nowType);
                    $("#fireAlarm_btn").click();
                }
                //sessionStorage.setItem("AlarmType","fault");
                //window.history.back();
            }
        });
    }
}

function posMove(svgid,svgdivid) {
    var svgObj = document.getElementById(svgid);//svg
    //console.log(oDiv);
    var svgDivObj = document.getElementById(svgdivid);//最外面控制宽高的div
    //console.log(sent.r);
    drag(svgObj,svgDivObj);
}
function drag(obj,oParent){
    obj.onmousedown = function (ev) {
        //console.log('sfsdf');
        var oEvent = ev || event;
        var sentX = oEvent.clientX - parseInt($(obj).css("left"));
        var sentY = oEvent.clientY - parseInt($(obj).css("top"));

        document.onmousemove = function (ev) {
            //document.onmousemove = function (ev) {
            var oEvent = ev || event;
            var slideLeft = oEvent.clientX - sentX;
            var slideTop = oEvent.clientY - sentY;
            //console.log($(oParent).css("width")+"==="+$(obj).css("width"));
            if (slideLeft >= 0) {
                slideLeft = 0;
            }
            if (slideLeft <= parseInt($(oParent).css("width")) - parseInt($(obj).css("width"))) {
                slideLeft = parseInt($(oParent).css("width")) - parseInt($(obj).css("width"));
            }
            if (slideTop >= 0) {
                slideTop = 0;
            }
            if (slideTop <= parseInt($(oParent).css("height")) - parseInt($(obj).css("height"))) {
                slideTop = parseInt($(oParent).css("height")) - parseInt($(obj).css("height"));
            }
            /*obj.setAttribute("left",slideLeft+"px");
             obj.setAttribute("top",slideTop+"px");*/
            $(obj).css("left", slideLeft + "px");
            $(obj).css("top", slideTop + "px");
            //ev.preventDefault();
            //return false;
        };
        document.onmouseup = function () {
            document.onmousemove = null;
            document.onmouseup = null;
            return;
        }
        return false;
    }
}

//点击放大按钮
function showBig(svgContainer){

    var svg = document.getElementById(svgContainer);//这个得到的就是图片对象
    var w = svg.getAttribute("width");
    // console.log(w);
    w = parseInt(w)+10;
    svg.setAttribute("width",w);

    var h = svg.getAttribute("height");
    h = (parseInt(h)*(w))/(w-10);
    svg.setAttribute("height",h);

    if($(".circles").length>0){
        //var r = $(".circles").eq(0).attr("r");
        circleR = circleR + 0.05;
        //让所有的圆半径变小
        $(".circles").attr("r",circleR);
    }

}
//点击缩小按钮
function showSmall(svgContainer){
    var svg = document.getElementById(svgContainer);
    var w = svg.getAttribute("width");
    w = parseInt(w)-10;
    svg.setAttribute("width",w);

    var h = svg.getAttribute("height");
    //h = parseInt(h)-7;
    h = (parseInt(h)*(w))/(w+10);
    svg.setAttribute("height",h);

    if($(".circles").length>0){
        //var r = $(".circles").eq(0).attr("r");
        circleR = circleR-0.05;
        //让所有的圆半径变小
        $(".circles").attr("r",circleR);
    }
}











