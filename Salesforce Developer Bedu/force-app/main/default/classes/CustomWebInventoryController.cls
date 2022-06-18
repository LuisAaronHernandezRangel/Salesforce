public class CustomWebInventoryController {
    private final sObject parent;
    public String  productCode {get;set;}
    public String  productName {get;set;}
    public Decimal productPrice {get;set;}
    public String  productExtID {get;set;}
	public Integer productQuantity{get;set;}
    public Decimal productInStock{get;set;}
    public boolean ifExist{get;set;}
    
    public CustomWebInventoryController(ApexPages.StandardController controller){
        parent=controller.getRecord();
    }

    public void Buscar(){
        QuotationHelper helper=new QuotationHelper();
        ifExist=helper.confirmProductExistByCode(productCode);
        productInStock=helper.searchProductByCode(productCode);
        
        //Inventario__c disponibleI= [select id, Cantidad_dis__c, Cantidad_apart__c FROM Inventario__c WHERE CodigoProd__c = :productCode LIMIT 1 ];
        Product2 disponibleP= [select id, ExternalId,Name FROM Product2 WHERE ProductCode = :productCode LIMIT 1 ];
        PricebookEntry disponiblePrice=[select id, UnitPrice FROM PricebookEntry WHERE ProductCode = :productCode LIMIT 1 ];
        
        productExtId=disponibleP.ExternalId;
        productName=disponibleP.Name;
        productPrice=disponiblePrice.UnitPrice;
        
    }
    
    public void Guardar(){
        
        QuotationHelper helperG=new QuotationHelper();
        Product2 disponibleP= [select id, ExternalId,Name FROM Product2 WHERE ProductCode = :productCode LIMIT 1 ];
        helperG.updateQuantity(disponibleP.id, productQuantity);
        
    }
    
    public void Cancelar(){
        //navigateToSObject('0Q0IY000000085s0');
    }
}