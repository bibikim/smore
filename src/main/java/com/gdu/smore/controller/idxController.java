package com.gdu.smore.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class idxController {
	
    @GetMapping("/")
    public String index() {
      return "index";
    }

}
