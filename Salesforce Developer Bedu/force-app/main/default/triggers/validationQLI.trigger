trigger validationQLI on QuoteLineItem (before insert) {
    
		QuoteLineItem qtregistro = Trigger.New[0];
        Id invId=qtregistro.Product2Id;
    
        List<Inventario__c> invlist = [SELECT Id,Cantidad_dis__c FROM Inventario__c WHERE Producto__c = :invId LIMIT 1];
        Inventario__c invreg=invlist[0];
        System.debug(invreg.Cantidad_dis__c);
 
    for(QuoteLineItem qt : Trigger.New){
        if(qt.Quantity > invreg.Cantidad_dis__c){
            qt.addError('Quantity no puede ser mayor que la cantidad disponible del producto elegido');
        }
    }
}