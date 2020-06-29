package com.dalbit.status.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/status/appVersion")
public class Sta_AppVersionController {

    @GetMapping("/list")
    public String list() {
        return "status/appVersion/list";
    }


}
