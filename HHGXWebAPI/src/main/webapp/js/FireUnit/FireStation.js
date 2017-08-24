/**
 * Created by Qiu on 2017/6/30.
 */
(function(){
    renderIndex();
    //点击新增按钮
    $("#addFireStation").get(0).onclick=function(){
        $("#dwmc").val("");
        $("#cjsj").val("");
        $("#lxr").val("");
        $("#lxdh").val("");
        $("#dwjbqk").val("");
        $("#bz").val("");

        $('#AddFireStationModal').modal({"backdrop":"static"});
        dataPick("#CreateDate");
        $("#addConfirm").get(0).onclick=function(){
            var myJson = getForm("#FireStationForm");
           // console.log(myJson);
            myJson.orgid = sessionStorage.getItem("OrgID");
            HH.post("/Organdpeople/AddFirecompany",myJson,function(data) {
              //  console.log("后台返回的添加信息");
              //  console.log(data);
                if (data.DataBag && data.StateMessage=="1000") {
                    $('#AddFireStationModal').modal("hide");
                    renderIndex();
                }
            });
        }
    };

    $("#FireStationTbody").on("click",".operation",function(){
        if($(this).text()=="查看详情"){
            HH.post("/Organdpeople/GetFirecompanyDetail",{"firecompayid":$(this).attr("firecompayid")},function(data) {
              //  console.log("后台返回某个详细信息");
              //  console.log(data);
                if (data.DataBag && data.StateMessage=="1000") {
                    $('#detailFireStationModal').modal({"backdrop":"static"});
                    render("#detailsData","#detailFireStationBody",data);
                    $("#detailFireStationModalConfirm").click(function(){
                        $('#detailFireStationModal').modal("hide");
                    });
                }
            });
            //yearMonthDay(".changeBuyTime");
        } if($(this).text()=="修改"){
            var firecompayid = $(this).attr("firecompayid");
            //首先获取详情
            HH.post("/Organdpeople/GetFirecompanyDetail",{"firecompayid":firecompayid},function(data) {
             //   console.log("后台返回某个详细信息");
             //   console.log(data);
                if (data.DataBag && data.StateMessage=="1000") {
                    $('#FireStationModal').modal({"backdrop":"static"});
                    render("#changeFireStationData","#FireStationBody",data);
                    dataPick(".createTime");
                    //点击保存
                    //alert(firecompayid);
                    $("#FireStationModalConfirm").get(0).onclick=function(){
                        var myJson = getForm("#FireStationChangeForm");
                        myJson.firecompayid = firecompayid;
                //        console.log(myJson);
                        HH.post("/Organdpeople/updateFirecompany",myJson,function(data) {
                         //   console.log("后台返回修改信息");
                         //   console.log(data);
                            if (data.DataBag && data.StateMessage=="1000") {
                                $('#FireStationModal').modal("hide");
                                renderIndex();
                            }
                        });
                    };
                }
            });

        }if($(this).text()=="删除"){
            $('#FireStationModal').modal({"backdrop":"static"});
            render("#isDeleteModalData","#FireStationBody");
            var firecompayid = $(this).attr("firecompayid");
            $("#FireStationModalConfirm").get(0).onclick=function(){
                HH.post("/Organdpeople/DeleteFirecompany",{"firecompayid":firecompayid},function(data) {
                  //  console.log("后台返回某个删除信息");
                   // console.log(data);
                    if (data.DataBag && data.StateMessage=="1000") {
                        $('#FireStationModal').modal("hide");
                        renderIndex();
                    }
                });
            }
        }if($(this).text()=="消防装备"){
            sessionStorage.setItem("firecompayid",$(this).attr("firecompayid"));
            //alert($(this).attr("firecompayid"))
            location.href="./FireEquipment.html";
        }
    });

})();

//下面是首页的表格数据
function renderIndex(){
    HH.post("/Organdpeople/GetFirecompanyList",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
       // console.log("后台返回首页表格的信息");
       // console.log(data);
        if (data.DataBag && data.StateMessage=="1000") {
            render("#FireStationTbodyData","#FireStationTbody",data);
        }
    });

}
























