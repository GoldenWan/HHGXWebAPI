/**
 * Created by Qiu on 2017/8/4.
 */
(function(){
    //点击查询按钮
    $("#findCity").click(function(){
        var cityVal = $("#city").val();
        HH.post("/WBSign/GetMaintenanceSysListByCityId",{"CityID":cityVal},function(data) {
            console.log("后台返回首页列表");
            console.log(data);
            var myJson = {data: data.DataBag.SysList};
            $.each(myJson.data,function(i,v){
                v["number"]=i*1+1;
            });
            render("#signDetailTbodyData", "#signDetailTbody",myJson);
        });
    });
    $("#findCity").click();
    //点击选择
    $("#signDetailTbody").on("click",".signDetailChoose",function(){
        $("#signDetailModal").modal({backdrop:"static"});
        var MaintenanceId = $.trim($(this).attr("MaintenanceId"));
        var myJson = {
            "orgid":sessionStorage.getItem("OrgID"),
            "MaintenanceId":MaintenanceId
        };

        HH.post("/WBSign/OrgUnMaintenSiteSys",myJson,function(data) {
            console.log("返回选择信息");
            console.log(data);
            var myJson = {data: data.DataBag};
            $.each(myJson.data,function(i,v){
                v["number"]=i*1+1;
            });
            render("#signDetailEveryData", "#signDetailContainer",myJson);

            //点击模态框的确定
            $("#signDetailModalConfirm").click(function(){
                var arr = [];
                var signMaintenanceCheckBox = $(".signMaintenanceCheckBox:checked");
                for(var i=0; i<signMaintenanceCheckBox.length; i++){
                    var obj = {
                        "tisystype":signMaintenanceCheckBox.eq(i).attr("tisystype"),
                        "siteid":signMaintenanceCheckBox.eq(i).attr("siteid"),
                    };
                    arr.push(obj);
                }
                var myJson = {
                    "MaintenaceId":MaintenanceId,
                    "SysList":arr,
                    "orgid":sessionStorage.getItem("OrgID"),
                    "RegistUser":sessionStorage.getItem("RealName")
                };
                console.log(myJson);
                HH.post("/WBSign/SetOrgMaintenanceSys",myJson,function(data) {
                    console.log("后台返回模态框添加信息");
                    console.log(data);
                    if(data.DataBag=="修改成功" && data.StateMessage==1000){
                        $("#signDetailModal").modal("hide");
                        window.history.go(-1);
                    }
                   /* var myJson = {data: data.DataBag.SysList};
                    $.each(myJson.data,function(i,v){
                        v["number"]=i*1+1;
                    });
                    render("#signDetailTbodyData", "#signDetailTbody",myJson);*/
                },function(){
                    alert("该系统已签约");
                    $("#signDetailModal").modal("hide");
                    return;
                });
            });
        });
    });



    //获取省市区数据对象
    var shenObj = area;
    //添加省节点
    var node1="<option value=''>全部</option>";
    console.log(shenObj);
    $.each(shenObj,function(i,v){
        node1=node1+"<option value="+i+">"+ v.AreaName+"</option>";
    });
    $("#province").html(node1);
    $("#province").change(function(){
        shiChange();
    });
    //市改变事件
    function shiChange(){
        //$("#city").html("");
        var shenVal = $("#province").val();
        console.log(shenVal+"==");
        if(shenVal==""){
            //alert('sd');
            return;
        }
        var shiArr = shenObj[shenVal].child;
        var node2="<option value=''>全部</option>";
        $.each(shiArr,function(i,v){
            node2=node2+"<option value="+i+">"+ v.AreaName+"</option>";
        });
        $("#city").html(node2);

    }
    shiChange();

})();