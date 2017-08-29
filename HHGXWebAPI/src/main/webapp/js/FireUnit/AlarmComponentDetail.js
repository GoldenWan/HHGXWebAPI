/**
 * Created by Qiu on 2017/7/1.
 */
(function(){
    var allNum = 1;

    //设置楼层和建筑
    $("#sitename").text(sessionStorage.getItem("sitename"));
    $("#floornum").text(sessionStorage.getItem("floornum"));

    var compoentTypeSelectData = "";
    //首页的表格数据渲染
    //alert(sessionStorage.getItem("cFlatPic"));
    var myData = {
        "cFlatPic":sessionStorage.getItem("cFlatPic")+"",
        //"cFlatPic":"20170719092401",
        "iDeviceType":0,
        "deviceaddress":"0",
        "PageIndex":1
    };
    //下面是返回的首页列表信息
    HH.post("/Orginfo/SelectDevicesList",myData, function (data) {
        console.log("后台返回的首页列表信息详情");
        console.log(data);
        if (data.DataBag && data.StateMessage == "1000") {
            $.each(data.DataBag.PageDatas,function(i,v){
                v["number"] = i+1;
            });
            render("#buildingTbData","#buildingTbody",data);
            //最后一个部件的序号
            //componentNum=$("#ComponentTb").get(0).rows[$("#ComponentTb tr").length-1];
            //componentNum = parseInt(componentNum.cells[1].innerHTML);
            componentNum = parseInt(data.DataBag.pageCount);
            //部件的个数
            //componentSeveral = $("#ComponentTb").get(0).rows.length-1;
            componentSeveral = parseInt(data.DataBag.pageCount);

            allNum = Math.ceil(data.DataBag.pageCount);

            createPaging("#in_paging", 1, allNum);
        }
    });

    //页码
    $("#in_paging").on("click", ".pagination>.pageNum", function () {
        var num = parseInt($(this).text());
        //pageReload(num)
        confirmBtnSelectIndexTb(num);
    });
    //上一页
    $("#in_paging").on("click", ".pagination>.upPage", function () {
        var num = parseInt($(".pagination>.active").text());
        if (num != 1) {
            num = num - 1;
            //pageReload(num);
            confirmBtnSelectIndexTb(num);
        }
    });
    //下一页
    $("#in_paging").on("click", ".pagination>.downPage", function () {
        var num = parseInt($(".pagination>.active").text());
        if (num != allNum) {
            num = num + 1;
           // pageReload(num);
            confirmBtnSelectIndexTb(num);
        }
    });

    //获取首页的部件类型
    HH.post("/Orginfo/DeviceTypeList","", function (data) {
        console.log("后台返回的首页部件类型信息");
        console.log(data);
        if (data.DataBag && data.StateMessage == "1000") {
            render("#compoentTypeSelectData","#compoentTypeSelect",data);
            compoentTypeSelectData = data;
        }
    });

    //首页的确认筛选按钮条件查询
    $("#ComponentConfirm").click(function(){
        confirmBtnSelectIndexTb(1);
    });
    function confirmBtnSelectIndexTb(nowNum){
        var nowNum = parseInt(nowNum);
        if (!nowNum) {
            nowNum = parseInt($("#in_paging").find(".pagination>.active").text());
            if (isNaN(nowNum)) {
                nowNum = 1;
            }
        }
        var compoentTypeSelect = $("#compoentTypeSelect").val();
        var deviceaddress = $("#deviceaddress").val();
        var cFlatPic = sessionStorage.getItem("cFlatPic");
        //var PageIndex = 1;
        if(deviceaddress==""){
            deviceaddress = "0";
        }
        var myData = {
            "cFlatPic":cFlatPic,
            "iDeviceType":compoentTypeSelect,
            "deviceaddress":deviceaddress,
            "PageIndex":nowNum
        }

        HH.post("/Orginfo/SelectDevicesList",myData, function (data) {
            console.log("后台返回的首页表格查询信息");
            console.log(data);
            if (data.DataBag && data.StateMessage == "1000") {
                $.each(data.DataBag.PageDatas,function(i,v){
                    v["number"] = i+1;
                });
                render("#buildingTbData","#buildingTbody",data);
                compoentTypeSelectData = data;

                allNum = Math.ceil(data.DataBag.pageCount);

                createPaging("#in_paging", nowNum, allNum);
            }
        });
    }


    //alert(sessionStorage.getItem("cFlatPic"));
    //表格上方按钮的操作
    $(".operateBtns").click(function(){
        /*if($(this).text()=="批量删除部件"){
            render("#isDeleteData","#changeBody");
            $('#changeModal').modal({"backdrop":"static"});
        }*/
        if($(this).text()=="新增部件"){
            render("#addComponentData","#changeBody");
            $('#changeModal').modal({"backdrop":"static"});
            $(".imgs").get(0).setAttribute("xlink:href","");
            $(".imgs").get(0).setAttribute("src","");
            //alert(sessionStorage.getItem("imFlatPic"));
            $(".imgs").get(0).setAttribute("xlink:href",ImgUrl+sessionStorage.getItem("imFlatPic"));
            $(".imgs").get(0).setAttribute("src",ImgUrl+sessionStorage.getItem("imFlatPic"));
            yearMonthDay("#createDate");
            yearMonthDay("#outDate");
            yearMonthDay("#installDate");
            var str="";
            console.log("新增部件返回");
            console.log(compoentTypeSelectData);
            //渲染新增里面的下拉框
            for(var i=0; i<compoentTypeSelectData.DataBag.length; i++){
                str = str+"<option value='"+compoentTypeSelectData.DataBag[i].iDeviceType+"'>"+compoentTypeSelectData.DataBag[i].DeviceTypeName+"</option>";
            }
            $("#alarmComponentSelect").append(str);
            //下面是获取传输设设备地址和系统地址，系统类型
           // alert(sessionStorage.getItem("alarmComponentSiteid"));
            HH.post("/Orginfo/GetSiteNeedAddress",{"siteid":sessionStorage.getItem("alarmComponentSiteid")}, function (data) {
                console.log("后台返回的获取信息");
                console.log(data);
                if (data.DataBag && data.StateMessage == "1000") {
                    //清空传输设备地址
                    $("#gatewayaddressSelect").html("");
                    var str="";
                    for(var i=0; i<data.DataBag.length; i++){
                        //gatewayaddressSelect
                        str += "<option value="+data.DataBag[i].Gatewayaddress+">"+data.DataBag[i].Gatewayaddress+"</option>"
                    }
                    $("#gatewayaddressSelect").append(str);
                    //根据传输设备地址选择系统地址
                    sysaddressFunc(data);
                    $("#gatewayaddressSelect").get(0).onclick=function(){
                        sysaddressFunc(data);
                    }

                }
            });
            //根据传输设备地址选择系统地址
            function sysaddressFunc(data){
                var sysaddressSelectObj="";
                var gatewayaddressSelect = $("#gatewayaddressSelect").val();
                //根据传输设备地址查询系统地址
                for(var j=0; j<data.DataBag.length; j++){
                    if($.trim(gatewayaddressSelect)==$.trim(data.DataBag[j].Gatewayaddress)){
                        sysaddressSelectObj = data.DataBag[j].otherInfo;
                        break;
                    }
                }
                //将系统地址数据绑定到下拉框上
                if(sysaddressSelectObj!=""){
                    //清空传输设备地址
                    $("#sysaddressSelect").html("");
                    console.log(sysaddressSelectObj);
                    var str="";
                    for(var i=0; i<sysaddressSelectObj.length; i++){
                        str += "<option value="+sysaddressSelectObj[i].Sysaddress+">"+sysaddressSelectObj[i].Sysaddress+"("+sysaddressSelectObj[i].tiSysType+")"+"</option>"
                    }
                    $("#sysaddressSelect").append(str);
                }
            }

            //点击新增里面的确认按钮
            $("#modalConfirm").get(0).onclick=function(){
                var myData = getForm("#addComponentForm");
                myData.cFlatPic = sessionStorage.getItem("cFlatPic");
                if($("#fPositionX").text() && $("#fPositionY").text()){
                    myData.fPositionX = $("#fPositionX").text();
                    myData.fPositionY = $("#fPositionY").text();
                }else{
                    alert('请标注部件');
                    return;
                }
                console.log(myData);
                //下面是调用新增部件api
                HH.post("/Orginfo/AddDevices",myData, function (data) {
                    console.log("后台返回的新增部件信息");
                    console.log(data);
                    if (data.DataBag && data.StateMessage == "1000") {
                        $('#changeModal').modal("hide");
                        location.reload();
                    }
                });
            }
            //点击放大和缩小按钮事件
            var big = $("#addBig");
            var small = $("#addSmall");
            big.click(function(){
                //alert('sadf');
                showBig("addSvgContainer");
            });
            small.click(function(){
                showSmall("addSvgContainer");
            });
            //下面是调用svg里面拖动图片的代码函数
            //获取svg
            var svgObj = $("#addSvgContainer");
            svgObj.get(0).onmousemove=function(){
                //调用在svg上面鼠标移动函数.参数：svg的id，包含svg的div的id，画圆的配置信息
                /*   参数分别是：
                 * 圆的半径，圆的边框颜色，圆的额边框宽度，圆填充颜色
                 * */
                var settings = {
                    'r':circleR,
                    'stroke':'darkgray',
                    'strokeWidth':'0',
                    'fill':'#ce8483',
                    'flag':'once'
                };
                posMove(this.id,"addSvgDiv",settings);
            }

        }
        if($(this).text()=="批量导入部件"){
            //render("#fileUpData","#changeBody");
            /*HH.post("/Orginfo/AddDevices",myData, function (data) {
                console.log("后台返回的新增部件信息");
                console.log(data);
                if (data.DataBag && data.StateMessage == "1000") {
                    $('#changeModal').modal("hide");
                    location.reload();
                }
            });*/
            $('#intoExcelModal').modal({"backdrop":"static"});

            $("#downFile").attr("href",ApiUrl+"/Orginfo/DownFile?filepath=Uploading/部件信息导入模板-8-8.xlsx");
            $('#upComponentForm').on("change","#file",function(){
                document.getElementById("userdefinedFile").value = document.getElementById("file").value;
            })
            //点击模态框保存
            $("#intoExcelModalConfirm").get(0).onclick=function(){
                $("#cFlatpic").val(sessionStorage.getItem("cFlatPic"));
                //$("#CompanyProfileForm").submit();
                //上传文件jQuery表单提交
                var options = {
                    //beforeSubmit: showRequest,  //提交前的回调函数
                    success: showResponse,      //提交后的回调函数
                    url: ApiUrl+"/Form/ExcelToDataBase", //默认是form的action， 如果申明，则会覆盖
                    type: "post",               //默认是form的method（get or post），如果申明，则会覆盖
                    dataType: "json"           //html(默认), xml, script, json...接受服务端返回的类型
                    //clearForm: true,          //成功提交后，清除所有表单元素的值
                    //resetForm: true,          //成功提交后，重置所有表单元素的值
                    //timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求
                }
                function showResponse(responseText, statusText){
                    console.log(responseText);
                    if(responseText.StateMessage==1000){
                        $("#intoExcelModal").modal("hide");
                        location.reload();
                        confirmBtnSelectIndexTb();

                    }else{
                        alert('你导入的文件已存在');
                    }
                }
                $("#upComponentForm").ajaxSubmit(options);
            }
        }
        if($(this).text()=="标注部件位置"){

            //清空原来跳转的数据
            $("#indexInput").val("");
            gotoFlag = false;
            //alert(sessionStorage.getItem("imFlatPic"));
            $('#pointComponentModal').modal({"backdrop":"static"});
            //设置标注部件里面的背景图
            //alert($(".imgs").length);
            $(".imgs").attr("xlink:href","");
            $(".imgs").attr("src","");
            //alert(sessionStorage.getItem("imFlatPic"));
            $(".imgs").attr("xlink:href",ImgUrl+sessionStorage.getItem("imFlatPic"));
            $(".imgs").attr("src",ImgUrl+sessionStorage.getItem("imFlatPic"));
            //$("#imgs").attr("src",ApiUrl+sessionStorage.getItem("imFlatPic"));
            //下面是请求第一个点的数据
            function askFirstPoint(){
                HH.post("/Orginfo/GetFirstDevice",{"cFlatPic":sessionStorage.getItem("cFlatPic")},function(data){
                    console.log("返回的第一个节点");
                    console.log(data);
                    if(data.StateMessage=="1000"){
                        //render("#coreComponentData","#caseComponentBody",data);
                        //$('#caseComponentModal').modal({"backdrop":"static"});
                        $("#DeviceNo").text(data.DataBag.DeviceNo);
                        $("#deviceaddress2").text(data.DataBag.deviceaddress);
                        $("#sysaddress").text(data.DataBag.Sysaddress);
                        $("#gatewayaddress").text(data.DataBag.Gatewayaddress);
                        $("#iDeviceType").text(data.DataBag.DeviceTypeName);
                        index = data.DataBag.DeviceNo;
                        //点击放大和缩小按钮事件
                        var big = $("#big");
                        var small = $("#small");
                        big.click(function(){
                            showBig("svgContainer");
                        });
                        small.click(function(){
                            showSmall("svgContainer");
                        });

                        //下面是调用svg里面拖动图片的代码函数
                        //获取svg
                        var svgObj = $("#svgContainer");
                        svgObj.get(0).onmousemove=function(){
                            //调用在svg上面鼠标移动函数.参数：svg的id，包含svg的div的id，画圆的配置信息
                            /*   参数分别是：
                             * 圆的半径，圆的边框颜色，圆的额边框宽度，圆填充颜色
                             * */
                            var settings = {
                                'r':circleR,
                                'stroke':'darkgray',
                                'strokeWidth':'0',
                                'fill':'#ce8483',
                                'flag':'showPointeds'
                            };
                            posMove(this.id,"svgDiv",settings);
                        }
                    }
                });
            }
            //askFirstPoint();
            //下面是显示上次已经标注过的点
            var myData = {
                "cFlatPic":sessionStorage.getItem("cFlatPic")+""
            };
            //下面是显示上次已经标注过的点渲染出来
            console.log(myData);
            HH.post("/Orginfo/GetLabelledDevice",myData, function (data) {
                console.log("后台返回的标注过的点信息");
                console.log(data);
                if(data.DataBag.length<1){
                    askFirstPoint();
                    //return;
                }else{

                    //设置上面的五个字段
                    console.log(data.DataBag[data.DataBag.length-1].DeviceNo+"="+data.DataBag[data.DataBag.length-1].deviceaddress+"="+data.DataBag[data.DataBag.length-1].DeviceTypeName);
                    $("#DeviceNo").text(data.DataBag[data.DataBag.length-1].DeviceNo);
                    $("#deviceaddress2").text(data.DataBag[data.DataBag.length-1].deviceaddress);
                    $("#sysaddress").text(data.DataBag[data.DataBag.length-1].Sysaddress);
                    $("#gatewayaddress").text(data.DataBag[data.DataBag.length-1].Gatewayaddress);
                    $("#iDeviceType").text(data.DataBag[data.DataBag.length-1].DeviceTypeName);
                    if (data.DataBag && data.StateMessage == "1000") {
                        //render("#detailComponentData","#caseComponentBody",data);
                        //点击放大和缩小按钮事件
                        var big = $("#big");
                        var small = $("#small");
                        big.click(function(){
                            //alert('sadf');
                            showBig("svgContainer");
                        });
                        small.click(function(){
                            showSmall("svgContainer");
                        });
                        //下面是调用svg里面拖动图片的代码函数
                        //获取svg
                        var svgObj = $("#svgContainer");
                        //svgObj.get(0).onmousemove=function(){
                        //调用在svg上面鼠标移动函数.参数：svg的id，包含svg的div的id，画圆的配置信息
                        /*   参数分别是：
                         * 圆的半径，圆的边框颜色，圆的额边框宽度，圆填充颜色
                         * */
                        var settings = {
                            'r':circleR,
                            'stroke':'darkgray',
                            'strokeWidth':'0',
                            'fill':'#ce8483',
                            'flag':'showPointeds',
                            'showAll':'showPointeds',
                            'x':data.DataBag,
                            'y':data.DataBag
                        };
                        posMove("svgContainer","svgDiv",settings);
                        //}
                    }
                }
            });
        }
        if($(this).text()=="批量删除部件"){
            $("#deleteComponentModal").modal({"backdrop":"static"});
            $("#deleteComponentConfirm").get(0).onclick=function(){
                var tempFlag = false;
                var indexChecks = $(".indexChecks:checked");
                for(var i=0; i<indexChecks.length; i++){
                    var deviceaddress = indexChecks.eq(i).attr("deviceaddress");
                    var sysaddress = indexChecks.eq(i).attr("Sysaddress");
                    var gatewayaddress = indexChecks.eq(i).attr("Gatewayaddress");
                    var myData = {
                        "deviceaddress":deviceaddress,
                        "sysaddress":sysaddress,
                        "gatewayaddress":gatewayaddress
                    };
                    HH.post("/Orginfo/DeleteDevices",myData, function (data) {
                        console.log("后台返回的首页的删除信息");
                        console.log(data);
                        if (data.DataBag && data.StateMessage == "1000") {
                            //render("#alarmComponentTbData","#alarmComponentTbody",data);
                            tempFlag = true;
                        }
                    });
                }
                location.reload();
                //confirmBtnSelectIndexTb();
                $("#deleteComponentModal").modal("hide");
            }

            /*var deviceaddress = $(this).attr("deviceaddress");
            var sysaddress = $(this).attr("Sysaddress");
            var gatewayaddress = $(this).attr("Gatewayaddress");
            var myData = {
                "deviceaddress":deviceaddress,
                "sysaddress":sysaddress,
                "gatewayaddress":gatewayaddress
            };
            $("#deleteComponentModal").modal({"backdrop":"static"});
            $("#deleteComponentConfirm").get(0).onclick=function(){
                HH.post("/Orginfo/DeleteDevices",myData, function (data) {
                    console.log("后台返回的首页的删除信息");
                    console.log(data);
                    if (data.DataBag && data.StateMessage == "1000") {
                        //render("#alarmComponentTbData","#alarmComponentTbody",data);
                        confirmBtnSelectIndexTb();
                        $("#deleteComponentModal").modal("hide");
                    }
                });
            }*/
        }
    });

    //表格里面的查看详情按钮操作
    $('#buildingTbody').on("click",".operation",function(){
        if($(this).text()=="查看详情"){
            //render("#detailComponentData","#caseComponentBody");
            $('#caseComponentModal').modal({"backdrop":"static"});

            var myData = {
                "deviceaddress":$(this).attr("deviceaddress"),
                "sysaddress":$(this).attr("Sysaddress"),
                "gatewayaddress":$(this).attr("Gatewayaddress")
            };
            //下面是查看详情返回的数据
            HH.post("/Orginfo/SelectDeviceDetail",myData, function (data) {
                if (data.DataBag && data.StateMessage == "1000") {
                    render("#detailComponentData","#caseComponentBody",data);
                    $(".imgs").get(0).setAttribute("xlink:href","");
                    $(".imgs").get(0).setAttribute("src","");
                    //alert(sessionStorage.getItem("imFlatPic"));
                    $(".imgs").get(0).setAttribute("xlink:href",ImgUrl+sessionStorage.getItem("imFlatPic"));
                    $(".imgs").get(0).setAttribute("src",ImgUrl+sessionStorage.getItem("imFlatPic"));
                    $("#buildingName").text(sessionStorage.getItem("sitename"));
                    $("#floorID").text(sessionStorage.getItem("floornum"));
                    //点击放大和缩小按钮事件
                    var big = $("#big2");
                    var small = $("#small2");
                    big.click(function(){
                        //alert('sadf');
                        showBig("svgContainer2");
                    });
                    small.click(function(){
                        showSmall("svgContainer2");
                    });
                    //下面是调用svg里面拖动图片的代码函数
                    //获取svg
                    var svgObj = $("#svgContainer2");
                    //svgObj.get(0).onmousemove=function(){
                    //调用在svg上面鼠标移动函数.参数：svg的id，包含svg的div的id，画圆的配置信息
                    /*   参数分别是：
                     * 圆的半径，圆的边框颜色，圆的额边框宽度，圆填充颜色
                     * */
                    var settings = {
                        'r':circleR,
                        'stroke':'darkgray',
                        'strokeWidth':'0',
                        'fill':'#ce8483',
                        'flag':'showOnePoint',
                        'x':data.DataBag[0].fPositionX,
                        'y':data.DataBag[0].fPositionY
                    };
                    posMove("svgContainer2","svgDiv2",settings);
                    //}
                }
            });
            $("#caseComponentConfirm").click(function(){
                $('#caseComponentModal').modal("hide");
            });
        }if($(this).text()=="修改"){
            $('#caseComponentModal').modal({"backdrop":"static"});
            var myData = {
                "deviceaddress":$(this).attr("deviceaddress"),
                "sysaddress":$(this).attr("Sysaddress"),
                "gatewayaddress":$(this).attr("Gatewayaddress")
            };
            var deviceaddress = $(this).attr("deviceaddress");
            var DeviceNo = $(this).attr("DeviceNo");

            //下面是修改里面的详情返回的数据
            HH.post("/Orginfo/SelectDeviceDetail",myData, function (data) {
                if (data.DataBag && data.StateMessage == "1000") {
                    render("#changeComponentData", "#caseComponentBody", data);
                    $(".imgs").get(0).setAttribute("xlink:href","");
                    $(".imgs").get(0).setAttribute("src","");
                    //alert(sessionStorage.getItem("imFlatPic"));
                    $(".imgs").get(0).setAttribute("xlink:href",ImgUrl+sessionStorage.getItem("imFlatPic"));
                    $(".imgs").get(0).setAttribute("src",ImgUrl+sessionStorage.getItem("imFlatPic"));
                    var temp = deviceaddress.split(".");
                    $("#changeRoad").val(temp[0]);
                    $("#changeAddress").val(temp[1]);
                    //渲染新增里面的下拉框
                    var str="";
                    for(var i=0; i<compoentTypeSelectData.DataBag.length; i++){
                        str = str+"<option value='"+compoentTypeSelectData.DataBag[i].iDeviceType+"'>"+compoentTypeSelectData.DataBag[i].DeviceTypeName+"</option>";
                    }
                    $("#changeComponentSelect").append(str);

                    //点击放大和缩小按钮事件
                    var big = $("#changeAddBig");
                    var small = $("#changeAddSmall");
                    big.click(function(){
                        //alert('sadf');
                        showBig("changeSvgContainer");
                    });
                    small.click(function(){
                        showSmall("changeSvgContainer");
                    });
                    //下面是调用svg里面拖动图片的代码函数
                    //获取svg
                    var svgObj = $("#changeSvgContainer");
                    //svgObj.get(0).onmousemove=function(){
                    //调用在svg上面鼠标移动函数.参数：svg的id，包含svg的div的id，画圆的配置信息
                    /*   参数分别是：
                     * 圆的半径，圆的边框颜色，圆的额边框宽度，圆填充颜色
                     * */
                    var settings = {
                        'r':circleR,
                        'stroke':'darkgray',
                        'strokeWidth':'0',
                        'fill':'#ce8483',
                        'flag':'showOnePoint',
                        'flagChange':'changeShowOnePoint',
                        'x':data.DataBag[0].fPositionX,
                        'y':data.DataBag[0].fPositionY
                    };
                    posMove("changeSvgContainer","changeSvgDiv",settings);
                    //}
                    //点击修改模态框里面的保存按钮
                    $("#caseComponentConfirm").get(0).onclick=function(){
                        var myData = getForm("#changeComponentForm");
                        myData.fPositionX=$("#changefPositionX").text();
                        myData.fPositionY=$("#changefPositionY").text();
                        myData.DeviceNo = DeviceNo;
                        myData.cFlatPic = sessionStorage.getItem("cFlatPic");
                        /*var temp = deviceaddress.split(".");
                        myData.Road = temp[0];
                        myData.Address = temp[1];*/
                        HH.post("/Orginfo/UpdateDevices",myData,function (data) {
                            if (data.DataBag && data.StateMessage == "1000") {
                                $('#caseComponentModal').modal("hide");
                                //location.reload();
                                confirmBtnSelectIndexTb();
                            }

                        });
                    }
                }
            });
        }if($(this).text()=="删除"){
            var deviceaddress = $(this).attr("deviceaddress");
            var sysaddress = $(this).attr("Sysaddress");
            var gatewayaddress = $(this).attr("Gatewayaddress");
            var myData = {
                "deviceaddress":deviceaddress,
                "sysaddress":sysaddress,
                "gatewayaddress":gatewayaddress
            };
            $("#deleteComponentModal").modal({"backdrop":"static"});
            $("#deleteComponentConfirm").get(0).onclick=function(){
                HH.post("/Orginfo/DeleteDevices",myData, function (data) {
                    if (data.DataBag && data.StateMessage == "1000") {
                        //render("#alarmComponentTbData","#alarmComponentTbody",data);
                        confirmBtnSelectIndexTb();
                        $("#deleteComponentModal").modal("hide");
                    }
                });
            }
        }
    });
})();
//点击跳转按钮
var gotoBtn = $('#gotoBtn');
gotoBtn.get(0).onclick = function () {
    goToFunc();
}
function goToFunc(){
    gotoFlag = true;
    noNodeNum=0;
    indexInput = $('#indexInput').val();
    /*if(parseInt(indexInput) > data.DataBag.length || parseInt(indexInput)<=0){
     alert('您输入的点有误');
     alert('sadfsd');
     return;
     }*/
    //下面是点击跳转的时候判断有无此点
    var temp = $("#svgDiv").find("circle[deviceNo="+indexInput+"]");
    if(temp.eq(0).get(0)==undefined){
        alert('不存在此部件');
        return;
    }

    $("#DeviceNo").text(indexInput);
    var temp = $("#svgDiv").find("circle[deviceNo="+indexInput+"]");
    temp = temp.eq(0).get(0);

    $("#deviceaddress2").text(temp.getAttribute("deviceaddress"));
    $("#sysaddress").text(temp.getAttribute("Sysaddress"));
    $("#gatewayaddress").text(temp.getAttribute("Gatewayaddress"));
    $("#iDeviceType").text(temp.getAttribute("deviceTypeName"));
}
var componentNum=0;//定义最后一个部件的序号
var componentSeveral = 0;//定义部件的数量
function posMove(svgid,svgdivid,settings) {
    //console.log('sadf');
   // alert(settings.r);
    var svgObj = document.getElementById(svgid);//svg
    //console.log(oDiv);
    var svgDivObj = document.getElementById(svgdivid);//最外面控制宽高的div
    var sent = {
        l: 10, //设置div在父元素的活动范围，10相当于给父div设置padding-left：10;
        r: parseInt(svgDivObj.getAttribute("width")) - parseInt(svgObj.getAttribute("width")), // offsetWidth:当前对象的宽度， offsetWidth = width+padding+border
        t: 10,
        b: parseInt(svgDivObj.getAttribute("height")) - parseInt(svgObj.getAttribute("height")),
        n: 10
    }
    //console.log(sent.r);
    drag(svgObj, sent,svgDivObj,settings);
}
/**
 *
 * @param obj:被拖动的div
 * @param sent :设置div在容器中可以被拖动的区域
 */
var indexInput = 0;
var index = "";//确认是第几个
var preIndex = 0;//点击上一个按钮初始化
var preNextFlag = false;
var noNodeNum=0;
var gotoFlag = false;//确定点击了跳转没
function drag(obj,sent,oParent,settings){
    var dmW = document.documentElement.clientWidth || document.body.clientWidth;
    var dmH = document.documentElement.clientHeight || document.body.clientHeight;

    var sent = sent || {};
    var l = sent.l || 0;
    var r = sent.r;
    var t = sent.t || 0;
    var b = sent.b;
    var n = sent.n || 10;

    //判断要是现实的是一个点(查看详情部分)
    if(settings.flag=="showOnePoint"){
        var circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
        //console.log(x+"-=-="+y);
        circle.setAttribute('cx', settings.x + "%");
        circle.setAttribute('cy', settings.y + "%");
        circle.setAttribute('r', settings.r);
        circle.setAttribute('stroke', settings.stroke);
        circle.setAttribute('stroke-width', settings.strokeWidth);
        circle.setAttribute('fill', settings.fill);
        circle.setAttribute('class', 'circles');
        $(obj).append(circle);
    }
    //下面是显示和画所有的点（画所有的点）
    if(settings.flag=="showPointeds" && settings.showAll=="showPointeds"){
        //下面是点击的时候删除之前的所有画圆
        if($(obj).children("circle")!=undefined){
            $(obj).children("circle").remove();
        }
        for(var i=0; i<settings.x.length; i++){
            var circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
             //console.log(x+"-=-="+y);
             circle.setAttribute('cx', settings.x[i].fPositionX + "%");
             circle.setAttribute('cy', settings.y[i].fPositionY + "%");
             circle.setAttribute('r', settings.r);
             circle.setAttribute('stroke', settings.stroke);
             circle.setAttribute('stroke-width', settings.strokeWidth);
             circle.setAttribute('fill', settings.fill);
             circle.setAttribute('class', 'circles');
            circle.setAttribute('index', parseInt(settings.x[i].DeviceNo)-1);
            circle.setAttribute('deviceNo', settings.x[i].DeviceNo);
            circle.setAttribute('deviceaddress', settings.x[i].deviceaddress);
            circle.setAttribute('deviceTypeName', settings.x[i].DeviceTypeName);
            circle.setAttribute('Sysaddress', settings.x[i].Sysaddress);
            circle.setAttribute('Gatewayaddress', settings.x[i].Gatewayaddress);
             $(obj).append(circle);
            //鼠标移动到图片上时，提示信息
            $("#svgDiv").on("mouseover mouseout",".circles",function(event){
                showToolTip(this);
            });
        }
        var datas = {
            "deviceaddress": $.trim($("#deviceaddress2").text()),
            "sysaddress":parseInt($.trim($("#sysaddress").text())),
            "gatewayaddress":$.trim($("#gatewayaddress").text()),
            "cFlatPic":sessionStorage.getItem("cFlatPic"),
            "DeviceNo":parseInt($.trim($("#DeviceNo").text())),
            "fPositionX":parseFloat(settings.x[settings.x.length-1].fPositionX),
            "fPositionY":parseFloat(settings.y[settings.x.length-1].fPositionY)
        };
        HH.post("/Orginfo/MarkPoint", datas, function (data) {
            if(data.StateMessage=="1000" && data.DataBag!="不存在下一个节点"){
                //设置所有标注了点的下一个点的信息
                $("#DeviceNo").text(data.DataBag.DeviceNo);
                $("#deviceaddress2").text(data.DataBag.deviceaddress);
                $("#sysaddress").text(data.DataBag.Sysaddress);
                $("#gatewayaddress").text(data.DataBag.Gatewayaddress);
                $("#iDeviceType").text(data.DataBag.DeviceTypeName);
            }

        });

        /*var circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
        //console.log(x+"-=-="+y);
        circle.setAttribute('cx', settings.x + "%");
        circle.setAttribute('cy', settings.y + "%");
        circle.setAttribute('r', settings.r);
        circle.setAttribute('stroke', settings.stroke);
        circle.setAttribute('stroke-width', settings.strokeWidth);
        circle.setAttribute('fill', settings.fill);
        circle.setAttribute('class', 'circles');
        $(obj).append(circle);*/
    }

    obj.onmousedown = function (ev){
        //if(noNodeNum==1 || parseInt($("#DeviceNo").text())>=componentNum+1){
        //alert(componentSeveral<$(".circles").length+"--"+$(".circles").length);

        var circles = $('.circles');

        //index++;
        //console.log($(obj).children("circle"))
        //$(obj).children("circle")
        //console.log(parseInt(obj.getAttribute("x")));
        var oEvent = ev || event;
        var sentX = oEvent.clientX - parseInt($(obj).css("left"));
        var sentY = oEvent.clientY - parseInt($(obj).css("top"));

        document.oncontextmenu = function (ev) {
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
            ev.preventDefault();
            //return false;
        };
        //证明是右键，取消点击默认事件
        if(ev.button==2){
            //alert('asdf');
            return;
        }
       //=============
        document.onmouseup = function () {
            document.onmousemove = null;
            document.onmouseup = null;
            return;
        }

        if((noNodeNum==1 || componentSeveral<$(".circles").length) && settings.flag!="once"){
            //alert(noNodeNum+"--downo");
            return;
        }
        if(componentSeveral==$(".circles").length && gotoFlag==false && settings.flag!="once"){
            //alert($(".circles").length);
            //alert('down拦截');
            return;
        }
        //下面是点击一下图片的时候就画一个圆形
        //x:屏幕的x-（父元素离屏幕左边的距离-svg的left绝对值）
        var x = oEvent.clientX-($(oParent).offset().left-Math.abs(parseInt($(obj).css("left"))));
        var y = oEvent.clientY+(document.body.scrollTop || document.documentElement.scrollTop)-($(oParent).offset().top-Math.abs(parseInt($(obj).css("top"))));
        var svgWidth = parseInt($(obj).css("width"));
        var svgHeight = parseInt($(obj).css("height"));
        x = (x/svgWidth)*100;
        y = (y/svgHeight)*100;

        //说明是只进行一次打点操作（点击新增部件的时候，因为只有一个点）
        if(settings.flag=="once"){
            var circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
            //console.log(x+"-=-="+y);
            circle.setAttribute('cx', x + "%");
            circle.setAttribute('cy', y + "%");
            circle.setAttribute('r', settings.r);
            circle.setAttribute('stroke', settings.stroke);
            circle.setAttribute('stroke-width', settings.strokeWidth);
            circle.setAttribute('fill', settings.fill);
            circle.setAttribute('class', 'circles');

            circle.setAttribute('index', index);
            //console.log(oEvent.clientX+"---"+oEvent.clientY);
            //下面是点击的时候删除之前的所有画圆
            if($(obj).children("circle")!=undefined){
                $(obj).children("circle").remove();
            }
            //console.log(circle);
            $(obj).append(circle);
            $("#fPositionX").text((x+"").substr(0,4));
            $("#fPositionY").text((y+"").substr(0,4));
            settings.flag="";
        }
        //changeShowOnePoint
        //判断要是显示的是一个点（修改按钮，修改一个点）
        if(settings.flagChange=="changeShowOnePoint" && settings.flag=="showOnePoint"){
            //下面是点击的时候删除之前的所有画圆
            if($(obj).children("circle")!=undefined){
                $(obj).children("circle").remove();
            }
            var circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
            //console.log(x+"-=-="+y);
            circle.setAttribute('cx', x + "%");
            circle.setAttribute('cy', y + "%");
            $("#changefPositionX").text((x+"").substr(0,4));
            $("#changefPositionY").text((y+"").substr(0,4));
            circle.setAttribute('r', settings.r);
            circle.setAttribute('stroke', settings.stroke);
            circle.setAttribute('stroke-width', settings.strokeWidth);
            circle.setAttribute('fill', settings.fill);
            circle.setAttribute('class', 'circles');
            $(obj).append(circle);
        }

        var datas = {
            "deviceaddress": $.trim($("#deviceaddress2").text()),
            "sysaddress":parseInt($.trim($("#sysaddress").text())),
            "gatewayaddress":$.trim($("#gatewayaddress").text()),
            "cFlatPic":sessionStorage.getItem("cFlatPic"),
            "DeviceNo":parseInt($.trim($("#DeviceNo").text())),
            "fPositionX":parseFloat(x),
            "fPositionY":parseFloat(y)
        };
       /* for(var i=0; i<circles.length; i++){
            console.log(circles.eq(i).get(0));
        }*/
        /*//下面是点击上一个下一个的部分
        if($(obj).children("circle")!=undefined && preIndex!=0 && preNextFlag==true){
            var temp = $(obj).find("circle[index="+preIndex+"]");

        }*/
        //下面是显示所有点和修改点
        if(settings.flag=="showPointeds"){
            HH.post("/Orginfo/MarkPoint", datas, function (data) {
            if(data.StateMessage=="1000"){

                //删除原来的点
                var temp = $(obj).find("circle[deviceNo="+indexInput+"]");

                if(temp.length!=0){//证明点了跳转按钮，并且存在此点
                    //alert("初次进入修改");
                    if(data.DataBag=="不存在下一个节点"){
                        noNodeNum++;
                        if(noNodeNum==2){
                            //alert('修改');
                            return;
                        }
                    }
                    /*if(componentSeveral==$(".circles").length){
                        alert('修改进入');
                        return;
                    }
                    alert(x);*/
                    var deviceNo = temp.eq(0).get(0).getAttribute('deviceNo');
                    var deviceaddress = temp.eq(0).get(0).getAttribute('deviceaddress');
                    var deviceTypeName = temp.eq(0).get(0).getAttribute('deviceTypeName');
                    var Sysaddress = temp.eq(0).get(0).getAttribute('Sysaddress');
                    var Gatewayaddress = temp.eq(0).get(0).getAttribute('Gatewayaddress');
                    var index = temp.eq(0).get(0).getAttribute('index');

                    temp.remove();
                    var circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
                    //console.log(x+"-=-="+y);
                    circle.setAttribute('cx', x + "%");
                    circle.setAttribute('cy', y + "%");
                    circle.setAttribute('r', circleR);
                    circle.setAttribute('stroke', settings.stroke);
                    circle.setAttribute('stroke-width', settings.strokeWidth);
                    circle.setAttribute('fill', settings.fill);
                    circle.setAttribute('class', 'circles');
                    circle.setAttribute('index', index);
                    //alert(deviceNo);
                    circle.setAttribute('deviceNo', deviceNo);
                    circle.setAttribute('deviceaddress', deviceaddress);
                    circle.setAttribute('deviceTypeName', deviceTypeName);

                    circle.setAttribute('Sysaddress', Sysaddress);
                    circle.setAttribute('Gatewayaddress', Gatewayaddress);
                    $(obj).append(circle);
                    var tempNo = parseInt(data.DataBag.DeviceNo)-parseInt(deviceNo);

                    indexInput = parseInt(indexInput);
                    indexInput = indexInput+tempNo;
                    //indexInput=0;
                }else {//不是修改，而是新增
                    //alert('else');
                    // alert('dowm');
                    // && noNodeNum==2
                    if(data.DataBag=="不存在下一个节点"){
                        noNodeNum++;
                        if(noNodeNum==1){
                            //alert('修改');
                            return;
                        }
                    }
                    if(componentSeveral==$(".circles").length){
                        return;
                    }
                    if(componentNum==parseInt($("#DeviceNo").text()) && noNodeNum==2){
                        return;
                    }
                    var circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
                    //console.log(x+"-=-="+y);
                    circle.setAttribute('cx', x + "%");
                    circle.setAttribute('cy', y + "%");
                    circle.setAttribute('r', circleR);
                    circle.setAttribute('stroke', settings.stroke);
                    circle.setAttribute('stroke-width', settings.strokeWidth);
                    circle.setAttribute('fill', settings.fill);
                    circle.setAttribute('class', 'circles');
                    circle.setAttribute('index', parseInt(data.DataBag.DeviceNo) - 1);
                    circle.setAttribute('deviceNo', $("#DeviceNo").text());
                    circle.setAttribute('deviceaddress', $("#deviceaddress2").text());
                    circle.setAttribute('deviceTypeName', $("#iDeviceType").text());

                    circle.setAttribute('Sysaddress', $("#sysaddress").text());
                    circle.setAttribute('Gatewayaddress', $("#gatewayaddress").text());
                    $(obj).append(circle);
                    //indexInput=0;

                }
                $("#DeviceNo").text(data.DataBag.DeviceNo);
                $("#deviceaddress2").text(data.DataBag.deviceaddress);
                $("#sysaddress").text(data.DataBag.Sysaddress);
                $("#gatewayaddress").text(data.DataBag.Gatewayaddress);
                $("#iDeviceType").text(data.DataBag.DeviceTypeName);

                //鼠标移动到图片上时，提示信息
                $("#svgDiv").on("mouseover mouseout",".circles",function(event){
                    showToolTip(this);
                });
            }
        });
        }
        return false;

    }
}

//点击关闭的时候清空画圆
$(".AlarmComponentDetailClose").click(function(){
   deleteCircles();
});
function deleteCircles(){
    noNodeNum=0;
    $(".circles").remove();
    //下面是点击的时候删除之前的所有画圆
    if($("#svgDiv").children("circle")!=undefined){
        $("#svgDiv").children("circle").remove();
    }
    //清空修改上面的圆
    if($("#changeSvgContainer").children("circle")!=undefined){
        $("#changeSvgContainer").children("circle").remove();
    }
    //清空新增里面的圆点
    if($("#addSvgContainer").children("circle")!=undefined){
        $("#addSvgContainer").children("circle").remove();
    }
}

var circleR = 6;
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



function yearMonthDay(data){
    $(data).datetimepicker({
        format: 'yyyy/mm/dd',//日期格式
        weekStart: 1,//一周从那天开始
        autoclose: true,//选中之后自动隐藏日期选择框
        startView: 2,//选完时间首先显示的视图（年月日）
        minView: 2,//日期时间选择器所能够提供的最精确的时间选择视图。
        forceParse: false,//你输入的可能不正规，但是它会强制尽量解析成你规定的格式（format）
        language: 'zh-CN'//
    });
}

//鼠标移动到图片上时，提示信息
function showToolTip(obj){
    if(event.type=="mouseover"){
        $("#bjxh").text(obj.getAttribute("deviceNo"));
        $("#bjdz").text(obj.getAttribute("deviceaddress"));
        $("#bjlx").text(obj.getAttribute("deviceTypeName"));
        //console.log(event.clientX+"=="+event.clientY);
        var x = event.clientX-$("#svgDiv").offset().left;
        var y = event.clientY+(document.body.scrollTop || document.documentElement.scrollTop)-$("#svgDiv").offset().top;
        $("#toolTip").css({
            "left":x+10+"px",
            "top":y+10+"px",
            "display":"block"
        });
    }else if(event.type=="mouseout"){
        $("#toolTip").css({
            "display":"none"
        });
    }

}























