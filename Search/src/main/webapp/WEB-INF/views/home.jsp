<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>MUSINSA</title>
	<script type="text/javascript" src="//static.msscdn.net/mfile_outsrc/js/vendor/jquery-1.11.1.min.js?20160201"></script>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
			var q = '';
			
			$('#search_query').keyup(function(){
				if(q != $('#search_query').val()){
					q = $('#search_query').val();
					if(q != null && q != ''){
						search(q);
					}else{
						$('#list').css('display','none');
						$('.recommendSearchWord-list dd').remove();
					}
				}
			});
		});
		
		
		function search(q){
			$('.recommendSearchWord-list dd').remove();
			
			$.ajax({
				type : 'get',
				url : '/search/api/keyword/suggestion',
				contentType: "application/json; charset=utf-8;",
				data : {'q' : q},
				dataType : 'json',
				success : function(data){ 
				      var res = null;
				      if(data != null && data.length > 0){
				    	  res = data;
				      }
				      
				      if(res == null){
							$('#list').css('display','none');
						}else{
							for(var i in res){
								$('.recommendSearchWord-list').append(''
										+ '	<dd kwd_type="keyword" kwd_value="'+ res[i] +'">'
										+ '		<span>'+ res[i] +'</span>'
										+ '</dd>'
										);
							}
							
							$('#list').css('display','block');
						}
				      
				},

			});
		}
	
	</script>
	
	<h1>
		MUSINSA
	</h1>
	
	<form id="search_form" method="get" action="https://search.musinsa.com/search/musinsa/integration">
		<input id="search_query" type="text" name="q" maxlength="30" autocomplete="off" class="search head-search-inp">
		<span id="search_button" class="search-btn btn ui-head-search-btn">
			<i class="ic-22-stencil-search ic-white">검색</i>
		</span>
	</form>

	<div id="list" style="display: none;">
		<dl class="recommendSearchWord-list list store_list">
			<dt class="title-listItem listItem clearfix">
				<span class="title">추천 검색어</span>
			</dt>
		</dl>
	</div>
</body>
</html>
