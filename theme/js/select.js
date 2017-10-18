//***********全选及取消全选
//选择全部数据
function selectAll(value,ids){
	var objs = document.getElementsByName(ids);
	for(var i=0; i<objs.length; i++) {
	      	objs[i].checked = value;
  	}
}
//取消选择全部
function cancelSelectAll(value,checkBoxName,checkAll){
	var checked = true;
	var objs = document.getElementsByName(checkAll);
	var ccCodes = document.getElementsByName(checkBoxName);
	for(var i=0;i<ccCodes.length;i++){
		if(ccCodes[i].checked == false){
			checked = false;
		}
	}
	if(checked == false){
		objs[0].checked = false;
	}else{
		objs[0].checked = true;
	}
}
//检验是否选择了数据
function checkSelect(checkBoxName){
	var checked = false;
	var ccCodes = document.getElementsByName(checkBoxName);
	for(var i=0;i<ccCodes.length;i++){
		if(ccCodes[i].checked){
			checked = true;
		}
	}
	if(checked) {
		return true;
	}else {
		return false;
	}	
}

//检查复选框是否选中了至少一个值
function checkSelectedOne(checkBoxName){
	var message = "你确定要执行此操作吗？";
	
	var checked = false;
	var ccCodes = document.getElementsByName(checkBoxName);
	for(var i=0;i<ccCodes.length;i++){  
		if(ccCodes[i].checked){
			checked = true;
		}
	}
	if(checked) {
		if(confirm(message)) 
			return true;
		else 
		    return false;
	}
	else {
		alert("请至少选中一个值");
		return false;
	}	

}