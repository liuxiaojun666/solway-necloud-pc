<%com.solway.necloud.common.util.PageBean pb = (com.solway.necloud.common.util.PageBean)request.getAttribute("result"); int pageSize = pb.getPageSize();%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/common/taglib.jsp"%>
  <%if(pb.getTotal()==0){ %>
  <%}else{%>
<!-- <div class="pagebar col-sm-12"> -->
<footer class="panel-footer">
<div class="row">
<%
		int endSize = (pb.getPageIndex()*pb.getPageSize()+pb.getData().size())<(pb.getPageIndex()+1)*pb.getPageSize()?(pb.getPageIndex()*pb.getPageSize()+pb.getData().size()):(pb.getPageIndex()+1)*pb.getPageSize();
		%>
	<div class="col-sm-4 hidden-xs">
	</div>
	<div class="col-sm-4 text-center">
		<small class="text-muted inline m-t-sm m-b-sm">
		显示<%=pb.getPageIndex()*pb.getPageSize()+1 %>到<%=endSize %>条，
		共<%=pb.getTotal() %>条
		</small>
	</div>
	<div class="col-sm-4 text-right text-center-xs">
		<ul class="pagination pagination-sm m-t-none m-b-none">
		<%if(pb.getPageIndex()==pb.getPreviousIndex()){ %>
          <li class="prev disabled"><a href="#"><span><i class="fa fa-chevron-left"></i></span></a></li>
		<%}else{%>
			<li><a href="javascript:goPage(<%=pb.getPreviousIndex()%>);"><i class="fa fa-chevron-left"></i></a></li>
		<%} %>

		 <%if(pb.getTotalPage()>2){
		 if(pb.getPageIndex()==0){ %>
		 	<li class="active"><a href="#"><span class="pageColor"><%=pb.getPageIndex()+1 %></span></a></li>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()+1%>);"><%=pb.getPageIndex()+2 %></a></li>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()+2%>);"><%=pb.getPageIndex()+3 %></a></li>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()+3%>);"><%=pb.getPageIndex()+4 %></a></li>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()+4%>);"><%=pb.getPageIndex()+5 %></a></li>

		 <%}else  if(pb.getPageIndex()==pb.getLastPageIndex()){ %>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()-4%>);"><%=pb.getPageIndex()-3%></a></li>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()-3%>);"><%=pb.getPageIndex()-2 %></a></li>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()-2%>);"><%=pb.getPageIndex()-1%></a></li>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()-1%>);"><%=pb.getPageIndex() %></a></li>
		 	<li class="active"><span class="pageColor"><%=pb.getPageIndex()+1 %></span></li>
		  <%}else{%>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()-2%>);"><%=pb.getPageIndex()-1%></a></li>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()-1%>);"><%=pb.getPageIndex() %></a></li>
		 	<li class="active"><span class="pageColor"><%=pb.getPageIndex()+1 %></span></li>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()+1%>);"><%=pb.getPageIndex()+2%></a></li>
		 	<li><a href="javascript:goPage(<%=pb.getPageIndex()+2%>);"><%=pb.getPageIndex()+3%></a></li>
		 <%}}else{ %>
			<c:forEach begin="0" end="${result.totalPage-1}" varStatus="ind">
				<c:choose>
					<c:when test="${ind.index==result.pageIndex}">
						<li class="active"><a href="javascript:void(0);"><%=pb.getPageIndex()+1 %></a></li>
					</c:when>
					<c:otherwise>
						<li><a href="javascript:goPage(${ind.index});"><span class="pageColor">${ind.index+1}</span></a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		<%}%>

		<%if(pb.getPageIndex()==pb.getNextPageIndex()){ %>
				<li class="next disabled"><a href="javascript:void(0);"><i class="fa fa-chevron-right"></i></a></li>
		<%}else{%>
			<li><a href="javascript:goPage(<%=pb.getNextPageIndex()%>);"><i class="fa fa-chevron-right"></i></a></li>
		<%}%>
		</ul>
	</div>
</div>
</footer>
<%}%>
<div>
	<input type="hidden" id="pageIndex" name="pageIndex" value="<%=pb.getPageIndex()%>"/>
	<input type="hidden" id="pageSize" name="pageSize" value="<%=pageSize%>"/>
</div>
