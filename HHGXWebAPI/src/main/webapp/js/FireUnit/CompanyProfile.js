/**
 * Created by Qiu on 2017/6/9.
 */
(function(){
    //点击编辑基本信息按钮弹出模态框
    $("#editBtn").click(function () {
        $("#companyBaseInfoMTK").modal({backdrop:"static"});
        //下面是获取首页所有所有信息
        HH.post("/Orginfo/GetOnlineOrg",{"OrgID":sessionStorage.OrgID},function(data){
            data = data.DataBag[0];
            //alert($.trim(data.YnImportant));
            if(data!=null){
                data = {"data":data};
              //  console.log("编辑返回数据");
               // console.log(data);
                render("#editModalData","#CompanyProfileForm",data);
                //是否为重点防火单位设置
                if($.trim(data.data.YnImportant)==null){
                }if($.trim(data.data.YnImportant)=="是"){
                    $("#editYes").attr("checked",true);
                }if($.trim(data.data.YnImportant)=="否"){
                    $("#editNo").attr("checked",true);
                }
                //单位类型绑定值
                $("#EditDwlx").val(data.data.OrganType);
                //单位其他情况绑定

                if(data.data.otherthings!=null){
                    //.eq(0).attr("checked","checked");
                    //console.log("下面是返回的单位其他情况");
                    if(data.data.otherthings.indexOf(",")!=-1){
                        var arr = data.data.otherthings.split(",");
                        //console.log(arr);
                        for(var i=0; i<arr.length; i++){
                            $("#EditeDwqtqk").find("input[value="+arr[i]+"]").attr("checked","checked");
                        }
                    }else{
                        $("#EditeDwqtqk").find("input[value="+data.data.otherthings+"]").attr("checked","checked");
                    }

                }
                //有无自动消防设备设置
                if($.trim(data.data.AutoFireFacility)==null){
                }if($.trim(data.data.AutoFireFacility)=="无"){
                    $("#editAutoFireY").attr("checked",true);
                }if($.trim(data.data.AutoFireFacility)=="有"){
                    $("#editAutoFireN").attr("checked",true);
                }
                //经济所有制设置选择
                $("#Editjjsyz").val(data.data.souyouzhi);
                dataPick("#dwclsj");
                //监管等级设置
                $("#jgdj").val(data.data.managegrade);
                //燃气类型设置
                $("#editRqlx").val(data.data.GasType);
                dataPick("#editjlsj");
                //dataPick("#editrwsj");
                yearMonthDay("#editrwsj");

            }
        });
    });
    //点击上传营业执照按钮弹出模态框
    $("#UpLicenseBtn").click(function () {
        //绑定营业执照的下拉框
        //alert(licenceData.CompanyType);
        if(licenceData){
            $("#CompanyType").val(licenceData.CompanyType);
        }
        //console.log(allData);
        $("#upLicenseModal").modal({backdrop:"static"});
        dataPick("#BuildTime");
        dataPick("#BusinessEndTime");
        dataPick("#RegistTime");
        $("#file").get(0).onchange=function(){
            document.getElementById("userdefinedFile").value = document.getElementById("file").value;
        };
        //alert(sessionStorage.getItem("OrgID"));
        //点击营业执照的模态框保存
        $("#upLicenseConfirm").click(function(){
            //$("#CompanyProfileForm").submit();
            $("#orgid").val(sessionStorage.getItem("OrgID"));
            //上传文件jQuery表单提交
            var options = {
                //beforeSubmit: showRequest,  //提交前的回调函数
                success: showResponse,      //提交后的回调函数
                url: ApiUrl+"/Form/AddBusinessLicence", //默认是form的action， 如果申明，则会覆盖
                type: "post",               //默认是form的method（get or post），如果申明，则会覆盖
                dataType: "json"           //html(默认), xml, script, json...接受服务端返回的类型
                //clearForm: true,          //成功提交后，清除所有表单元素的值
                //resetForm: true,          //成功提交后，重置所有表单元素的值
                //timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求
            }
            function showResponse(responseText, statusText){
               // console.log(responseText);
                if(responseText.StateMessage=="1000"){
                    $("#upLicenseModal").modal("hide");
                    location.reload();
                }
                /*if(statusText=="success"){
                 alert('上传成功');
                 }*/
            }
            /* function showRequest(formData, jqForm, options){
             var queryString = $.param(formData);   //name=1&address=2
             var formElement = jqForm[0];              //将jqForm转换为DOM对象
             var address = formElement.address.value;  //访问jqForm的DOM元素
             return true;  //只要不返回false，表单都会提交,在这里可以对表单元素进行验证
             }*/
            $("#upLicenseBody").ajaxSubmit(options);
        });

        //upyyqx
    });

    //下面是获取首页所有所有信息
    var allData = "";
    //首页的营业执照信息
    var licenceData = "";
    HH.post("/Orginfo/GetOnlineOrg",{"OrgID":sessionStorage.OrgID},function(data){
        console.log("首页信息");
        console.log(data);
        data = data.DataBag[0];
        sessionStorage.ManagerOrgID = data.ManagerOrgID;//设置首页返回的ManagerOrgID
      //  console.log('首页所有数据');
      //  console.log(data);
        if(data!=null){
            data = {"data":data};
            //allData = data;
            //console.log("单位基本信息");
            //console.log(data);
            render("#companyIndexFormData","#companyIndexForm",data);
        }
    });

    //下面是获取首页营业执照信息
    HH.post("/Orginfo/GetBusinessLicence",{"orgid":sessionStorage.OrgID},function(data){
       // console.log("详情营业执照信息：");
        data = data.DataBag[0];
        licenceData = data;
      //  console.log(data);
        //if(data!=null){
            data = {"data":data};
          //  console.log(data);
            //
            render("#companyLicenseFormData","#companyLicenseForm",data);
            //console.log(data.data.PictureUrl);
            //下面是渲染上传营业执照部分(模态框里面的)
            render("#upLicenseData","#upLicenseBody",data);
        //}

    });



    //下面是调用时间插件

   /* yearMonthDay("clrq");
    yearMonthDay("yyqx");
    yearMonthDay("djrq");
    yearMonthDay("jlsj");
    yearMonthDay("Showdwclsj");*/

    //下面是封装的年月日
    function yearMonthDay(node,start){
        var startDate;
        if (!start) {
            startDate = new Date();
        } else {
            startDate = start;
        }
        $(node).datetimepicker({
            format: 'yyyy/mm/dd',//日期格式
            weekStart: 1,//一周从那天开始
            autoclose: true,//选中之后自动隐藏日期选择框
            startView: 2,//选完时间首先显示的视图（年月日）
            minView: 2,//日期时间选择器所能够提供的最精确的时间选择视图。
            forceParse: true,//你输入的可能不正规，但是它会强制尽量解析成你规定的格式（format）
            language: 'zh-CN',
            initialDate: startDate,
            todayHighlight: true,
            pickerPosition:'top-right'
        });
    }
    //禁止用户在输入框输入空格
    var inputText = $(".inputText");
    var inputDate = $(".inputDate");
    stopEmpty(inputDate);
    stopEmpty(inputText);

    //点击单位基本信息保存
    $("#companyModalSaveBtn").click(function(){
        var inputCheckBox = $('.inputCheckBox:checked');
        var YnImportant = $(".YnImportant:checked");
        var AutoFireFacility = $(".AutoFireFacility:checked");
        //判断是否有复选框被选中
        if(inputCheckBox.length<=0){
            alert('请选择单位情况');
            return;
        }if(YnImportant.length<=0){
            alert("请选择是否为重点防火单位");
            return;
        }if(AutoFireFacility.length<=0){
            alert("请选择有无自动消防设备");
            return;
        }

       // console.log('发送给后台的数据：');
        var editData = getForm("#CompanyProfileForm");
        editData.ManagerOrgID = sessionStorage.ManagerOrgID;


        var temp = editData.otherthings;
        var otherthingsStr = "";
        //console.log(temp[0]+"="+temp[1]);
        if(temp instanceof Array){
            for(var i=0; i<temp.length; i++){
                otherthingsStr = otherthingsStr+temp[i]+",";
            }
            otherthingsStr = otherthingsStr.substring(0,otherthingsStr.length-1);
            editData.otherthings = otherthingsStr;
        }
        console.log(editData);
        HH.post("/Orginfo/UpdateOnlineOrg",editData,function(data){
       //     console.log("点击编辑保存返回数据：");
       //     console.log(data);
            if(data.StateMessage=="1000"){
                $("#companyBaseInfoMTK").modal("hide");
                location.reload();
            }
           /* data = data.DataBag[0];
            if(data!=null){
                data = {"data":data};
                //  console.log(data);
                render("#companyLicenseFormData","#companyLicenseForm",data);

            }*/
        });
    })

})();





