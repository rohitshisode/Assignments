public with sharing class EFT_DataFactory {
    /**
     * Creates EFT_Transaction_Status object data
     *
     * @param count   Number of records to be created
     *
     * @return accounts List of Accounts
     */
    public static List<EFT_Transaction_Status__c> createEFT(Integer count) {
        List<EFT_Transaction_Status__c> eftList = new List<EFT_Transaction_Status__c>();
        List<SalesHeader__c> sales = SalesHeader_Factory.createAndInsertSales(1);
        for (Integer i = 1; i <= count; i++) {
            EFT_Transaction_Status__c eft = new EFT_Transaction_Status__c();
            eft.Method_of_Transaction__c = 'Credit Card Address Verify';
            eft.Transaction_Status__c = 'Declined';
            eft.Transaction_Date__c  = System.today();
            eft.SalesHeader__c = sales[0].Id;
            eftList.add(eft);
        }
        return eftList;
    }

    /**
     * Creates and insert Account records.
     *
     * @param count   Number of records to be created
     *
     * @return accounts List of Accounts
     */
     public static List<EFT_Transaction_Status__c> createAndInsertEft(Integer count) {
        List<EFT_Transaction_Status__c> eftList = createEFT(count);
        return insertData(eftList);
    }

    /**
     * Insert Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<EFT_Transaction_Status__c> insertData(List<EFT_Transaction_Status__c> eftList) {
        insert eftList;
        return eftList;
    }

    /**
     * Update Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<EFT_Transaction_Status__c> updateData(List<EFT_Transaction_Status__c> eftList) {
        update eftList;
        return eftList;
    }
}