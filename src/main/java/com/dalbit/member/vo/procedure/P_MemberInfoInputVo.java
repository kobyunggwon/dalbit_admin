package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class P_MemberInfoInputVo extends SearchVo {
    private String mem_no;
    private String memWithdrawal;
    private String auto_change;
}
