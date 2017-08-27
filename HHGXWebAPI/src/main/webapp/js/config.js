﻿var BaseUrl = "http://"+window.location.host;
var HtmlUrl = BaseUrl+"/html";
var CssUrl = BaseUrl+"/css";
var JsUrl = BaseUrl+"/js";

var ApiUrl = BaseUrl+"/HHGXWebAPI";
var ImgUrl = BaseUrl;

var people = {
    "消防控制室操作人员":{
        "PeoplePicPath":false,
        "PeopleName":true,
        "sex":true,
        "job":true,
        "identification":true,
        "birthday":true,
        "certificateID":true,
        "education":true,
        "department":true,
        "WorkBeginDate":true,
        "YnTraining":true,
        "trainingTime":true,
        "GetDate":true,
        "YnEscapeLeader":true,
        "OnDutyArea":true,
        "OrderNum":true
    },
    "社会单位消防安全管理人":{
        "PeoplePicPath":true,
        "PeopleName":true,
        "sex":true,
        "job":true,
        "identification":true,
        "birthday":true,
        "certificateID":true,
        "YnTraining":true,
        "tel":true,
        "department":true
    },
    "社会单位消防安全责任人":{
        "PeoplePicPath":true,
        "PeopleName":true,
        "sex":true,
        "job":true,
        "identification":true,
        "birthday":true,
        "certificateID":true,
        "YnTraining":true,
        "tel":true,
        "issuedate":true,
        "department":true
    },
    "专（兼）职消防安全管理人员":{
        "PeoplePicPath":false,
        "PeopleName":true,
        "sex":true,
        "job":true,
        "identification":true,
        "birthday":true,
        "certificateID":true,
        "YnTraining":true,
        "issuedate":true,
        "OrderNum":true,
        "department":true
    }
};