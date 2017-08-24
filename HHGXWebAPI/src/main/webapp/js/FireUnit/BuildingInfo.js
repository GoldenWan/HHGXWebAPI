/**
 * Created by Qiu on 2017/6/10.
 */
(function(){
    //下面是将首页的表格里面的表格内容渲染到页面首页表格里面
   // console.log(sessionStorage.OrgID);
    //alert(sessionStorage.getItem("OrgID"));
    HH.post("/Orginfo/GetSiteList",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
       // console.log("下面是返回的首页信息");
       // console.log(data);
        if (data.DataBag && data.StateMessage=="1000") {
            var myData = data;
            render("#buildIndexTbData", "#buildIndexTb", myData);
        }
    });

})()

//下面是调用百度地图的用法
/*$(document).ready(function(){
    //调用百度地图函数
    baiDuMap("container","lng","lat");
    //baiDuMap("container1");

})*/


//==========================下面是建筑页面首页的按钮点击事件封装============================
$(document.body).on("click",".operationBuild",function(){
    var operateId = $(this).closest("tr").attr("data-id");
    var type = $(this).attr("data-type");
    if(type=="detail"){
        //设置建筑名字
        var sitename = $(this).attr("sitename");
        var siteid = $(this).attr("siteid");
        //下面是获取详情里面的详细信息
        HH.post("/Orginfo/GetSite",{"siteid":siteid},function(data) {
            //console.log("下面是返回的详情信息");
            //console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                render("#detailModelData", "#buildingInfoContainer", data);
                //$("#detailModal").modal({backdrop:"static"});
            }
        });
        //下面是获取详情里面的外观图
        HH.post("/Orginfo/GetAppearancepicList",{"siteid":siteid},function(data) {
           // console.log("下面是返回的详情图片信息");
            //console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                data.sitename = sitename;
                render("#indexImgModelData", "#imgInfoContainer", data);
                //$("#detailModal").modal({backdrop:"static"});
            }
        });
        $("#detailModal").modal({backdrop:"static"});
        $("#detailModelConfirm").get(0).onclick=function(){
            $("#detailModal").modal("hide");
            //location.reload();
        }

    }else if(type=="change"){//点击修改的事件=-================================
        /*var formData = getForm("#changeModalForm");
        console.log('返回修改的数据');
        console.log(formData);*/
        var siteid = $(this).attr("siteid");
        HH.post("/Orginfo/GetSite",{"siteid":siteid},function(data) {
            //console.log("下面是返回的后台修改信息");
           // console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                render("#changeModelData", "#changeModalForm", data);
                //baiDuMap("changeContainer","jd","wd");
                if(data.DataBag[0].fLongitude && data.DataBag[0].fLatitude){
                    positionMap("changeContainer", data.DataBag[0].fLongitude, data.DataBag[0].fLatitude, "jd","wd");
                }else{
                    positionMap("changeContainer", sessionStorage.getItem("fLongitude"), sessionStorage.getItem("fLatitude"), "jd","wd");
                }
                $("#changeModal").modal({backdrop:"static"});
                dataPick("#jlsj");
                $("#changeUseproperty").val(data.DataBag[0].useproperty);
                $("#changeNHDJ").val(data.DataBag[0].NHDJ);
                $("#changeJGLX").val(data.DataBag[0].JGLX);
                $("#changeSitetypename").val(data.DataBag[0].sitetypename);
            }
        });

        //修改模态框里面的保存按钮
        $("#changeModalConfirm").get(0).onclick=function(){
            var formData = getForm("#changeModalForm");
          //  console.log('前端返回修改的数据');
            formData.siteid = siteid;//建筑物编号
            formData.orgid = sessionStorage.getItem("OrgID");
          //  console.log(formData);
            HH.post("/Orginfo/UpdateSite",formData,function(data) {
          //      console.log("返回的保存按钮信息");
           //     console.log(data);
                if (data.DataBag && data.StateMessage=="1000") {
                    $("#changeModal").modal("hide");
                    location.reload();
                }/*else{
                    alert("请完善信息");
                    return;
                }*/
            });
        }
    }else if(type=="delete"){
        $("#isDeleteBuilding").modal({backdrop:"static"});
        var siteid = $(this).attr("siteid");
        //点击删除此行建筑信息的确定按钮
        $("#doDeleteBuilding").get(0).onclick=function(){
           // console.log(siteid);
            HH.post("/Orginfo/DeleteSite",{"siteid":siteid},function(data) {
           //      console.log("返回的后台删除信息");
            //     console.log(data);
                 if (data.DataBag && data.StateMessage=="1000") {
                     $("#isDeleteBuilding").modal("hide");
                     location.reload();
                 }
             });

        }

    }else if(type=="showImg"){
        $("#showImgModal").modal({backdrop:"static"});
        var siteid = $(this).attr("siteid");
        $("#buildingName").text($(this).attr("sitename"));//设置建筑名称
        //每次点击外观图的时候都清空
        $("#showImgModalDivs").html('');
        HH.post("/Orginfo/GetAppearancepicList",{"siteid":siteid},function(data) {
           // console.log("下面是返回的详情图片信息");
            console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                //data.sitename = sitename;
                render("#showImgModelData", "#showImgModalDivs", data);
                //调用封装的删除图片方法，buildingImg：传入图片的父元素，i：当前点击的某个元素
                deleteImg("buildingImg","i");
                //$("#detailModal").modal({backdrop:"static"});
            }
        });
        $("#showImgModalBody").on("change","#file",function(){
            var vPhotoname = $(this).val().split("\\");
            vPhotoname = vPhotoname[vPhotoname.length-1];
            //设置这两个魏隐藏，提交到后台
            $("#siteid").val(siteid);
            $("#vPhotoname").val(vPhotoname);
            //上传文件jQuery表单提交的
            var options = {
                //beforeSubmit: showRequest,  //提交前的回调函数
                success: showResponse,      //提交后的回调函数
                url: ApiUrl+"/Form/AddAppearance", //默认是form的action， 如果申明，则会覆盖
                type: "post",               //默认是form的method（get or post），如果申明，则会覆盖
                dataType: "json"           //html(默认), xml, script, json...接受服务端返回的类型
                //clearForm: true,          //成功提交后，清除所有表单元素的值
                //resetForm: true,          //成功提交后，重置所有表单元素的值
                //timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求
            }
            function showResponse(responseText, statusText){
               // console.log("下面是返回的上传情况");
               // console.log(responseText);
                if(responseText.StateMessage=="1000"){
                    $("#showImgModalDivs").html('');
                    HH.post("/Orginfo/GetAppearancepicList",{"siteid":siteid},function(data) {
                 //       console.log("下面是返回的详情图片信息");
                 //       console.log(data);
                        if (data.DataBag && data.StateMessage=="1000") {
                            data.sitename = sitename;
                            render("#showImgModelData", "#showImgModalDivs", data);
                            //调用封装的删除图片方法，buildingImg：传入图片的父元素，i：当前点击的某个元素
                            deleteImg("buildingImg","i");
                            //$("#detailModal").modal({backdrop:"static"});
                        }
                    });
                }
                /*if(statusText=="success"){
                 alert('上传成功');
                 }*/
            }
            $("#showImgModalForm").ajaxSubmit(options);

        });

    }else if(type=="add"){
        //alert(sessionStorage.getItem("fLongitude")+"=="+sessionStorage.getItem("fLatitude"));
        if(sessionStorage.getItem("fLongitude")){
            positionMap("container", sessionStorage.getItem("fLongitude"), sessionStorage.getItem("fLatitude"), "lng","lat");
        }else{
            positionMap("container", 104.06554, 30.679965, "lng","lat");
        }

        dataPick("#addjlsj");
        $("#addModal").modal({backdrop:"static"});
        $("#buildingAddConfirm").get(0).onclick=function(){
            var addFormData = getForm("#addModalForm");
            addFormData.orgid = sessionStorage.getItem("OrgID");
            //alert(sessionStorage.getItem("OrgID"));
          //  console.log("添加前的数据");
          //  console.log(addFormData);
            HH.post("/Orginfo/addSite",addFormData,function(data) {
           //     console.log("后台返回的添加信息");
           //     console.log(data);
                if (data.DataBag && data.StateMessage=="1000") {
                    //render("#buildIndexTbData", "#buildIndexTb", data);
                    $("#addModal").modal("hide");
                    location.reload();
                }
            });
        };
    }
    //一次传入：容器id,x,y坐标，经纬度坐标的显示区id
    function positionMap(temp, lngNum, latNum, lng, lat) {
        var map = new BMap.Map(temp);
        //(lngNum+"=="+latNum);

        map.addControl(new BMap.NavigationControl());
        map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
        map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件

        var latitude = latNum;//纬度
        var longitude = lngNum;//经度
        //alert(latitude+"-"+longitude);
        var marker = new BMap.Marker(new BMap.Point(longitude, latitude));  // 创建标注
        map.addOverlay(marker);              // 将标注添加到地图中

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
});