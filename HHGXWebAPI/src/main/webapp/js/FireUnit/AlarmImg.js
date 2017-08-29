/**
 * Created by Qiu on 2017/8/21.
 */
(function(){
    function judgeStatus(){
        if(sessionStorage.getItem("imFlatPicStatus")=="default"){
            $("#imFlatPicImg").attr("xlink:href","");
            $("#imFlatPicImg").attr("src","");
            $("#imFlatPicImg").attr("xlink:href","../../image/origin/watching.jpg");
            $("#imFlatPicImg").attr("src","../../image/origin/watching.jpg");

        }else {
            $("#imFlatPicImg").attr("xlink:href", "");
            $("#imFlatPicImg").attr("src", "");
            $("#imFlatPicImg").attr("xlink:href", ImgUrl + "" + sessionStorage.getItem("imFlatPic"));
            $("#imFlatPicImg").attr("src", ImgUrl + "" + sessionStorage.getItem("imFlatPic"));

        }

        var image = document.createElementNS('http://www.w3.org/2000/svg','image');
        //image.setAttributeNS(null,"src","../../image/origin/logoBig.png");
        image.setAttributeNS(null,'width','20');
        image.setAttributeNS(null,'height','20');
        image.setAttributeNS(null,"href","../../image/origin/red.gif");
        image.setAttributeNS(null,'x',myAllData.DataBag[0].fPositionX+"%");
        image.setAttributeNS(null,'y',myAllData.DataBag[0].fPositionY+"%");
        image.setAttributeNS(null, 'visibility', 'visible');
        image.setAttributeNS(null,'class','img');
        image.setAttributeNS(null,'data-toggle','tooltip');
        image.setAttributeNS(null,'title','Ĭ�ϵ� Tooltip');
        console.log(image);
        //$('#svgContainer').append($(image));
        document.getElementById('svgContainer').appendChild(image);

    }
    function addImgFunc(){

    }


    judgeStatus();
    //alert(sessionStorage.getItem("imFlatPic"));
    window.setInterval(function () {
        judgeStatus();
        console.log(sessionStorage.getItem("imFlatPicStatus"));
        //location.reload();
    }, 5000);

    //����Ŵ����С��ť�¼�
    /*var big = $("#big");
    var small = $("#small");
    big.click(function(){
        //alert('sadf');
        showBig("imFlatPicSvg");
    });
    small.click(function(){
        showSmall("imFlatPicSvg");
    });
    posMove("imFlatPicSvg","imFlatPicImgDiv");*/



})();

function posMove(svgid,svgdivid) {
    var svgObj = document.getElementById(svgid);//svg
    //console.log(oDiv);
    var svgDivObj = document.getElementById(svgdivid);//��������ƿ�ߵ�div
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

//����Ŵ�ť
function showBig(svgContainer){

    var svg = document.getElementById(svgContainer);//����õ��ľ���ͼƬ����
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
        //�����е�Բ�뾶��С
        $(".circles").attr("r",circleR);
    }

}
//�����С��ť
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
        //�����е�Բ�뾶��С
        $(".circles").attr("r",circleR);
    }
}


