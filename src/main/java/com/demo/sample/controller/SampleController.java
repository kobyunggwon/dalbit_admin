package com.demo.sample.controller;

import com.demo.sample.service.SampleService;
import com.demo.sample.vo.SampleVo;
import com.demo.common.vo.UserVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Slf4j
@Controller
public class SampleController {

    @Autowired
    SampleService sampleService;

    @GetMapping("sample")
    public String sayhello(Model model){

        int cnt = sampleService.getCount();
        log.debug("카운트는 ? : {}", cnt);

        List<SampleVo> list = sampleService.getList();
        log.debug("리스트 ? : {}", list);

        model.addAttribute("userInfo", UserVo.getUserInfo());

        return "welcome";
    }

    @GetMapping("login")
    public String login(){
        return "/login/login";
    }

    @GetMapping("admin")
    public String admin(){
        return "/admin";
    }

}
