@isTest
private class ABC_ContainerExtensionTest {

    static testMethod void invoiceGenerationTest() {
        test.startTest();
        Invoice_Containers__c invoice = InvoiceContainersDataFactory.createAndInsertInvoices();
        ApexPages.StandardController stdController = new ApexPages.StandardController(invoice);
        ABC_ContainerExension invoiceVar = new ABC_ContainerExension(stdController);
        test.stopTest();
        Invoice_Containers__c inv = [SELECT Service_Fee__c
                                          , Total_Labour_Cost__c
                                          , Total_Service_Cost__c
                                          , Discount__c
                                          , Tax__c
                                          , Total__c 
                                     FROM Invoice_Containers__c][0];
        System.assertEquals(inv.Service_Fee__c, invoiceVar.invoiceContainer.Service_Fee__c);
        System.assertEquals(inv.Total_Labour_Cost__c, invoiceVar.invoiceContainer.Total_Labour_Cost__c);
        System.assertEquals(inv.Total_Service_Cost__c,invoiceVar.invoiceContainer.Total_Service_Cost__c);
        System.assertEquals(inv.Discount__c, invoiceVar.invoiceContainer.Discount__c);
        System.assertEquals(inv.Tax__c, invoiceVar.invoiceContainer.Tax__c);
        System.assertEquals(inv.Total__c, invoiceVar.invoiceContainer.Total__c);
        System.assert(invoiceVar.mapExpenses != null);
        System.assert(invoiceVar.expenseLabelList != null);
    }
    static testMethod void invoiceGenerationHardCodedTest(){
        test.startTest();
        Invoice_Containers__c invoice = InvoiceContainersDataFactory.createAndInsertInvoices();
        ApexPages.StandardController stdController = new ApexPages.StandardController(invoice);
        ABC_ContainerExension invoiceVar = new ABC_ContainerExension(stdController);
        test.stopTest();
        System.assertEquals(10000, invoiceVar.invoiceContainer.Service_Fee__c);
        System.assertEquals(20000, invoiceVar.invoiceContainer.Total_Labour_Cost__c);
        System.assertEquals(22500,invoiceVar.invoiceContainer.Total_Service_Cost__c);
        System.assertEquals(2, invoiceVar.invoiceContainer.Discount__c);
        System.assertEquals(2, invoiceVar.invoiceContainer.Tax__c);
        System.assertEquals(42483, invoiceVar.invoiceContainer.Total__c);
    }
}