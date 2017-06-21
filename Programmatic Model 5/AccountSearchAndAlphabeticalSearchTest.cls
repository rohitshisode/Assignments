@isTest
private class AccountSearchAndAlphabeticalSearchTest {

    static testMethod void searchAccountsTest(){
       test.startTest();
       List<Account> accountList = AccountFactory.createAccounts(100);
       insert accountList;
       ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accountList);
       SearchRecordsAccount s=new SearchRecordsAccount(stdController);
       s.getstring = 'Acc';
       s.searchAccounts();
       test.stopTest();
       System.assertEquals(100,SearchRecordsAccount.accounts.size());
    }
    static testMethod void searchFailTest(){
        test.startTest();
        List<Account> accountList = AccountFactory.createAccounts(1);
        ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accountList);
        Test.setCurrentPage(Page.DisplayAllAccountRecords);
        SearchRecordsAccount s=new SearchRecordsAccount(stdController);
        s.getstring = 'Ac';
        s.searchAccounts();
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        System.debug('Masg:::'+msgs);
        String errorMsg=msgs[0].getDetail();
        system.assertEquals('Please enter atleast 3 characters',errorMsg);
        System.debug('Error Message:::'+errorMsg);
        test.stopTest();
    }
    
    static testMethod void displayByAlphabetTest() {
        test.startTest();
        List<Account> accounts = AccountFactory.createAccounts(100);
        insert accounts;
        ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accounts);
        SearchRecordsAccount s=new SearchRecordsAccount(stdController);
        s.alphabet = 'A';
        s.searchByAlphabet();
        test.stopTest();
        System.assertEquals(100, SearchRecordsAccount.accounts.size());
    }
    
    static testMethod void displayAllTest() {
        test.startTest();
        List<Account> accounts = AccountFactory.createAccounts(100);
        insert accounts;
        ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accounts);
        SearchRecordsAccount s=new SearchRecordsAccount(stdController);
        s.alphabet = 'All';
        s.searchByAlphabet();
        test.stopTest();
        System.assertEquals(100, SearchRecordsAccount.accounts.size());
    }
    static testMethod void clearLinkTest() {
        test.startTest();
        List<Account> accounts = AccountFactory.createAccounts(100);
        insert accounts;
        ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accounts);
        SearchRecordsAccount s=new SearchRecordsAccount(stdController);
        s.displayAllRecords();
        test.stopTest();
        System.assertEquals(100, SearchRecordsAccount.accounts.size());
        System.assertEquals(null,s.getstring);
    }
    static testMethod void remoteTest() {
        test.startTest();
        List<Account> accounts = AccountFactory.createAccounts(100);
        insert accounts;
        Account acc = [Select Id,Name from Account where Name = 'Account1'];
        Id accountId = acc.id;
        SearchRecordsAccount.deleteAcc(accountId);
        test.stopTest();
        List<Account> accountlist = [Select Id from Account];
        System.assertEquals(99, accountlist.size());
   }
}