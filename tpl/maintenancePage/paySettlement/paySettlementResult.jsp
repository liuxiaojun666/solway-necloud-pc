<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="utf-8"%>
<%@ include file="/common/taglib.jsp"%>
<script src="${ctx}/theme/js/select.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/checkSelected.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$("[name=ids]:checkbox").click(function() {
		$("#all").removeAttr("checked");
	});
});
function deleteRow(id){
	if(confirm("确定要删除这条数据吗？")){
		singledel(id);
	}
}
function singledel(id){
	$.ajax({
		type : "post",
		url : "${ctx}/PaySettlement/delete.htm",
		data:{"id":id},
		dataType : "json",
		success : function(json) {
			promptObj('success', '',json.message);	
			goPage(0);
		},error:function(){
			promptObj('error', '',"删除失败");
		}
	});
}
</script>
<table id="result_table" class="table table-striped b-t b-light">
	<thead>
		<tr>
			<th style="width: 20px;">
				<label class="i-checks m-b-none">
					<input type="checkbox" id="all"
			onclick="changeAll(this.checked,'ids');" /><i></i>
				</label>
			</th>
			<th>电站名称</th>
			<th>支出业务单号</th>
			<th>支出项目</th>
			<th>支出金额</th>
			<th>支出人</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody role="alert" aria-live="polite" aria-relevant="all">
		
				<c:forEach items="${result.data }" var="vo">
				<tr>
					<td>
					<label class="i-checks m-b-none">
					<input type="checkbox" name="ids" id="ids" value="${vo.id}" />
					<i></i></label>
					</td>
					<td>${vo.pstationname }</td>
					<td>${vo.payno }</td>
					<td>${vo.paycontent }</td>
					<td>${vo.paymoney }</td>
					<td>${vo.payman }</td>
					<td>
						<a class="text-info">
         					 <i class="icon-note" onclick="editData(${vo.id},'paySettlementModal');" ></i></a>
						<a class="text-info" onclick="deleteRow(${vo.id});"><i class="icon-trash"></i></a>
					</td>
				</tr>
				</c:forEach>
	</tbody>
</table>
<%@ include file="/common/pagebar.jsp"%>
