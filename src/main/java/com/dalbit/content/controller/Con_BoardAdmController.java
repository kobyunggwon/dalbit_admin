package com.dalbit.content.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/content/boardAdm")
public class Con_BoardAdmController {

    @GetMapping("/list")
    public String list() {
        return "content/boardAdm/list";
    }


    @GetMapping("/popup/editList")
    public String editList() {
        return "content/boardAdm/popup/editList";
    }

}
