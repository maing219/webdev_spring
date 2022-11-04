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
						type="hidden" name="keyword" value="${ cri.keyword }"> <input
						type="hidden" name="type" value="${ cri.type }">
				</form>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New
					Reply</button>
			</div>
			<div class="panel-body">
				<ul class="chat">
				</ul>
			</div>
			<div class="panel-footer">
				<div class="input-group"></div>
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
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> <input class="form-control" name="reply"
						value="New Reply">
				</div>
				<div class="form-group">
					<label>Replyer</label> <input class="form-control" name="replyer"
						value="Replyer">
				</div>
				<div class="form-group">
					<label>Reply Date</label> <input class="form-control"
						name="replyDate" value="2022-11-04">
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<script src="/resources/js/reply.js"></script>
<script>
	$(function() {
		console.log(replyService);
		console.log("JS TEST");
		var bnoValue = "${ board.bno }";

		var replyUL = $(".chat");

		showList(1);
		function showList(page) {
			replyService
					.getList(
							{
								bno : bnoValue,
								page : 1
							},
							function(list) {
								//console.log(list);
								var str = "";
								if (list == null || list.length == 0) {
									replyUL.html("");
									return;
								}

								for (var i = 0, len = list.length || 0; i < len; i++) {
									//console.log(list[i]);
									str += '<li class="left clearfix" data-rno="' + list[i].rno + '">';
									str += '<div>';
									str += '<div class="header">';
									str += '<strong class="primary-font">'
											+ list[i].replyer + '</strong>'
									str += '<small class="pull-right text-muted"></i>'
											+ replyService
													.displayTime(list[i].replyDate)
											+ '</small>';
									str += '</div>';
									str += '<p>' + list[i].reply + '</p>';
									str += '</div>';
									str += '</li>';
								}

								replyUL.html(str);
							});
		}
		
		var modal = $(".modal");
		//modal.modal("show");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		$("#addReplyBtn").click(function() {
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id!='modalCloseBtn']").hide();
			modalRegisterBtn.show();
			modal.modal("show");
		});
		
		$("#modalCloseBtn").click(function() {
			modal.modal("hide");
		});

		/*
		replyService.get(10, function(data) {
			console.log(data);
		});
		 */

		/*
		replyService.update({rno: 10, reply: "Modified Reply", bno: bnoValue},
				function(result) {
			alert("수정완료");
		});
		 */

		/*
		replyService.remove(41, function(result) {
			console.log(result);
			if(result == "success") {
				alert("REMOVED");
			}
		});
		 */

		/*
		replyService.getList({bno: bnoValue, page: 1}, function(list) {
			// console.log(list);
			for(var i=0, len=list.length || 0; i<len; i++) {
				console.log(list[i]);
			}
		});
		 */

		/*
		replyService.add({reply: "JS TEST", replyer: "tester", bno: bnoValue},
				function(result) {
			alert("result: " + result);
		});
		 */
	})
</script>

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