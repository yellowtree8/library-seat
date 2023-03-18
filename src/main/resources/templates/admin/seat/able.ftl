<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
    <title>${siteName!""}|座位管理-设置座位可用</title>
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

                                <#-- 选座-->
                                <form action="able" id="seat-able-form" method="post" class="row">

                                    <table class="table table-bordered">
                                        <thead>
                                        <#list 1..reading.getRow() as y>
                                            <tr>
                                                <#list seats as seat>
                                                    <#if seat.YAxis=y>
                                                        <th align="center" id="place" value="${seat.getId()}">


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

    function submitSeat(id) {
            $.confirm({
                title: '设置座位状态',
                content: '选择状态',
                buttons: {
                    confirm: {
                        text: '设置不可用',
                        btnClass: 'btn-red',
                        action: function(){
                            $.ajax({
                                url: 'able',
                                type: 'POST',
                                data: {
                                    "id": id ,
                                    "status": 2
                                },
                                dataType: 'json',
                                success: function (data) {
                                    if (data.code == 0) {
                                        showSuccessMsg('修改成功!', function () {
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
                    somethingElse: {
                        text: '设置为可用',
                        btnClass: 'btn-blue',
                        action: function(){
                            $.ajax({
                                url: 'able',
                                type: 'POST',
                                data: {
                                    "id": id ,
                                    "status": 1
                                },
                                dataType: 'json',
                                success: function (data) {
                                    if (data.code == 0) {
                                        showSuccessMsg('修改成功!', function () {
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
                        text: '取消'
                    }
                }
            });


        // $.alert({
        //     title: '设置不可用',
        //     content: '是否选择该座位',
        //     buttons: {
        //         confirm: {
        //             text: '确认',
        //             btnClass: 'btn-primary',
        //             action: function () {
        //                 $.ajax({
        //                     url: 'able',
        //                     type: 'POST',
        //                     data: {
        //
        //                     },
        //                     dataType: 'json',
        //                     success: function (data) {
        //                         if (data.code == 0) {
        //                             showSuccessMsg('修改成功!', function () {
        //                                 window.location.reload();
        //                             })
        //                         } else {
        //                             showErrorMsg(data.msg);
        //                         }
        //                     },
        //                     error: function (data) {
        //                         alert('网络错误!');
        //                     }
        //                 });
        //             }
        //         },
        //         cancel: {
        //             text: '取消',
        //         }
        //     }
        // });
    }

    //监听上传图片按钮
    $("#add-pic-btn").click(function () {
        $("#select-file").click();

    });
</script>
</body>
</html>