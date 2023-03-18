<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
    <title>${siteName!""}|座位管理-选座</title>
    <#include "../common/header.ftl"/>

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
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header"><h4>选座</h4></div>
                            <div class="card-body">

                                <#--日期选择-->
                                <form action="choose" id="date-choose-form" method="get" class="row">
                                    <div class="input-group">
                                        <span class="input-group-addon m-b-3">日期</span>

                                        <input class="form-control js-datepicker m-b-3" type="text" id="time"
                                               style="width: 500px;" placeholder="yyyy-mm-dd" value="${date_time!""}"
                                               data-date-format="yyyy-mm-dd"/>

                                        <input type="number" id="date" id="date" name="date" value="" hidden/>

                                        <div class="input-group m-b-3">
                                            <span class="input-group-addon">时段</span>
                                            <select name="timeCode" class="form-control" id="timeCode">
                                                <option value="1"
                                                        <#if timeCode==1>
                                                            selected="selected"
                                                        </#if>
                                                >上午
                                                </option>
                                                <option value="2"
                                                        <#if timeCode==2>
                                                            selected="selected"
                                                        </#if>
                                                >下午
                                                </option>
                                            </select>
                                        </div>
                                        <input type="number" id="readingId" name="id" value="" hidden>
                                        <span class="input-group-btn">
                            <button class="btn btn-primary" id="date-form-submit-btn">查询</button>
                        </span>
                                    </div>
                                </form>

                                <#-- 选座-->
                                <form action="choose" id="seat-choose-form" method="post" class="row">

                                    <table class="table table-bordered">
                                        <thead>
                                        <#list 1..reading.getRow() as y>
                                            <tr>
                                                <#list seats as seat>
                                                    <#if seat.YAxis=y>
                                                        <th align="center" id="place" value="${seat.getId()}">


                                                            <#if seat.getStatus()==2>
                                                                <input name="seatId" value="${seat.getId()}" type="hidden"/>
                                                                <image id="seatImage"
                                                                        <#if seat.getStatus()==2>
                                                                            src="/admin/images/seat/occupied.png"
                                                                        <#else>
                                                                            src="/admin/images/seat/leisure.png"
                                                                        </#if>
                                                                >
                                                                </image>
                                                                <br>
                                                                ${seat.YAxis}排${seat.XAxis}座
                                                            <#else>
                                                                <a href="#" onclick="submitSeat(${seat.getId()})">
                                                                    <input name="seatId" value="${seat.getId()}" type="hidden"/>
                                                                    <image id="seatImage"
                                                                            <#if seat.getStatus()==2>
                                                                                src="/admin/images/seat/occupied.png"
                                                                            <#else>
                                                                                src="/admin/images/seat/leisure.png"
                                                                            </#if>
                                                                    >
                                                                    </image>
                                                                    <br>
                                                                    ${seat.YAxis}排${seat.XAxis}座
                                                                </a>
                                                            </#if>

                                                        </th>
                                                    </#if>
                                                </#list>
                                            </tr>

                                        </#list>
                                        </thead>

                                    </table>

                                </form>

                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </main>
        <!--End 页面主要内容-->
    </div>
</div>
<#include "../common/footer.ftl"/>
<script type="text/javascript" src="/admin/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="/admin/js/main.min.js"></script>
<script type="text/javascript" src="/admin/js/perfect-scrollbar.min.js"></script>


<!--时间选择插件-->
<script src="/admin/js/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="/admin/js/bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN.min.js"></script>
<script type="text/javascript" src="/admin/js/main.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

    })

    $("#date-form-submit-btn").click(function () {
        if (!checkForm("date-choose-form")) {
            return;
        }

        var urlParam = window.location.search;

        var readingId = urlParam.substring(urlParam.lastIndexOf('=') + 1, urlParam.length);

        var timestamp = Date.parse(new Date($("#time").val()));

        $("#date").val(timestamp);

        $("#readingId").val(readingId);

        $("#date-choose-form").submit();

    });


    function submitSeat(id) {
        $.alert({
            title: '选座',
            content: '是否选择该座位',
            buttons: {
                confirm: {
                    text: '确认',
                    btnClass: 'btn-primary',
                    action: function () {
                        $.ajax({
                            url: 'choose',
                            type: 'POST',
                            data: {
                                "date": Date.parse(new Date($("#time").val())),
                                "timeCode": $("#timeCode").val(),
                                "seatId": id
                            },
                            dataType: 'json',
                            success: function (data) {
                                if (data.code == 0) {
                                    showSuccessMsg('选座成功!', function () {
                                        window.location.reload();
                                    })
                                } else {
                                    showErrorMsg(data.msg);
                                }
                            },
                            error: function (data) {
                                alert('网络错误!');
                            }
                        });
                    }
                },
                cancel: {
                    text: '取消',
                }
            }
        });
    }

    //监听上传图片按钮
    $("#add-pic-btn").click(function () {
        $("#select-file").click();

    });
</script>
</body>
</html>