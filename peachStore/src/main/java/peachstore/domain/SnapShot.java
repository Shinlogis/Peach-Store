package peachstore.domain;

import lombok.Data;

@Data
public class SnapShot {
	
	private int snapshotId;
    private int productId;
    private String productName;
    private int price;
    private String size;
    private String capacity;
    private String color;
    private String engraving;

}
