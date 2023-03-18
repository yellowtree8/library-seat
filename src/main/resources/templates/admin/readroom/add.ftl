<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>${siteName!""}|阅读室管理-添加阅读室</title>
<#include "../common/header.ftl"/>

</head>

<body>
<div class="lyear-layout-web">
    <div class="lyear-layout-container">
        <!--左侧导航-->
        <aside class="lyear-layout-sidebar">

            <!-- logo -->
            <div id="logo" class="sidebar-header">
                <a href="index.html"><img src="/admin/images/logo-sidebar.png" title="${siteName!""}" alt="${siteName!""}" /></a>
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
                            <div class="card-header"><h4>添加阅览室</h4></div>
                            <div class="card-body">
                                <form action="/readType/save" id="read-add-form" method="post" class="row">
                                    <div class="input-group m-b-10">
                                        <span class="input-group-addon">阅览室名称</span>
                                        <input type="text" class="form-control required" id="name" name="name" value="" placeholder="请输入阅览室名称" tips="请填写阅览室名称" />
                                    </div>
                                    </thead>
                                    <tbody>
                                    <div class="input-group m-b-10">
                                        <span class="input-group-addon">阅览室行数</span>
                                        <input type="number" class="form-control required" id="row" name="row" value="" oninput="this.value = this.value.replace(/[^0-9]/g, 1)" placeholder="请输入阅览室行数" tips="阅览室行数不能为空且只允许填写数字"/>
                                    </div>
                                    <div class="input-group m-b-10">
                                        <span class="input-group-addon">阅览室列数</span>
                                        <input type="number" class="form-control required" id="lie" name="lie" value="" oninput="this.value = this.value.replace(/[^0-9]/g, 1)" placeholder="请输入阅览室列数" tips="阅览室列数不能为空且只允许填写数字"/>
                                    </div>

                                    <div class="input-group m-b-10">
                                        <span class="input-group-addon">类型</span>
                                        <select name="readingType.id" class="form-control" id="readingType">
                    	<#list readType as type>
                            <option value="${type.id}">${type.name}</option>
                        </#list>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <button type="button" class="btn btn-primary ajax-post" id="add-form-submit-btn">确 定</button>
                                        <button type="button" class="btn btn-default" onclick="javascript:history.back(-1);return false;">返 回</button>
                                    </div>
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
<script type="text/javascript">
    $(document).ready(function(){
        //提交按钮监听事件
        $("#add-form-submit-btn").click(function(){
            if(!checkForm("read-add-form")){
                return;
            }
            var data = $("#read-add-form").serialize();
            $.ajax({
                url:'/readRoom/save',
                type:'POST',
                data:data,
                dataType:'json',
                success:function(data){
                    if(data.code == 0){
                        showSuccessMsg('阅览室添加成功!',function(){
                            window.location.href = '/readRoom/list';
                        })
                    }else{
                        showErrorMsg(data.msg);
                    }
                },
                error:function(data){
                    alert('网络错误!');
                }
            });
        });
    });

</script>
</body>
</html>