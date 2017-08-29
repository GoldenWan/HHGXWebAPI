/**
 * Created by Qiu on 2017/6/24.
 */
(function(){
    var myAllData="";
    HH.post("/AlarmData/FireUnDealInfo",{"Firealarmid": $.trim(sessionStorage.getItem("Firealarmid"))},function(data) {
        console.log("后台返回的详情信息");
        console.log(data);
        if (data.DataBag && data.StateMessage=="1000") {
            myAllData = data;
            render("#baseInfoData","#targBaseInfoRow",data);
            $("#navBar>li").css("border-bottom","none");
            $("#navBar>li:first-of-type").css("border-bottom","3px solid gray");
        }
    });

    //点击导航条展现不同数据
    var lis = $("#navBar>li");

    $(document.body).on("click","#navBar>li",function(){
        if($(this).text()=="地图"){
            $("#navBar>li").css("border-bottom","none");
            $("#navBar>li:nth-of-type(3)").css("border-bottom","3px solid gray");
            render("#mapData","#targBaseInfoRow",myAllData);
            var temp = $("#mapContainer");
            //console.log(temp.attr("id"));
            if(temp.attr("id")!=undefined){
                //baiDuMap(temp.attr("id"),"lng","lat");
                //alert(myAllData.DataBag[0].fLongitude+"==="+myAllData.DataBag[0].fLatitude);
                positionMap(temp.attr("id"),myAllData.DataBag[0].fLongitude,myAllData.DataBag[0].fLatitude);
                //searchMap(myAllData.DataBag[0].fLongitude,myAllData.DataBag[0].fLatitude,temp.attr("id"));
            }
        }if($(this).text()=="基本信息"){
            $("#navBar>li").css("border-bottom","none");
            $("#navBar>li:nth-of-type(1)").css("border-bottom","3px solid gray");
            //alert(sessionStorage.getItem("Firealarmid"));
            //HH.post("/AlarmData/FireDealInfo",{"Firealarmid":sessionStorage.getItem("Firealarmid")},function(data) {
               // console.log("后台返回的详情信息");
                //console.log(data);
                //if (data.DataBag && data.StateMessage=="1000") {
                    render("#baseInfoData","#targBaseInfoRow",myAllData);
                //}
            //});
            //render("#baseInfoData","#targBaseInfoRow",data);
        }if($(this).text()=="总平图"){
            render("#allBigImgData","#targBaseInfoRow",myAllData);
            var big = $("#bigbFlatpic");
            var small = $("#smallbFlatpic");
            big.click(function(){
                doSmall("allBigImg");
            });
            small.click(function(){
                doBig("allBigImg");
            });
            //下面是调用svg里面拖动图片的代码函数
            //获取svg
            var svgObj = $("#allBigImg");
            svgObj.get(0).onmousemove=function(){
                //调用在svg上面鼠标移动函数.参数：svg的id，包含svg的div的id，画圆的配置信息
                /*   参数分别是：
                 * 圆的半径，圆的边框颜色，圆的额边框宽度，圆填充颜色
                 * */
                var settings = {
                    'r':10,
                    'stroke':'darkgray',
                    'strokeWidth':'2',
                    'fill':'darkgray'
                };
                posMove(this.id,"svgDivbFlatpic",settings);
            }

            $("#navBar>li").css("border-bottom","none");
            $("#navBar>li:nth-of-type(2)").css("border-bottom","3px solid gray");
        }if($(this).text()=="外观图"){
            render("#outViewImgData","#targBaseInfoRow",myAllData);

            $("#navBar>li").css("border-bottom","none");
            $("#navBar>li:nth-of-type(4)").css("border-bottom","3px solid gray");
        }if($(this).text()=="平面图"){
            render("#graphData","#targBaseInfoRow",myAllData);
            //设置部件序号，部件地址，部件类型
            $("#bjxh").text(myAllData.DataBag[0].DeviceNo);
            $("#bjdz").text(myAllData.DataBag[0].deviceaddress);
            $("#bjlx").text(myAllData.DataBag[0].DeviceTypeName);

            $("#navBar>li").css("border-bottom","none");
            $("#navBar>li:nth-of-type(5)").css("border-bottom","3px solid gray");
            //模拟后台传回的左边点信息，画图
            var image = document.createElementNS('http://www.w3.org/2000/svg','image');
            //image.setAttributeNS(null,"src","../../image/origin/logoBig.png");
            image.setAttributeNS(null,'width','20');
            image.setAttributeNS(null,'height','20');
            image.setAttributeNS(null,"href","../../image/origin/red.gif");
            image.setAttributeNS(null,'x',myAllData.DataBag[0].fPositionX+"%");
            image.setAttributeNS(null,'y',myAllData.DataBag[0].fPositionY+"%");
            image.setAttributeNS(null, 'visibility', 'visible');
            image.setAttributeNS(null,'class','img');
            image.setAttributeNS(null,'data-toggle','tooltip');
            image.setAttributeNS(null,'title','默认的 Tooltip');
            console.log(image);
            //$('#svgContainer').append($(image));
            document.getElementById('svgContainer').appendChild(image);

            //鼠标移动到图片上时，提示信息
            $("#targBaseInfoRow").on("mouseover mouseout",".img",function(event){
                if(event.type=="mouseover"){
                    console.log(event.clientX+"=="+event.clientY);
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
            });

           /* $("#targBaseInfoRow .img").hover(function(){
                alert('aaaa');
            });
*/
            //点击放大和缩小按钮事件
            var big = $("#big");
            var small = $("#small");
            big.click(function(){
                doSmall("svgContainer");
            });
            small.click(function(){
                doBig("svgContainer");
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
                    'r':10,
                    'stroke':'darkgray',
                    'strokeWidth':'2',
                    'fill':'darkgray'
                };
                posMove(this.id,"svgDiv",settings);
            }
        }
    });

})();
function doSmall(svgContainer){
    var svg = document.getElementById(svgContainer);//这个得到的就是图片对象
    var w = svg.getAttribute("width");
    console.log(w);
    w = parseInt(w)+10;
    svg.setAttribute("width",w);

    var h = svg.getAttribute("height");
    h = parseInt(h)+7;
    svg.setAttribute("height",h);
}
function doBig(svgContainer){
    var svg = document.getElementById(svgContainer);
    var w = svg.getAttribute("width");
    w = parseInt(w)-10;
    svg.setAttribute("width",w);

    var h = svg.getAttribute("height");
    h = parseInt(h)-7;
    svg.setAttribute("height",h);
}

function posMove(svgid,svgdivid,settings) {
    //console.log('sadf');
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
function drag(obj,sent,oParent,settings){

    var dmW = document.documentElement.clientWidth || document.body.clientWidth;
    var dmH = document.documentElement.clientHeight || document.body.clientHeight;

    var sent = sent || {};
    var l = sent.l || 0;
    var r = sent.r;
    var t = sent.t || 0;
    var b = sent.b;
    var n = sent.n || 10;

    obj.onmousedown = function (ev){
        //console.log(parseInt(obj.getAttribute("x")));
        var oEvent = ev || event;
        var sentX = oEvent.clientX - parseInt($(obj).css("left"));
        var sentY = oEvent.clientY - parseInt($(obj).css("top"));
        //下面是点击一下图片的时候就画一个圆形
        //var circle = document.createElementNS('http://www.w3.org/2000/svg','circle');
        //x:屏幕的x-（父元素离屏幕左边的距离-svg的left绝对值）
        var x = oEvent.clientX-($(oParent).offset().left-Math.abs(parseInt($(obj).css("left"))));
        var y = oEvent.clientY+(document.body.scrollTop || document.documentElement.scrollTop)-($(oParent).offset().top-Math.abs(parseInt($(obj).css("top"))));
        var svgWidth = parseInt($(obj).css("width"));
        var svgHeight = parseInt($(obj).css("height"));
        x = (x/svgWidth)*100;
        y = (y/svgHeight)*100;
        console.log(x+"-=-="+y);
        //circle.setAttribute('cx',x+"%");
        //circle.setAttribute('cy',y+"%");
        //circle.setAttribute('r',settings.r);
        //circle.setAttribute('stroke',settings.stroke);
        //circle.setAttribute('stroke-width',settings.strokeWidth);
        //circle.setAttribute('fill',settings.fill);
        //circle.setAttribute('class','circles');
        //console.log(oEvent.clientX+"---"+oEvent.clientY);
        //下面是点击的时候删除之前的所有画圆
        /*if($(obj).children("circle")!=undefined){
            $(obj).children("circle").remove();
        }*/
        //$(obj).append(circle);

        document.onmousemove = function (ev){
            var oEvent = ev || event;
            var slideLeft = oEvent.clientX - sentX;
            var slideTop = oEvent.clientY - sentY;
            //console.log($(oParent).css("width")+"==="+$(obj).css("width"));
            if(slideLeft>=0){
                slideLeft=0;
            }
            if(slideLeft<=parseInt($(oParent).css("width"))-parseInt($(obj).css("width"))){
                slideLeft=parseInt($(oParent).css("width"))-parseInt($(obj).css("width"));
            }
            if(slideTop>=0){
                slideTop=0;
            }
            if(slideTop<=parseInt($(oParent).css("height"))-parseInt($(obj).css("height"))){
                slideTop=parseInt($(oParent).css("height"))-parseInt($(obj).css("height"));
            }
            /*obj.setAttribute("left",slideLeft+"px");
            obj.setAttribute("top",slideTop+"px");*/
            $(obj).css("left",slideLeft+"px");
            $(obj).css("top",slideTop+"px");

        };
        document.onmouseup = function (){
            document.onmousemove = null;
            document.onmouseup = null;
        }
        return false;
    }
}

//点击处理按钮弹出模态框
$("#dealBtn").click(function(){
    $("#alarmHandleModal").modal({"backdrop":"static"});
    //清空处理状况
    $(".alarm").attr('checked',false);
    $("#statementInfo").val("");

    if(sessionStorage.getItem("AlarmType")=="fire") {
        $(".buildingForm:nth-of-type(2)").css("display", "none");
    }else if(sessionStorage.getItem("AlarmType")=="fault") {
        //alert('asdf');
        $(".alarmDiv:nth-of-type(2)").css("display", "none");
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
        //console.log(myData);
        HH.post("/AlarmData/FireDetail",myData,function(data) {
           // console.log("后台返回的警情处理信息");
          //  console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                $("#alarmHandleModal").modal("hide");
                if(sessionStorage.getItem("AlarmType")=="fault"){
                    sessionStorage.setItem("AlarmType","fault");
                }else if(sessionStorage.getItem("AlarmType")=="fire"){
                    sessionStorage.setItem("AlarmType","fire");
                }
                //sessionStorage.setItem("AlarmType","fault");
                window.history.back();
            }
        });
    }

});

//点击返回按钮返回上一级
$('#goBack').click(function(){
    if(sessionStorage.getItem("AlarmType")=="fault"){
        sessionStorage.setItem("AlarmType","fault");
    }else if(sessionStorage.getItem("AlarmType")=="fire"){
        sessionStorage.setItem("AlarmType","fire");
    }
    window.history.back();
});

//一次传入：容器id,x,y坐标，经纬度坐标的显示区id
function positionMap(temp, lngNum, latNum, lng, lat) {
    var map = new BMap.Map(temp);

    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
    map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
    map.addControl(new BMap.MapTypeControl());//给
    map.enableScrollWheelZoom(true);//设置地图可以滚动

    var latitude = latNum;//纬度
    var longitude = lngNum;//经度
    //alert(latitude+"-"+longitude);
    var marker = new BMap.Marker(new BMap.Point(longitude, latitude));  // 创建标注
    map.addOverlay(marker);              // 将标注添加到地图中

    map.addEventListener("load",function(){
        $("#coverLoad").hide();
    })

    map.centerAndZoom(new BMap.Point(longitude, latitude), 13);
    //map.centerAndZoom(new BMap.Point(latitude, longitude), 13);

}



















