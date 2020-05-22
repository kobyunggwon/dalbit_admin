var payDataTableSource = {
    'payList': {
        'url': '/rest/payment/pay/list'

        , 'columns': [
            /*{'title': '주문번호', 'data': 'order_id'}*/
             {'title': '회원번호 <br /> 닉네임', 'data' : 'data', 'width':'80px', 'render': function(data, type, row) {
                    return '<a href="javascript://" class="_openMemberPop" data-memNo="' + row.mem_no + '">' + row.mem_no + '</a> </br> '+row.mem_nick+''
                }}
            , {'title': '수단', 'data': 'pay_way', 'width':'60px', 'render': function(data, type, row) {
                    return codeString(data);
                }}
            , {'title': '정보', 'data': 'data', 'width':'120px', 'render': function(data, type, row) {
                    var info="";
                    if(row.pay_way == 'MC'){
                        info = common.phoneNumHyphen(row.pay_info_no);
                    } else if(row.pay_way == 'CN'){
                        info = common.cardNo(row.pay_info_no) + '<br/>' + row.pay_info_nm;
                    } else if(row.pay_way == 'VA'){
                        info = row.pay_info_no + '<br/>' + bankCodeToString(row.pay_info_nm);
                    } else {
                        info = '-'
                    }

                    return info;
                }}
            , {'title': '시도일시', 'data': 'pay_dt_comein', 'width':'80px', 'render': function(data, type, row) {
                    return common.convertToDate(data, 'YYYY-MM-DD HH:mm:ss');
                }}
            , {'title': '완료일시', 'data': '', 'width':'80px', 'render': function(data, type, row) {
                    return row.pay_yn == 'y' ? row.pay_ok_date + '<br/>' + row.pay_ok_time : '-';
                }}
            , {'title': '결제<br />아이템', 'data': 'pay_code', 'width':'60px'}
            , {'title': '금액', 'data': '', 'width':'80px', 'render': function(data, type, row) {
                    var tmp = row.pay_slct + '<br/>' + (row.pay_slct == 'KRW') ? common.addComma(row.pay_amt.split(".")[0]) + '원' : row.pay_amt.split(".")[0];
                    return tmp;
                }}
            , {'title': '취소 시<br/>차감 달', 'data': 'dal_cnt', 'width':'55px', 'render': function(data, type, row) {
                    return (row.pay_yn == 'y' && row.cancel_state == 'n')  ? common.addComma(data) : '-';
                }}
            , {'title': '보유 달', 'data': 'tot_dal_cnt', 'width':'55px', 'render': function(data, type, row) {
                    return common.addComma(data);
                }}
            , {'title': '직원<br/>여부', 'data': 'chrgr_yn', 'width':'30px', 'render': function(data, type, row) {
                    return data.toUpperCase();
                }}
            , {'title': '플랫폼', 'data': 'os', 'width':'40px', 'render': function(data, type, row) {
                    return osGubun(data);
                }}
            , {'title': '취소일시', 'data': '', 'width':'80px', 'render': function(data, type, row) {
                    return row.cancel_state == 'y' ? row.cancel_dt : '-';
                }}
            , {'title': '취소실패사유', 'data': 'fail_msg', 'width':'250px', 'render': function(data, type, row) {
                    return !common.isEmpty(row.fail_msg) ? row.fail_msg : '-';
                }}
            , {'title': '처리자', 'data': 'op_name', 'width':'80px'}
            , {'title': '결제<br />상태', 'data': 'pay_yn', 'width':'30px', 'render': function(data, type, row) {
                    return '<label style="color: #ee0648; font-weight: bold">'+data.toUpperCase()+'</label>';
                }}
            , {'title': '취소<br />상태', 'data': 'cancel_state', 'width':'30px', 'render': function(data, type, row) {
                    return '<label style="color: #0b38aa; font-weight: bold">'+data.toUpperCase()+'</label>';
                }}
            , {'title': '취소', 'data': '', 'width':'80px', 'render': function(data, type, row) {

                return (row.pay_way == 'VA' || row.pay_yn == 'n' || row.cancel_state != 'n') ? '-' : (row.tot_dal_cnt < row.dal_cnt) ? "보유 달 부족" :
                        /*'<button type="button" class="btn btn-default cancelBtn" ' +
                                'data-paycd="'+ row.pay_way+'" ' +
                                'data-tradeid="'+row.order_id+'" ' +
                                'data-mobilid="'+row.bill_id+'" ' +
                                'data-prdtprice="'+row.pay_amt.split(".")[0]+'" ' +
                                'data-storeid="'+row.store_id+'" ' +
                                'data-memno="'+row.mem_no+'" ' +
                                'data-dalcnt="'+row.dal_cnt+'" ' +
                                'data-memnick="'+row.mem_nick+'" ' +
                                'onclick="cancelClick($(this).data())"> 취소' +
                         '</button>'*/
                    '-'
            }}
        ]
        , 'comments': ''
    },
}