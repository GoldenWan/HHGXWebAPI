(function () {

    var allNum = 1;

    var orgid;

    //局部刷新
    function pageReload(nowNum) {

        var nowNum = parseInt(nowNum);
        var ReviewState = $("#ReviewState").val();

        if (!nowNum) {
            nowNum = parseInt($("#in_paging").find(".pagination>.active").text());
            if (isNaN(nowNum)) {
                nowNum = 1;
            }
        }

        var info = {
            MaintenanceId: sessionStorage.getItem("OrgID"),
            ReviewState: ReviewState,
            pageIndex: 1
        };
        HH.post("/FHSign/GetOrgList", info, function (data) {

            var myJson = {data: data.DataBag.PageDatas};

            $.each(myJson.data, function (i, v) {
                v["num"] = i * 1 + 1 + nowNum * 20 - 20;
                v.vSysdesc = v.vSysdesc.join("，");
                if(v.ReviewState=="待审批"){
                    v["state"]={"State1":true}
                }
                if(v.ReviewState=="已签约"){
                    v["state"]={"State2":true}
                }
                if(v.ReviewState=="待解约"){
                    v["state"]={"State3":true}
                }
                if(v.ReviewState=="已解约"){
                    v["state"]={"State4":true}
                }
            });
            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pageCount;

            createPaging("#in_paging", nowNum, allNum);

        });
    }

    $("#ReviewState").change(function(){
        pageReload(1);
    });
    $("#ReviewState").change();

    //页码
    $("#in_paging").on("click", ".pagination>.pageNum", function () {
        var num = parseInt($(this).text());
        pageReload(num)
    });
    $("#in_paging").on("click", ".pagination>.upPage", function () {
        var num = parseInt($(".pagination>.active").text());
        if (num != 1) {
            num = num - 1;
            pageReload(num);
        }
    });
    $("#in_paging").on("click", ".pagination>.downPage", function () {
        var num = parseInt($(".pagination>.active").text());
        if (num != allNum) {
            num = num + 1;
            pageReload(num);
        }
    });

    //操作审批
    $("#in_page").on("click", ".btn_sign", function () {
        var operationId = $(this).attr("data-id");
        var operationtype = $(this).attr("data-type");

        var info = {
            orgid: operationId,
            ReviewState:operationtype,
            MaintenanceId: sessionStorage.getItem("OrgID")
        };
        HH.post("/FHSign/GetOrgDetail", info, function (data) {
            var myJson = data.DataBag;

            $.each(myJson.vSysdesc, function (i, v) {
                v["num"] = i * 1 + 1;
            });
            render("#signView", "#signPage", myJson);
        });

    });

    //审批通过，拒绝按钮
    $("#signPage").on("click", "#approval_btn>button", function () {
        orgid = $(this).attr("data-id");
    });

    //审批确认通过按钮
    $("#sign_trueModal_btn").click(function () {

        var info = {
            ReviewUserId: sessionStorage.getItem("RealName"),
            MaintenanceId: sessionStorage.getItem("OrgID"),
            orgid: orgid,
            state: true
        };

        HH.post("/FHSign/SignOrg", info, function (data) {
            pageReload();
            $('#signModal').modal('hide');
            $('#sign_trueModal').modal('hide');
        });

    });

    //审批确认拒绝按钮
    $("#sign_falseModal_btn").click(function () {

        var info = {
            ReviewUserId: sessionStorage.getItem("RealName"),
            MaintenanceId: sessionStorage.getItem("OrgID"),
            orgid: orgid,
            state: false
        };

        HH.post("/FHSign/SignOrg", info, function (data) {
            pageReload();
            $('#signModal').modal('hide');
            $('#sign_falseModal').modal('hide');
        });

    });

    //操作已签约查看详情
    $("#in_page").on("click", ".btn_sign_check", function () {
        var operationId = $(this).attr("data-id");
        var operationtype = $(this).attr("data-type");

        var info = {
            orgid: operationId,
            ReviewState:operationtype,
            MaintenanceId: sessionStorage.getItem("OrgID")
        };
        HH.post("/FHSign/GetOrgDetail", info, function (data) {
            var myJson = data.DataBag;

            $.each(myJson.vSysdesc, function (i, v) {
                v["num"] = i * 1 + 1;
            });
            render("#sign_checkView", "#sign_checkPage", myJson);
        });

    });

    //操作解约
    $("#in_page").on("click", ".btn_cancel", function () {
        var operationId = $(this).attr("data-id");
        var operationtype = $(this).attr("data-type");

        var info = {
            orgid: operationId,
            ReviewState:operationtype,
            MaintenanceId: sessionStorage.getItem("OrgID")
        };
        HH.post("/FHSign/GetOrgDetail", info, function (data) {
            var myJson = data.DataBag;

            $.each(myJson.vSysdesc, function (i, v) {
                v["num"] = i * 1 + 1;
            });
            render("#cancelView", "#cancelPage", myJson);
        });

    });

    //解约通过，拒绝按钮
    $("#cancelPage").on("click", "#cancel_btn>button", function () {
        orgid = $(this).attr("data-id");
    });

    //解约确认通过按钮
    $("#cancel_trueModal_btn").click(function () {

        var info = {
            AgreementMan: sessionStorage.getItem("RealName"),
            MaintenanceId: sessionStorage.getItem("OrgID"),
            orgid: orgid,
            state: true
        };

        HH.post("/FHSign/TerminteOrg", info, function (data) {
            pageReload();
            $('#cancelModal').modal('hide');
            $('#cancel_trueModal').modal('hide');
        });

    });

    //解约确认拒绝按钮
    $("#cancel_falseModal_btn").click(function () {

        var info = {
            AgreementMan: sessionStorage.getItem("RealName"),
            MaintenanceId: sessionStorage.getItem("OrgID"),
            orgid: orgid,
            state: false
        };

        HH.post("/FHSign/TerminteOrg", info, function (data) {
            pageReload();
            $('#cancelModal').modal('hide');
            $('#cancel_falseModal').modal('hide');
        });

    });

    //操作已签约查看详情
    $("#in_page").on("click", ".btn_cancel_check", function () {
        var operationId = $(this).attr("data-id");
        var operationtype = $(this).attr("data-type");

        var info = {
            orgid: operationId,
            ReviewState:operationtype,
            MaintenanceId: sessionStorage.getItem("OrgID")
        };
        HH.post("/FHSign/GetOrgDetail", info, function (data) {
            var myJson = data.DataBag;

            $.each(myJson.vSysdesc, function (i, v) {
                v["num"] = i * 1 + 1;
            });
            render("#cancel_checkView", "#cancel_checkPage", myJson);
        });

    });

})();