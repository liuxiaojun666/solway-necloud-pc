function showModal(modalId){
	$('#'+modalId).modal('show');
}
function hideModal(modalId){
	$('#'+modalId).modal('hide');
	//$('#'+modalId+'form').validate().resetForm();
}
function addData(modalId){
	initPageData();
	showModal(modalId);
}
function editData(id,modalId){
	initPageData(id);
	showModal(modalId);
}
function viewData(id,modalId){
	initPageData(id);
	showModal(modalId);
}
/**
 * 主从结构，添加从表数据
 * @param modalId
 */
function addSlaveData(modalId) {
	initSlavePageData('', modalId);
	showModal(modalId);
}
/**
 * 主从结构，修改从表数据
 * @param modalId
 */
function editSlaveData(id,modalId){
	initSlavePageData(id, modalId);
	showModal(modalId);
}
/**
 * 主从结构，显示从表数据
 * @param id
 * @param modalId
 */
function viewSlaveData(id,modalId){
	initSlaveDetailData(id, modalId);
	showModal(modalId);
}
function editDataThreshold(id,modalId){
	initThresholdData(id);
	showModal(modalId);
	PageData(id);
}
//表格过滤
app.filter('orderClass', function() {
	  return function (direction) {
	    if (direction === -1)
	      return "fa fa-angle-down";
	    else
	      return "fa fa-angle-up";
	  }
	});

//分页
app.filter('paging', function() {
	  return function (items, index, pageSize) {
	    if (!items)
	      return [];

	    var offset = (index - 1) * pageSize;
	    return items.slice(offset, offset + pageSize);
	  }
	});
app.filter('size', function() {
	  return function (items) {
	    if (!items)
	      return 0;

	    return items.length || 0
	  }
	});
