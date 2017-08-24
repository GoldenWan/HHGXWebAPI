/**
 * Created by Qiu on 2017/8/21.
 */
(function(){
    $("#imFlatPicImg").attr("xlink:href","");
    $("#imFlatPicImg").attr("src","");
    $("#imFlatPicImg").attr("xlink:href",ImgUrl+""+sessionStorage.getItem("imFlatPic"));
    $("#imFlatPicImg").attr("src",ImgUrl+""+sessionStorage.getItem("imFlatPic"));

    //点击放大和缩小按钮事件
    var big = $("#big");
    var small = $("#small");
    big.click(function(){
        //alert('sadf');
        showBig("imFlatPicSvg");
    });
    small.click(function(){
        showSmall("imFlatPicSvg");
    });
    posMove("imFlatPicSvg","imFlatPicImgDiv");



})();

function posMove(svgid,svgdivid) {
    var svgObj = document.getElementById(svgid);//svg
    //console.log(oDiv);
    var svgDivObj = document.getElementById(svgdivid);//最外面控制宽高的div
    //console.log(sent.r);
    drag(svgObj,svgDivObj);
}
function drag(obj,oParent){
    obj.onmousedown = function (ev) {
        //console.log('sfsdf');
        var oEvent = ev || event;
        var sentX = oEvent.clientX - parseInt($(obj).css("left"));
        var sentY = oEvent.clientY - parseInt($(obj).css("top"));

        document.onmousemove = function (ev) {
            //document.onmousemove = function (ev) {
            var oEvent = ev || event;
            var slideLeft = oEvent.clientX - sentX;
            var slideTop = oEvent.clientY - sentY;
            //console.log($(oParent).css("width")+"==="+$(obj).css("width"));
            if (slideLeft >= 0) {
                slideLeft = 0;
            }
            if (slideLeft <= parseInt($(oParent).css("width")) - parseInt($(obj).css("width"))) {
                slideLeft = parseInt($(oParent).css("width")) - parseInt($(obj).css("width"));
            }
            if (slideTop >= 0) {
                slideTop = 0;
            }
            if (slideTop <= parseInt($(oParent).css("height")) - parseInt($(obj).css("height"))) {
                slideTop = parseInt($(oParent).css("height")) - parseInt($(obj).css("height"));
            }
            /*obj.setAttribute("left",slideLeft+"px");
             obj.setAttribute("top",slideTop+"px");*/
            $(obj).css("left", slideLeft + "px");
            $(obj).css("top", slideTop + "px");
            //ev.preventDefault();
            //return false;
        };
        document.onmouseup = function () {
            document.onmousemove = null;
            document.onmouseup = null;
            return;
        }
        return false;
    }
}

//点击放大按钮
function showBig(svgContainer){

    var svg = document.getElementById(svgContainer);//这个得到的就是图片对象
    var w = svg.getAttribute("width");
    // console.log(w);
    w = parseInt(w)+10;
    svg.setAttribute("width",w);

    var h = svg.getAttribute("height");
    h = (parseInt(h)*(w))/(w-10);
    svg.setAttribute("height",h);

    if($(".circles").length>0){
        //var r = $(".circles").eq(0).attr("r");
        circleR = circleR + 0.05;
        //让所有的圆半径变小
        $(".circles").attr("r",circleR);
    }

}
//点击缩小按钮
function showSmall(svgContainer){
    var svg = document.getElementById(svgContainer);
    var w = svg.getAttribute("width");
    w = parseInt(w)-10;
    svg.setAttribute("width",w);

    var h = svg.getAttribute("height");
    //h = parseInt(h)-7;
    h = (parseInt(h)*(w))/(w+10);
    svg.setAttribute("height",h);

    if($(".circles").length>0){
        //var r = $(".circles").eq(0).attr("r");
        circleR = circleR-0.05;
        //让所有的圆半径变小
        $(".circles").attr("r",circleR);
    }
}


