package com.dalbit.customer.controller.rest;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.customer.service.Cus_QuestionService;
import com.dalbit.customer.vo.FaqVo;
import com.dalbit.customer.vo.procedure.P_QuestionDetailInputVo;
import com.dalbit.customer.vo.procedure.P_QuestionListInputVo;
import com.dalbit.customer.vo.procedure.P_QuestionOperateVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("rest/customer/question")
public class Cus_QuestionRestController {

    @Autowired
    Cus_QuestionService cus_questionService;

    @Autowired
    GsonUtil gsonUtil;

    /**
     * 1:1 신고 목록 조회
     */
    @PostMapping("list")
    public String list(P_QuestionListInputVo pQuestionListInputVo) {

        String result = cus_questionService.getQuestionList(pQuestionListInputVo);

        return result;
    }

    /**
     *  1:1 문의하기 상세 조회
     */
    @PostMapping("detail")
    public String detail(P_QuestionDetailInputVo pQuestionDetailInputVo) {
        return cus_questionService.callServiceCenterQnaDetail(pQuestionDetailInputVo);
    }

    /**
     *  1:1 문의하기 처리하기
     */
    @PostMapping("operate")
    public String operate(P_QuestionOperateVo pQuestionOperateVo) {
        return cus_questionService.callServiceCenterQnaOperate(pQuestionOperateVo);
    }

    @PostMapping("getFaqGroupList")
    public String getFaqGroupList(FaqVo faqVo){

        if(faqVo.getSlct_type() == 0){
            faqVo.setSlct_type(1);
        }

        List<FaqVo> faqGroupList = cus_questionService.getFaqGroupList();
        List<FaqVo> faqSubList = cus_questionService.getFaqSubList(faqVo);

        HashMap map = new HashMap();
        map.put("faqGroupList", faqGroupList);
        map.put("faqSubList", faqSubList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, map));
    }

    @PostMapping("getFaqSubList")
    public String getFaqSubList(FaqVo faqVo){

        if(faqVo.getSlct_type() == 0){
            faqVo.setSlct_type(1);
        }

        List<FaqVo> faqSubList = cus_questionService.getFaqSubList(faqVo);

        HashMap map = new HashMap();
        map.put("faqSubList", faqSubList);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, map));
    }

}
