<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				Board List Page
				<button id="regBtn" type="button"
					class="btn btn-outline btn-primary btn-xs pull-right">Register
					New Board</button>
			</div>
			<div class="panel-body">
				<table width="100%"
					class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${ list }" var="board">
							<tr>
								<td>${ board.bno }</td>
								<td><a class="move" href="${ board.bno }">${ board.title }</a></td>
								<td>${ board.writer }</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${ board.regDate }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${ board.updateDate }" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<form id="searchForm" action="/board/list" method="get">
					<select name="type">
						<option value="" ${ pageMaker.cri.type == null ? "selected" : "" }>---</option>
						<option value="T" ${ pageMaker.cri.type == "T" ? "selected" : "" }>제목</option>
						<option value="C" ${ pageMaker.cri.type == "C" ? "selected" : "" }>내용</option>
						<option value="W" ${ pageMaker.cri.type == "W" ? "selected" : "" }>작성자</option>
						<option value="TC"
							${ pageMaker.cri.type == "TC" ? "selected" : "" }>제목+내용</option>
						<option value="TCW"
							${ pageMaker.cri.type == "TCW" ? "selected" : "" }>제목+내용+작성자</option>
					</select> <input type="text" name="keyword"
						value="${ pageMaker.cri.keyword }"> <input type="hidden"
						name="pageNum" value="${ pageMaker.cri.pageNum }"> <input
						type="hidden" name="amount" value="${ pageMaker.cri.amount }">
					<button class="btn btn-default">Search</button>
				</form>
				<div class="pull-right">
					<ul class="pagination">
						<c:if test="${ pageMaker.prev }">
							<li class="paginate_button previous"><a
								href="${ pageMaker.startPage-1 }">Previous</a></li>
						</c:if>
						<c:forEach var="num" begin="${ pageMaker.startPage }"
							end="${ pageMaker.endPage }">
							<li
								class="paginate_button ${ pageMaker.cri.pageNum == num ? 'active' : '' }"><a
								href="${ num }">${ num }</a></li>
						</c:forEach>
						<c:if test="${ pageMaker.next }">
							<li class="paginate_button next"><a
								href="${ pageMaker.endPage + 1 }">Next</a></li>
						</c:if>
					</ul>
				</div>
				<form id="actionForm" action="/board/list" method="get">
					<input type="hidden" name="pageNum"
						value="${ pageMaker.cri.pageNum }"> <input type="hidden"
						name="amount" value="${ pageMaker.cri.amount }"> <input
						type="hidden" name="keyword" value="${ pageMaker.cri.keyword }">
					<input type="hidden" name="type" value="${ pageMaker.cri.type }">
				</form>
			</div>
		</div>
	</div>
</div>

<div class="modal fade in" id="myModal" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body">lorem</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<script>
	$(function() {
		var result = '${result}';

		checkModal(result);

		history.replaceState({}, null, null);

		function checkModal(result) {
			if (result === '' || history.state) {
				return;
			}

			if (result === 'success') {
				$(".modal-body").html("정상적으로 처리되었습니다.");
			} else if (parseInt(result) > 0) {
				$(".modal-body")
						.html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
			}

			$("#myModal").modal("show");
		}

		$("#regBtn").click(function() {
			self.location = "/board/register";
		});

		var actionForm = $("#actionForm");
		$(".pagination a").on("click", function(e) {
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});

		$(".move").on(
				"click",
				function(e) {
					e.preventDefault();
					actionForm.append("<input type='hidden' name='bno' value='"
							+ $(this).attr('href') + "'>");
					actionForm.attr("action", "/board/get");
					actionForm.submit();
				});

		$("#searchForm button").on("click", function(e) {
			var searchForm = $("#searchForm");
			if (!searchForm.find("option:selected").val()) {
				alert("검색 종류를 선택하세요");
				return false;
			}

			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				return false;
			}

			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			searchForm.submit();
		});
	});
</script>
<%@ include file="../includes/footer.jsp"%>