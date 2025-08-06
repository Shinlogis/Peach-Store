package peachstore.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import peachstore.domain.SnapShot;
import peachstore.domain.User;

@Getter @Setter
@AllArgsConstructor
@NoArgsConstructor
public class PaymentSessionData {
    private String postCode;
    private String address;
    private String detailAddress;
    private List<SnapShot> snapshotList;
    private User user;

    public boolean isValid() {
        return snapshotList != null && !snapshotList.isEmpty();
    }
}
