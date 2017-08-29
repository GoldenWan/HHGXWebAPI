/**
 * Created by Qiu on 2017/7/5.
 */
$(document).ready(function(){
    getFirstPostion();
});
function getFirstPostion(){
    $("#navBar>li:first-of-type").css({"border-bottom": "3px solid #4A90E2", "color": "#5E9DE6"});
    //下面是获取地理位置
    HH.post("/Orginfo/GetMapPoint",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
        //console.log("后台返回的地理信息");
        //console.log(data);
        var fLongitude = 104.107293;
        var fLatitude = 30.664204;
        if (data.DataBag && data.StateMessage=="1000") {
            if(data.DataBag[0].fLongitude==null || data.DataBag[0].fLatitude==null){
                $("#lng").val(fLongitude);
                $("#lat").val(fLatitude);
                //alert(data.DataBag[0].fLongitude+"=="+data.DataBag[0].fLatitude);
                sessionStorage.setItem("fLongitude",fLongitude);
                sessionStorage.setItem("fLatitude",fLatitude);
                positionMap("positionMap",fLongitude,fLatitude,"lng","lat");
            }else{
                $("#lng").val(data.DataBag[0].fLongitude);
                $("#lat").val(data.DataBag[0].fLatitude);
                //alert(data.DataBag[0].fLongitude+"=="+data.DataBag[0].fLatitude);
                sessionStorage.setItem("fLongitude",data.DataBag[0].fLongitude);
                sessionStorage.setItem("fLatitude",data.DataBag[0].fLatitude);
                positionMap("positionMap",data.DataBag[0].fLongitude,data.DataBag[0].fLatitude,"lng","lat");
            }
        }
    });
}

var lng = "";
var lat = "";
(function(){
    /*$("html").ajaxStart(function(){
        $("#coverLoad").show();
    }).ajaxStop(function(){
        $("#coverLoad").hide();
    });*/
    render("#positionData","#postionManage");
    //baiDuMap("positionMap",'lng','lat');
    $("#savePosition").get(0).onclick=function(){
        $("#savePositionModal").modal({"backdrop":"static"});
        $("#savePositionConfirmModal").click(function(){
            savePosition();
        });

    };

    $("#navBar li").click(function(){
        if($(this).text()=="地址位置管理"){
            var lis = $("#navBar>li");
            for(var i=0; i<lis.length; i++){
                lis.eq(i).css({"border": "none", "color": "#333"});
            }
            $(this).css({"border-bottom": "3px solid #4A90E2", "color": "#5E9DE6"});

            render("#positionData","#postionManage");
            //baiDuMap("positionMap",'lng','lat');
            //positionMap("positionMap",$("#lng").val(),$("#lat").val(),"lng","lat");
            getFirstPostion();
            $("#savePosition").get(0).onclick=function(){
                $("#savePositionModal").modal({"backdrop":"static"});

                $("#savePositionConfirmModal").click(function(){
                    savePosition();
                });
            };
        } else if($(this).text()=="总平图管理"){
            //$(".navBar>li").css({"border": "none", "color": "white"});
            var lis = $("#navBar>li");
            for(var i=0; i<lis.length; i++){
                lis.eq(i).css({"border": "none", "color": "#333"});
            }
            $(this).css({"border-bottom": "3px solid #4A90E2", "color": "#5E9DE6"});
            //render("#allImageData","#postionManage");
            //获取总平图
            function getAllImg(){
                HH.post("/Orginfo/GetTotalFlatPic",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
                    //console.log("后台返回的总平图");
                    console.log(data);
                    var myJson = {
                        "picUrl":data.DataBag[0]
                    };
                    console.log(data.DataBag[0]);
                    if (data.DataBag && data.StateMessage=="1000") {
                        render("#allImageData","#postionManage",myJson);
                        //$("#portrait").attr("src",ImgUrl+data.DataBag[0]);
                    }
                });
            }
            getAllImg();

            $("#postionManage").on("change","#file",function(){
                $("#orgid").val(sessionStorage.getItem("OrgID"));
                var options = {
                    //beforeSubmit: showRequest,  //提交前的回调函数
                    success: showResponse,      //提交后的回调函数
                    url: ApiUrl+"/Form/SubmitTotalFlatPic", //默认是form的action， 如果申明，则会覆盖
                    type: "post",               //默认是form的method（get or post），如果申明，则会覆盖
                    dataType: "json"           //html(默认), xml, script, json...接受服务端返回的类型
                    //clearForm: true,          //成功提交后，清除所有表单元素的值
                    //resetForm: true,          //成功提交后，重置所有表单元素的值

                    //timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求
                }
                function showResponse(responseText, statusText){
                    //console.log("下面是返回的上传情况");
                    //console.log(responseText);
                    if(responseText.StateMessage=="1000" && responseText.DataBag=="提交总平图成功！"){
                        //上传成功后调用获取总平图
                        getAllImg();
                    }
                }
                //console.log($("#activityForm"));
                $("#activityForm").ajaxSubmit(options);
            });
            //提交总平图
            /*$("#file").get(0).onchange=function(){

            };*/
        }
    });

})();

function savePosition(){
    if($("#lng").val()=="" || $("#lat").val()==""){
        alert('请先定位');
        return;
    }
    var myJson = {
        "orgid":sessionStorage.getItem("OrgID"),
        "fLongitude":$("#lng").val(),
        "fLatitude":$("#lat").val()
    };
    //console.log(myJson);
    HH.post("/Orginfo/SetMapPoint",myJson,function(data) {
       // console.log("后台返回的保存经纬度");
       // console.log(data);
        if (data.DataBag && data.StateMessage=="1000") {
            $("#savePositionModal").modal("hide");
        }
    });

}

function showPreview(source) {
    document.getElementById("userdefinedFile").value = document.getElementById("file").value;
    var file = source.files[0];
    if(window.FileReader) {
        var fr = new FileReader();
        fr.onloadend = function(e) {
            document.getElementById("portrait").src = e.target.result;
        };
        fr.readAsDataURL(file);
    }
}
//一次传入：容器id,x,y坐标，经纬度坐标的显示区id
function positionMap(temp, lngNum, latNum, lng, lat) {
    var map = new BMap.Map(temp);
    console.log(map);

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

    map.addEventListener("click", function (e) {
        map.clearOverlays();
        var marker = new BMap.Marker(new BMap.Point(e.point.lng, e.point.lat));  // 创建标注
        map.addOverlay(marker);              // 将标注添加到地图中

        document.getElementById(lng).value = e.point.lng;
        document.getElementById(lat).value = e.point.lat;
    });


}























