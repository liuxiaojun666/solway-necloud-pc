Array.prototype.lastIndexOf = function(e) {
	for (var i = this.length - 1, j; j = this[i]; i--) {
		if (j == e) {
			return i;
		}
	}
	return -1;
}

Array.prototype.contains = function (val) {
	var i = this.length;
	while (i--) {
		if (this[i] === val) {
			return true;
		}
	}
	return false;
}
Array.prototype.removeByValue = function(val) {
	for(var i=0; i<this.length; i++) {
		if(this[i] == val) {
			this.splice(i, 1);
			break;
		}
	}
}
/**
 * each��һ�����ϵ���������������һ��������Ϊ������һ���ѡ�Ĳ���
 * ��������������ν����ϵ�ÿһ��Ԫ�غͿ�ѡ�����ú������м��㣬��������õĽ��������
 {%example
 <script>
      var a = [1,2,3,4].each(function(x){return x > 2 ? x : null});
      var b = [1,2,3,4].each(function(x){return x < 0 ? x : null});
      alert(a);
      alert(b);
 </script>
 %}
 * @param {Function} fn ���е����ж��ĺ���
 * @param more ... ���������ѡ���û��Զ������
 * @returns {Array} ����������û�н�������ؿռ�
 */
Array.prototype.each = function (fn) {
    fn = fn || Function.K;
    var a = [];
    var args = Array.prototype.slice.call(arguments, 1);
    for (var i = 0; i < this.length; i++) {
        var res = fn.apply(this, [this[i], i].concat(args));
        if (res != null) a.push(res);
    }
    return a;
};

/**
 * �õ�һ�����鲻�ظ���Ԫ�ؼ���<br/>
 * Ψһ��һ������
 * @returns {Array} �ɲ��ظ�Ԫ�ع��ɵ�����
 */
Array.prototype.uniquelize = function () {
    var ra = new Array();
    for (var i = 0; i < this.length; i++) {
        if (!ra.contains(this[i])) {
            ra.push(this[i]);
        }
    }
    return ra;
};

/**
 * ���������ϵĲ���
 {%example
 <script>
      var a = [1,2,3,4];
      var b = [3,4,5,6];
      alert(Array.complement(a,b));
 </script>
 %}
 * @param {Array} a ����A
 * @param {Array} b ����B
 * @returns {Array} �������ϵĲ���
 */
Array.complement = function (a, b) {
    return Array.minus(Array.union(a, b), Array.intersect(a, b));
};

/**
 * ���������ϵĽ���
 {%example
 <script>
      var a = [1,2,3,4];
      var b = [3,4,5,6];
      alert(Array.intersect(a,b));
 </script>
 %}
 * @param {Array} a ����A
 * @param {Array} b ����B
 * @returns {Array} �������ϵĽ���
 */
Array.intersect = function (a, b) {
    return a.uniquelize().each(function (o) {
        return b.contains(o) ? o : null
    });
};

/**
 * ���������ϵĲ
 {%example
 <script>
      var a = [1,2,3,4];
      var b = [3,4,5,6];
      alert(Array.minus(a,b));
 </script>
 %}
 * @param {Array} a ����A
 * @param {Array} b ����B
 * @returns {Array} �������ϵĲ
 */
Array.minus = function (a, b) {
    return a.uniquelize().each(function (o) {
        return b.contains(o) ? null : o
    });
};

/**
 * ���������ϵĲ���
 {%example
 <script>
      var a = [1,2,3,4];
      var b = [3,4,5,6];
      alert(Array.union(a,b));
 </script>
 %}
 * @param {Array} a ����A
 * @param {Array} b ����B
 * @returns {Array} �������ϵĲ���
 */
Array.union = function (a, b) {
    return a.concat(b).uniquelize();
};