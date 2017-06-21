/**************************************************************************************************
 * Class : AccountFactory
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Data-factory for account object, to test bulkify functionality
 **************************************************************************************************/
public with sharing class AccountFactory {
    /*public static List<Account> accountDummy(){
        List<Account> accList = new List<Account>();
        Account acc;
        for(Integer i=0;i<230;i++){
            acc = new Account(Name = 'Test'+String.valueof(i));
            accList.add(acc);
        }
        return accList;
    }*/
    /**
     * Creates Account object data with particular email domain field populated and inserts the record. 
     *
     * @return record of account
     */
    public static Account createAccountsWithDomain(Boolean flag) {
        Account account = new Account();
        account.Name = 'AccountSample';
        if(flag)
            account.Email_Domain__c = 'espl.com';
        insert account;
        return account;
    }
    /**
     * Creates Account object data
     *
     * @param count   Number of records to be created
     *
     * @return accounts List of Accounts
     */
    public static List<Account> createAccounts(Integer count) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 1; i <= count; i++) {
            Account account = new Account();
            account.Name = 'Account'+i;
            accounts.add(account);
        }
        return accounts;
    }

    /**
     * Creates and insert Account records.
     *
     * @param count   Number of records to be created
     *
     * @return accounts List of Accounts
     */
     public static List<Account> createAndInsertAccounts(Integer count) {
        List<Account> accounts = createAccounts(count);
        return insertData(accounts);
    }

    /**
     * Insert Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<Account> insertData(List<Account> accounts) {
        insert accounts;
        return accounts;
    }

    /**
     * Update Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<Account> updateData(List<Account> accounts) {
        update accounts;
        return accounts;
    }
}