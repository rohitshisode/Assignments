@isTest
private class AccountTest {

    static testMethod void TestValidAccountClone() {
        Test.startTest();
            List <Account> acc = AccountFactory.createAndInsertAccounts(400);
        Test.stopTest();
        List<Account> accList = [SELECT Id,Name FROM Account WHERE Name LIKE '%Account%'];
        System.assertEquals(800,accList.size());
    }
    
    static testMethod void TestValidSingleAccountClone() {
        Test.startTest();
            List <Account> acc = AccountFactory.createAndInsertAccounts(1);
        Test.stopTest();
        List<Account> accList = [SELECT Id,Name FROM Account WHERE Name LIKE '%Account%'];
        System.assertEquals(2,accList.size());
    }

    
    static testMethod void TestInvalidAccountClone(){
        Test.startTest();
            List <Account> accList = AccountFactory.createAccounts(25);
        Test.stopTest();
        List<Account> accountList = new List<Account>(); 
        for(Account acc: accList){
            acc.Name=null;
        }
        try{
            insert accList;
            accountList = [SELECT Id,Name FROM Account WHERE Name LIKE '%Account%'];
        }catch(DMLException e){
            System.assertEquals(0,accountList.size());
        }
        
    }
}