package com.dalbit.util;

import com.dalbit.common.code.Code;
import com.dalbit.inforex.vo.InforexDeptCode;
import com.dalbit.inforex.vo.InforexMember;
import com.dalbit.inforex.vo.InforexPosCode;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

@Slf4j
@Component
public class InforexApiUtil {

    private static HttpSession httpSession;
    @Autowired
    HttpSession currentHttpSession;
    @PostConstruct
    private void init () {
        httpSession = this.currentHttpSession;
    }

    public static InforexPosCode[] getInforexPosCode(){
        String sessionName = DalbitUtil.getProperty(Code.인포렉스_직급코드.getCode());
        InforexPosCode[] inforexPosCodes = (InforexPosCode[])httpSession.getAttribute(sessionName);
        if(DalbitUtil.isEmpty(inforexPosCodes)){
            String result = RestApiUtil.sendGet(DalbitUtil.getProperty(Code.인포렉스_직급코드.getDesc()));
            inforexPosCodes = new Gson().fromJson(result, InforexPosCode[].class);
            httpSession.setAttribute(sessionName, inforexPosCodes);
        }
        return inforexPosCodes;
    }

    public static InforexDeptCode[] getInforexDeptCode(){
        String sessionName = DalbitUtil.getProperty(Code.인포렉스_부서코드.getCode());
        InforexDeptCode[] inforexDeptCodes = (InforexDeptCode[])httpSession.getAttribute(sessionName);
        if(DalbitUtil.isEmpty(inforexDeptCodes)){
            String result = RestApiUtil.sendGet(DalbitUtil.getProperty(Code.인포렉스_부서코드.getDesc()));
            inforexDeptCodes = new Gson().fromJson(result, InforexDeptCode[].class);
            httpSession.setAttribute(sessionName, inforexDeptCodes);
        }
        return inforexDeptCodes;
    }

    public static InforexMember[] getInforexDutyCode(){
        String sessionName = DalbitUtil.getProperty(Code.인포렉스_직책코드.getCode());
        InforexMember[] inforexMembers = (InforexMember[])httpSession.getAttribute(sessionName);
        if(DalbitUtil.isEmpty(inforexMembers)){
            String result = RestApiUtil.sendGet(DalbitUtil.getProperty(Code.인포렉스_직책코드.getDesc()));
            inforexMembers = new Gson().fromJson(result, InforexMember[].class);
            httpSession.setAttribute(sessionName, inforexMembers);
        }
        return inforexMembers;
    }

    public static InforexMember[] getInforexMemberList(){
        String sessionName = DalbitUtil.getProperty(Code.인포렉스_임직원목록.getCode());
        InforexMember[] inforexMembers = (InforexMember[])httpSession.getAttribute(sessionName);
        if(DalbitUtil.isEmpty(inforexMembers)){
            String result = RestApiUtil.sendGet(DalbitUtil.getProperty(Code.인포렉스_임직원목록.getDesc()));
            inforexMembers = new Gson().fromJson(result, InforexMember[].class);
            httpSession.setAttribute(sessionName, inforexMembers);
        }
        return inforexMembers;
    }
}
