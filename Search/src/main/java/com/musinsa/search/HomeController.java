package com.musinsa.search;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/api/keyword/suggestion", produces = "application/json; charset=utf-8")
	public @ResponseBody List<String> keyword(@RequestParam Map<String, Object> map) {
		List<String> list = new ArrayList<String>();
		list.add("나이키");
		list.add("나이키 골프");
		list.add("운동화 나이키");
		list.add("브랜드 나이키");
		list.add("반다나");
		
		
		String q = (String) map.get("q");
		
		List<String> suggestionList = new ArrayList<String>();
		if(q != null && !q.equals("")) {
			for(String str : list) {
				if(str.contains(q)) {
					suggestionList.add(str);
				}
			}
		}
		
		return suggestionList;
	}
}
