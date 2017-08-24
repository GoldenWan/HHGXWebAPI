/**
 * Created by Qiu on 2017/6/14.
 */

(function(){
    //查询是否审批
    HH.post("/Orginfo/GetOrgApproveState",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
       // console.log("后台返回的首页是否审批");
       // console.log(data);
        if (data.DataBag && data.StateMessage=="1000") {
            var ManagerOrgName = data.DataBag[0].ManagerOrgName;
            sessionStorage.setItem("ManagerOrgName",ManagerOrgName);
            //location.href="./InformationRegistrationDetail.html";
        }
    });

    //下面是获取首页下拉框数据
    HH.post("/Orginfo/GetManagerOrgList","",function(data) {
       // console.log("后台返回的首页下拉框信息");
       // console.log(data);
        if (data.DataBag && data.StateMessage=="1000") {
            render("#indexSelectData","#chooseManager",data);
            //设置首页下拉框被选中
            if(sessionStorage.getItem("chooseManagerVal")){
                //$("#chooseManager").find("option[value="+sessionStorage.getItem("chooseManagerVal")+"]").attr("selected",true);
                $("#chooseManager").val(sessionStorage.getItem("chooseManagerVal"));
            }
        }
    });

    //下面是获取首页应当巡查内容数据
    shouldPatrol();
    //下面是获取首页应当检测内容数据
    shouldCheck();

})();
//下面是获取首页应当检测内容数据
function shouldCheck(){
    $("#checkProgramTbBody").html('');
    HH.post("/Patrol/GetUserCheckProject",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
       // console.log("后台返回的首页应当检测信息");
       // console.log(data);
        if (data.DataBag && data.StateMessage=="1000") {
            for(var i=0; i<data.DataBag.length; i++){
                var str="";
                for(var j=0; j<data.DataBag[i].Contents.length; j++){
                    str += "<tr tiSysType="+data.DataBag[i].tiSysType+">";
                    if(j==0){
                        str+="<td rowspan='"+data.DataBag[i].Contents.length+"'>"+data.DataBag[i].vSysdesc+"</td> ";
                    }
                    str+= "<td>"+data.DataBag[i].Contents[j].ProjectName+"</td>" +
                        "<td>"+data.DataBag[i].Contents[j].ProjectContent+"</td>" +//findProgramCheckbox
                        "<td><a ProjectId="+data.DataBag[i].Contents[j].ProjectId+" type='checkbox' class='checkProgramCheckbox operation'>删除</a></td>" +
                        "</tr> ";
                }//"<td><input type='checkbox' class='findProgramCheckbox'/></td> " +
                $("#checkProgramTbBody").append(str);
            }
            //下面是点击首页检测表格的删除==============================
            $(".checkProgramCheckbox").click(function(){
             //   console.log(this);
                var myData = {
                    "orgid":sessionStorage.getItem("OrgID"),
                    "ProjectId":$(this).attr("ProjectId")
                };
              //  console.log(myData)
                HH.post("/Patrol/DeleteUserCheckProject",myData,function(data) {
               //     console.log('下面是返回的删除应当检测信息');
                //    console.log(data);
                    shouldCheck();
                });
            })

        }
    });
}
//下面是获取首页应当巡查内容数据
function shouldPatrol(){
    $("#findProgramTbBody").html('');
    HH.post("/Patrol/GetPatrolProject",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
       // console.log("后台返回的首页应当巡查信息");
       // console.log(data);
        if (data.DataBag && data.StateMessage=="1000") {
            for(var i=0; i<data.DataBag.length; i++){
                var str="";
                for(var j=0; j<data.DataBag[i].Contents.length; j++){
                    str += "<tr tiSysType="+data.DataBag[i].tiSysType+">";
                    if(j==0){
                        str+="<td rowspan='"+data.DataBag[i].Contents.length+"'>"+data.DataBag[i].vSysdesc+"</td> ";
                    }
                    str+= "<td>"+data.DataBag[i].Contents[j].ProjectContent+"</td> " +
                        "<td><a ProjectId="+data.DataBag[i].Contents[j].ProjectId+" type='checkbox' class='checkProgramCheckbox operation'>删除</a></td>" +
                        "</tr> ";
                }
                $("#findProgramTbBody").append(str);
            }
            //下面是点击首页巡查表格的删除==============================
            $(".checkProgramCheckbox").click(function(){
               // console.log(this);
                var myData = {
                    "orgid":sessionStorage.getItem("OrgID"),
                    "ProjectId":$(this).attr("ProjectId")
                };
               // console.log(myData);
                HH.post("/Patrol/DeleteCheckProjectContent",myData,function(data) {
                  //  console.log('下面是返回的删除应当检测信息');
                  //  console.log(data);
                    shouldPatrol();
                });
            })

        }
    });
}


var row="";//定义被选中待删除的行
//封装的单位信息注册页面的操作按钮事件
$(document.body).on("click",".operateCompanyRegister",function(){
    var type = $(this).attr("data-type");
    if(type=="checkProgramAdd"){//点击检测项目的添加按钮
        $("#checkProgramModal").modal({backdrop:"static"});
        $("#checkProgramModalTbBody").html("");
        //render("#checkProgramModalData","#checkProgramModalTbBody");
        //获取所有的应当检测
        HH.post("/Patrol/GetUserCheckProject",{"orgid":sessionStorage.getItem("OrgID"),"action":"add"},function(data) {
           // console.log("后台返回的首页应当检测添加信息");
           // console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                for(var i=0; i<data.DataBag.length; i++){
                    var str="";
                    for(var j=0; j<data.DataBag[i].Contents.length; j++){
                        str += "<tr tiSysType="+data.DataBag[i].tiSysType+">";
                        if(j==0){
                            str+="<td rowspan='"+data.DataBag[i].Contents.length+"'>"+data.DataBag[i].vSysdesc+"</td> ";
                        }
                        str+= "<td>"+data.DataBag[i].Contents[j].ProjectName+"</td>" +
                            "<td>"+data.DataBag[i].Contents[j].ProjectContent+"</td>" +
                            "<td><input ProjectId="+data.DataBag[i].Contents[j].ProjectId+" type='checkbox' class='checkProgramCheckbox'/></td>" +
                            "</tr> ";
                    }//"<td><input type='checkbox' class='findProgramCheckbox'/></td> " +
                    $("#checkProgramModalTbBody").append(str);
                }

                //下面是添加的全选功能
                $("#checkProgramModalRow").html("");
                //var str = "全选 <input style='margin-top: 5px' type='checkbox' class='checkProgramSelectAll'/>";
                var str = "<label class='col-sm-1 control-label' id='selectAllLabelCheckProgram' style='padding: 0px;text-align: right;margin-left: 83%' for='checkProgramSelectAll'>全选</label>" +
                        "<div class='col-sm-1'>" +
                            "<input id='checkProgramSelectAll' style='padding: 0px;margin-top: 5px' type='checkbox' class='checkProgramSelectAll'/>" +
                        "</div>";

                $("#checkProgramModalRow").append(str);
                $("#checkProgramSelectAll").click(function(){
                    //alert(checkStatus)
                    if(this.checked){
                        $(".checkProgramCheckbox").prop("checked",true);
                    }else{
                        $(".checkProgramCheckbox").prop("checked",false);
                    }
                });

                //下面是点击应当检测模态框的确认按钮================
                $("#checkProgramConfirm").get(0).onclick=function(){
                    var findProgramCheckbox = $(".checkProgramCheckbox:checked");
                    //alert(findProgramCheckbox.length);
                    var arr = [];
                    for(var i=0; i<findProgramCheckbox.length; i++){
                        var projectid = findProgramCheckbox.eq(i).attr("ProjectId");
                        var obj = {
                            "ProjectId":projectid
                        };
                        arr.push(obj);
                    }
                    var myData = {
                        "ProjectList":arr,
                        "orgid":sessionStorage.getItem("OrgID")
                    };
                    //console.log(myData);
                    HH.post("/Patrol/AddUserCheckProject",myData,function(data) {
                     //   console.log("下面是返回的添加检测项目的保存");
                      //  console.log(data);
                        if(data.StateMessage==1000){
                            $("#checkProgramModal").modal("hide");
                            shouldCheck();
                        }else{
                            alert('添加失败');
                            return;
                        }
                    });
                }
            }
        });

    }else if(type=="findProgramAdd"){//点击巡查内容的添加按钮
        $("#findProgramModal").modal({backdrop:"static"});
        //render("#findProgramModalData","#findProgramModalTbBody");
        $("#findProgramModalTbBody").html("");
        //获取所有的应当巡查的内容
        HH.post("/Patrol/GetPatrolProject",{"orgid":sessionStorage.getItem("OrgID"),"action":"add"},function(data) {
           // console.log("后台返回的应当巡查的添加信息");
           // console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                for(var i=0; i<data.DataBag.length; i++){
                    var str="";
                    for(var j=0; j<data.DataBag[i].Contents.length; j++){
                        str += "<tr tiSysType="+data.DataBag[i].tiSysType+">";
                        if(j==0){
                            str+="<td rowspan='"+data.DataBag[i].Contents.length+"'>"+data.DataBag[i].vSysdesc+"</td> ";
                        }
                        str+= "<td>"+data.DataBag[i].Contents[j].ProjectContent+"</td> " +
                            "<td><input ProjectId="+data.DataBag[i].Contents[j].ProjectId+" type='checkbox' class='findProgramCheckbox'/></td>" +
                            "</tr> ";
                    }
                    $("#findProgramModalTbBody").append(str);
                }

                //下面是添加的全选功能
                $("#findProgramModalRow").html("");
                //var str = "全选 <input style='margin-top: 5px' type='checkbox' class='checkProgramSelectAll'/>";
                var str = "<label class='col-sm-1 control-label' id='selectAllLabelCheckProgram' style='padding: 0px;text-align: right;margin-left: 83%' for='findProgramSelectAll'>全选</label>" +
                    "<div class='col-sm-1'>" +
                    "<input id='findProgramSelectAll' style='padding: 0px;margin-top: 5px' type='checkbox' class='findProgramSelectAll'/>" +
                    "</div>";

                $("#findProgramModalRow").append(str);
                $("#findProgramSelectAll").click(function(){
                    //alert(checkStatus)
                    if(this.checked){
                        $(".findProgramCheckbox").prop("checked",true);
                    }else{
                        $(".findProgramCheckbox").prop("checked",false);
                    }
                });

                //下面是点击应当巡查模态框的确认按钮================
                $("#findProgramConfirm").get(0).onclick=function(){
                    var findProgramCheckbox = $(".findProgramCheckbox:checked");
                    //alert(findProgramCheckbox.length);
                    var arr = [];
                    for(var i=0; i<findProgramCheckbox.length; i++){
                        var projectid = findProgramCheckbox.eq(i).attr("ProjectId");
                        var obj = {
                            "ProjectId":projectid
                        };
                        arr.push(obj);
                    }
                    var myData = {
                        "ProjectList":arr,
                        "orgid":sessionStorage.getItem("OrgID")
                    };
                   // console.log(myData);
                    HH.post("/Patrol/AddPatrolProject",myData,function(data) {
                    //    console.log("下面是返回的巡查内容保存");
                     //   console.log(data);
                        if(data.StateMessage==1000){
                            $("#findProgramModal").modal("hide");
                            shouldPatrol();
                        }else{
                            alert('添加失败');
                            return;
                        }
                    });
                }
            }
        });
    }/*else if(type=="checkProgramDelete"){//点击检测项目表格里面数据的删除按钮
        $("#isDeleteRow").modal({backdrop:"static"});
        row = $(this).parent().parent();
        deleteRow(row);
    }else if(type=="findProgramDelete"){//点击巡查内容表格里面数据的删除按钮
        $("#isDeleteRow").modal({backdrop:"static"});
        row = $(this).parent().parent();
        deleteRow(row);
    }else if(type=="upData"){//点击提交按钮

    }*/

})
//确认删除某一行数据
function deleteRow(row){
    if(row!=""){
        row.remove();
    }
}

//封装的此页面模态框里面的点击确定事件
/*$(document.body).on("click",".ConfirmBtn",function(){
    var id = $(this).attr("id");
    if(id=="checkProgramConfirm"){//点击检测项目模态框的确认按钮
        //将模态框选中的数据添加到表格里面
        appendTbData("#checkProgramModalTb",".checkProgramCheckbox","#checkProgramTbBody","checkProgramDelete");
    }else if(id=="findProgramConfirm"){//点击巡查内容模态框的确认按钮
        //将模态框选中的数据添加到表格里面
        appendTbData("#findProgramModalTb",".findProgramCheckbox","#findProgramTbBody","findProgramDelete");
    }else if(id=="doDeleteRowConfirm"){//点击删除按钮模态框的确认按钮
        deleteRow(row);
    }

});*/
/*
* tbname:模态框里面表格的id
* checkClass:模态框里面复选框的类名
* targetTb:渲染的目标表格的bodyid
* buttonType：删除按钮的data-type类型
* */
function appendTbData(tbname,checkClass,targetTb,buttonType){
    //获得选中的复选框
    var checkedBox = $(tbname+" "+checkClass+":checked");
    if(checkedBox.length<1){
        return;
    }
    var arrCheckedBox = [];//放选中的
    for(var i=0; i<checkedBox.length; i++){
        var programName = checkedBox.eq(i).parent().prev().text();
        arrCheckedBox.push(programName);
    }
    var tbBodyName = $(targetTb);
    var str="";
    for(var i=0; i<checkedBox.length; i++){
        str += "<tr>" +
            "<td>"+arrCheckedBox[i]+"</td>" +
            "<td>" +
            "<button type='button' data-type='"+buttonType+"' data-api=//UserModule/UserManager/DefautIndex' class='operateCompanyRegister btn btn-sm btn-danger' data-toggle='modal'>删除</button> " +
            "</td> " +
            "</tr>";
    }
    tbBodyName.append(str);
}
var chooseManagerVal="";
$("#submitBtn").click(function(){
    var managerOrgID=$("#chooseManager option:selected").val();
    HH.post("/Orginfo/SetOnlineOrgManagerID",{"orgid":sessionStorage.getItem("OrgID"),managerOrgID:managerOrgID},function(data) {
        //console.log('下面是返回的提交信息');
        //console.log(data);
        if(data.StateMessage==1000){
            chooseManagerVal = $("#chooseManager").val();
            sessionStorage.setItem("chooseManagerVal",chooseManagerVal);
            alert(data.DataBag);
        }
    });
})











