public with sharing class SalesHeader_Factory {
    /**
     * Creates EFT_Transaction_Status object data
     *
     * @param count   Number of records to be created
     *
     * @return accounts List of Accounts
     */
    public static List<SalesHeader__c> createSalesHeader(Integer count) {
        List<SalesHeader__c> salesList = new List<SalesHeader__c>();
        List<Account> acc = AccountFactory.createAndInsertAccounts(1);
        List<Contact> cnt = ContactFactory.createAndInsertContacts(1);
        for (Integer i = 1; i <= count; i++) {
            SalesHeader__c sales = new SalesHeader__c();
            sales.Total_Amount__c = 3000;
            sales.Account__c = acc[0].Id;
            sales.Contact__c  = cnt[0].Id;
            
            salesList.add(sales);
        }
        return salesList;
    }

    /**
     * Creates and insert Account records.
     *
     * @param count   Number of records to be created
     *
     * @return accounts List of Accounts
     */
     public static List<SalesHeader__c> createAndInsertSales(Integer count) {
        List<SalesHeader__c> salesList = createSalesHeader(count);
        return insertData(salesList);
    }

    /**
     * Insert Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<SalesHeader__c> insertData(List<SalesHeader__c> salesList) {
        insert salesList;
        return salesList;
    }

    /**
     * Update Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<SalesHeader__c> updateData(List<SalesHeader__c> salesList) {
        update salesList;
        return salesList;
    }
}