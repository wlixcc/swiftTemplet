> 创建`NSManagedObject`自动赋值`CreateAt`


	public class ChargeModel: NSManagedObject {
	    
	    public override func awakeFromInsert() {
	        super.awakeFromInsert()
	        createAt = Date()
	    }
	
	}
		