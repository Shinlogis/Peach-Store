package peachstore.repository.admin;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import peachstore.domain.Admin;

@Repository
@RequiredArgsConstructor
@Slf4j
public class AdminDAOImpl implements AdminDAO {

    private final SqlSessionTemplate sqlSessionTemplate;
    private static final String NAMESPACE = "Admin";

    @Override
    public Admin selectById(int adminId) {
        Admin admin = sqlSessionTemplate.selectOne(NAMESPACE + ".selectById", adminId);
        return admin;
    }

    @Override
    public int insertAdmin(Admin admin) {
        int result = sqlSessionTemplate.insert(NAMESPACE + ".insertAdmin", admin);
        return result;
    }

    @Override
    public Admin selectAdminByLogin(Map<String, Object> map) {
        Admin admin = sqlSessionTemplate.selectOne(NAMESPACE + ".selectByLogin", map);
        return admin;
    }

    @Override
    public List<Admin> selectAll() {
        List<Admin> list = sqlSessionTemplate.selectList(NAMESPACE + ".selectAll");
        return list;
    }

    @Override
    public int updatePassword(Map<String, Object> map) {
        int result = sqlSessionTemplate.update(NAMESPACE + ".updatePassword", map);
        return result;
    }

    @Override
    public int updateIsActive(Map<String, Object> map) {
        int result = sqlSessionTemplate.update(NAMESPACE + ".updateIsActive", map);
        return result;
    }

    @Override
    public int updateAdminInfo(Admin admin) {
        int result = sqlSessionTemplate.update(NAMESPACE + ".updateAdminInfo", admin);
        return result;
    }
    
    public Admin selectAdminByEmail(String email) {
        return sqlSessionTemplate.selectOne("Admin.selectAdminByEmail", email);
    }
}
