/**
 * Created by Qiu on 2017/6/30.
 */
(function(){
    var indexTbDetailData;
    var allNum = 1;
    //下面是获得首页的列表信息
    function getTransport(nowNum){
        HH.post("/Orginfo/SelectGateway",{"orgid":sessionStorage.getItem("OrgID"),"PageIndex":nowNum},function(data) {
            console.log("后台返回的首页信息");
            console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                render("#transportEquipmentData","#transportEquipmentTbody",data);
                //去除最后一个逗号
                var trs= $("#transportEquipmentTb tr");
                for(var i=1; i<trs.length; i++){
                    var tdText = trs.eq(i).get(0).cells[6].innerHTML;
                    tdText = $.trim(tdText);
                    var newVal = tdText.substring(0,tdText.length-1);
                    trs.eq(i).get(0).cells[6].innerHTML = newVal;
                }

                allNum = Math.ceil(data.DataBag.pageCount / 20);

                if (allNum == 0) {
                    allNum = 1
                }
                createPaging("#in_paging", nowNum, allNum);
            }
        });
    }
    getTransport(1);

    //页码
    $("#in_paging").on("click", ".pagination>.pageNum", function () {
        var num = parseInt($(this).text());
        //pageReload(num)
        getTransport(num);
    });
    //上一页
    $("#in_paging").on("click", ".pagination>.upPage", function () {
        var num = parseInt($(".pagination>.active").text());
        if (num != 1) {
            num = num - 1;
            //pageReload(num);
            getTransport(num);
        }
    });
    //下一页
    $("#in_paging").on("click", ".pagination>.downPage", function () {
        var num = parseInt($(".pagination>.active").text());
        if (num != allNum) {
            num = num + 1;
            // pageReload(num);
            getTransport(num);
        }
    });

    //点击新增的时候弹出模态框
    $('#addTransportEquipment').click(function(){
        render("#addTransportData","#transportEquipmentBody")
        $('#transportEquipmentModal').modal({"backdrop":"static"});
        dataPick("#productTime");
        dataPick("#installTime");

        //点击新增模态框里面的保存按钮
        $("#addModalConfirm").get(0).onclick=function(){
            //点击新增模态框里面的保存按钮
            var myData;
            myData = getForm("#addModalForm");
            var addTransportEquipmentTb = $("#addTransportEquipmentTb tr");
            var FireSysList = [];
            //alert(addTransportEquipmentTb.length);
            for(var i=1; i<addTransportEquipmentTb.length; i++){
                var temp = {
                    "siteid":$($(addTransportEquipmentTb[i]).children("td")[0]).attr("siteid"),
                    "tisystype":$($(addTransportEquipmentTb[i]).children("td")[1]).attr("tisystype"),
                    "Sysaddress":$($(addTransportEquipmentTb[i]).children("td")[2]).text(),
                };
                FireSysList.push(temp);
            }
            myData.FireSysList=FireSysList;
          //  console.log(myData);//检测前端传的数据OK
            HH.post("/Orginfo/AddGateway",myData,function(data) {
             //   console.log("后台返回的添加模态框里面的添加信息");
              //  console.log(data);
                if (data.DataBag && data.StateMessage=="1000") {
                    $('#transportEquipmentModal').modal("hide");
                    location.reload();

                }
            });
        }
    });
    //添加模态框里面的添加按钮触发的模态框
    $('#transportEquipmentBody').on("click","#modalAddBtn", function () {
        $('#addTransportModal').modal({"backdrop":"static"});
        HH.post("/Orginfo/GetFireSystemList",{"orgid":sessionStorage.getItem("OrgID"),"isDivid":"No"},function(data) {
           // console.log("后台返回的添加模态框里面的添加信息");
           // console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                render("#addAddModalData","#addTransportBody",data);
            }
        });
        //下面是点击添加模态框里面的添加保存按钮
        $("#addAddModalConfirm").get(0).onclick=function(){
            addAddSave("#addTransportEquipmentTb");
        };
        //$("#addTransportEquipmentTb").get(0);
    });
    //修改模态框里面的添加按钮触发的模态框
    $('#transportEquipmentBody').on("click","#modalChangeBtn", function () {
        $('#addTransportModal').modal({"backdrop":"static"});
        HH.post("/Orginfo/GetFireSystemList",{"orgid":sessionStorage.getItem("OrgID"),"isDivid":"No"},function(data) {
           // console.log("后台返回的添加模态框里面的添加信息");
           // console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                render("#addAddModalData","#addTransportBody",data);
                $("#addAddSelect").attr("disabled",true);
            }
        });
        //下面是点击添加模态框里面的添加保存按钮
        $("#addAddModalConfirm").get(0).onclick=function(){
            addAddSave("#changeTransportTb");
        };
        //$("#addTransportEquipmentTb").get(0);
    });


    //点击首页表格的修改按钮
    $('#transportEquipmentTbody').on("click",".operation", function (){
        //console.log(this);
        if($(this).text()=="修改"){
            //alert('asdf');
            var Gatewayaddress = $(this).attr("Gatewayaddress");
            //alert(Gatewayaddress);
            $('#transportEquipmentModal').modal({"backdrop":"static"});

            //事先绑定好查询数据
            HH.post("/Orginfo/GatewayInfo",{"orgid":sessionStorage.getItem("OrgID"),"Gatewayaddress":$(this).attr("Gatewayaddress")},function(data) {
               // console.log("后台返回的首页查看详情信息");
               // console.log(data);
                indexTbDetailData = data;
                if (data.DataBag && data.StateMessage=="1000") {
                    //$('#transportEquipmentModal').modal("hide");
                    //location.reload();
                    render("#changeTransportData","#transportEquipmentBody",data);
                    dataPick("#changeProductTime");
                    dataPick("#changeInstallTime");

                    //将数据绑定到修改模态框里面的表格上面
                   // console.log(data.DataBag[0].FireSysList);
                    var str="";
                    var temp = data.DataBag[0].FireSysList;
                    var addAddAddress = $("#addAddAddress").val();
                    for(var i=0; i<temp.length; i++){
                        str += "<tr>" +
                            "<td siteid="+temp[i].siteid+">"+temp[i].sitename+"</td>" +
                            "<td tiSysType="+temp[i].tiSysType+">"+temp[i].vSysdesc+"</td>" +
                            "<td>"+temp[i].Sysaddress+"</td>" +
                            "<td><a siteid="+temp[i].siteid+" class='operation addDeleteTr'>删除</a>" +
                            "</td>"+
                            "</tr>";
                    }
                    $("#changeTransportTb").append(str);
                    $(".addDeleteTr").get(0).onclick=function(){
                        $(this).parent().parent("tr").remove();
                    };
                }
            });

            //点击修改模态框里面的保存按钮
            $("#addModalConfirm").get(0).onclick=function() {
                //点击修改模态框里面的保存按钮
                var myData;
                myData = getForm("#changeModalForm");

                var changeTransportTbTr = $("#changeTransportTb tr");
                var FireSysList = [];
                //alert(addTransportEquipmentTb.length);
                for (var i = 1; i < changeTransportTbTr.length; i++) {
                    var temp = {
                        "siteid": $($(changeTransportTbTr[i]).children("td")[0]).attr("siteid"),
                        "tisystype": $($(changeTransportTbTr[i]).children("td")[1]).attr("tisystype"),
                        "Sysaddress": $($(changeTransportTbTr[i]).children("td")[2]).text(),
                    };
                    FireSysList.push(temp);
                }
                myData.FireSysList = FireSysList;
                myData.Gatewayaddress = Gatewayaddress;
               // console.log(myData);//检测前端传的数据OK
                HH.post("/Orginfo/UpdateGateway", myData, function (data) {
                  //  console.log("后台返回的添加模态框里面的修改信息");
                   // console.log(data);
                    if (data.DataBag && data.StateMessage == "1000") {
                        $('#transportEquipmentModal').modal("hide");
                        location.reload();
                    }
                });
            }

        }if($(this).text()=="查看详情"){
            //alert('asdf');
            $('#transportEquipmentModal').modal({"backdrop":"static"});
            HH.post("/Orginfo/GatewayInfo",{"orgid":sessionStorage.getItem("OrgID"),"Gatewayaddress":$(this).attr("Gatewayaddress")},function(data) {
                //console.log("后台返回的首页查看详情信息");
                //console.log(data);
                indexTbDetailData = data;
                if (data.DataBag && data.StateMessage=="1000") {
                    //$('#transportEquipmentModal').modal("hide");
                    //location.reload();
                    render("#detailTable","#transportEquipmentBody",data);
                }
            });
            $("#addModalConfirm").get(0).onclick=function(){
                $('#transportEquipmentModal').modal("hide");
            };

        }if($(this).text()=="删除"){
            $('#transportDeleteModal').modal({"backdrop":"static"});
            var aLink = $(this);
            var thisTr = $(this).parent().parent("tr");
            //console.log(thisTr.get(0));
            $("#deleteModalConfirm").get(0).onclick=function(){
                HH.post("/Orginfo/DeleteGateway",{"Gatewayaddress":aLink.attr("Gatewayaddress")},function(data) {
                  //  console.log("后台返回的首页删除信息");
                   // console.log(data);
                    if (data.DataBag && data.StateMessage=="1000") {
                        thisTr.remove();
                        $('#transportDeleteModal').modal("hide");
                    }
                });
            }

        }


    });
    $('#transportEquipmentBody').on("click","#modalChangeBtn", function () {
        $('#addTransportModal').modal({"backdrop":"static"});
    });

})();

/*var buildingObj={
    "01":{
        "name":"消防建筑1",
        "child":{
            "0101":{
                "name":"楼层11",
                "child":{
                    "010101":{
                        "name":"地址111"
                    }
                }
            },
            "0102":{
                "name":"楼层12",
                "child":{
                    "010201":{
                        "name":"地址121"
                    }
                }
            }
        }
    },
    "02":{
        "name":"消防建筑2",
        "child":{
            "0201":{
                "name":"楼层21",
                "child":{
                    "020101":{
                        "name":"地址211"
                    }
                }
            },
            "0202":{
                "name":"楼层22",
                "child":{
                    "020202":{
                        "name":"地址212"
                    }
                }
            }
        }
    },

};*/
/*renderBuilding();//渲染建筑物第一级
function renderBuilding(){
    console.log(buildingObj);
    var buildings = "";
    $.each(buildingObj,function(i,v){
        buildings+="<option value='"+i+"'>"+ v.name+"</option>";
    });
    $("#buildings").html(buildings);
    renderLevel();//因为页面刷新的时候就有默认的选择，所以此处要调用一次
}
$("#buildings").change(function(){
    renderLevel();
});

function renderLevel(){//渲染楼层第二级
    var buildingSelected = $("#buildings").val();
    console.log(buildingSelected);
    var levelObj = buildingObj[buildingSelected].child;
    var buildings = "";
    $.each(levelObj,function(i,v){
        buildings+="<option value='"+i+"'>"+ v.name+"</option>";
    });
    $("#levelBuildings").html(buildings);
    renderAddress();//因为页面刷新的时候就有默认的选择，所以此处要调用一次
}
$("#levelBuildings").change(function(){
    renderAddress();
});
renderLevel();

function renderAddress(){//渲染设备地址第三级
    var buildings = $("#buildings").val();
    var levelBuildingsSelected = $("#levelBuildings").val();
    console.log(levelBuildingsSelected);

    var addressObj = buildingObj[buildings].child[levelBuildingsSelected].child;
    var buildings = "";
    $.each(addressObj,function(i,v){
        buildings+="<option value='"+i+"'>"+ v.name+"</option>";
    });
    $("#addressBuildings").html(buildings);
}
renderAddress();*/

function addAddSave(tbId){
    var sitename = $("#addAddSelect option:selected").attr("sitename");
    var vSysdesc = $("#addAddSelect option:selected").attr("vSysdesc");
    var addAddAddress = $("#addAddAddress").val();
    var siteid = $("#addAddSelect option:selected").attr("siteid");
    var tiSysType = $("#addAddSelect option:selected").attr("tiSysType");
    if(addAddAddress==""){
        alert('系统地址不能为空');
        return;
    }
    var str = "<tr>" +
        "<td siteid="+siteid+">"+sitename+"</td>" +
        "<td tiSysType="+tiSysType+">"+vSysdesc+"</td>" +
        "<td>"+addAddAddress+"</td>" +
        "<td><a siteid="+siteid+" class='operation addDeleteTr'>删除</a>" +
        "</td>"+
        "</tr>";
    var addTransportEquipmentTbody = $(tbId);
    addTransportEquipmentTbody.append(str);
    //隐藏添加里面的添加模态框
    $("#addTransportModal").modal("hide");
    //点击添加摩天狂里面的删除按钮
    $(".addDeleteTr").click(function(){
        $(this).parent().parent("tr").remove();
    });

}

//下面是封装的年月日
function yearMonthDay(data){
    //$('#'+data).datetimepicker({
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































