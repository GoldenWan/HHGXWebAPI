(function(){

    HH.post("/Orginfo/OnlineAllInfo", {orgid:sessionStorage.getItem("FireInquiryId")}, function (data) {
        var myJson = data.DataBag;

        //公司基本信息
        if(myJson.BaseInfo.length!=0){
            render("#baseInfoData","#baseInfo",myJson.BaseInfo[0]);
        }
        //营业执照
        if(myJson.BusiLicence.length!=0){
            render("#licenseData","#license",myJson.BusiLicence[0]);
        }

    });

})();




