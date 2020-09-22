package com.dalbit.content.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/content/push")
public class PushController {

    @GetMapping("/list")
    public String list() {
        return "content/push/list";
    }

    @GetMapping("/popup")
    public String popup() {
        return "content/push/pushPopup";
    }
}
