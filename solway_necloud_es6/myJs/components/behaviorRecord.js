app.factory('myService', function () {
    let behaviorRecordArr = [];
    function push(obj) {
        behaviorRecordArr.push(obj);
    }
    function pop(index) {
        behaviorRecordArr = behaviorRecordArr.slice(0, index);
    }
    function set(index, obj) {
        behaviorRecordArr[i] = {
            ...behaviorRecordArr[i],
            ...obj
        };
    }
    function get() {
        return behaviorRecordArr;
    }

    return {
        set,
        get,
        push,
        pop
    }

});