/**
 * Created by Qiu on 2017/8/4.
 */
(function () {

    var fireAlarm_timer;
    var fault_timer;
    var allNum = 1;
    //下面是封装的年月日
    function yearMonthDay(data) {
        $('#' + data).datetimepicker({
            format: 'yyyy/mm/dd',//日期格式
            weekStart: 1,//一周从那天开始
            autoclose: true,//选中之后自动隐藏日期选择框
            startView: 2,//选完时间首先显示的视图（年月日）
            minView: 2,//日期时间选择器所能够提供的最精确的时间选择视图。
            forceParse: false,//你输入的可能不正规，但是它会强制尽量解析成你规定的格式（format）
            language: 'zh-CN'//
        });
    };

    yearMonthDay("fireAlarm_startDate");
    yearMonthDay("fireAlarm_stopDate");
    yearMonthDay("fault_startDate");
    yearMonthDay("fault_stopDate");

    //局部刷新
    function pageReload(type, view, page, nowNum) {
        var nowNum = parseInt(nowNum);
        if (!nowNum) {
            nowNum = parseInt($("#in_paging").find(".pagination>.active").text());
            if (isNaN(nowNum)) {
                nowNum = 1;
            }
        }
        var info = {
            pageIndex:nowNum,
            orgid: sessionStorage.getItem("OrgID"),
            cAlarmtype: type,
            startTime:"",
            endTime:""
        };
        console.log("给后台数据");
        console.log(info);
        HH.post("/OrgControl/GetAlarmDataList", info, function (data) {
            var myJson = {data: data.DataBag.PageDatas};
            console.log(data);
            $.each(myJson.data,function(i,v){
                v["number"]=i*1+1;
            });
            render(view, page, myJson);

            allNum = data.DataBag.pageCount;

            createPaging(".in_paging", nowNum, allNum);
        });
    };

    //选项卡，火警按钮
    $("#fireAlarm_btn").click(function () {
        $(".Pro_tab>div").css({"border-bottom": "transparent", "color": "#333"});
        $(this).css({"border-bottom": "3px solid #4A90E2", "color": "#5E9DE6"});
        $(".Pro_tab").attr("data-on", "1");
        $("#fireAlarm_page").css("display", "block");
        $("#fault_page").css("display", "none");

        pageReload("火警", "#fireAlarm_view", "#fireAlarm_table",1);
    });

    //选项卡，故障按钮
    $("#fault_btn").click(function () {
        $(".Pro_tab>div").css({"border-bottom": "transparent", "color": "#333"});
        $(this).css({"border-bottom": "3px solid #4A90E2", "color": "#5E9DE6"});
        $(".Pro_tab").attr("data-on", "2");
        $("#fireAlarm_page").css("display", "none");
        $("#fault_page").css("display", "block");

        pageReload("故障", "#fault_view", "#fault_table",1);
    });

    //火警列表，处理按钮
    $("#fireAlarm_page").on("click", ".handle_btn", function () {
        var Firealarmid = $(this).attr("data-id");
        sessionStorage.setItem("Firealarmid",Firealarmid);
        sessionStorage.setItem("AlarmType","fire");
        window.location.href="./AlarmRecordHandel.html";
    });
    //故障列表，处理按钮
    $("#fault_page").on("click", ".handle_btn", function () {
        var Firealarmid = $(this).attr("data-id");
        sessionStorage.setItem("Firealarmid",Firealarmid);
        sessionStorage.setItem("AlarmType","fault");
        window.location.href="./AlarmRecordHandel.html";
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
                pageReload("火警", "#fireAlarm_view", "#fireAlarm_table",1)
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
                pageReload("故障", "#fault_view", "#fault_table",1)
            },5000);
        }else{
            clearInterval(fault_timer);
        }
    });

    var nowType = sessionStorage.getItem("AlarmType");
    if(nowType=="fault"){
        //alert('a');
        $("#fault_btn").click();
    }else{
        //alert('b');
        $("#fireAlarm_btn").click();
    }
    //故障点击查询按钮按时间
    $("#gzAlarmRecord").click(function(){
        var alarmType="";
        if(nowType=="fault"){
            alarmType = "故障";
        }else{
            alarmType = "火警";
        }
        findFromTime(alarmType,"#fault_view", "#fault_table");
    });

    //火警点击查询按钮时间
    $("#hjAlarmRecord").click(function(){
        var alarmType="";
        if(nowType=="fault"){
            alarmType = "故障";
        }else{
            alarmType = "火警";
        }
        findFromTime(alarmType,"#fireAlarm_view", "#fireAlarm_table");
    });


    function findFromTime(alarmType,moban,targets){
        var cAlarmtype = $("#startTime");
        var info = {
            pageIndex:1,
            orgid: sessionStorage.getItem("OrgID"),
            startTime:$("#startTime").val(),
            endTime:$("#endTime").val(),
            cAlarmtype:alarmType
        };
        HH.post("/OrgControl/GetAlarmDataList", info, function (data) {
            //console.log(data);
            var myData = {
                data:data.DataBag.PageDatas
            };
            $.each(myData.data,function(i,v){
                v["number"]=i*1+1;
            });
            render(moban,targets,myData);
        });

    }


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
                //alert('yyyy');
                pageReload("火警", "#fireAlarm_view", "#fireAlarm_table",num);
            }else if(typeNum=="2"){
                pageReload("故障", "#fault_view", "#fault_table",num);
                //alert('tttt');
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

})();




