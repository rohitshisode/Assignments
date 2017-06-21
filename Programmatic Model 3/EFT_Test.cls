/**************************************************************************************************
 * Test Class : EFT_Test
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : class to check functionality of EFT_Trigger
 * Trigger : EFT_Trigger
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 *   1.0      Rohit Shisode   19/05/2016    Initial Development
 **************************************************************************************************/
@isTest
private class EFT_Test {


//Checks for proper eft records that meet criteria to create a case records
    static testMethod void EFT_TestForProperEftRecord() {
        Test.startTest();
            List<EFT_Transaction_Status__c> eftList = EFT_DataFactory.createAndInsertEft(25);
            eftList = [SELECT Id
                            , SalesHeader__c
                            , SalesHeader__r.Account__c
                            , SalesHeader__r.Contact__c
                            , Transaction_Date__c
                            , Transaction_Status__c
                            , SalesHeader__r.Status__c
                            , SalesHeader__r.Account__r.Name
                       FROM EFT_Transaction_Status__c WHERE Id IN :eftList];
        Test.stopTest();
        List<Case> caseList = [SELECT Id, Type, Reason, Origin FROM Case Where Type = 'Address Did Not Verify' AND Origin = 'Internal'];
        System.assertEquals(caseList.size(),25);
        for(Case caseVar: caseList){
            for(EFT_Transaction_Status__c eft: eftList){
                if(eft.SalesHeader__c == caseVar.SalesHeader__c){
                    System.assertEquals(eft.SalesHeader__r.Account__c,caseVar.AccountId);
                    System.assertEquals(eft.SalesHeader__r.Contact__c,caseVar.ContactId);
                    System.assertEquals(eft.Transaction_Date__c,caseVar.Order_Date__c);
                }
            }
            
        }
    }
    
    
//Checks for single proper eft record that meets criteria to create a case record


    static testMethod void EFT_TestForSingleProperEftRecord() {
        Test.startTest();
            List<EFT_Transaction_Status__c> eftList = EFT_DataFactory.createAndInsertEft(1);
        Test.stopTest();
        List<Case> caseList = [SELECT Id, Type, Reason, Origin FROM Case Where Type = 'Address Did Not Verify' AND Origin = 'Internal'];
        System.assertEquals(caseList.size(),1);
    }
    
    
//Checks for eft records(Few of them meet the criteria) to create a case records


    static testMethod void EFT_TestForFewEftRecordMeetingCriteria() {
        Test.startTest();
            List<EFT_Transaction_Status__c> eftList = EFT_DataFactory.createEft(200);
            Boolean flag=true;
            for(EFT_Transaction_Status__c eft :eftList){
                if(flag){
                    eft.Method_of_Transaction__c = 'Debit Card Address Verify';
                    flag = false;
                }else{
                    flag=true;
                }
            }
            Insert eftList;
        Test.stopTest();
        List<Case> caseList = [SELECT Id, Type, Reason, Origin FROM Case Where Type = 'Address Did Not Verify' AND Origin = 'Internal'];
        System.assertEquals(caseList.size(),100);
    }


//Checks for improper eft records that DO NOT meet criteria to create a case records


    static testMethod void EFT_TestForEftRecordNotMeetingCriteria() {
        Test.startTest();
            List<EFT_Transaction_Status__c> eftList = EFT_DataFactory.createEft(200);
            for(EFT_Transaction_Status__c eft :eftList){
                    eft.Method_of_Transaction__c = 'Debit Card Address Verify';
            }
            Insert eftList;
        Test.stopTest();
        List<Case> caseList = [SELECT Id, Type, Reason, Origin FROM Case Where Type = 'Address Did Not Verify' AND Origin = 'Internal'];
        System.assertEquals(caseList.size(),0);
    }
}