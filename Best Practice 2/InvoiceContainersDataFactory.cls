public with sharing class InvoiceContainersDataFactory {
    public static Invoice_Containers__c createInvoices(){
        List<Contact> contacts = ContactFactory.createAndInsertContacts(1);
        Invoice_Containers__c invoice = new Invoice_Containers__c();
        invoice.Contact__c = contacts[0].id;
        invoice.Labour_Cost_Per_Unit__c=2000;
        invoice.Number_of_Labours__c=10;
        invoice.Number_of_Containers__c = 50;
        invoice.Cost_Per_Container__c = 250;
        invoice.Service_Fee__c = 10000;
        invoice.Tax__c = 2;
        invoice.Discount__c = 2;
        return invoice;
    }

   public static Invoice_Containers__c createAndInsertInvoices()
   {
       Invoice_Containers__c invoice = createInvoices();
       insert invoice;
       return invoice;
   }

}