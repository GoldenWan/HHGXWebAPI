//浏览器类型及版本检测
function getBrowserInfo(){
    var Sys = {};
    var ua = navigator.userAgent.toLowerCase();
    var re =/(msie|firefox|chrome|opera|version).*?([\d.]+)/;
    var m = ua.match(re);
    if(m){
        Sys.browser = m[1].replace("/version/", "safari");
        Sys.ver = m[2];
    }
    return Sys;
}

//tem:模板节点
//node:目标添加位置节点
//data:json对象
function render(tem, node, data) {
    //用jquery获取模板
    var tpl = $(tem).html();
    //预编译模板
    var template = Handlebars.compile(tpl);

    //图片添加路径
    Handlebars.registerHelper("imgSrc", function (index, options) {
        return ImgUrl + index;
    });

    //模拟json数据
    var context = data;
    //匹配json内容
    var html = template(context);
    //输入模板
    $(node).html(html);
}

//获取cookie参数方法
function get_cookie(Name) {
    var search = Name + "="//查询检索的值
    var returnvalue = "";//返回值
    if (document.cookie.length > 0) {
        var sd = document.cookie.indexOf(search);
        if (sd != -1) {
            sd += search.length;
            end = document.cookie.indexOf(";", sd);
            if (end == -1)
                end = document.cookie.length;
            //unescape() 函数可对通过 escape() 编码的字符串进行解码。
            returnvalue = decodeURI(document.cookie.substring(sd, end))
        }
    }
    return returnvalue;
}

//封装的渲染ztree方法(ztreeName是传入的ztree的id,zNodes是后台传回的数据)
function showZtree(ztreeName, zNodes, mySetting) {
    var setting = mySetting;
    $(document).ready(function () {
        $.fn.zTree.init($(ztreeName), setting, zNodes);
    });
}

(function () {
//===================================================AJAX处理封装==================================================================
    function HHObj() {
        // 一个对象工厂，以后生成新对象不用new了，直接执行这个方法即可。
        return new HHObj.fn.init();
    }

    // HH的初始方法
    HHObj.fn = HHObj.prototype = {
        init: function () {

        },
        //url：不需要加IP地址，例如："/UserModule/UserManager/DefautIndex"
        //method：成功回调函数
        //prompt：错误提示回调函数
        get: function (url, method, prompt) {
            var myJson = {
                tokenUUID: get_cookie("UserId"),
                infoBag: {}
            };
            $.ajax({
                type: "post",
                url: ApiUrl + url,
                data: JSON.stringify(myJson),
                dataType: "json"
            }).done(function (data) {
                if (data.StateMessage == 1000) {
                    if (data.DataBag) {
                        if (method) {
                            method(data);
                        }
                    } else {
                        console.log("缺少DataBag参数")
                    }
                } else if (data.StateMessage == -1) {
                    window.location.href = "../index.html";
                } else if (data.StateMessage == -2) {
                    if (prompt) {
                        prompt(data);
                    }else{
                        alert(data.DataBag)
                    }
                } else if (data.StateMessage == -256) {
                    console.log(data.DataBag);
                } else {
                    console.log("状态码不对，StateMessage=" + data.StateMessage);
                }
            });
        },
        //url：不需要加IP地址，例如："/UserModule/UserManager/DefautIndex"
        //data：传递参数，JSON对象
        //method：成功回调函数
        //prompt：错误提示回调函数
        post: function (url, data, method, prompt) {
            var myJson = {
                tokenUUID: get_cookie("UserId"),
                infoBag: data
            };
            $.ajax({
                type: "post",
                url: ApiUrl + url,
                data: JSON.stringify(myJson),
                dataType: "json"
            }).done(function (data) {
                if (data.StateMessage == 1000) {
                    if (data.DataBag) {
                        if (method) {
                            method(data);
                        }
                    } else {
                        console.log("缺少DataBag参数")
                    }
                } else if (data.StateMessage == -1) {
                    window.location.href = "../index.html";
                } else if (data.StateMessage == -2) {
                    if (prompt) {
                        prompt(data);
                    }else{
                        alert(data.DataBag)
                    }
                } else if (data.StateMessage == -256) {
                    console.log(data.DataBag);
                } else {
                    console.log("状态码不对，StateMessage=" + data.StateMessage);
                }
            });
        }
    };

    HHObj.prototype.init.prototype = HHObj.fn;
    // 修正构造器指向
    HHObj.prototype.constructor = HHObj;

    window.HH = HHObj();

})();

//鼠标点击到图片上的X按钮上时，提示用户是否要删除
//containImg:点击i图标的父元素
//i:点击的图标元素
function deleteImg(containImg, i) {
    $("." + containImg).on("click", i, function () {
        var img = $(this).parent("div").parent();
        var iphotoID = $(this).attr("iphotoID");
        $("#isDeleteImg").modal({backdrop: "static"});
        $("#doDeleteImg").get(0).onclick = function () {
            HH.post("/Orginfo/DeleteAppearance", {"iphotoID": iphotoID}, function (data) {
                console.log("下面是返回的删除某个图片信息");
                console.log(data);
                if (data.DataBag && data.StateMessage == "1000") {
                    img.remove();
                    $("#isDeleteImg").modal("hide");
                }
            });
        };
    })
}

//封装的禁止用户输入空格
function stopEmpty(obj) {
    for (var i = 0; i < obj.length; i++) {
        obj.get(i).onkeypress = function (event) {
            if (event.keyCode == 32) {
                event.returnValue = false;
            }
        }
    }
}

//获取form数据方法
//node:form节点，遵循jquery的选择器
function getForm(node) {
    var data = {};
    var form = $(node).serializeArray();
    $.each(form, function () {
        if (data[this.name] == undefined) {
            data[this.name] = this.value;
        } else {
            if ($.isArray(data[this.name])) {
                data[this.name].push(this.value);
            } else {
                var arr = [];
                arr.push(data[this.name]);
                arr.push(this.value);
                data[this.name] = arr;
            }
        }
    });

    return data;
}

//调用百度地图的方法
function baiDuMap(temp, lng, lat) {
    var map = new BMap.Map(temp);

    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
    map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件

    var latitude = 30.67;//纬度
    var longitude = 104.06;//经度
    //alert(latitude+"-"+longitude);
    var marker = new BMap.Marker(new BMap.Point(longitude, latitude));  // 创建标注
    map.addOverlay(marker);              // 将标注添加到地图中

    map.centerAndZoom(new BMap.Point(81, 152), 13);
    //map.centerAndZoom(new BMap.Point(latitude, longitude), 13);

    map.addEventListener("click", function (e) {
        map.clearOverlays();
        var marker = new BMap.Marker(new BMap.Point(e.point.lng, e.point.lat));  // 创建标注
        map.addOverlay(marker);              // 将标注添加到地图中

        //document.getElementById("info").innerHTML = e.point.lng + ", " + e.point.lat;
        document.getElementById(lng).value = e.point.lng;
        document.getElementById(lat).value = e.point.lat;

    });
}

//调用百度地图（根据经度纬度标注位置）
function searchMap(x, y, container) {
    var map = new BMap.Map(container);

    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
    map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件

    /*function center(x, y) {
     map.centerAndZoom(new BMap.Point(x, y), 15);

     }*/
    addpoint(x, y);
    function addpoint(x, y, info, pic) {

        var sContent = "<h4 style='margin:0 0 5px 0;padding:0.2em 0'>警情信息</h4>" +
            " <table><tr><td><img style='float:right;margin:4px' id='imgDemo' src='" + pic + "' width='139' height='104' title='火警'/> </td>" +
            "<td><p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>" + info + "</p> </td><tr></tabel>" +
            "</div>";
        var infoWindow = new BMap.InfoWindow(sContent);  // 创建信息窗口对象

        /*
         var myIcon = new BMap.Icon("/images/pic1.png", new BMap.Size(28, 37),
         {
         offset: new BMap.Size(10, 25),
         imageOffset: new BMap.Size(0 - 1 * 28, 0)
         });

         var marker = new BMap.Marker(new BMap.Point(x, y), { icon: myIcon });  // 创建标注
         */

        var marker = new BMap.Marker(new BMap.Point(x, y));  // 创建标注
        map.addOverlay(marker);              // 将标注添加到地图中

        map.centerAndZoom(new BMap.Point(x, y), 15);

        marker.addEventListener("click", function () {
            this.openInfoWindow(infoWindow);
            //图片加载完毕重绘infowindow
            document.getElementById('imgDemo').onload = function () {
                infoWindow.redraw();
            }
        });
    }
}

//省市区联动调用
//shen：省下拉框节点，jquery选择器
//shi：省下拉框节点，jquery选择器
//qu：省下拉框节点，jquery选择器
function areaObj(shen, shi, qu, areaId) {

    //添加省节点
    this.shenCreate = function () {
        var node1 = "";
        $.each(area, function (i, v) {
            node1 = node1 + "<option value=" + i + ">" + v.AreaName + "</option>";
        });
        $(shen).html(node1);
    };
    //区改变事件
    this.quChange = function () {
        var shenVal = $(shen).val();
        var shiVal = $(shi).val();
        var quArr = area[shenVal].child[shiVal].child;

        var node3 = ""
        $.each(quArr, function (i, v) {
            node3 = node3 + "<option value=" + i + ">" + v.AreaName + "</option>";
        });
        $(qu).html(node3);
    };
    //市改变事件
    this.shiChange = function () {
        var shenVal = $(shen).val();
        var shiArr = area[shenVal].child;

        var node2 = ""
        $.each(shiArr, function (i, v) {
            node2 = node2 + "<option value=" + i + ">" + v.AreaName + "</option>";
        });
        $(shi).html(node2);

        var shiVal = $(shi).val();
        var quArr = area[shenVal].child[shiVal].child;

        var node3 = ""
        $.each(quArr, function (i, v) {
            node3 = node3 + "<option value=" + i + ">" + v.AreaName + "</option>";
        });
        $(qu).html(node3);
    };
    //初始化
    this.init = function () {

        this.shenCreate();

        this.shiChange();

        $(shen).change(this.shiChange);
        $(shi).change(this.quChange);

        if (areaId) {
            $(shen).val(areaId[0]);
            this.shiChange();
            $(shi).val(areaId[1]);
            this.quChange();
            $(qu).val(areaId[2]);
        }

    };
    this.init();

}

//手机号验证
function checkMobile(s) {
    var regu = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
    var re = new RegExp(regu);
    if (re.test(s)) {
        return true;
    } else {
        return false;
    }
}

//获取下拉列表
//api：对应请求api
//info：传递的参数，一个object对象
//param1：option的value的值
//param2：option的文字信息
//node：渲染节点位置
//value：初始化值
function getList(api, info, param1, param2, node, value, method, allFalse) {
    var op = "<option value='all'>全部</option>";
    if(allFalse){
        op = "";
    }
    HH.post(api, info, function (data) {
        if (data.DataBag) {
            var myJson = data.DataBag;
            var val1, val2;
            $.each(myJson, function (i, v) {
                if (param1) {
                    val1 = v[param1];
                } else {
                    val1 = v;
                }
                if (param2) {
                    val2 = v[param2];
                } else {
                    val2 = v;
                }
                op = op + "<option value='" + val1 + "'>" + val2 + "</option>";
            });
            $(node).html(op);
            if (value) {
                $(node).val(value);
            }
            if (method) {
                method();
            }
        } else {
            console.log("缺少dataBag参数！")
        }
    });
};

//下面是封装的年月日
//node：对应输入框节点
//start：默认打开时间，可以不传
//ishour：是否显示时分秒，传布尔值
function dataPick(node, start ,ishour,endtime) {
    var startDate;
    var format;
    var view;
    var endTime;
    if (!start) {
        startDate = new Date();
    } else {
        startDate = start;
    }
    if(ishour){
        format = 'yyyy/mm/dd hh:ii:ss';
        view = 0;
    }else{
        format = 'yyyy/mm/dd';
        view = 2;
    }
    if(endtime){
        endTime = endtime;
    }else{
        endTime = "";
    }
    $(node).datetimepicker({
        format: format,//日期格式
        weekStart: 1,//一周从那天开始
        autoclose: true,//选中之后自动隐藏日期选择框
        startView: 2,//选完时间首先显示的视图（年月日）
        endDate: endTime,//可选的结束时间
        minView: view,//日期时间选择器所能够提供的最精确的时间选择视图。
        forceParse: true,//你输入的可能不正规，但是它会强制尽量解析成你规定的格式（format）
        language: 'zh-CN',
        initialDate: startDate,
        todayHighlight: true,
        todayBtn: true
    });
};

//获取图片url
function getObjectURL(file) {
    var url = null;
    if (window.createObjectURL != undefined) {
        url = window.createObjectURL(file)
    } else if (window.URL != undefined) {
        url = window.URL.createObjectURL(file)
    } else if (window.webkitURL != undefined) {
        url = window.webkitURL.createObjectURL(file)
    }
    return url
};

//创建页码
//node：目标节点，支持jquery选择器
//nowNum：当前页码
//allNum：总共页码
function createPaging(node, nowNum, numCount) {

    var nowNum = parseInt(nowNum);
    var allNum = Math.ceil(parseInt(numCount) / 20);

    if (allNum == 0) {
        allNum = 1
    }

    var mess = '<div class="dataCount">总共'+numCount+'条记录</div>';

    var op = '<ul class="pagination"><li class="upPage"><a>&laquo;</a></li>';

    if (allNum < 12) {
        for (var i = 1; i <= allNum; i++) {
            if (nowNum == i) {
                op = op + '<li class="active pageNum"><a>' + i + '</a></li>';
            } else {
                op = op + '<li class="pageNum"><a>' + i + '</a></li>';
            }
        }
    } else {
        if (nowNum < 3) {
            for (var i = 1; i <= 5; i++) {
                if (nowNum == i) {
                    op = op + '<li class="active pageNum"><a>' + i + '</a></li>';
                } else {
                    op = op + '<li class="pageNum"><a>' + i + '</a></li>';
                }
            }
            op = op + '<li class="disabled"><a>...</a></li>';
            for (var i = allNum - 4; i <= allNum; i++) {
                if (nowNum == i) {
                    op = op + '<li class="active pageNum"><a>' + i + '</a></li>';
                } else {
                    op = op + '<li class="pageNum"><a>' + i + '</a></li>';
                }
            }
        } else {
            if (allNum - nowNum <= 7) {
                op = op + '<li class="pageNum"><a>1</a></li><li class="pageNum"><a>2</a></li><li class="pageNum"><a>3</a></li><li class="disabled"><a>...</a></li>';
                for (var i = allNum - 7; i <= allNum; i++) {
                    if (nowNum == i) {
                        op = op + '<li class="active pageNum"><a>' + i + '</a></li>';
                    } else {
                        op = op + '<li class="pageNum"><a>' + i + '</a></li>';
                    }
                }

            } else {
                for (var i = nowNum - 2; i <= nowNum + 2; i++) {
                    if (nowNum == i) {
                        op = op + '<li class="active pageNum"><a>' + i + '</a></li>';
                    } else {
                        op = op + '<li class="pageNum"><a>' + i + '</a></li>';
                    }
                }
                op = op + '<li class="disabled"><a>...</a></li>';
                for (var i = allNum - 4; i <= allNum; i++) {
                    if (nowNum == i) {
                        op = op + '<li class="active pageNum"><a>' + i + '</a></li>';
                    } else {
                        op = op + '<li class="pageNum"><a>' + i + '</a></li>';
                    }
                }
            }

        }

    }

    op = op + '<li class="downPage"><a>&raquo;</a></li></ul>';

    var foo = "<div>" + mess + op + "</div>";

    $(node).html(foo);

}

//文档类型文件上传设置
function wordFileChange(target) {
    var fileSize = 0;
    var userAgent = navigator.userAgent;
    var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera;
    if (isIE && !target.files) {
        var filePath = target.value;
        var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
        var file = fileSystem.GetFile(filePath);
        fileSize = file.Size;
    } else {
        fileSize = target.files[0].size;
    }
    var size = (fileSize / 1024) / 1024;
    if (size > 20) {
        alert("文件不能大于20M");
        target.value = "";
        return false
    }
    var name = target.value;
    var fileName = name.substring(name.lastIndexOf(".") + 1).toLowerCase();
    if (fileName != "doc" && fileName != "docx" && fileName != "wps" && fileName != "ppt" && fileName != "pdf" && fileName != "xls" && fileName != "xlm" && fileName != "xlsx" && fileName != "xml" && fileName != "txt") {
        alert("请选择文档格式文件上传！");
        target.value = "";
        return false
    }
    return true
}

//图片类型文件上传设置
function imgFileChange(target) {
    var fileSize = 0;
    var userAgent = navigator.userAgent;
    var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera;
    if (isIE && !target.files) {
        var filePath = target.value;
        var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
        var file = fileSystem.GetFile(filePath);
        fileSize = file.Size;
    } else {
        fileSize = target.files[0].size;
    }
    var size = (fileSize / 1024) / 1024;
    if (size > 20) {
        alert("文件不能大于20M");
        target.value = "";
        return false
    }
    var name = target.value;
    var fileName = name.substring(name.lastIndexOf(".") + 1).toLowerCase();
    if (fileName != "png" && fileName != "jpg" && fileName != "jpeg" && fileName != "bmp" && fileName != "gif") {
        alert("请选择图片格式文件上传(png,jpg,jpeg,bmp,gif)！");
        target.value = "";
        return false
    }
    return true
}

//文件上传按钮处理方法
//node：input节点
//type：上传文件类型（file为文档类型，img为图片类型）
function fileUp(node, type) {
    if (type == "file") {
        wordFileChange(node);
    } else if (type == "img") {
        imgFileChange(node);
    }
    var file = $(node).val().split("\\");
    file = file[file.length - 1];
    $(node).parent().prev().text(file);
}