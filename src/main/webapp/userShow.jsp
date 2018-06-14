<%--
  Created by IntelliJ IDEA.
  User: Mr.K
  Date: 2018/6/11
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<body>


<table id="dg" title="studcurd" class="easyui-datagrid" fitColumns="true"
       pagination="true" rownumbers="true"
       url="${pageContext.request.contextPath}/stud/datagrid" fit="true"
       toolbar="#tb">

    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="50" align="center">id</th>
        <th field="name" width="100" align="center">name</th>
        <th field="age" width="50" align="center">age</th>
        <th field="sex" width="50" align="center">sex</th>
        <th field="addr" width="50" align="center">adr</th>

    </tr>
    </thead>
</table>

<div id="tb">
    <div>
        <a href="javascript:openUserAddDialog()" class="easyui-linkbutton"
           iconCls="icon-add" plain="true">添加</a> <a
            href="javascript:openUserModifyDialog()" class="easyui-linkbutton"
            iconCls="icon-edit" plain="true">修改</a> <a
            href="javascript:deleteUser()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">删除</a>
    </div>
<div>
    &nbsp;用户名：&nbsp;<input type="text" id="s_name" size="20"
                           onkeydown="if(event.keyCode==13) searchUser()"/> <a
        href="javascript:searchUser()" class="easyui-linkbutton"
        iconCls="icon-search" plain="true">搜索</a>
</div>
</div>

<div id="dlg" class="easyui-dialog"
     style="width: 620px;height:300px;padding: 10px 20px" closed="true"
     buttons="#dlg-buttons">
    <form id="fm" method="post">
        <table cellspacing="8px">
            <tr>
                <td>用户名：</td>
                <td><input type="text" id="name" name="name"
                           class="easyui-validatebox" required="true"/>&nbsp;<font
                        color="red">*</font>
                    <input type="text" id="id" name="id"
                           class="easyui-validatebox" required="true"/>&nbsp;<font
                            color="red">*</font>
                </td>
            </tr>
            <tr>
                <td>年龄：</td>
                <td><input type="text" id="age" name="age"
                           class="easyui-validatebox" required="true"/>&nbsp;<font
                        color="red">*</font>
                </td>
            </tr>
            <tr>
               <td>性别：</td>
                <td><input type="text" id="sex" name="sex"
                           class="easyui-validatebox" required="true"/>&nbsp;<font
                        color="red">*</font>
                </td>

            </tr>
            <tr>
                <td>地址：</td>
                <td><input type="text" id="addr" name="addr"
                           class="easyui-validatebox" required="true"/>&nbsp;<font
                        color="red">*</font>
                </td>
            </tr>

        </table>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:saveUser()" class="easyui-linkbutton"
       iconCls="icon-ok">保存</a>
    <a href="javascript:closeUserDialog()" class="easyui-linkbutton"
       iconCls="icon-cancel">关闭</a>
</div>
</body>
<script type="text/javascript">
    var url = "${pageContext.request.contextPath}/stud";
    /*搜索单个用户名字*/
    function searchUser() {
        $("#dg").datagrid('load', {
            "name": $("#s_name").val()
        });
    }
    /*删除*/
    function deleteUser(){
       /*获取选择的行*/
        var selectedRows = $("#dg").datagrid('getSelections');
        /*var selectedRow = $("#dg").datagrid('getSelections');*/
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的数据！");
            return;
        }
        var strIds = [];
        /*遍历选择的id*/
        for (var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].id);

        }
        /*通过，分割*/
        var ids = strIds.join(",");
        alert(strIds);
        $.messager.confirm("系统提示","您确认要删除<font color='=red'>"+selectedRows.length+
        "</font>条数据吗？",function(r){
            if(r){
                $.ajax({
                    type:"DELETE",
                    datatype:"json",
                    url:"/stud/"+ids,
                    data:{},
                    success:function(result) {

                        if(result.resultCode==200) {
                            $.messager.alert("系统提示","数据已经成功删除！") ;
                            $("#dg").datagrid("reload");
                        }else
                            {
                            $.messager.alert("系统提示","fail");
                        };
                    },
                    error:function(){
                        $.messager.alert("error");
                    }
                });
            }
        });
    }


    function saveUser(){
        var name = $("#name").val();
        var age = $("#age").val();
        var id = $("#id").val();
        var addr = $("#addr").val();
        var sex = $("#sex").val();
        var data={"id":id,"name":name,"age":age,"addr":addr,"sex":sex};
        alert(data);
        alert(JSON.stringify(data));
        $.ajax({
           type:method,
            datatype:"json",
            url:url,

            data:JSON.stringify(data),
            contentType:"application/json;charset=utf-8",
            success:function(result){
                if(result.resultCode==200){
                    $.messager.alert("系统提示","保存成功");
                    $("#dlg").dialog("close");
                    $("#dg").datagrid("reload");
                    resetValue;
                }
            },
            error:function(){
                $.messager.alert("系统提示","shibao");
                $("#dlg").dialog("close");
                resetValue();
            }
        });
    }
    function closeUserDialog() {
            $("#dlg").dialog("close");
            resetValue();
    }

    function resetValue() {
        $("#name").val("");
        $("#id").val("");
        $("#age").val("");
        $("#sex").val("");
        $("#addr").val("");

    }



    /*添加user*/
    function openUserAddDialog(){
        $("#dlg").dialog("open").dialog("setTitle","添加用户信息");
        method = "POST";
    }
/*修改*/
    function openUserModifyDialog() {
        var selectedRows = $("#dg").datagrid('getSelections');
        if (selectedRows.length != 1) {
            $.messager.alert("系统提示", "请选择一条要编辑的数据！");
            return;
        }
        var row = selectedRows[0];

        $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
        $('#fm').form('load', row);

        method = "PUT";
    }


</script>
</html>
