package peachstore.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SnapShot {
	
	private int snapshot_id;
    private int product_id;
    private String product_name;
    private int price;
    private String size;
    private String capacity;
    private String color;
    private String engraving;
    private String filename;
    private String order_quantity;
}
