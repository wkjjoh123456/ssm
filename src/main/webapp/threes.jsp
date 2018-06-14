<%--
  Created by IntelliJ IDEA.
  User: Mr.K
  Date: 2018/6/12
  Time: 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/jquery-easyui-1.4/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/jquery-easyui-1.4/themes/icon.css">
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.4/jquery.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.4/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery-easyui-1.4/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
<input id="cc2" class="easyui-combobox"
       data-options="valueField:'id',textField:'text',url:'js/combo.json'" />

<br><br>
省：&nbsp;&nbsp;&nbsp;
<input id="sheng" class="easyui-combobox" style="width:100px"/>
<br><br>
市：&nbsp;&nbsp;&nbsp;
<input id="shi" class="easyui-combobox" style="width:100px"/>

<br><br>
区县：<input id="qu" class="easyui-combobox" style="width:100px"/>


<script type="text/javascript">
    $("#sheng").combobox({
        url: 'area/query/' + 1,
        valueField: 'areaid',
        textField: 'areaname',
        editable: false,
        onLoadSuccess: function (data) {
            alert(1,data[0].areaname,data[0].areaid);
            $('#sheng').combobox('select', data[0].areaname);
             $('#sheng').combobox('setValue', data[0].areaid);
            $('#shi').combobox({

                url: 'area/query/' + data[0].areaid,
                valueField: 'areaid',
                textField: 'areaname',
                editable: false,
                onLoadSuccess: function (data) {
                    $('#shi').combobox('select', data[    0].areaname);
                    $('#shi').combobox('setValue', data[0].areaid);
                    $('#qu').combobox({
                        url: 'area/query/' + data[0].areaid,
                        valueField: 'areaid',
                        textField: 'areaname',
                        editable: false,
                        onLoadSuccess:function(area){
                            $('#qu').combobox('select', area[0].areaname);
                            $('#qu').combobox('setValue', area[0].areaid);
                        }
                    })
                },
            });
        }
    })
    $("#sheng").combobox({
        onSelect:function(area){
            $('#shi').combobox('clear');
            var id = $('#sheng').combobox('getValue');
            $('#shi').combobox('reload','area/query/'+id);
        }
    })
    $("#shi").combobox({
        onSelect:function(){
            $('#qu').combobox('clear');
            var id = $('#shi').combobox('getValue');
            $('#qu').combobox('reload','area/query/'+id);
        }
    })
</script>
</body>
</html>
