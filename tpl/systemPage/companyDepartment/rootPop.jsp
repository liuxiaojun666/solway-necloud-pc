<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal fade" id="rootPop">
    <div class="modal-dialog">
        <div class="modal-content wrapper-lg">
			<div class="clearfix">
				<div class="col-sm-5 text-center">
					<button class="btn" type="button">待授权人员</button>
					<ul id="select1" class="mt10 list-unstyled bgf3 list-group bdd" style="min-height: 400px;">
						<li class="list-group-item bdn bgf3"><a href="javascript:;">阿萨德佛</a></li>
						<li class="active list-group-item bdn bgf3"><a href="javascript:;">萨德佛</a></li>
					</ul>
				</div>
				<div class="col-sm-2 mt40 pt20">
					<ul class="pagination paginationGoTo">
						<li id="add_all"><a href="javascript:;" title="全部移到右侧">&raquo;</a></li><br>
						<li id="add" class="active"><a class="mt20" href="javascript:;" title="移动选择项到右侧">&gt;</a></li><br>
						<li id="remove" class="active"><a class="mt20" href="javascript:;" title="移动选择项到左侧">&lt;</a></li><br>
						<li id="remove_all"><a class="mt20" href="javascript:;" title="全部移到左侧">&laquo;</a></li>
					</ul>
				</div>
				<div class="col-sm-5 text-center">
					<button class="btn" type="button">已授权人员</button>
					<ul id="select2" class="mt10 list-unstyled list-group bgf3 bdd" style="min-height: 400px;">
						<li class="list-group-item bdn bgf3"><a href="javascript:;">阿萨佛</a></li>
						<li class="list-group-item bdn bgf3"><a href="javascript:;">萨佛</a></li>
					</ul>
				</div>
			</div>
			<div class="text-center mt20">
				<button class="btn btn-info" id="submitRootBtn" name="submitRootBtn" type="submit">保存</button>
				<button class="btn ml10" data-dismiss="modal" id="unRootBtn" name="unRootBtn" type="button">取消</button>
			</div>
        </div>
    </div>
</div>
<script>
	$(".list-group li").click(function(event) {
		$(this).toggleClass('active');
	});
	//移到右边
	$('#add').click(function(){
		if(!$("#select1 li").is(".active")){
			alert("请选择需要移动的选项")
		} else {
			$('#select1 li.active').removeClass('active').appendTo('#select2');
		}
	});
	//移到左边
	$('#remove').click(function(){
		if(!$("#select2 li").is(".active")){
			alert("请选择需要移动的选项")
		} else {
			$('#select2 li.active').removeClass('active').appendTo('#select1');
		}
	});
	//全部移到右边
	$('#add_all').click(function(){
		$('#select1 li').removeClass('active').appendTo('#select2');
	});
	//全部移到左边
	$('#remove_all').click(function(){
		$('#select2 li').removeClass('active').appendTo('#select1');
	});
	//双击选项
	$('#select1').dblclick(function(){ //绑定双击事件
		//获取全部的选项,删除并追加给对方
		$("li.active",this).appendTo('#select2'); //追加给对方
	});
	//双击选项
	$('#select2').dblclick(function(){
		$("li.active",this).appendTo('#select1');
	});
</script>
