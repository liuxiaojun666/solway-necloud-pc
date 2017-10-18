<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 定位 -->
<div class="modal fade bs-example-modal-lg" id="positioningModal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row modal-lg">
		<div class="modal-content ">
			<a class="icon-close modelCloseBtn" data-dismiss="modal"></a>
			<div class="modal-body wrapper-lg">
				<style type="text/css">
#allmap {
	width: 100%;
	height: 500px;
	overflow: hidden;
	margin: 0;
	font-family: "微软雅黑";
}
</style>
				<div id="allmap"></div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
// 	// 百度地图API功能
// 	var map = new BMap.Map("allmap");
// 	var point = new BMap.Point(116.404, 39.915);
// 	map.centerAndZoom(point, 15);
// 	var marker = new BMap.Marker(point); // 创建标注
// 	map.addOverlay(marker); // 将标注添加到地图中
// 	marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
</script>
