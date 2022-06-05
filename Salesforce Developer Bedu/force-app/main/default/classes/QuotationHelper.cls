public class QuotationHelper {
    public static void initialConfig() {
		List<Account> accList = new List<Account> {
   			new Account(Name='Compumundo',EXTERNAI_ID__c='ACC0200',Rating='Hot'),
            new Account(Name='Compuworld',EXTERNAI_ID__c='ACC0201',Rating='Hot')
            };
	// Bulk insert all contacts with one DML call
	insert accList;
    System.debug(accList);
    }
    
    public static List<Inventario__c> productsInInventory() {
    	List<Inventario__c> inv= [select Name, CodigoProd__c,  Producto__r.Name,Producto__r.ExternalId, Cantidad_dis__c, Cantidad_apart__c  from Inventario__c ORDER BY CodigoProd__c  ASC Limit 200];
    	System.debug(inv);
        return inv;
    }
}