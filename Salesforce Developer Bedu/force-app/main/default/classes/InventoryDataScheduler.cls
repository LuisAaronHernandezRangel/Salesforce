public class InventoryDataScheduler{
    @InvocableMethod(label='executingInventory')
    public static void execute(){
        ExternalLegacyConnection();
    }
    
    @future(callout=true) 
    public static void ExternalLegacyConnection(){
        String restAPIURL='https://64bjp0q5wg.execute-api.us-east-2.amazonaws.com/Implement/';
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setMethod('GET');
        httpRequest.setEndpoint(restAPIURL);
        String response='';
        try{
            Http http = new Http();
            httpResponse httpResponse = http.send(httpRequest);
                if(httpResponse.getStatusCode()==200) {
                    response=JSON.serializePretty(JSON.deserializeUntyped(httpResponse.getBody()));
                }else{
                    System.debug('httpResponse'+httpResponse.getBody());
                    throw new CalloutException(httpResponse.getBody());
                }
        }catch(System.Exception e){
            System.debug('ERROR'+ e);
            throw e;
        }
        
        System.debug('**response**: ' + response);
        if(response != ''){
            JSONParser parser= JSON.createParser(response);
            Double cantReservada=0;
            Integer cantReservadaInt=0;
            Decimal cantReservadaDec=0;
            
            List<Inventario__c> invList = new List<Inventario__c>();
            
            
            while(parser.nextToken()!=null){
                
                Inventario__c item = new Inventario__c();
                Inventario__c InventarioToUpdate;
                
                
                System.debug('TIPO'+parser.getCurrentToken());
                System.debug('VALOR'+parser.getText());
                
                
                if((parser.getCurrentToken()==JSONtoken.FIELD_NAME)&&(parser.getText()=='name')){
                    parser.nextToken();
                    item.Name=parser.getText();
                }
                else if((parser.getCurrentToken()==JSONtoken.FIELD_NAME)&&(parser.getText()=='ProductID')){
                    parser.nextToken();
                    item.CodigoProd__c=parser.getText();
                }
                   else if((parser.getCurrentToken()==JSONtoken.FIELD_NAME)&&(parser.getText()=='Quan')){
                    parser.nextToken();
                    item.Cantidad_dis__c=parser.getDecimalValue();
                    
                }
                   else if((parser.getCurrentToken()==JSONtoken.FIELD_NAME)&&(parser.getText()=='BlockedQuan')){
                    item.Cantidad_apart__c=parser.getDecimalValue();
                }
                   else if(parser.getCurrentToken()==JSONtoken.START_OBJECT){
                    parser.nextToken();
                    invList.add(item);
                }
            }
            
            update invList;
        }
    }
}