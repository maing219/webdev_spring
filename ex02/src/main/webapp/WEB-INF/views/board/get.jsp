<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Read</div>
			<div class="panel-body">
				<div class="form-group">
					<label>BNO</label> <input class="form-control" name="bno"
						value="${ board.bno }" readonly>
				</div>
				<div class="form-group">
					<label>Title</label> <input class="form-control" name="title"
						value="${ board.title }" readonly>
				</div>
				<div class="form-group">
					<label>Content</label>
					<textarea class="form-control" rows="3" name="content" readonly>${ board.content }</textarea>
				</div>
				<div class="form-group">
					<label>Writer</label> <input class="form-control" name="writer"
						value="${ board.writer }" readonly>
				</div>
				<button class="btn btn-default listBtn">List</button>
				<button class="btn btn-info modBtn">Modify</button>
				<form id="actionForm" action="/board/list" method="get">
					<input type="hidden" name="bno" value="${ board.bno }"> <input
						type="hidden" name="pageNum" value="${ cri.pageNum }"> <input
						type="hidden" name="amount" value="${ cri.amount }"> <input
						type="hidden" name="keyword" value="${ cri.keyword }">
					<input type="hidden" name="type" value="${ cri.type }">
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	var actionForm = $("#actionForm");
	$(function() {
		$(".listBtn").click(function(e) {
			e.preventDefault();
			actionForm.find("input[name='bno']").remove();
			actionForm.submit();
		});

		$(".modBtn").click(function(e) {
			e.preventDefault();
			actionForm.attr("action", "/board/modify");
			actionForm.submit();
		});
	});
</script>
<%@ include file="../includes/footer.jsp"%>