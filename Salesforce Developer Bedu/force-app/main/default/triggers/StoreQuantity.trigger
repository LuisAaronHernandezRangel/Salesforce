trigger StoreQuantity on QuoteLineItem (after update, after insert) {
	QuoteLineItem qt= new QuoteLineItem();
    for(QuoteLineItem elem:Trigger.New){
        qt=elem;
    }
    QuotationHelper qot= new QuotationHelper();
    System.debug(qt.Product2Id+' '+qt.Quantity);
    qot.updateQuantity(qt.Product2Id,qt.Quantity);
    
}