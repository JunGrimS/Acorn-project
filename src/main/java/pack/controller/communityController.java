package pack.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class communityController {
	 
	@RequestMapping("community")
	public String community() {
		
		return "community";
	}
}
