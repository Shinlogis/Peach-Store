package peachstore.shop.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import peachstore.domain.SnapShot;
import peachstore.service.snapshot.SnapShotService;

@RestController
public class SnapshotController {

    @Autowired
    private SnapShotService snapshotService;

    @PostMapping("/returnsnapshot")
    @ResponseBody
    public ResponseEntity<List<SnapShot>> handleSnapshotInsertAndReturn(@RequestBody List<SnapShot> snapshotList, HttpSession session) {
        try {
            // 1. 스냅샷 리스트 DB에 저장 (insert만)
            snapshotService.insertSnapshots(snapshotList);

            // 2. 저장된 snapshot_id를 기반으로 다시 조회
            List<SnapShot> result = snapshotService.getInsertedSnapshots(snapshotList);
            System.out.println("스냅샷 수신 완료: " + snapshotList.size());

            // 3. 세션에 저장
            session.setAttribute("cartSnapshots", result);

            // 4. 클라이언트에 저장된 데이터 반환
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            e.printStackTrace();  // 디버깅을 위해 예외 로그 출력
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
