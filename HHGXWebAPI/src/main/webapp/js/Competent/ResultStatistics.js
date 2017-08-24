(function(){

    //局部刷新
    function pageReload() {

        var startTime = $("#startDate").find("input").val();
        var endTime = $("#stopDate").find("input").val();

        var info = {
            ManagerOrgID : sessionStorage.getItem("OrgID"),
            startTime : startTime,
            endTime : endTime
        };

        HH.post("/ManageOrgInfo/AlarmCencus", info, function (data) {
            var myJson = data.DataBag;
            var xList = [];
            var yList = [];
            var yMax = 0;
            $.each(myJson,function(i,v){
                yMax = yMax + v.count;

                xList.push(v.checkresult);
                yList.push(v.count);
            });

            var dataShadow = [];

            for (var i = 0; i < myJson.length; i++) {
                dataShadow.push(yMax);
            }

            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('in_page'));

            // 指定图表的配置项和数据
            var option = {
                title: {},
                tooltip: {},
                legend: {},
                xAxis: {
                    name:"火警类别",
                    data: xList,
                    axisLabel: {
                        //inside: true,
                        textStyle: {
                            fontSize:18,
                            fontWeight:"bold"
                        }
                    },
                    axisTick: {
                        show: false
                    },
                    axisLine: {
                        show: false
                    },
                    z: 10
                },
                yAxis: {
                    name:"处理次数",
                    max:yMax
                },
                series: [
                    { // For shadow
                        type: 'bar',
                        itemStyle: {
                            normal: {color: 'rgba(0,0,0,0.05)'}
                        },
                        barGap:'-100%',
                        barCategoryGap:'40%',
                        data: dataShadow,
                        animation: false
                    },{
                    name: '数量',
                    type: 'bar',
                    data: yList,
                    itemStyle:{
                        normal:{
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    {offset: 0, color: '#83bff6'},
                                    {offset: 0.5, color: '#188df0'},
                                    {offset: 1, color: '#188df0'}
                                ]
                            )
                        },
                        emphasis: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    {offset: 0, color: '#2378f7'},
                                    {offset: 0.7, color: '#2378f7'},
                                    {offset: 1, color: '#83bff6'}
                                ]
                            )
                        }
                    }
                }],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross'
                    },
                    backgroundColor: 'rgba(0, 0, 0, 0.8)',
                    borderWidth: 1,
                    borderColor: '#ccc',
                    padding: 10,
                    textStyle: {
                        color: '#ffffff'
                    },
                    position: function (pos, params, el, elRect, size) {
                        var obj = {top: 10};
                        obj[['left', 'right'][+(pos[0] < size.viewSize[0] / 2)]] = 30;
                        return obj;
                    },
                    extraCssText: 'width: 170px'
                }
            };

            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);

        });

    };

    dataPick("#startDate");
    dataPick("#stopDate");

    //查询按钮
    $("#check_btn").click(function () {
        pageReload()
    });

    $("#check_btn").click();

})();