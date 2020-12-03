package com.dalbit.content.controller.rest;

import com.dalbit.content.service.Con_FullmoonService;
import com.dalbit.content.vo.procedure.P_FullmoonConditionInputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("rest/content/fullmoon")
public class Con_FullmoonRestController {

    @Autowired
    Con_FullmoonService con_fullmoonService;

    @Autowired
    GsonUtil gsonUtil;

    @PostMapping("/info/condition")
    public String fullmoonManagementSelect(P_FullmoonConditionInputVo pFullmoonConditionInputVo) {
        String result = con_fullmoonService.callFullmoonManagementSelect(pFullmoonConditionInputVo);
        return result;
    }

}