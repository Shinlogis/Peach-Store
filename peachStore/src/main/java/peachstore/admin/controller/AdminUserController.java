package peachstore.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Admin;
import peachstore.repository.admin.AdminDAOImpl;
import peachstore.util.PasswordUtil;

@Slf4j
@Controller
public class AdminUserController {

    @Autowired
    private AdminDAOImpl adminDAOImpl;

    // 로그인 폼
    @GetMapping("/user/loginform")
    public String getLoginForm() {
        return "/user/loginform"; 
    }

    // 로그인 처리
    @PostMapping("/user/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session) {

        // email 기반 관리자 조회
        Map<String, Object> param = new HashMap<>();
        param.put("email", email);
        Admin admin = adminDAOImpl.selectAdminByLogin(param);

        // 로그인 검증 (패스워드 해싱 & 비교)
        if (admin != null) {   
        	if (!admin.isActive()) {
            return "redirect:/admin/user/loginform?error=deactivated";
        }
            String hashed = PasswordUtil.hashPassword(password, admin.getSalt());
            if (hashed.equals(admin.getPassword())) {
                session.setAttribute("user", admin);
                return "redirect:/admin/main";
            } else {
                log.warn("비밀번호 불일치: 입력값={}, 기대값={}", hashed, admin.getPassword());
            }
        }
        return "redirect:/admin/user/loginform?error=1";
    }

    // 로그아웃
    @GetMapping("/user/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/main";
    }

    // 관리자 등록 폼
    @GetMapping("/user/registform")
    public String getRegisterForm(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("user");
        if (!"super".equalsIgnoreCase(admin.getRole())) {
            model.addAttribute("msg", "권한이 없습니다.");
            model.addAttribute("url", "/admin/main");
            return "/user/forbidden";
        }
        return "/user/registform";
    }

    @PostMapping("/user/regist")
    public String register(@RequestParam String email,
                           @RequestParam String adminName,
                           @RequestParam(defaultValue = "admin") String role,
                           HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("user");
        if (!"super".equalsIgnoreCase(admin.getRole())) {
            model.addAttribute("msg", "권한이 없습니다.");
            model.addAttribute("url", "/admin/main");
            return "/user/forbidden";
        }
    	
        // 1. 이메일 중복 체크
        Admin existingAdmin = adminDAOImpl.selectAdminByEmail(email);
        if (existingAdmin != null) {
            // 이미 사용중인 이메일
            return "redirect:/admin/user/registform?error=1";
        }

        // 2. 신규 등록 절차 (기존 코드)
        String password = email;
        String salt = PasswordUtil.generateSalt();
        String hashedPassword = PasswordUtil.hashPassword(password, salt);

        admin = new Admin();
        admin.setEmail(email);
        admin.setPassword(hashedPassword);
        admin.setSalt(salt);
        admin.setAdminName(adminName);
        admin.setRole(role);
        admin.setActive(true);

        int result = adminDAOImpl.insertAdmin(admin);
        if(result > 0){
            return "redirect:/admin/main";
        } else {
            return "redirect:/admin/user/registform?error=1";
        }
    }
    
    @GetMapping("/user/changepasswordform")
    public String getChangePasswordForm() {
        return "/user/changepasswordform"; 
    }
    
    
    @PostMapping("/user/changepassword")
    public String changePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if(admin == null) {
            return "redirect:/admin/user/loginform";
        }

        // 1. 새 비번 확인
        if (!newPassword.equals(confirmPassword)) {
            // 비밀번호 불일치 경고 처리 (에러 페이지 or 메시지)
            return "redirect:/admin/user/changepasswordform?error=mismatch";
        }

        // 2. 현재 비번 검증
        String hashedCurrent = PasswordUtil.hashPassword(currentPassword, admin.getSalt());
        if (!hashedCurrent.equals(admin.getPassword())) {
            // 현재 비번 불일치
            return "redirect:/admin/user/changepasswordform?error=wrongpw";
        }

        // 3. 새 비번 해싱 + salt 새로 생성
        String newSalt = PasswordUtil.generateSalt();
        String hashedNewPw = PasswordUtil.hashPassword(newPassword, newSalt);

        // 4. DB 업데이트
        Map<String, Object> param = new HashMap<>();
        param.put("adminId", admin.getAdminId());
        param.put("password", hashedNewPw);
        param.put("salt", newSalt);

        int result = adminDAOImpl.updatePassword(param);

        if(result > 0){
            // 세션 비밀번호/salt도 최신값으로 갱신(로그아웃 유도해도 됨)
            admin.setPassword(hashedNewPw);
            admin.setSalt(newSalt);
            session.setAttribute("user", admin);
            return "redirect:/admin/main?msg=pwchanged";
        } else {
            return "redirect:/admin/user/changepasswordform?error=fail";
        }
    }
    
    @PostMapping("/user/setactive")
    public String setActive(@RequestParam int adminId,
                            @RequestParam boolean isActive,
                            HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("user");
        if (!"super".equalsIgnoreCase(admin.getRole())) {
            model.addAttribute("msg", "권한이 없습니다.");
            model.addAttribute("url", "/admin/main");
            return "/user/forbidden";
        }

        Map<String, Object> param = new HashMap<>();
        param.put("adminId", adminId);
        param.put("isActive", isActive);

        int result = adminDAOImpl.updateIsActive(param);
        return "redirect:/admin/user/adminlist"; 
    }
    
    @GetMapping("/user/adminlist")
    public String getAdminList(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (!"super".equalsIgnoreCase(admin.getRole())) {
            model.addAttribute("msg", "권한이 없습니다.");
            model.addAttribute("url", "/admin/main");
            return "/user/forbidden";
        }
        List<Admin> adminList = adminDAOImpl.selectAll();
        model.addAttribute("adminList", adminList);
        return "/user/adminlist";
    }
}