(function(){

    HH.post("/Orginfo/OnlineAllInfo", {orgid:sessionStorage.getItem("CompetentOrg")}, function (data) {
        var myJson = data.DataBag;
        var siteList = {};

        $.each(myJson.recordProject, function (i, v) {
            v["len"] = v.Contents.length;
        });
        $.each(myJson.checkProject, function (i, v) {
            v["len"] = v.Contents.length;
        });

        //建筑消防设施应巡查项目
        Handlebars.registerHelper("myTd1", function (ng, options) {
            var node = "";
            for (var i = 0; i < ng.length; i++) {
                for (var j = 0; j < ng[i].Contents.length; j++) {
                    node = node + '<tr>';
                    if (j == 0) {
                        node = node + '<td rowspan="' + ng[i].len + '">' + ng[i].vSysdesc + '</td>';
                    }
                    node = node +
                        '<td>' + ng[i].Contents[j].ProjectContent + '</td>' +
                        '</tr>';
                };
            };
            return node;
        });

        //建筑消防设施应检测项目
        Handlebars.registerHelper("myTd2", function (ng, options) {
            var node = "";
            for (var i = 0; i < ng.length; i++) {
                for (var j = 0; j < ng[i].Contents.length; j++) {
                    node = node + '<tr>';
                    if (j == 0) {
                        node = node + '<td rowspan="' + ng[i].len + '">' + ng[i].vSysdesc + '</td>';
                    }
                    node = node +
                        '<td>' + ng[i].Contents[j].ProjectName + '</td>' +
                        '<td>' + ng[i].Contents[j].ProjectContent + '</td>' +
                        '</tr>';
                };
            };
            return node;
        });

        //公司基本信息
        if(myJson.BaseInfo.length!=0){
            render("#baseInfoData","#baseInfo",myJson.BaseInfo[0]);
        }
        //营业执照
        if(myJson.BusiLicence.length!=0){
            render("#licenseData","#license",myJson.BusiLicence[0]);
        }
        //表格建筑物信息
        if(myJson.siteListInfo.length!=0){
            render("#buildingData","#buildingInfoTbBody",myJson.siteListInfo);
        }
        //表格系统信息
        if(myJson.sysInfo.length!=0){
            render("#systemData","#systemInfoTbBody",myJson.sysInfo);
        }
        //建筑消防设施应巡查项目
        if(myJson.recordProject.length!=0){
            render("#fireInfoData","#fireInfoTbBody",myJson.recordProject);
        }
        //建筑消防设施应检测项目
        if(myJson.checkProject.length!=0){
            render("#fireChekcInfoData","#fireChekcInfoBody",myJson.checkProject);
        }

        //建筑物信息处理
        $.each(myJson.siteListInfo,function(i,v){
            siteList[v.siteid] = v;
        });
        $("#buildingInfoTbBody").on("click",".buildingName",function(){
            var opt = $(this).attr("data-id");
            var siteInfo = siteList[opt];

            $('#buildingInfo').modal({"backdrop":"static"});
            render("#buildingInfoData","#buildingInfoRow",siteInfo);
        })

    });

    //审核通过
    $("#auditModal_okBtn").click(function(){
        var info = {
            orgid:sessionStorage.getItem("CompetentOrg"),
            ApproveState:"已通过"
        };
        HH.post("/Orginfo/ApproveResult", info, function (data) {
            window.location.href = "RegistrationAudit.html"
        });

    });

    //审核不通过
    $("#auditModal_noBtn").click(function(){
        var info = {
            orgid:sessionStorage.getItem("CompetentOrg"),
            ApproveState:"不通过",
            ApproveIdea:$("#Approveldea").val()
        };
        HH.post("/Orginfo/ApproveResult", info, function (data) {
            window.location.href = "RegistrationAudit.html"
        });
    });

})();




