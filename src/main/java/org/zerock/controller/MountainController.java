
package org.zerock.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.mountain.MountainVO;
import org.zerock.service.mountain.MountainService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping("/*")
@Log4j
public class MountainController {

	private MountainService service;
	
	// 산 등록
	@PostMapping("/register")
	public String register(MountainVO mountain,RedirectAttributes rttr) {
		
		service.register(mountain);
		
		log.info("register POST...");
	    
		//등록 성공시 
		rttr.addFlashAttribute("result",mountain.getNo());
		rttr.addFlashAttribute("confirm", mountain.getNo() + "글 등록 성공!");
		
		return "redirect: mountain/list";
	}
	
/*
	// 산 리스트
	@GetMapping("/list")
	public String list(@ModelAttribute("cri")Criteria cri , Model model) {
		List<MountainVO> list = service.getList(cri);
		return null;
		
		
	}
	
	// 산읽기(코스/명소/축제/맛집)
	public String read() {
		return "";
	}
	// 산 수정
	public String update() {
		return "";
	}
	// 산 삭제
	public String delete() {
		return "";
	}

	*/
}
