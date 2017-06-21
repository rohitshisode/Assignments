/**************************************************************************************************
 * Class : AccountOpportunityBatchTest
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Test Class to test the functionality of AccountOpportunityBatch
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   09/06/2017    Initial Development
 **************************************************************************************************/
@isTest
private class AccountOpportunityBatchTest {
    @testSetup
    static void setup(){
        List<AccountContactRole> AccountContactRole_List = AccountContactRoleFactory.createAndInsertAccountContactRoles(10);
    }
    static testMethod void testAccount() {
        list <account> fetchedAccount_List;
        Test.StartTest();
        fetchedAccount_List = [select id,Name from account];
        System.debug('Account Proper:::::'+fetchedAccount_List);
        System.assertEquals(10, fetchedAccount_List.size());
        Test.StopTest();
    }
    
    static testMethod void testForAccountContactRoleOpportunity() {
        Test.StartTest();
        AccountOpportunityBatch obj = new AccountOpportunityBatch ();
        ID batchprocessid = Database.executeBatch(obj,200);
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =: batchprocessid];
        System.debug('Batch Id:::'+a);
        Test.StopTest();
        //System.assertEquals(10,a.JobItemsProcessed);
    }
}