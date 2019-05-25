<%--
  Created by IntelliJ IDEA.
  User: 不顾冷暖，不分秋冬
  Date: 2019/5/14
  Time: 15:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%-- 引入jquery --%>
    <script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
    <%-- 引入样式 --%>
    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
        <!-- 员工修改模态框 -->
        <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">员工修改</h4>
                    </div>
                    <div class="modal-body">
                        <%--水平表单--%>
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">empName</label>
                                <div class="col-sm-10">
                                    <p class="form-control-static" id="empName_update_static"></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">email</label>
                                <div class="col-sm-10">
                                    <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@126.com">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">gender</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender01_update_input" value="M" checked="checked"> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender02_update_input" value="F"> 女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">gender</label>
                                <div class="col-sm-4">
                                    <%-- 部门提交部门id即可 --%>
                                    <select class="form-control" name="dId"></select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                    </div>
                </div>
            </div>
        </div>



        <!-- 员工添加模态框 -->
        <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                    </div>
                    <div class="modal-body">
                        <%--水平表单--%>
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">empName</label>
                                <div class="col-sm-10">
                                    <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">email</label>
                                <div class="col-sm-10">
                                    <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@126.com">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">gender</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender01_add_input" value="M" checked="checked"> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender02_add_input" value="F"> 女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">gender</label>
                                <div class="col-sm-4">
                                    <%-- 部门提交部门id即可 --%>
                                    <select class="form-control" name="dId"></select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- 搭配显示页面 --%>
        <div class="container">
            <%-- 标题 --%>
            <div class="row">
                <div class="col-md-12">
                    <h1>SSM_CRUD</h1>
                </div>
            </div>
            <%-- 按钮 --%>
            <div class="row">
                <div class="col-md-4 col-md-offset-8">
                    <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
                    <button class="btn btn-danger" id="emp_del_all_btn">删除</button>
                </div>
            </div>
            <%-- 显示表格数据 --%>
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-hover" id="emps_table">
                        <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" id="check_all"/>
                                </th>
                                <th>#</th>
                                <th>empName</th>
                                <th>gender</th>
                                <th>email</th>
                                <th>deptName</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>
            <%-- 分页 --%>
            <div class="row">
                <%-- 分页文字信息 --%>
                <div class="col-md-6" id="page_info_area">

                </div>
                <%-- 分页条信息 --%>
                <div class="col-md-6" id="page_nav_area">

                </div>
            </div>
        </div>
        <script type="text/javascript">

            //总记录数
            var totalRecord,currentPage;

            //1.页面加载完成以后，直接去发送一个ajax请求,要到分页数据
            $(function(){
                //去首页
                to_page(1);
            });

            function to_page(pn) {
                $.ajax({
                    url:"${APP_PATH }/emps",
                    data:"pn="+pn,
                    type:"GET",
                    success:function(result) {
                        //console.log(result);
                        //1.解析并显示员工数据
                        build_emps_table(result);
                        //2.解析并显示分页信息
                        bulid_page_info(result);
                        //3.解析显示分页条
                        build_page_nav(result);
                    }
                });
            }

            function build_emps_table(result) {
                //清空table表格
                $("#emps_table tbody").empty();
                var emps = result.extend.pageInfo.list;
                $.each(emps,function(index,item) {
                    // alert(item.empName);
                    var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                    var empIdTd = $("<td></td>").append(item.empId);
                    var empNameTd = $("<td></td>").append(item.empName);
                    var genderTd = $("<td></td>").append(item.gender=='M'?'男':'女');
                    var emailId = $("<td></td>").append(item.email);
                    var deptNameTd = $("<td></td>").append(item.department.deptName);
                    //按钮
                    /***
                     <button class="btn btn-primary btn-sm">
                     <span class="glyphicon glyphicon-music" aria-hidden="true"></span>
                     编辑
                     </button>
                     */
                    var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                                     .append($("<span></span>").addClass("glyphicon glyphicon-music")).append("编辑");
                    //为编辑按钮添加一个自定义的属性，来表示当前的员工id
                    editBtn.attr("edit-id",item.empId);
                    var delBtn =$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                                     .append($("<span></span>").addClass("glyphicon glyphicon-fire")).append("删除");
                    //为删除按钮添加一个自定义的属性来表示当前删除的员工id
                    delBtn.attr("del-id",item.empId);
                    var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                    //append方法执行完成以后还是返回原来的元素
                     $("<tr></tr>").append(checkBoxTd)
                                    .append(empIdTd)
                                    .append(empNameTd)
                                    .append(genderTd)
                                    .append(emailId)
                                    .append(deptNameTd)
                                    .append(btnTd)
                                    .appendTo("#emps_table tbody");
                })
            }
            //解析显示分页信息
            function bulid_page_info(result) {
                //清空分页信息
                $("#page_info_area").empty();
                $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，" +
                                "总共"+result.extend.pageInfo.pages+"页," +
                                "总"+result.extend.pageInfo.total+"条记录数");
                                totalRecord = result.extend.pageInfo.total;
                                currentPage = result.extend.pageInfo.pageNum;
            }
            //解析显示分页条,点击分页要能跳转
            function build_page_nav(result) {
                //#page_nav_area
                //清空分页导航条信息
                $("#page_nav_area").empty();
                var ul = $("<ul></ul>").addClass("pagination");

                //构建元素
                var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
                var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

                //判断是否有上一页
                if(result.extend.pageInfo.hasPreviousPage == false){
                    firstPageLi.addClass("disabled");
                    prePageLi.addClass("disabled");
                }else {
                    //为元素添加点击翻页的事件
                    firstPageLi.click(function () {
                        to_page(1);
                    });
                    prePageLi.click(function () {
                        to_page(result.extend.pageInfo.pageNum - 1);
                    })
                }

                //添加首页和前一页的提示
                ul.append(firstPageLi).append(prePageLi);
                //1，2，3 遍历给ul中添加页码提示
                $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
                    var numLi = $("<li></li>").append($("<a></a>").append(item));
                    if(result.extend.pageInfo.pageNum == item){
                        numLi.addClass("active");
                    }
                    numLi.click(function () {
                        to_page(item);
                    })
                    ul.append(numLi);
                })

                var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
                var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

                //判断是否有下一页
                if(result.extend.pageInfo.hasNextPage == false){
                    nextPageLi.addClass("disabled");
                    lastPageLi.addClass("disabled");
                }else {
                    //为元素添加点击翻页的事件
                    nextPageLi.click(function () {
                        to_page(result.extend.pageInfo.pageNum + 1);
                    })
                    lastPageLi.click(function () {
                        to_page(result.extend.pageInfo.pages);
                    })
                }

                //添加下一页和末页的提示
                ul.append(nextPageLi).append(lastPageLi);

                //把ul加入到nav中
                var navEle = $("<nav></nav>").append(ul);
                navEle.appendTo("#page_nav_area");
            }

            //清空表单样式及内容
            function reset_form(ele){
                $(ele)[0].reset();
                //清空表单样式
                $(ele).find("*").removeClass("has-error has-success");
                $(ele).find(".help-block").text("");
            }

            //点击新增按钮弹出模态框
            $("#emp_add_modal_btn").click(function () {
                //清楚表单数据（表单完整重置  (表单的数据，表单的样式)）
                reset_form("#empAddModal form");

                // $("")[0].reset();
                //发送ajax请求，查出部门信息，显示在下拉列表中
                getDepts("#empAddModal select");
                //弹出模态框
                $("#empAddModal").modal({
                    backdrop:'static'
                });
            });

            //查出所有部门信息并显示在下拉列表中
            function getDepts(ele) {
                $(ele).empty();
                $.ajax({
                    url:"${APP_PATH }/depts",
                    type:"GET",
                    success:function (result) {
                        // console.log(result)
                        //显示部门信息在下拉列表中
                        $.each(result.extend.depts,function () {
                            var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                            optionEle.appendTo(ele);
                        })
                    }
                });
            }

            //校验表单数据
            function validate_add_form(){
                //1.拿到要校验的数据,使用正则表达式
                var empName = $("#empName_add_input").val();
                var repName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
                if(!repName.test(empName)){
                    // alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
                    show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
                    return false;
                }else {
                    show_validate_msg("#empName_add_input","success","");
                }
                //2.校验邮箱信息
                var email = $("#email_add_input").val();
                var regEmail = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
                if(!regEmail.test(email)){
                    // alert("邮箱格式不正确");
                    show_validate_msg("#email_add_input","error","邮箱格式不正确");
                    // $("#email_add_input").parent().addClass("has-error");
                    // $("#email_add_input").next("span").text("邮箱格式不正确");
                    return false;
                }else {
                    // $("#email_add_input").parent().addClass("has-success");
                    // $("#email_add_input").next("span").text("");
                    show_validate_msg("#email_add_input","success","")
                }
                return true;
            }

            function show_validate_msg(ele,status,msg){
                //清楚当前元素的校验状态
                $(ele).parent().removeClass("has-success has-error");
                $(ele).next("span").text("");
                if("success" == status){
                    $(ele).parent().addClass("has-success");
                    $(ele).next("span").text(msg);

                }else if ("error" == status) {
                    $(ele).parent().addClass("has-error");
                    $(ele).next("span").text(msg);
                }
            }

            //校验用户名是否可用
            $("#empName_add_input").focusout(function () {
                //发送ajax请求校验用户名是否可用
                var empName = this.value;
                $.ajax({
                    url:"${APP_PATH }/checkuser",
                    data:"empName="+empName,
                    type:"POST",
                    success:function (result) {
                        if(result.code==100){
                            show_validate_msg("#empName_add_input","success","用户名可用");
                            $("#emp_save_btn").attr("ajax-va","success");
                        }else {
                            show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                            $("#emp_save_btn").attr("ajax-va","error");
                        }
                    }
                })
            })

            //点击保存，保存员工
            $("#emp_save_btn").click(function () {
                //1.模态框中填写的表单数据提交给服务器进行保存

                //2.先对要提交给服务器的数据进行校验
                if(!validate_add_form()){
                    return false;
                }

                //3.判断之前的ajax用户名校验是否成功
                if($(this).attr("ajax-va")=="error"){
                    return false;
                }

                //4.发送ajax请求保存员工
                // alert("aaa");
                $.ajax({
                    url:"${APP_PATH }/emp",
                    type:"POST",
                    data:$("#empAddModal form").serialize(),
                    success:function (result) {
                        // alert(result.msg);
                        if (result.code == 100){
                            //员工保存成功：
                            //1.关闭模态框
                            $("#empAddModal").modal('hide');
                            //2.来到最后一页，显示刚才保存的数据
                            //发送ajax请求显示最后一页数据即可
                            to_page(totalRecord);
                        } else {
                            //显示失败信息
                            // console.log(result);
                            //有哪个字段的错误信息就显示哪个字段的
                            if(undefined != result.extend.errorFields.email){
                                //显示邮箱错误信息
                                show_validate_msg("#email_add_input","error",result.extend.errorFields.email)
                            }
                            if(undefined != result.extend.errorFields.empName){
                                //显示员工名字的错误信息
                                show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName)
                            }
                        }

                    }
                });
            });

            //问题：只用用click事件触发不了，因为是按钮创建之前就绑定了click
            //解决：1.可用在创建按钮的时候绑定（不推荐，代码冗杂）
            //      2.绑定live()   （jquery新版中没有live，使用on进行替代）
            $(document).on("click",".edit_btn",function () {
                // alert("edit");

                //1.查出部门信息，显示部门信息
                getDepts("#empUpdateModal select");
                //2.查出员工信息，显示员工信息
                getEmp($(this).attr("edit-id"));
                //3.把员工的id传递给模态框的更新按钮
                $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));

                //显示模态框
                $("#empUpdateModal").modal({
                    backdrop:'static'
                });
            })

            function getEmp(id) {
                // alert("aaa");
                $.ajax({
                    url:"${APP_PATH }/emp/"+id,
                    type:"GET",
                    success:function (result) {
                        //console.log(result)

                        var empData = result.extend.emp;
                        $("#empName_update_static").text(empData.empName);
                        $("#email_update_input").val(empData.email);
                        $("#empUpdateModal input[name=gender]").val([empData.gender]);
                        $("#empUpdateModal select").val([empData.dId]);
                    }
                });
            }

            //点击更新，更新员工信息
            $("#emp_update_btn").click(function () {
                //验证邮箱是否合法
                //1.校验邮箱信息
                var email = $("#email_update_input").val();
                var regEmail = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
                if(!regEmail.test(email)){
                    show_validate_msg("#email_update_input","error","邮箱格式不正确");
                    return false;
                }else {
                    show_validate_msg("#email_update_input","success","")
                }

                //2.发送ajax请求保存更新的员工数据
                $.ajax({
                    url:"${APP_PATH }/emp/"+$(this).attr("edit-id"),
                    type:"PUT",
                    data:$("#empUpdateModal form").serialize(),
                    success:function (result) {
                        // alert(result.msg);
                        //1.关闭模态框
                        $("#empUpdateModal").modal("hide");
                        //2.回到本页面
                        to_page(currentPage);
                    }
                });
            });

            //单个删除
            $(document).on("click",".delete_btn",function(){
                //1.弹出是否确认删除
                var  empName = $(this).parents("tr").find("td:eq(2)").text();
                var empId = $(this).attr("del-id");
                // alert($(this).parents("tr").find("td:eq(1)").text());
                if(confirm("确认删除【"+ empName+"】吗？")){
                    //确认，发送ajax请求删除即可
                    $.ajax({
                        url:"${APP_PATH}/emp/"+empId,
                        type:"DELETE",
                        success:function (result) {
                            alert(result.msg);
                            //回到本页
                            to_page(currentPage);
                        }
                    })
                }
            });

            //全选 /全不选 功能
            $("#check_all").click(function () {
                $("#check_all").empty();
                //attr获取checked是undefined
                //attr用于获取自定义属性的值；
                //prop用于修改和读取dom原生属性的值
                // alert($(this).prop("checked"));
                $(".check_item").prop("checked",$(this).prop("checked"));
            });

            $(document).on("click",".check_item",function () {
                //判断当前选择中的元素是否为所有checkbox的个数
                var flag = $(".check_item:checked").length==$(".check_item").length;
                $("#check_all").prop("checked",flag);

            });

            //点击全部删除，就批量删除
            $("#emp_del_all_btn").click(function () {

                // alert("aaa");
                var len = $(".check_item:checked");//所选择的个数(用于遍历)
                var empNames = "";
                var del_idstr = "";
                $.each(len,function () {
                    //this
                    // alert($(this).parents("tr").find("td:eq(2)").text());
                    empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
                    //组装员工id字符串
                    del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
                });
                //去除empNames拼接多余的  ，
                empNames = empNames.substring(0,empNames.length-1);
                //去除id拼接多余的 -
                del_idstr = del_idstr.substring(0,del_idstr.length-1);
                if (confirm("确认删除【"+ empNames +"】吗？")) {
                    //发送ajax请求
                    $.ajax({
                        url:"${APP_PATH }/emp/"+del_idstr,
                        type:"DELETE",
                        success:function (result) {
                            alert(result.msg);
                            //回到当前页
                            to_page(currentPage);
                            $("#check_all").prop("checked",false);
                        }
                    })
                }

            })
        </script>
</body>
</html>
