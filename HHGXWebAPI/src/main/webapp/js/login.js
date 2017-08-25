(function(){

    //获取当前的浏览器信息
    var sys = getBrowserInfo();
    //sys.browser得到浏览器的类型，sys.ver得到浏览器的版本
    if(sys.browser=="msie"&&parseInt(sys.ver)<9){
        alert("当前IE浏览器的版本是：IE" + parseInt(sys.ver)+"，请升级到IE9及以上版本");
    }

    //设置验证码图片路径
    $('#yzm').click(function(){
        $('#yzm').prop('src',ApiUrl+'/UserManager/Code?'+Math.random());
    });
    $('#yzm').click();

    //设置提示信息隐藏
    $("#login_yzmErro").css('display',"none");

    //返回按钮
    $("#login_back").click(function(){
        location.href = HtmlUrl + "/loginChoice.html"
    });

    //点击上边的登录按钮
    $("#loginDivBtn").click(function(){
        chooseLogin();
    });
    function chooseLogin(){
        $("#loginDivBtn").addClass("login_active");
        $("#reginDivBtn").removeClass("login_active");

        $(".regin_page").css("visibility","hidden");
        $(".login_page").css("visibility","visible");
    }
    //点击上边的注册按钮
    $("#reginDivBtn").click(function(){
        //先清空以前写过的
        $("#company_name").val("");
        $("#regin_u_name").val("");
        $("#regin_u_code").val("");
        $("#regin_u_pwd").val("");
        $("#regin_pwdErro").text("");

        $("#loginDivBtn").removeClass("login_active");
        $("#reginDivBtn").addClass("login_active");

        $(".login_page").css("visibility","hidden");
        $(".regin_page").css("visibility","visible");

        //获取省市区数据对象
        var shenObj = area;
        //console.log(shenObj);
        //添加省节点
        var node1="";
        $.each(shenObj,function(i,v){
            node1=node1+"<option value="+i+">"+ v.AreaName+"</option>";
        });
        $("#province").html(node1);
        $("#province").change(function(){
            shiChange();
        });
        //市改变事件
        function shiChange(){
            var shenVal = $("#province").val();
            //console.log(shenVal);
            var shiArr = shenObj[shenVal].child;

            var node2=""
            $.each(shiArr,function(i,v){
                node2=node2+"<option value="+i+">"+ v.AreaName+"</option>";
            });
            $("#city").html(node2);

            quChange();
        }
        shiChange();
        $("#city").change(function(){
            quChange();
        });
        //区改变事件
        function quChange(){
            var shenVal = $("#province").val();
            var shiVal = $("#city").val();
            var quArr = shenObj[shenVal].child[shiVal].child;

            var node3=""
            $.each(quArr,function(i,v){
                node3=node3+"<option value="+i+">"+ v.AreaName+"</option>";
            });
            $("#area").html(node3);
        }

        //点击获得验证码
        $("#getTelCodeBtn").get(0).onclick=function(){
            var temp = {
                "UserPoneNo":$("#regin_u_name").val()
            };
            HH.post("/UserManager/RegistMessage",temp,function(data){
                console.log('手机验证码返回数据');
                console.log(data);
                if(data.StateMessage==1000){
                    setTelCodeFunc();
                }
                sessionStorage.setItem("yzm",data.DataBag);
            });
        }
    });
    //设置手机获取验证码按钮
    function setTelCodeFunc(){
        $("#getTelCodeBtn").attr("disabled",true);
        var timeSecond = 60;
        $("#getTelCodeBtn").text(timeSecond+"S");
        var timeInterval = window.setInterval(function(){
            timeSecond = timeSecond - 1;
            //var timeRes = timeSecond;
            $("#getTelCodeBtn").text(timeSecond+"S");
            if(timeSecond==0){
                window.clearInterval(timeInterval);
                $("#getTelCodeBtn").text("获取");
                $("#getTelCodeBtn").css({
                    "background-color":"#4A90E2",
                    "color":"#FFFFFF"
                });
                $("#getTelCodeBtn").attr("disabled",false);
            }
        },1000);
        $("#getTelCodeBtn").css({
            "background-color":"#A0A0A0",
            "color":"white"
        });
    }

    //点击登录的时候判断
    $("#login_okbtn").click(function(){
        var u_name = $("#u_name");//手机号
        var u_pwd = $("#u_pwd");//密码
        var u_code = $("#u_code");//验证码

        var loginTel = u_name.val();
        var loginPwd = u_pwd.val();
        var loginCode = u_code.val();
        //alert(loginCode);
        var login_telErro = $("#login_telErro");
        var login_mimaErro = $("#login_mimaErro");
        var login_yzmErro = $("#login_yzmErro");

        var telStatus = judgeTel(loginTel);
        var pwdStatus = judgePwd(loginPwd);
        var codeStatus = judgePwd(loginCode);

        if(telStatus=="ok" || telStatus=="erro"){
            if(pwdStatus=="ok"){
                if(codeStatus=="ok"){
                    codeStatus = loginCode;
                    //测试假的数据
                    var obj = {
                        "username":loginTel,
                        "password":loginPwd,
                        "code":codeStatus
                    };
                    //console.log(obj);
                    //render("#doData","#targetData",obj);
                    $.ajax({
                        type:"GET",
                        url:ApiUrl+"/UserManager/LoginBy",
                        data:obj,
                        dataType:"json",
                        success:function(data){
                            //console.log(JSON.parse(data));
                            //-256不成功
                          //  console.log("登录返回数据");
                          //  console.log(data);
                            if(data.StateMessage==1000){
                                document.cookie = "UserId="+encodeURI(data.DataBag.tokenID)+"; path=/";
                                window.location.href="./html/main.html";
                            }else if(data.StateMessage==-2){
                                //console.log(data.DataBag);
                                $("#login_mimaErro").text("密码错误");
                                $("#login_mimaErro").css('display',"block");
                                return;
                            }else if(data.DataBag=="您输入的验证码不正确！"){
                                $("#login_yzmErro").text("您输入的验证码有错");
                                $("#login_yzmErro").css('display',"block");
                                $('#yzm').click();
                                return;
                            }else if(data.DataBag=="没有用户 请注册"){
                                $("#login_yzmErro").text("用户名或密码错误!");
                                $("#login_yzmErro").css('display',"block");
                                return;
                            }
                        },
                        error:function(XMLHttpRequest, textStatus, errorThrown){

                        }
                    });

                }else{
                    login_yzmErro.text("验证码不能为空");
                    login_yzmErro.css("display","block");
                    u_code.focus();
                    u_code.blur(function () {
                        var loginCode = u_code.val();
                        if(judgePwd(loginCode)=="ok"){
                            //u_pwd.focus();
                            login_yzmErro.text("");
                            login_yzmErro.css("display","none");
                        }else{
                            //alert('dsf');
                            u_code.focus();
                            login_yzmErro.text("密码不能为空");
                            login_yzmErro.css("display","block");
                        }
                    });
                }
            }else{//这里是密码的判断
                login_mimaErro.text("密码不能为空");
                login_mimaErro.css("display","block");
                u_pwd.focus();
                u_pwd.blur(function () {
                    var loginPwd = u_pwd.val();
                    if(judgePwd(loginPwd)=="ok"){
                        //u_pwd.focus();
                        login_mimaErro.text("");
                        login_mimaErro.css("display","none");
                    }else{
                        //alert('dsf');
                        u_pwd.focus();
                        login_mimaErro.text("密码不能为空");
                        login_mimaErro.css("display","block");
                    }
                });
            }

        }else{//这里是用户名的判断
            login_telErro.text("请输入正确的号码格式");
            login_telErro.css("display","block");
            u_name.focus();
            u_name.blur(function () {
                var loginTel = u_name.val();
                if(judgeTel(loginTel)=="ok" || judgeTel(loginTel)=="erro"){
                    //u_pwd.focus();
                    login_telErro.text("");
                    login_telErro.css("display","none");
                }else{
                    //alert('dsf');
                    u_name.focus();
                    login_telErro.text("请输入正确的号码格式");
                    login_telErro.css("display","block");
                }
            });
        }

    });

    function judgeTel(str){
        var re = /^1\d{10}$/;
        re = /0?(13|14|15|18)[0-9]{9}/;
        if(str==""){
            return "empty";
        }else if (re.test(str)) {
            return "ok";
        }else{
            return "erro";
        }
    }
    function judgePwd(str){
        if(str==""){
            return "empty";
        }else{
            return "ok";
        }
    }


    //点击注册的时候判断
    var selectedIndex = "";
    var u_type = $("#u_type");
    $("#regin_okbtn").get(0).onclick=function(){
        $("#regin_pwdErro").text("");
        var province = $("#province option:selected").text();
        var city = $("#city option:selected").text();
        var area = $("#area option:selected").text();
      //  console.log(province)
       // console.log(city)
        //console.log(area)
        //if(selectedIndex=="" || province=="请选择省份" || area=="请选择市"){
            if(selectedIndex==""){
                //alert("请选择用户类型");
                $("#regin_pwdErro").text("请选择用户类型");
                $("#regin_pwdErro").css("display","block");
                return;
            }/*if(province=="请选择省份"){
                alert("请选择省份");
                return;
            }if(city=="请选择市"){
                alert("请选择市");
                return;
            }*/
            //return;
        //}else{
            var selectedValue = u_type.get(0).options[selectedIndex].value;

            var u_name = $("#regin_u_name");//手机号
            var u_pwd = $("#regin_u_pwd");//密码
            var u_code = $("#regin_u_code");//验证码
            var company = $("#company_name");//公司名字

            var loginTel = u_name.val();//注册手机号
            var loginPwd = u_pwd.val();//密码
            var loginCode = u_code.val();//验证码
            var companyName = company.val();//公司名字
            var areaValue = $("#area").val();

            var login_telErro = $("#regin_telErro");
            var login_mimaErro = $("#regin_pwdErro");
            var login_yzmErro = $("#regin_yzmErro");

            var telStatus = judgeTel(loginTel);//判定手机号
            var pwdStatus = judgePwd(loginPwd);//判定密码
            var codeStatus = judgePwd(loginCode);//判定验证码
            var companyStatus = judgePwd(companyName);//判定公司名字

            if(companyStatus=="ok"){
                if(telStatus=="ok"){
                    //var regin_u_code = $("#regin_u_code").val();
                    /*if(regin_u_code!=sessionStorage.getItem("yzm")){
                        $("#regin_pwdErro").text("验证码不正确");
                        return;
                    }*/
                    if(codeStatus=="ok"){
                        if(pwdStatus=="ok"){
                            if($("#checks").prop("checked")==false){
                                //alert("请阅读使用协议");
                                $("#regin_pwdErro").text("请阅读使用协议");
                                return;
                            }
                            var data = {
                                "username":loginTel,
                                "password":loginPwd,
                                "orgname":companyName,
                                "AreaID":areaValue,
                                "verifycode":loginCode,
                                "UserBelongTo":selectedValue
                            };
                            var myData = {
                                tokenUUID: "",
                                infoBag: data
                            };
                            console.log(myData);
                         //   console.log(myData);
                            $.ajax({
                                type:"POST",
                                url:ApiUrl+"/UserManager/RegisterNew",
                                data:JSON.stringify(myData),
                                dataType:"json",
                                success:function(datas){
                               //     console.log(datas);
                                    //-256不成功
                                //    console.log("登录返回数据");
                                    if(datas.StateMessage==1000){
                                        $("#gotoModal").modal({backdrop:"static"});
                                        var gotoTime = 3;
                                        $("#gotoTime").text(gotoTime);
                                        var gotoInterval = window.setInterval(function(){
                                            gotoTime = gotoTime - 1;
                                            $("#gotoTime").text(gotoTime);
                                            if(gotoTime==0){
                                                window.clearInterval(gotoInterval);
                                                $("#gotoModal").modal("hide");
                                                chooseLogin();
                                            }
                                        },1000);
                                        $("#gotoModalConfirm").get(0).onclick=function(){
                                            $("#gotoModal").modal("hide");
                                            chooseLogin();
                                        };

                                    }else if(datas.StateMessage==-1 && datas.DataBag.code==1){
                                        //alert('asdf');
                                        //$("#regin_pwdErro").text('');
                                        $("#regin_pwdErro").text("此账号已注册，请重新注册");
                                        return;
                                    }else if(datas.StateMessage==-1 && datas.DataBag.code==2){
                                        $("#regin_pwdErro").text("验证码为空，请先获取验证码");
                                        return;
                                    }else if(datas.StateMessage==-1 && datas.DataBag.code==3){
                                        $("#regin_pwdErro").text("验证码不正确");
                                        return;
                                    }
                                    else{
                                        alert('注册失败请重新注册');
                                        return;
                                    }
                                },
                                error:function(XMLHttpRequest, textStatus, errorThrown){
                                    alert('程序出错');
                                  //  console.log(XMLHttpRequest);
                                  //  console.log(textStatus);
                                   // console.log(errorThrown);
                                }
                            });

                        }else{//这里是密码的判断
                            $("#regin_pwdErro").text("密码不能为空");
                            //login_mimaErro.text("密码不能为空");
                            //login_mimaErro.css("display","block");
                            u_pwd.focus();
                            u_pwd.blur(function () {
                                var loginPwd = u_pwd.val();
                                if(judgePwd(loginPwd)=="ok"){
                                    //u_pwd.focus();
                                    login_mimaErro.text("");
                                    login_mimaErro.css("display","none");
                                }else{
                                    //alert('dsf');
                                    u_pwd.focus();
                                    //login_mimaErro.text("密码不能为空");
                                    //login_mimaErro.css("display","block");
                                }
                            });
                        }
                    }else{
                        $("#regin_pwdErro").text("验证码不能为空");
                        //login_yzmErro.css("display","block");
                        u_code.focus();
                        u_code.blur(function () {
                            var loginCode = u_code.val();
                            if(judgePwd(loginCode)=="ok"){
                                //u_pwd.focus();
                                login_yzmErro.text("");
                                login_yzmErro.css("display","none");
                            }else{
                                //alert('dsf');
                                u_code.focus();
                                //login_yzmErro.text("密码不能为空");
                                //login_yzmErro.css("display","block");
                            }
                        });
                    }
                }else{//这里是用户名的判断
                    /*login_telErro.text("请输入正确的号码格式");
                    login_telErro.css("display","block");*/
                    $("#regin_pwdErro").text("请输入正确的号码格式");
                    u_name.focus();
                    u_name.blur(function () {
                        var loginTel = u_name.val();
                        if(judgeTel(loginTel)=="ok"){
                            //u_pwd.focus();
                            login_telErro.text("");
                            login_telErro.css("display","none");
                        }else{
                            //alert('dsf');
                            u_name.focus();
                            /*login_telErro.text("请输入正确的号码格式");
                            login_telErro.css("display","block");*/
                            $("#regin_pwdErro").text("请输入正确的号码格式");
                        }
                    });
                }
            }else{
                $("#regin_pwdErro").text("公司名字不能为空");
                //$("#regin_pwdErro").css("display","block");
            }
        //}
    }
    //注册里面的下拉框改变事件
    u_type.change(function(){
        selectedIndex = this.selectedIndex;
    });

    // 用户点击眼睛的时候看得见密码
    var showPwdIcon = $("#showPwdIcon");
    var flagShowPwd = "hide";
    showPwdIcon.click(function () {
        var regin_u_pwd = $("#regin_u_pwd");
        if (flagShowPwd == "hide") {
            regin_u_pwd.get(0).type = "text";
            flagShowPwd = "show";
        }else if(flagShowPwd=="show"){
            regin_u_pwd.get(0).type = "password";
            flagShowPwd = "hide";
        }

    });

})();





