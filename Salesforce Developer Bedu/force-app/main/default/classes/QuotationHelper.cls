public class QuotationHelper implements QuotationSync {
    public static Decimal initialConfig() {
		List<Account> accList = new List<Account> {
   			new Account(Name='Compumundo',EXTERNAI_ID__c='ACC0200',Rating='Hot'),
            new Account(Name='Compuworld',EXTERNAI_ID__c='ACC0201',Rating='Hot')
            };
	// Bulk insert all contacts with one DML call
	insert accList;
    //System.debug(accList);
    return(accList.size());

    }
    
    public List<Inventario__c> productsInventory() {
    	List<Inventario__c> inv= [select Name, CodigoProd__c,  Producto__r.Name,Producto__r.ExternalId, Cantidad_dis__c, Cantidad_apart__c  from Inventario__c ORDER BY CodigoProd__c  ASC Limit 200];
    	//System.debug(inv);
        return inv;
    }
    
    public boolean confirmProductExistByCode(String cproducto){
        List<Product2> existente = [SELECT Id FROM Product2 WHERE ExternalId = :cproducto LIMIT 1];
        if(existente.size()==0){
            return false;
        }
        
        else
            return true;
    }
    
    public Decimal searchProductByCode(String cproducto){
        if(confirmProductExistByCode(cproducto)){
            Inventario__c disponible= [select id, Cantidad_dis__c, Cantidad_apart__c FROM Inventario__c WHERE CodigoProd__c = :cproducto LIMIT 1 ];
            Decimal cdisponible= disponible.Cantidad_dis__c;
            
               return cdisponible; 
         
        }else 
            return 0;
    }
    
    public Decimal updateQuantity(Id product2Id, Decimal quantity){
        Product2 prod=[SELECT Name,ExternalId,ProductCode FROM Product2 where id= :product2Id];
        boolean existente = confirmProductExistByCode(prod.ProductCode);
        System.debug('existente'+existente);
       
        if(searchProductByCode(prod.ProductCode) > quantity && existente){
           
            //System.debug('existente'+disp);
            
                Inventario__c inv =[SELECT id, Name,Cantidad_dis__c, Cantidad_apart__c,CodigoProd__c FROM Inventario__c where CodigoProd__c = :prod.ProductCode LIMIT 1   ];
                inv.Cantidad_apart__c=inv.Cantidad_apart__c + quantity;
                inv.Cantidad_dis__c=inv.Cantidad_dis__c - quantity;
                update inv;
                System.debug('perro');
                return inv.Cantidad_dis__c;
                
                
        }else
            System.debug('algo falla');
        	return 0;
    }
    
    @InvocableMethod(label='StockAlert')
    public static void StockEmptyAlert(){
        List<Inventario__c> lstInv=new List<Inventario__c>();
        QuotationHelper qts= new QuotationHelper();
        
        lstInv=qts.productsInventory();
        List<FeedItem> feed = new List<FeedItem>();
        
        for(Inventario__c inv:lstInv){
            if(inv.Cantidad_dis__c<=1){
                FeedItem objPost = new FeedItem();
                objPost.ParentId=UserInfo.getUserId();
                objPost.Body='Producto sin Inventario';
                feed.add(objPost);
                inv.fecha_hora_Alerta__c=System.now();
            }
            update inv;
        }
        insert feed;
        
	}
}