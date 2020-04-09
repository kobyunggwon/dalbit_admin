package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import com.dalbit.util.DalbitUtil;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
public class P_MemberListOutputVo extends SearchVo {

    private String mem_userid;
    private String mem_no;
    private String mem_nick;
    private String memName;
    private String mem_phone;
    private String mem_slct;
    private int connectCnt;
    private String payCntAmount;
    private int mem_state;
    private String connectState;
    private String liveBroad;

    private Date joinDate;
    private String joinDateFormat;
    private Date last_connect_date;
    private String last_connect_DateFormat;

    public void setJoinDate(Date joinDate){
        this.joinDate = joinDate;
        this.joinDateFormat = DalbitUtil.convertDateFormat(joinDate, "yyyy.MM.dd HH:mm:ss");
    }
    public void setLast_connect_date(Date last_connect_date){
        this.last_connect_date = last_connect_date;
        this.last_connect_DateFormat = DalbitUtil.convertDateFormat(last_connect_date, "yyyy.MM.dd HH:mm:ss");
    }
}
