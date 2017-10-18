<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<script type="text/javascript">
function pageData(pb){
	if(pb.total!=0){
		var content='<footer class="panel-footer"><div class="row">';
		content+='<div class="col-sm-4 hidden-xs"></div>';
		content+='<div class="col-sm-4 text-center"><small class="text-muted inline m-t-sm m-b-sm">';
		endSize = (pb.pageIndex*pb.pageSize+pb.data.length)<(pb.pageIndex+1)*pb.pageSize?(pb.pageIndex*pb.pageSize+pb.data.length):(pb.pageIndex+1)*pb.pageSize;
		content+='显示'+(pb.pageIndex*pb.pageSize+1)+'到'+endSize+'条，共'+pb.total+'条记录';
		content+='</small></div>';
		
		content+='<div class="col-sm-4 text-right text-center-xs"><ul class="pagination pagination-sm m-t-none m-b-none">';
		if(pb.pageIndex==pb.previousIndex){
			content+='<li class="prev disabled"><a href="#"><span><i class="fa fa-chevron-left"></i></span></a></li>';
		}else{
			content+='<li><a  ng-click="goPage('+pb.previousIndex+');"><i class="fa fa-chevron-left"></i></a></li>';
		}
		if(pb.totalPage>5){
		if(pb.pageIndex==0){
			content+='<li class="active"><a href="#none"><span class="pageColor">'+(pb.pageIndex+1) +'</span></a></</li>';
			content+='<li><a  ng-click="goPage('+(pb.pageIndex+1)+');">'+(pb.pageIndex+2) +'</a></li>';
			content+='<li><a  ng-click="goPage('+(pb.pageIndex+2)+');">'+(pb.pageIndex+3) +'</a></li>';
			content+='<li><a  ng-click="goPage('+(pb.pageIndex+3)+');">'+(pb.pageIndex+4) +'</a></li>';
			content+='<li><a  ng-click="goPage('+(pb.pageIndex+4)+');">'+(pb.pageIndex+5) +'</a></li>';
		 }else if(pb.pageIndex==1){
			 content+='<li><a  ng-click="goPage('+(pb.pageIndex-1)+');">'+pb.pageIndex +'</a></li>';
			 content+='<li class="active"><span class="pageColor">'+(pb.pageIndex+1) +'</span></li>';
			 content+='<li><a  ng-click="goPage('+(pb.pageIndex+1)+');">'+(pb.pageIndex+2) +'</a></li>';
			 content+='<li><a  ng-click="goPage('+(pb.pageIndex+2)+');">'+(pb.pageIndex+3) +'</a></li>';
			 content+='<li><a  ng-click="goPage('+(pb.pageIndex+3)+');">'+(pb.pageIndex+4) +'</a></li>';
		 }else if(pb.pageIndex==(pb.lastPageIndex-1)){
			 content+='<li><a  ng-click="goPage('+(pb.pageIndex-3)+');">'+(pb.pageIndex-2)+'</a></li>';
			 content+='<li><a  ng-click="goPage('+(pb.pageIndex-2)+');">'+(pb.pageIndex-1) +'</a></li>';
			 content+='<li><a  ng-click="goPage('+(pb.pageIndex-1)+');">'+pb.pageIndex +'</a></li>';
			 content+='<li class="active"><span class="pageColor">'+(pb.pageIndex+1) +'</span></li>';
			 content+='<li><a  ng-click="goPage('+pb.pageIndex+1+');">'+(pb.pageIndex+2) +'</a></li>';
		 }else if(pb.pageIndex==pb.lastPageIndex){
			 content+='<li><a  ng-click="goPage('+(pb.pageIndex-4)+');">'+(pb.pageIndex-3)+'</a></li>';
			 content+='<li><a  ng-click="goPage('+(pb.pageIndex-3)+');">'+(pb.pageIndex-2) +'</a></li>';
			 content+='<li><a  ng-click="goPage('+(pb.pageIndex-2)+');">'+(pb.pageIndex-1)+'</a></li>';
			 content+='<li><a  ng-click="goPage('+(pb.pageIndex-1)+');">'+pb.pageIndex +'</a></li>';
			 content+='<li class="active"><span class="pageColor">'+(pb.pageIndex+1) +'</span></li>';
		  }else{
			  content+='<li><a  ng-click="goPage('+(pb.pageIndex-2)+');">'+(pb.pageIndex-1)+'</a></li>';
			  content+='<li><a  ng-click="goPage('+(pb.pageIndex-1)+');">'+pb.pageIndex +'</a></li>';
			  content+='<li class="active"><span class="pageColor">'+(pb.pageIndex+1) +'</span></li>';
			  content+='<li><a  ng-click="goPage('+(pb.pageIndex+1)+');">'+(pb.pageIndex+2)+'</a></li>';
			  content+='<li><a  ng-click="goPage('+(pb.pageIndex+2)+');">'+(pb.pageIndex+3)+'</a></li>';
		  }
		}else{
			for(var i=0;i<pb.totalPage;i++){
				if(i==pb.pageIndex){
					content+='<li class="active"><a href="javascript:void(0);">'+(pb.pageIndex+1)+'</a></li>';
				}else{
					content+='<li><a ><span class="pageColor"  ng-click="goPage('+i+');">'+(i+1)+'</span></a></li>';
				}
			}
		}
		
		if(pb.pageIndex==pb.nextPageIndex){
			content+='<li class="next disabled"><a href="javascript:void(0);"><i class="fa fa-chevron-right"></i></a></li>';
		}else{
			content+='<li><a  ng-click="goPage('+pb.nextPageIndex+');"><i class="fa fa-chevron-right"></i></a></li>';
		}
		
		content+='</ul></div>';
		
		content+='</div></footer>';
		content+='<div>';
		content+='<input type="hidden" id="pageIndex" name="pageIndex" value="'+pb.pageIndex+'"/>';
		content+='<input type="hidden" id="pageSize" name="pageSize" value=""'+pb.pageSize+'"/>';
		content+='</div>';
		$("#pbDiv").html(content);
	}	
}
</script>
<div id="pbDiv"></div>