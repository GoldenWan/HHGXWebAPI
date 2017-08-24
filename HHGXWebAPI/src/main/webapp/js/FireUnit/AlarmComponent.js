/**
 * Created by Qiu on 2017/7/1.
 */
(function(){
    //渲染首页的建筑物列表下拉框
    HH.post("/Orginfo/BriefsiteList",{"orgid":sessionStorage.getItem("OrgID")},function(data) {
        if (data.DataBag && data.StateMessage=="1000") {
            render("#alarmComponentSelectData","#alarmComponentSelect",data);
            var selectedId = $("#alarmComponentSelect option:selected").attr("siteid");
            findIndexTb(selectedId,1);
            sessionStorage.setItem("alarmComponentSiteid",selectedId);
            $("#alarmComponentSelect").change(function(){
                selectedId = $("#alarmComponentSelect option:selected").attr("siteid");
                sessionStorage.setItem("alarmComponentSiteid",selectedId);
                findIndexTb(selectedId,1);
            });
        }
    });

    //渲染首页表格信息
    //render("#alarmComponentTbData","#alarmComponentTbody");
    //点击查看详情等操作
    $("#alarmComponentTbody").on("click",".operation",function(){
        if($(this).text()=="查看详情"){
            sessionStorage.setItem("alarmComponentSiteid",$(this).attr("siteid"));
            sessionStorage.setItem("cFlatPic",$(this).attr("cFlatPic"));
            sessionStorage.setItem("imFlatPic",$(this).attr("imFlatPic"));
            sessionStorage.setItem("sitename",$(this).attr("sitename"));
            sessionStorage.setItem("floornum",$(this).attr("floornum"));
            location.href="AlarmComponentDetail.html";
        }
    })

})();
var allNum = 1;
//渲染首页表格
function findIndexTb(siteid,nowNum){
    var myJson = "";
    if(siteid==""){
        myJson={
            "siteid":"",
            "orgid":sessionStorage.getItem("OrgID"),
            "PageIndex":nowNum
        };
    }else{
        myJson={
            "siteid":siteid,
            "orgid":sessionStorage.getItem("OrgID"),
            "PageIndex":nowNum
        };
    }
    HH.post("/Orginfo/SiteDevices", myJson, function (data) {
        if (data.DataBag && data.StateMessage == "1000") {
            console.log(data);
            render("#alarmComponentTbData","#alarmComponentTbody",data);
            allNum = Math.ceil(data.DataBag.pageCount / 20);

            if (allNum == 0) {
                allNum = 1
            }
            createPaging("#in_paging", nowNum, allNum);
        }
    });
}
//页码
$("#in_paging").on("click", ".pagination>.pageNum", function () {
    var selectedId = $("#alarmComponentSelect option:selected").attr("siteid");
    var num = parseInt($(this).text());
    //pageReload(num)
    findIndexTb(selectedId,num);
});
//上一页
$("#in_paging").on("click", ".pagination>.upPage", function () {
    var selectedId = $("#alarmComponentSelect option:selected").attr("siteid");
    var num = parseInt($(".pagination>.active").text());
    if (num != 1) {
        num = num - 1;
        //pageReload(num);
        findIndexTb(selectedId,num);
    }
});
//下一页
$("#in_paging").on("click", ".pagination>.downPage", function () {
    var selectedId = $("#alarmComponentSelect option:selected").attr("siteid");
    var num = parseInt($(".pagination>.active").text());
    if (num != allNum) {
        num = num + 1;
        // pageReload(num);
        findIndexTb(selectedId,num);
    }
});

















