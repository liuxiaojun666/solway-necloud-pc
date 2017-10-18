<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ attribute name="curPage" type="java.lang.Integer" required="true" description="当前页"%>
<%@ attribute name="totalPages" type="java.lang.Integer" required="true" description="总页数"%>
<%@ attribute name="totalRecords" type="java.lang.Integer" required="false" description="总记录"%>

<c:set var="displaySize" value="2"/>
<c:set var="current" value="${curPage <= 0 ? 1 : curPage}"/>
<c:set var="current" value="${curPage > totalPages ? totalPages : curPage}"/>

<c:set var="begin" value="${current - displaySize}"/>
<c:set var="begin" value="${begin <= 0 ? 1 : begin}"/>

<c:set var="end" value="${current + displaySize}"/>
<c:set var="end" value="${end > totalPages ? totalPages : end}"/>

<c:set var="pageNum" value="${displaySize * 2 + 1}"/>
<c:set var="distence" value="${end - begin}"/>

<c:if test="${distence < pageNum}">
    <%--左补充--%>
    <c:if test="${(current - begin) > (end - current)}">
        <c:set var="begin" value="${end - pageNum + 1}"/>
        <c:set var="begin" value="${begin <= 0 ? 1 : begin}"/>
    </c:if>
    <%--右补充--%>
    <c:if test="${(current - begin) < (end - current)}">
        <c:set var="end" value="${begin + pageNum - 1}"/>
        <c:set var="end" value="${end > totalPages ? totalPages : end}"/>
    </c:if>
</c:if>

<nav aria-label="Page navigation">
    <ul class="pagination">
        <c:choose>
            <c:when test="${current == 1}">
                <li class="disabled"><span title="首页">首页</span></li>
                <li class="disabled"><span title="上一页">&lt;&lt;</span></li>
            </c:when>
            <c:otherwise>
                <li><a href="javascript:jumpPage(1);" title="首页">首页</a></li>
                <li><a href="javascript:jumpPage(${current - 1});" title="上一页">&lt;&lt;</a></li>
            </c:otherwise>
        </c:choose>

        <c:forEach begin="${begin}" end="${end}" var="i" step="1">
            <li <c:if test="${current == i}"> class="active"</c:if>>
                <a href="javascript:jumpPage( ${i});" title="第${i}页">${i}</a>
            </li>
        </c:forEach>

        <c:choose>
            <c:when test="${current == totalPages}">
                <li class="disabled"><span title="下一页">&gt;&gt;</span></li>
                <li class="disabled"><span title="尾页">尾页</span></li>
            </c:when>
            <c:otherwise>
                <li><a href="javascript:jumpPage(${current + 1});" title="下一页">&gt;&gt;</a></li>
                <li><a href="javascript:jumpPage(${totalPages});" title="尾页">尾页</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</nav>
