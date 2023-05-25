<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.ProductComment" %>
<%@ page import="com.chengxusheji.po.ProductClass" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的productClassObj信息
    List<ProductClass> productClassList = (List<ProductClass>)request.getAttribute("productClassList");
    Product product = (Product)request.getAttribute("product");
	List<ProductComment> commentList = (ArrayList<ProductComment>) request.getAttribute("commentList");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看图书详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>Product/frontlist">图书信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">图书id:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">图书分类:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductClassObj().getProductName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">图书名称:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductName()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">图书图片:</div>
		<div class="col-md-10 col-xs-6"><img class="img-responsive" src="<%=basePath %><%=product.getProductPhoto() %>"  border="0px"/></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">作者:</div>
		<div class="col-md-10 col-xs-6"><%=product.getAuthor()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">出版社:</div>
		<div class="col-md-10 col-xs-6"><%=product.getPublish()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">出版日期:</div>
		<div class="col-md-10 col-xs-6"><%=product.getPublishDate()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">页数:</div>
		<div class="col-md-10 col-xs-6"><%=product.getPageNum()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">字数:</div>
		<div class="col-md-10 col-xs-6"><%=product.getWordNum()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">ISBN:</div>
		<div class="col-md-10 col-xs-6"><%=product.getIsbn()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">图书定价:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductPrice()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">图书简介:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductDesc()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">图书文件:</div>
		<div class="col-md-10 col-xs-6"><a href="<%=basePath%><%=product.getProductFile()%>" target="_blank"><%=product.getProductFile()%></a></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">是否推荐:</div>
		<div class="col-md-10 col-xs-6"><%=product.getRecommandFlag()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">图书评分:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductScore()%>分</div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">添加时间:</div>
		<div class="col-md-10 col-xs-6"><%=product.getAddTime()%></div>
	</div>
	
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">评分等级:</div>
		<div class="col-md-10 col-xs-6">
			<select id="score" name="score">
				<option value="10">力荐:&nbsp;5颗星</option>
				<option value="8">推荐:&nbsp;4颗星</option>
				<option value="6">还行:&nbsp;3颗星</option>
				<option value="4">较差:&nbsp;2颗星</option>
				<option value="2">很差:&nbsp;1颗星</option>
			</select>
		</div>
	</div>
	
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">评论内容:</div>
		<div class="col-md-10 col-xs-6">
			<textarea id="content" style="width:100%" rows=8></textarea>
		</div>
	</div>
	
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="userComment();" class="btn btn-primary">发布书评</button>
			<button onclick="history.back();" class="btn btn-info">返回</button>
		</div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold"></div>
		<div class="col-md-8 col-xs-7">
			<% for(ProductComment productComment: commentList) { %>
			<div class="row" style="margin-top: 20px;">
				<div class="col-md-2 col-xs-3">
					<div class="row text-center"><img src="<%=basePath %><%=productComment.getUserObj().getUserPhoto() %>" style="border: none;width:60px;height:60px;border-radius: 50%;" /></div>
					<div class="row text-center" style="margin: 5px 0px;"><%=productComment.getUserObj().getUser_name() %></div>
				</div>
				<div class="col-md-2 col-xs-2">
					<% for(int i=0;i<(productComment.getCommentScore()/2);i++) { %>
					<img src="<%=basePath %>images/star.jpg" widht="15px" height="15px" />
					<% } %>
				</div>
				<div class="col-md-5 col-xs-3"><%=productComment.getContent() %></div>
				<div class="col-md-3 col-xs-4" ><%=productComment.getCommentTime() %></div>
			</div>
		
			<% } %> 
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";


function userComment() {
	var content = $("#content").val();
	if(content == "") {
		alert("请输入评论内容");
		return;
	}

	$.ajax({
		url : basePath + "ProductComment/userAdd",
		type : "post",
		dataType: "json",
		data: {
			"productComment.productObj.productId": <%=product.getProductId() %>,
			"productComment.commentScore": $("#score").val(),
			"productComment.content": content
		},
		success : function (data, response, status) {
			if(data.success){
				alert("评论成功~");
				location.reload();
			}else{
				alert(data.message);
			}
		}
	});
}


$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 </script> 
</body>
</html>

