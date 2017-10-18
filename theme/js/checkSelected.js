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
function checkSelect(checkBoxName){
	return checkSelectMsg(checkBoxName,"请至少选中一个值");
}

function checkSelectMsg(checkBoxName,msg){
	
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
		alert(msg);
		return false;
	}	

}

function changeAll(value,ids){
				var objs = document.getElementsByName(ids);
				for(var i=0; i<objs.length; i++) {
				      	objs[i].checked = value;
			  	}
			}
			
			
			/** 
*删除数组指定下标或指定对象 
*/  
Array.prototype.remove=function(obj){  
    for(var i =0;i <this.length;i++){  
        var temp = this[i];  
        if(!isNaN(obj)){  
            temp=i;  
        }  
        if(temp == obj){  
            for(var j = i;j <this.length;j++){  
                this[j]=this[j+1];  
            }  
            this.length = this.length-1;  
        }     
    }  
} 
