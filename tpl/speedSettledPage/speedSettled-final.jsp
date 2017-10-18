<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="m-t-lg col-sm-12 no-padder text-center">
	<p class="font-big-1 black-1"><i class="fa fa-check" style="color: #54a886"></i> 恭喜您，入驻成功</p>
</div>
<div class="col-sm-12 no-padder text-center m-t-xxl"> 
	<div class="col-sm-push-2 col-sm-8 well">
		<div class="col-sm-6 speedSettled-download-A" style="cursor:pointer">
			<h4><i class="fa fa-check-circle"></i> 下载数据采集</h4>
			<small>
				数据采集的简介，数据采集的简介
				数据采集的简介，数据采集的简介
				数据采集的简介，数据采集的简介
				数据采集的简介，数据采集的简介
				数据采集的简介，数据采集的简介
				数据采集的简介，数据采集的简介
			</small>
		</div>
		<div class="col-sm-6 speedSettled-download-B" style="cursor:pointer">
			<h4><i class="fa fa-check-circle"></i> 下载数据包</h4>
			<small>
				数据包的简介，数据包的简介
				数据包的简介，数据包的简介
				数据包的简介，数据包的简介
				数据包的简介，数据包的简介
				数据包的简介，数据包的简介
				数据包的简介，数据包的简介
			</small>
		</div>
		
		<button class="btn size-lg btn-green m-t-xxl" type="button" onclick="">下 载</button>
	</div>
</div>
<script type="text/javascript">
$(function(){
	
	//点击删除_弹出弹窗
	$(".speedSettled-download-A").on("click",function (){
			clickI($(".speedSettled-download-A"));
		}
	);
	
	$(".speedSettled-download-B").on("click",function (){
			clickI($(".speedSettled-download-B"));
		}
	);
	
});

/*
 * 点击复选区域
 */
function clickI(sd) {

	var i = sd.find("i");
	
	if(i.hasClass("fa fa-check-circle")){
		i.removeClass();
		i.addClass("fa fa-circle-thin");
	}
	else if(i.hasClass("fa fa-circle-thin")){
		i.removeClass();
		i.addClass("fa fa-check-circle");
	}
	else{
		i.removeClass();
		i.addClass("fa fa-circle-thin");
	}

}
</script>