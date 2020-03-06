package com.dalbit.content.controller.rest;

import com.dalbit.content.service.NoticeService;
import com.dalbit.content.vo.procedure.P_noticeInsertVo;
import com.dalbit.content.vo.procedure.P_noticeListInputVo;
import com.dalbit.content.vo.procedure.P_noticeListOutputVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@RestController
@RequestMapping("rest/content/notice")
public class NoticeRestController {

    @Autowired
    NoticeService noticeService;

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    MessageUtil messageUtil;

    /**
     * 사이트 공지 보기
     */
    @PostMapping("list")
    public String list(P_noticeListInputVo pNoticeListInputVo) {
        String result =noticeService.callServiceCenterNoticeList(pNoticeListInputVo);
        return result;
    }

    /**
     * 사이트 공지 등록
     */
    @PostMapping("insert")
    public String insert(P_noticeInsertVo pNoticeInsertVo) {
        String result = noticeService.callServiceCenterNoticeAdd(pNoticeInsertVo);
        return result;
    }

}
