/**
 * table合并单元格-列合并
 * @param _w_table_id：table id
 * @param _w_table_colnum：要合并的列（从1开始）
 */
function mergeColumn(_w_table_id, _w_table_colnum) {
	_w_table_firsttd = "";
	_w_table_currenttd = "";
	_w_table_SpanNum = 0;
	_w_table_Obj = $("#" + _w_table_id + " tr td:nth-child(" + _w_table_colnum
			+ ")");
	_w_table_Obj.each(function(i) {
		if (i == 0) {
			_w_table_firsttd = $(this);
			_w_table_SpanNum = 1;
		} else {
			_w_table_currenttd = $(this);
			if (_w_table_firsttd.text() == _w_table_currenttd.text()) {
				_w_table_SpanNum++;
				_w_table_currenttd.hide(); // remove();
				_w_table_firsttd.attr("rowSpan", _w_table_SpanNum);
			} else {
				_w_table_firsttd = $(this);
				_w_table_SpanNum = 1;
			}
		}
	});
}