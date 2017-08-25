/**
 * Created by Qiu on 2017/6/30.
 */
(function(){
    var indexSelectData="";
    //渲染首页下拉框数据
    HH.post("/Orginfo/GetSiteName",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
        console.log("后台返回的首页建筑物");
        console.log(data);
        indexSelectData = data;
        if (data.DataBag && data.StateMessage=="1000") {
            //渲染首页下拉框数据
            render("#buildingSelectData","#indexSelectBuilding",data);

            var indexSelectBuilding = $("#indexSelectBuilding");
            var indexSelectBuildingVal = indexSelectBuilding.val();
            //渲染默认下拉框
            findTbBuilding(indexSelectBuildingVal,1);
            //选择渲染下拉框
            indexSelectBuilding.change(function(){
                indexSelectBuildingVal = $(this).val();
                findTbBuilding(indexSelectBuildingVal,1);
            });
        }
    });
    //下面的方法是根据选中的下拉框数据查询建筑物列表
    function findTbBuilding(siteid,nowPage){
        var myData = {
            "orgid":sessionStorage.getItem("OrgID"),
            "siteid":siteid,
            "PageIndex":nowPage
        };
        HH.post("/Orginfo/GetflatpicList",myData,function(data) {
            console.log("下面是返回的建筑物列表");
            console.log(data);
            render("#buildingTbData","#buildingTbody",data);
        });
    }

    //点击删除等操作
    $("#buildingTbody").on("click",".operation",function(){
        if($(this).text()=="删除"){
            //render("#idDeleteData","#buildingBody");
            $('#buildingDeleteModal').modal({"backdrop":"static"});
            var myData={
                "cFlatPic":$(this).attr("cFlatPic")
            };
            $("#modalDeleteConfirm").get(0).onclick=function(){
                HH.post("/Orginfo/DeleteflatPic",myData,function(data) {
         //           console.log("下面是返回的删除平面图信息");
          //          console.log(data);
                    if (data.DataBag=="删除数据成功" && data.StateMessage=="1000") {
                        $('#buildingDeleteModal').modal("hide");
                        findTbBuilding($("#indexSelectBuilding").val(),1);
                        //location.reload();
                    }
                    //render("#buildingTbData","#buildingTbody",data);
                });
            };
        }else if($(this).text()=="详情"){
           // console.log($(this).attr("imFlatPic"));
           // $("#imFlatPicTarget").attr("src",ImgUrl+""+$(this).attr("imFlatPic"));
            $("#imFlatPicTarget").get(0).setAttribute("xlink:href","");
            $("#imFlatPicTarget").get(0).setAttribute("src","");
            $("#imFlatPicTarget").get(0).setAttribute("xlink:href",ImgUrl+""+$(this).attr("imFlatPic"));
            $("#imFlatPicTarget").get(0).setAttribute("src",ImgUrl+""+$(this).attr("imFlatPic"));
            //console.log(ApiUrl+""+$(this).attr("imFlatPic"));
            $('#buildingDetailModal').modal({"backdrop":"static"});
            $("#buildingDetailConfirm").click(function(){
                $('#buildingDetailModal').modal("hide");
            });
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
            posMove("svgContainer","imgDiv");

        }else if($(this).text()=="修改"){
            render("#changeBuildingData","#buildingChangeBody");
            $('#buildingChangeModal').modal({"backdrop":"static"});
           // $("#floorLevelChange");
         //   console.log(indexSelectData);
            var str="";
            for(var i=0; i<indexSelectData.DataBag.length; i++){
                str = str+ "<option value='"+indexSelectData.DataBag[i].siteid+"'>"+indexSelectData.DataBag[i].sitename+"</option>";
            }
            $("#ChangeModalSelect").append(str);
            $("#floorLevelChange").val($(this).attr("floornum"));

            $('#buildingChangeBody').on("change","#fileChange",function(){
                document.getElementById("userdefinedFileChange").value = document.getElementById("fileChange").value;
            });

            var cFlatPic = $(this).attr("cFlatPic");
            var siteid = $(this).attr("siteid");
            console.log(cFlatPic+"="+siteid);
            $("#cFlatPicChange").val(cFlatPic);
            $("#siteidChange").val(siteid);
            //点击修改模态框的保存按钮
            $("#buildingChangeConfirm").get(0).onclick=function(){
                //设置隐藏的提交给表单的值
            //    console.log(cFlatPic+"=="+siteid);
                //上传文件jQuery表单提交
                var options = {
                    //beforeSubmit: showRequest,  //提交前的回调函数
                    success: showResponse,      //提交后的回调函数
                    url: ApiUrl+"/Form/UpdateflatPic", //默认是form的action， 如果申明，则会覆盖
                    type: "post",               //默认是form的method（get or post），如果申明，则会覆盖
                    dataType: "json"           //html(默认), xml, script, json...接受服务端返回的类型
                    //clearForm: true,          //成功提交后，清除所有表单元素的值
                    //resetForm: true,          //成功提交后，重置所有表单元素的值
                    //timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求
                }
                function showResponse(responseText, statusText){
               //     console.log("修改上传返回的：");
               //     console.log(responseText);
               //     console.log(statusText);
                    if (responseText.DataBag=="数据修改成功" && responseText.StateMessage=="1000") {
                        $('#buildingChangeModal').modal("hide");
                        //location.reload();
                        var indexSelectBuilding = $("#indexSelectBuilding");
                        var indexSelectBuildingVal = indexSelectBuilding.val();
                        //渲染默认下拉框
                        findTbBuilding(indexSelectBuildingVal,1);
                    }
                }
                $("#buildingChangeForm").ajaxSubmit(options);
            }
        }
    })
    //点击新增按钮
    $("#addDrawingInfo").click(function(){
        /*var str =  "<tr> " +
            "<td></td> " +
            "<td></td> " +
            "<td></td> " +
            "<td> " +
            "<a class='operation' data-toggle='modal' data-target=''>删除</a> " +
        "</td> " +
        "</tr>";
        var buildingTbody = $("#buildingTbody");
        buildingTbody.append(str);*/
        //渲染从首页取得的下拉框数据(新增里面的下拉框)
        var addModalSelect = $("#addModalSelect");
        addModalSelect.html('');
       // console.log(indexSelectData);
        var str ="";
        for(var i=0; i<indexSelectData.DataBag.length; i++){
            str = str+ "<option value='"+indexSelectData.DataBag[i].siteid+"'>"+indexSelectData.DataBag[i].sitename+"</option>";
        }
        addModalSelect.append(str);

        //render("#addBuildingData","#buildingBody");
        $('#buildingModal').modal({"backdrop":"static"});
        $('#buildingBody').on("change","#file",function(){
            document.getElementById("userdefinedFile").value = document.getElementById("file").value;

        });

        //点击模态框保存
        $("#modalConfirm").get(0).onclick=function(){
            //给隐藏的input设置值用于form提交
            var addModalSelectVal = $("#addModalSelect").val();
            $("#siteid").val(addModalSelectVal);

            var floorLevel = $("#floorLevel").val();
            $("#floornum").val(floorLevel);

            var vPhotoname = $("#file").val().split("\\");
            vPhotoname = vPhotoname[vPhotoname.length-1];
            $("#imFlatPic").val(vPhotoname);

            $("#orgid").val(sessionStorage.getItem("OrgID"));

            //$("#CompanyProfileForm").submit();
            //上传文件jQuery表单提交
            var options = {
                //beforeSubmit: showRequest,  //提交前的回调函数
                success: showResponse,      //提交后的回调函数
                url: ApiUrl+"/Form/AddflatPic", //默认是form的action， 如果申明，则会覆盖
                type: "post",               //默认是form的method（get or post），如果申明，则会覆盖
                dataType: "json"           //html(默认), xml, script, json...接受服务端返回的类型
                //clearForm: true,          //成功提交后，清除所有表单元素的值
                //resetForm: true,          //成功提交后，重置所有表单元素的值
                //timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求
            }
            function showResponse(responseText, statusText){
          //      console.log("点击上传返回的：");
           //     console.log(responseText);
           //     console.log(statusText);
                if (responseText.DataBag=="添加平面图成功" && responseText.StateMessage=="1000") {
                    $('#buildingModal').modal("hide");
                    var addModalSelectVal = $("#addModalSelect").val();
                    $("#indexSelectBuilding").val(addModalSelectVal);
                    findTbBuilding(addModalSelectVal,1);

                    //location.reload();
                    //alert(myDate.toLocaleTimeString()+"/"+myDate.toLocaleDateString());
                }
            }
            $("#buildingForm").ajaxSubmit(options);
        }
    });

})();

function posMove(svgid,svgdivid) {
    var svgObj = document.getElementById(svgid);//svg
    //console.log(oDiv);
    var svgDivObj = document.getElementById(svgdivid);//最外面控制宽高的div
    //console.log(sent.r);
    drag(svgObj,svgDivObj);
}
function drag(obj,oParent){
    obj.onmousedown = function (ev) {
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






































