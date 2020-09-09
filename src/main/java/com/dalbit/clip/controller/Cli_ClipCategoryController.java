package com.dalbit.clip.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/clip/category")
public class Cli_ClipCategoryController {

    @GetMapping("/list")
    public String list() {
        return "clip/category/info";
    }
}
