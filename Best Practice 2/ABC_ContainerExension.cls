public with sharing class ABC_ContainerExension {
    public Invoice_Containers__c invoiceContainer{get;set;}
    public Map<String,String> mapExpenses{get;set;}
    public List<String> expenseLabelList{get;set;}
    public ABC_ContainerExension (ApexPages.StandardController controller)
    {
        invoiceContainer = (Invoice_Containers__c)controller.getRecord();
        invoiceContainer = [SELECT Service_Fee__c
                                 , Number_of_Containers__c
                                 , Cost_Per_Container__c
                                 , Total_Service_Cost__c
                                 , Number_of_Labours__c
                                 , Labour_Cost_Per_Unit__c
                                 , Total_Labour_Cost__c
                                 , Discount__c
                                 , Tax__c
                                 , Total__c
                            FROM Invoice_Containers__c 
                            WHERE Id=:invoiceContainer.Id];
        mapExpenses = new Map<String,String>();
        expenseLabelList = new List<String>();
        Double taxAmount, discountAmount,totalAmount;
        totalAmount = (invoiceContainer.Total_Service_Cost__c + invoiceContainer.Total_Labour_Cost__c);
        discountAmount = ((totalAmount * invoiceContainer.Discount__c)/100);
        taxAmount = (((totalAmount - discountAmount)*invoiceContainer.Tax__c)/100);
        mapExpenses.put('Total Service Fee', string.valueOf(invoiceContainer.Total_Service_Cost__c));
        mapExpenses.put('('+invoiceContainer.Number_of_Containers__c+' Containers at rate of '+invoiceContainer.Cost_Per_Container__c+')',' ');
        mapExpenses.put('Labour Cost', string.valueOf(invoiceContainer.Total_Labour_Cost__c));
        mapExpenses.put('('+invoiceContainer.Number_of_Labours__c+' Labours at rate of '+invoiceContainer.Labour_Cost_Per_Unit__c+')',' ');
        mapExpenses.put('Discount Amount('+invoiceContainer.Discount__c+'% Discount)', string.valueOf(discountAmount));
        mapExpenses.put('Tax Amount ('+invoiceContainer.Tax__c+'% Tax)',string.valueOf(taxAmount));
        mapExpenses.put('Total', string.valueOf(invoiceContainer.Total__c));
        System.debug('Map Of Expenses:::'+mapExpenses);
        expenseLabelList.addAll(mapExpenses.keySet());
        System.debug('List Of Expenses::::'+expenseLabelList);
    }
}