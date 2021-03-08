package com.dalbit.event.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/event")
public class GGamGGamEController {

    @GetMapping("/ggamggame/info")
    public String GGamGGamEList() {
        return "event/ggamggame/info";
    }

}
