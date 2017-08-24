(function(){

    var myDate = new Date();

    //局部刷新
    function pageReload() {

        var startTime = $("#startDate").find("input").val();
        var stopTime = $("#stopDate").find("input").val();

        var info = {
            ManagerOrgID: sessionStorage.getItem("OrgID"),
            StartTime: startTime,
            endTime: stopTime
        };
        HH.post("/ManageOrgInfo/UserCheckList", info, function (data) {

            var myJson = {data: data.DataBag};
            myJson["startTime"] = startTime;
            myJson["stopTime"] = stopTime;

            $.each(myJson.data,function(i,v){
                v["num"] = i*1+1;

                if((v.sysCheckCount*1)!=0){
                    var num1 = (v.UserCheckCount*1)/(v.sysCheckCount*1)*100;
                    v["complete"] = num1.toFixed(2) + "%";
                }else{
                    v["complete"] = "0%";
                }

                if((v.UsercheckProjectCount*1)!=0){
                    var num2 = (v.UsercheckProjectOKCount*1)/(v.UsercheckProjectCount*1)*100;
                    v["qualified"] =  num2.toFixed(2)+ "%";
                }else{
                    v["qualified"] = "0%";
                }

            });

            render("#in_view", "#in_page", myJson);

        });
    };

    dataPick("#startDate");
    dataPick("#stopDate");

    $("#startDate").find("input").val(myDate.getFullYear()+"/"+(myDate.getMonth()-1)+"/"+myDate.getDate());
    $("#stopDate").find("input").val(myDate.getFullYear()+"/"+(myDate.getMonth()+1)+"/"+myDate.getDate());

    $("#check_btn").click(function(){
        pageReload();
    });

    $("#in_page").on("click",".btn_check",function(){
        var operationId = $(this).attr("data-id");
        sessionStorage.setItem("FireOrgID",operationId);
        window.location.href = "PatrolSituationInfo.html";
    });

    $("#check_btn").click();

})();