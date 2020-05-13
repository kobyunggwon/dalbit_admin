package com.dalbit.member.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.dao.Mem_GiftDao;
import com.dalbit.member.vo.procedure.P_MemberGiftInputVo;
import com.dalbit.member.vo.procedure.P_MemberGiftOutputVo;
import com.dalbit.util.GsonUtil;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Mem_GiftService {

    @Autowired
    Mem_GiftDao mem_GiftDao;
    @Autowired
    GsonUtil gsonUtil;

    public String getGiftHistory(P_MemberGiftInputVo pMemberGiftInputVo){

        pMemberGiftInputVo.setPageNo(pMemberGiftInputVo.getPageNo() -1);
        pMemberGiftInputVo.setPageNo(pMemberGiftInputVo.getPageNo() * pMemberGiftInputVo.getPageCnt());
        ArrayList<P_MemberGiftOutputVo> giftList = null;

        int memberList_totalCnt = 0;
        if(pMemberGiftInputVo.getSlctType() == -1){
            giftList = mem_GiftDao.callGiftHistory_all(pMemberGiftInputVo);
            memberList_totalCnt = mem_GiftDao.callGiftHistory_all_totalCnt(pMemberGiftInputVo);
        }else if(pMemberGiftInputVo.getSlctType() == 0 || pMemberGiftInputVo.getSlctType() == 1){
            giftList = mem_GiftDao.callGiftHistory(pMemberGiftInputVo);
            memberList_totalCnt = mem_GiftDao.callGiftHistory_totalCnt(pMemberGiftInputVo);
        }else if(pMemberGiftInputVo.getSlctType() == 4 || pMemberGiftInputVo.getSlctType() == 5){
            giftList = mem_GiftDao.callGiftHistory_event(pMemberGiftInputVo);
            memberList_totalCnt = mem_GiftDao.callGiftHistory_event_totalCnt(pMemberGiftInputVo);
        }

        P_MemberGiftOutputVo summary = new P_MemberGiftOutputVo();

        int giftCnt = 0;
        int dalCnt = 0;
        for(int i=0;i<giftList.size();i++){
            giftCnt = giftCnt +  giftList.get(i).getItemCnt();
            dalCnt = dalCnt + giftList.get(i).getRuby();
        }
        summary.setGiftCnt(giftCnt);
        summary.setDalCnt(dalCnt);




        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.환전내역보기성공, giftList, new PagingVo(memberList_totalCnt),summary));
        return result;
    }
}
