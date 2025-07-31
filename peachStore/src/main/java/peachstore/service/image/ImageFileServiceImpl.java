package peachstore.service.image;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import peachstore.exception.Uploadexception;
import peachstore.util.FileCommonManager;

/**
 * 공통 이미지 서비스 구현체
 * @author 김예진
 * @since 2025-07-31
 */
@Service
@RequiredArgsConstructor
public class ImageFileServiceImpl implements ImageFileService {

    private final FileCommonManager fileManager;

    @Override
    public Map<String, Object> saveImage(MultipartFile file, String fileDirName, String savePath) throws Uploadexception {
        List<String> savedFiles = fileManager.saveFiles(new MultipartFile[] { file }, savePath, fileDirName);

        Map<String, Object> result = new HashMap<>();
        result.put("fileDirName", fileDirName);
        result.put("savedFiles", savedFiles);
        return result;
    }

    @Override
    public void removeImage(String subDir, String subDirPrefix) throws Uploadexception {
        fileManager.remove(subDir, subDirPrefix);
    }
}