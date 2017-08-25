/**
 * Created by Qiu on 2017/6/29.
 */
(function(){
    var allNum = 1;
    //获取首页表格数据
    indexTb(1);
    function indexTb(nowNum){
        HH.post("/Organdpeople/GetequipmentList",{"PageIndex":nowNum},function(data) {
        //HH.post("/Organdpeople/GetequipmentList",{"firecompayid":sessionStorage.getItem("firecompayid")},function(data) {
            ///console.log("后台返回装备首页数据");
           // console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                render("#fireEquipmentData","#fireEquipmentTbody",data);

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
        var num = parseInt($(this).text());
        //pageReload(num)
        indexTb(num);
    });
    //上一页
    $("#in_paging").on("click", ".pagination>.upPage", function () {
        var num = parseInt($(".pagination>.active").text());
        if (num != 1) {
            num = num - 1;
            //pageReload(num);
            indexTb(num);
        }
    });
    //下一页
    $("#in_paging").on("click", ".pagination>.downPage", function () {
        var num = parseInt($(".pagination>.active").text());
        if (num != allNum) {
            num = num + 1;
            // pageReload(num);
            indexTb(num);
        }
    });

    var equipmentData = "";
    //获取首页的装备类型
    HH.post("/Organdpeople/GetEquipmentType","",function(data) {
         console.log("后台返回装备类型");
         console.log(data);
         if (data.DataBag && data.StateMessage=="1000") {
             equipmentData = data;
             //render("#equipmentTypeData","#equipmentType",data);
             //根据装备类型来查询下面的装备
             //var equipmentType = $("#equipmentType").val();
             //findEquipments(equipmentType);
             /*$("#equipmentType").change(function(){
                 equipmentType = $(this).val();
                 //findEquipments(equipmentType);
             })*/
         }
     });
    /*function findEquipments(equipmentType){
        HH.post("/Organdpeople/GetEquipmentByType",{"equipmenttype":equipmentType},function(data) {
            console.log("后台返回查询列表信息");
            console.log(data);
            if (data.DataBag && data.StateMessage=="1000") {
                //indexTb();
                render("#fireEquipmentData","#fireEquipmentTbody",data);
            }
        });
    }*/

    //点击新增的时候弹出模态框
    $('#addEquipment').get(0).onclick=function(){
        //下面渲染新增模态框
        render("#addFireEquipmentData","#fireEquipmentBody");
        $('#fireEquipmentModal').modal({"backdrop":"static"});
        //下面渲染新增模态框里面的装备类型
        var str="";
        for(var i=0; i<equipmentData.DataBag.length; i++){
            str = str +"<option value='"+equipmentData.DataBag[i]+"'>"+equipmentData.DataBag[i]+"</option>";
        }
        $("#addEquipmentSel").append(str);
        dataPick(".addBuyTime");

        //点击模态框的确定按钮
        $("#fireEquipmentModalConfirm").get(0).onclick=function(){
            var myJson = getForm("#FireEquipmentForm");
             console.log(myJson);
            //myJson.firecompayid = sessionStorage.getItem("firecompayid");
            //alert(sessionStorage.getItem("firecompayid"));
            HH.post("/Organdpeople/Addequipment",myJson,function(data) {
           //     console.log("后台返回添加信息");
           //     console.log(data);
                if (data.DataBag && data.StateMessage=="1000") {
                    $('#fireEquipmentModal').modal("hide");
                    //var equipmentType = $("#equipmentType").val();
                    //findEquipments(equipmentType);
                    indexTb(parseInt($(".pageNum").text()));
                }
            });

        };
    };

    //表格里面的修改和删除触发事件
    $('#fireEquipmentTbody').on("click",".operation",function(){
        if($(this).text()=="修改"){
            //点击修改的时候先把详情获取
            $('#fireEquipmentModal').modal({"backdrop":"static"});
            var EquipmentID = $(this).attr("EquipmentID");
            var myJson = {
                "EquipmentID":EquipmentID
            };
            //渲染详情
            HH.post("/Organdpeople/getequipmentdetail",myJson,function(data) {
                console.log("后台返回某个装备信息");
                console.log(data);
                if (data.DataBag && data.StateMessage=="1000") {
                    render("#changeFireEquipmentData","#fireEquipmentBody",data);
                    $("#changeEquipmentSel").html("");
                    //equipmentData绑定所有的下拉框
                    var str = "";
                    for(var i=0; i<equipmentData.DataBag.length; i++){
                        str = str+"<option value='"+equipmentData.DataBag[i]+"'>"+equipmentData.DataBag[i]+"</option>";
                    }
                    $("#changeEquipmentSel").append(str);
                    //绑定修改里面的下拉框
                    $("#changeEquipmentSel").val(data.DataBag.PageDatas[0].equipmenttype);
                    dataPick(".changeBuyTime");
                    //修改保存按钮
                    $("#fireEquipmentModalConfirm").get(0).onclick=function(){
                        var myJson = getForm("#changeFireEquipmentForm");
                        myJson.EquipmentID = EquipmentID
                  //      console.log(myJson);
                        HH.post("/Organdpeople/updateequipment",myJson,function(data) {
                       //      console.log("后台返回修改信息");
                        //     console.log(data);
                             if (data.DataBag && data.StateMessage=="1000") {
                                 $('#fireEquipmentModal').modal("hide");
                                 //console.log($(".pageNum").text());
                                 indexTb(parseInt($(".pageNum").text()));
                                 /*var equipmentType = $("#equipmentType").val();
                                 findEquipments(equipmentType);*/
                             }
                        });
                    }
                }
            });

        } if($(this).text()=="删除"){
            $('#fireEquipmentModal').modal({"backdrop":"static"});
            render("#isDeleteModalData","#fireEquipmentBody");
            var myJson = {
                "EquipmentID":$(this).attr("EquipmentID")
            };
            //点击删除的确认
            $("#fireEquipmentModalConfirm").get(0).onclick=function(){
                HH.post("/Organdpeople/deleteequipment",myJson,function(data) {
                   // console.log("后台返回删除信息");
                  //  console.log(data);
                    if (data.DataBag && data.StateMessage=="1000") {
                        $('#fireEquipmentModal').modal("hide");
                        indexTb(parseInt($(".pageNum").text()));
                        /*var equipmentType = $("#equipmentType").val();
                        findEquipments(equipmentType);*/
                    }
                });
            }
        }
    })

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

})();





