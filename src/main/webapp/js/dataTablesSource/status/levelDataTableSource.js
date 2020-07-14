var levelDataTableSource = {
    'memLevelList': {
        'url': '/rest/status/level/list'

        , 'columns': [
            {'title': '레벨', 'data' : 'level', 'width':'40px'}
            ,{'title': '명칭', 'data' : 'grade', 'width':'80px'}
            ,{'title': '경험치(비율)', 'data' : 'memExp', 'width':'80px', 'render': function (data, type, row, meta) {
                    return data + "(" + Number(row.expPro).toFixed(2) + "%)";
                }}
            ,{'title': '누적 경험치', 'data' : 'exp', 'width':'80px'}
            ,{'title': '회원번호', 'data' : 'mem_no', 'width':'80px', 'render': function (data, type, row, meta) {
                    return util.memNoLink(data, row.mem_no);
                }}
            ,{'title': '닉네임', 'data' : 'mem_nick', 'width':'80px'}
            ,{'title': '성별(나이)', 'data' : 'mem_sex', 'width':'80px','render' : function(data, type, row, meta) {
                    return common.sexIcon(data) + "(" + row.age.split('.')[0] + "세)";
                }}
            ,{'title': '태그', 'data' : '', 'width':'80px', 'render': function (data, type, row, meta) {
                    var tmp = "";
                    if(row.newdj_badge == "1"){
                        tmp = tmp + '<span class ="label" style="background-color:#d9c811">' + "신입" + '</span><br/>';
                    }
                    if(row.specialdj_badge == "1"){
                        tmp = tmp + '<span class ="label" style="background-color:red">' + "스페셜DJ" + '</span><br/>';
                    }
                    if(row.badge_value != "" && row.badge_value != null){
                        if(row.badge_value == 1){
                            tmp = tmp + '<span class ="label" style="background-color:#006ad9">' + "회장" + '</span><br/>';
                        }else if(row.badge_value == 2){
                            tmp = tmp + '<span class ="label" style="background-color:#d97c07">' + "부회장" + '</span><br/>';
                        }else if(row.badge_value == 3){
                            tmp = tmp + '<span class ="label" style="background-color:#0ed900">' + "사장" + '</span><br/>';
                        }
                    }
                    return tmp;
                }}
            ,{'title': '최근방송일시', 'data' : 'broadDate', 'width':'80px'}
            ,{'title': '최근청취일시', 'data' : 'listenDate', 'width':'80px'}
            ,{'title': '최근레벨업일시<br/>(며칠 전)', 'data' : 'levelUpDate', 'width':'80px','render' : function(data, type, row, meta) {
                    return data + '<br/>(' + row.levelUpDay + '일 전)';
                }}
            ,{'title': '보유달', 'data' : 'dal', 'width':'80px','render' : function(data){
                    return common.addComma(data) + "개"
                }}
            ,{'title': '보유별', 'data' : 'byeol', 'width':'80px','render' : function(data){
                    return common.addComma(data) + "개"
                }}
            ,{'title': '선물 한 수', 'data' : 'present', 'width':'80px','render' : function(data){
                    return common.addComma(data) + "개"
                }}
            ,{'title': '선물 받은 수', 'data' : 'receive', 'width':'80px','render' : function(data){
                    return common.addComma(data) + "개"
                }}
        ]
    },
}