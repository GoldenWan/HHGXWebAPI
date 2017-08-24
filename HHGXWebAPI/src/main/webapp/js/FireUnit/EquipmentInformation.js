(function () {

    var deleteId;

    dataPick("#createDate_add");
    dataPick("#overDate_add");
    dataPick("#installDate_add");

    var allNum = 1;

    //局部刷新
    function pageReload(nowNum) {

        var nowNum = parseInt(nowNum);

        if (!nowNum) {
            nowNum = parseInt($("#in_paging").find(".pagination>.active").text());
            if (isNaN(nowNum)) {
                nowNum = 1;
            }
        }

        var conditionName = $("#conditionName").val();
        var conditionValue = $("#conditionValue").val();

        var info = {
            orgid: sessionStorage.getItem("OrgID"),
            conditionName: conditionName,
            conditionValue: conditionValue,
            PageIndex: nowNum
        };
        HH.post("/Facility/GetFireDeviceList", info, function (data) {

            var myJson = {data: data.DataBag.PageDatas};
            render("#in_view", "#in_page", myJson);

            allNum = data.DataBag.pageCount;

            createPaging("#in_paging", nowNum, allNum);

        });
    };

    $("#check_btn").click(function () {
        pageReload(1);
    });

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

    //获取建筑物列表
    getList("/Orginfo/BriefsiteList", {orgid: sessionStorage.getItem("OrgID")}, "siteid", "sitename", "#build_add");
    //获取部件类型列表
    getList("/Facility/GetDeviceType", {}, "iDeviceType", "DeviceTypeName", "#sys_add");

    //添加处理方法
    $("#add_btn").click(function () {
        var myJson = getForm("#form_add");

        HH.post("/Facility/AddFireDevice", myJson, function (data) {
            $('#addModal').modal('hide');
            document.getElementById("form_add").reset();
            pageReload();
        });
    });

    //操作详情
    $("#in_page").on("click", ".btn_check", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Facility/GetFireDevice", {deviceNo: operationId}, function (data) {
            var myJson = data.DataBag[0];
            render("#checkView", "#checkPage", myJson);
        });

    });

    //操作修改
    $("#in_page").on("click", ".btn_edit", function () {
        var operationId = $(this).attr("data-id");

        HH.post("/Facility/GetFireDevice", {deviceNo: operationId}, function (data) {
            var myJson = data.DataBag[0];
            render("#editView", "#editPage", myJson);

            dataPick("#createDate_edit", myJson.productDate);
            dataPick("#overDate_edit", myJson.validate);
            dataPick("#installDate_edit", myJson.SetupDate);

            //获取建筑物列表
            getList("/Orginfo/BriefsiteList", {orgid: sessionStorage.getItem("OrgID")}, "siteid", "sitename", "#build_edit", myJson.siteid);
            //获取部件类型列表
            getList("/Facility/GetDeviceType", {}, "iDeviceType", "DeviceTypeName", "#sys_edit", myJson.iDeviceType);

            $("#edit_btn").click(function () {
                var myJson = getForm("#form_edit");
                HH.post("/Facility/UpdateFireDevice", myJson, function (data) {
                    $('#editModal').modal('hide')
                    pageReload();
                });
            });

        });

    });

    //操作删除
    $("#in_page").on("click", ".btn_delete", function () {
        deleteId = $(this).attr("data-id");
    });
    $("#deleteModal").on("click", "#deleteModal_btn", function () {
        HH.post("/Facility/DeleteFireDeviceList", {deviceNo: deleteId}, function (data) {
            $('#deleteModal').modal('hide');
            pageReload();
        });
    })

    $("#check_btn").click();

})();