<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
    <title>${siteName!""}|违规人数-${title!""}</title>
    <#include "../common/header.ftl"/>
    <style>
        td {
            vertical-align: middle;
        }
    </style>

</head>

<body>
<div class="lyear-layout-web">
    <div class="lyear-layout-container">
        <!--左侧导航-->
        <aside class="lyear-layout-sidebar">

            <!-- logo -->
            <div id="logo" class="sidebar-header">
                <a href="index.html"><img src="/admin/images/logo-sidebar.png" title="${siteName!""}"
                                          alt="${siteName!""}"/></a>
            </div>
            <div class="lyear-layout-sidebar-scroll">
                <#include "../common/left-menu.ftl"/>
            </div>

        </aside>
        <!--End 左侧导航-->

        <#include "../common/header-menu.ftl"/>

        <!--页面主要内容-->
        <main class="lyear-layout-content">

            <div class="container-fluid">

                <div class="row">
                    <div class="col-sm-12 col-lg-12">
                        <div id="violate" style="height: 800px"></div>
                    </div>

                </div>

        </main>
        <!--End 页面主要内容-->
    </div>
</div>
<#include "../common/footer.ftl"/>
<script type="text/javascript" src="/admin/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="/admin/js/main.min.js"></script>
<script type="text/javascript" src="/admin/js/echarts/echarts.min.js"></script>
<script type="text/javascript">

    // 基于准备好的dom，初始化echarts实例
    var violateChart = echarts.init(document.getElementById('violate'));

    $(document).ready(function () {
        var a = new Array();
        var name = new Array();
        $.ajax({
            url: '/statistic/statisticsMap',
            async: true,
            cache: false,
            dataType: "json",
            success: function (data) {
                for (var key in data.data) {
                     a.push({type:'bar',name:key,barGap:'5%',data:data.data[key],itemStyle: {
                             normal: {
                                 label: {
                                     show: true, //开启显示
                                     position: 'top', //在上方显示
                                     textStyle: { //数值样式
                                         color: 'black',
                                         fontSize: 12
                                     }
                                 }
                             }

                         }}) ;
                     name.push({key});
                }
                console.log(a)
                violateChart.setOption({
                    xAxis: {
                        data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
                        name: "月份",
                    },
                    legend:name,
                    series: a


                });
                // 设置加载等待隐藏
                violateChart.hideLoading();

            }
        });
        // 显示标题，图例和空的坐标轴
        violateChart.setOption({
            color: ['#ff2495','#245bff','#8aff24','#ff7c24','#CCFF33','#33CC99','#009966','#2244FF','#999955','#9999CC','#FF66CC','#DD55CC'],

            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            series: name,
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {
                data: [],
                axisTick: {
                    alignWithLabel: true
                }

            },
            yAxis: [
                {
                    minInterval: 1,
                    type: 'value',
                }
            ],
            series: a
        })
    });


</script>


</body>
</html>