package peachstore.admin.controller;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Admin;
import peachstore.repository.admin.AdminDAOImpl;

@Slf4j
@Controller
public class AdminUserController {

	
    @Autowired
    private AdminDAOImpl adminDAOImpl;

    // 관리자 로그인 폼 요청
    @GetMapping("/user/loginform")
    public String getLoginForm() {
        return "/user/loginform"; 
    }

    // 관리자 로그인 처리
    @PostMapping("/user/login")
    public String login(@RequestParam String id,
                        @RequestParam String password,
                        HttpSession session) {

        Admin admin = adminDAOImpl.login(id, password);

        if (admin != null) {
            session.setAttribute("user", admin); // 사용자 세션 키 유지 (user 그대로)
            return "redirect:/admin/main"; 
        } else {
            return "redirect:/admin/user/loginform?error=1"; // 로그인 실패
        }
    }

    // 로그아웃
    @GetMapping("/admin/user/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/main";
    }
}