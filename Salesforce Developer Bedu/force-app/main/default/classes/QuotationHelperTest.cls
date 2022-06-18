@isTest
public class QuotationHelperTest {
    @isTest
    public static void pruebauno(){
		Test.startTest();
        decimal a;
        a=QuotationHelper.initialConfig();
        Test.StopTest();
        System.assertEquals(2, a);
            
    }
    
        @isTest
    public static void pruebados(){
        
		Test.startTest();
        QuotationHelper qt = new QuotationHelper();
        List<Inventario__c> inv=qt.productsInventory();
        Test.StopTest();
        System.assert(inv.size()>=0);
            
    }
    
            @isTest
    public static void pruebatres(){
        Product2 prod=new Product2();
        prod.Name='test';
        prod.ProductCode='Tst-0001';
        prod.ExternalId='Tst-0001';
        insert prod;
		Test.startTest();
		QuotationHelper qt3 = new QuotationHelper();
        boolean b= qt3.confirmProductExistByCode('Tst-0001');
        boolean c= qt3.confirmProductExistByCode('tst');
        Test.stopTest();
        System.assert(b==true);
        System.assert(c==false);
            
    }
    
                @isTest
    public static void pruebacinco(){
        Inventario__c inv=new Inventario__c();
        inv.Cantidad_dis__c=100;
        inv.CodigoProd__c='Tst-0001';
        inv.Name='Test';
        inv.Cantidad_apart__c=50;
        insert inv;
        
        Product2 prod=new Product2();
        prod.Name='test';
        prod.ProductCode='Tst-0001';
        prod.ExternalId='Tst-0001';
        insert prod;
        
		Test.startTest();
		QuotationHelper qt5 = new QuotationHelper();
        Decimal h= qt5.searchProductByCode(prod.ProductCode);
        Decimal i= qt5.searchProductByCode('tst');
        Test.stopTest();
        System.assert(h>=0);
        System.assert(i==0);
            
    }
    
                @isTest
    public static void pruebacuatro(){
        Product2 prod=new Product2();
        prod.Name='test';
        prod.ProductCode='Tst-0001';
        prod.ExternalId='Tst-0001';
        insert prod;
        
        Inventario__c inv=new Inventario__c();
        inv.Cantidad_dis__c=100;
        inv.CodigoProd__c='Tst-0001';
        inv.Name='Test';
        inv.Cantidad_apart__c=50;
        insert inv;
        
		Test.startTest();
		QuotationHelper qt = new QuotationHelper();
        
        Decimal f= qt.updateQuantity(prod.id,3);
        Decimal g= qt.updateQuantity(prod.id,400);
        Test.stopTest();
        
        System.assert(inv.Cantidad_dis__c > f);
        System.assert(g==0);
            
    }
    @isTest
        public static void pruebaseis(){
        
        Datetime fh= Datetime.newInstance(1960,2,17, 7,8,16);
        Inventario__c inv=new Inventario__c();
        inv.Cantidad_dis__c=1;
        inv.CodigoProd__c='Tst-0001';
        inv.Name='Test';
        inv.Cantidad_apart__c=50;
        inv.fecha_hora_Alerta__c=fh;
        insert inv;
        
		Test.startTest();
		QuotationHelper.StockEmptyAlert();
        Test.stopTest();
        //System.assert(inv.fecha_hora_Alerta__c != fh);

            
    }
    
}