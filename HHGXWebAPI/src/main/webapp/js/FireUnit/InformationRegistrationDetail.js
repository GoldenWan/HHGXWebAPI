/**
 * Created by Qiu on 2017/7/31.
 */
/**
 * Created by Qiu on 2017/6/14.
 */

(function(){
    //设置主管部门
    $("#managerDiv").text(sessionStorage.getItem("ManagerOrgName"));

    //下面是获取首页应当巡查内容数据
    shouldPatrol();
    //下面是获取首页应当检测内容数据
    shouldCheck();

})();
//下面是获取首页应当检测内容数据
function shouldCheck(){
    $("#checkProgramTbBody").html('');
    HH.post("/Patrol/GetUserCheckProject",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
        console.log("后台返回的首页应当检测信息");
        console.log(data);
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
                        //"<td><a ProjectId="+data.DataBag[i].Contents[j].ProjectId+" type='checkbox' class='checkProgramCheckbox operation'>删除</a></td>" +
                        "</tr> ";
                }//"<td><input type='checkbox' class='findProgramCheckbox'/></td> " +
                $("#checkProgramTbBody").append(str);
            }
            //下面是点击首页检测表格的删除==============================
            $(".checkProgramCheckbox").click(function(){
                console.log(this);
                var myData = {
                    "orgid":sessionStorage.getItem("OrgID"),
                    "ProjectId":$(this).attr("ProjectId")
                };
                console.log(myData)
                HH.post("/Patrol/DeleteUserCheckProject",myData,function(data) {
                    console.log('下面是返回的删除应当检测信息');
                    console.log(data);
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
        console.log("后台返回的首页应当巡查信息");
        console.log(data);
        if (data.DataBag && data.StateMessage=="1000") {
            for(var i=0; i<data.DataBag.length; i++){
                var str="";
                for(var j=0; j<data.DataBag[i].Contents.length; j++){
                    str += "<tr tiSysType="+data.DataBag[i].tiSysType+">";
                    if(j==0){
                        str+="<td rowspan='"+data.DataBag[i].Contents.length+"'>"+data.DataBag[i].vSysdesc+"</td> ";
                    }
                    str+= "<td>"+data.DataBag[i].Contents[j].ProjectContent+"</td> " +
                        //"<td><a ProjectId="+data.DataBag[i].Contents[j].ProjectId+" type='checkbox' class='checkProgramCheckbox operation'>删除</a></td>" +
                        "</tr> ";
                }
                $("#findProgramTbBody").append(str);
            }
            //下面是点击首页巡查表格的删除==============================
            $(".checkProgramCheckbox").click(function(){
                console.log(this);
                var myData = {
                    "orgid":sessionStorage.getItem("OrgID"),
                    "ProjectId":$(this).attr("ProjectId")
                };
                console.log(myData);
                HH.post("/Patrol/DeleteCheckProjectContent",myData,function(data) {
                    console.log('下面是返回的删除应当检测信息');
                    console.log(data);
                    shouldPatrol();
                });
            })

        }
    });
}












