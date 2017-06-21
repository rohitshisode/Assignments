/**************************************************************************************************
 * Class : EftHandler
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Helper class for EFT_Tigger, Validates EFT record data and creates case records accordingly.
 * Test Class : EFT_Test
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 *   1.0      Rohit Shisode   19/05/2016    Initial Development
 **************************************************************************************************/
public with sharing class EftHandler {
    /*Creates case records for EFT_Transactions condition checks*/
    
    public static void checkEftAndAddCases(List<EFT_Transaction_Status__c> eftList){
        AssignmentRule ar = [SELECT Id FROM AssignmentRule WHERE SobjectType ='Case' AND Active = true LIMIT 1];
        Database.DMLOptions dmlOptions = new Database.DMLOptions();
        dmlOptions.assignmentRuleHeader.assignmentRuleId = ar.Id;
        List<Case> caseList = new List<Case>(); 
        List<EFT_Transaction_Status__c> queryEftList = [SELECT Transaction_Date__c,Transaction_Status__c,SalesHeader__r.Status__c,
                                                  SalesHeader__r.Account__c,SalesHeader__r.Account__r.Name,SalesHeader__r.Contact__c
                                                  FROM EFT_Transaction_Status__c WHERE Id IN :eftList AND 
                                                  Method_of_Transaction__c = 'Credit Card Address Verify' AND
                                                  Transaction_Status__c = 'Declined' AND
                                                  SalesHeader__r.Status__c ='Open'];
        for(EFT_Transaction_Status__c eftL: queryEftList){
            Case newCase = createCaseRecords(eftL);
            newCase.setOptions(dmlOptions);
            caseList.add(newCase);
        }
        insert caseList;
    }
    
    /*Creates Case record with given mapping if above conditions are true*/
    
    public static Case createCaseRecords(EFT_Transaction_Status__c eft){
        Id devRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Assignment').getRecordTypeId();
        Case caseInstance = new Case();
        caseInstance.AccountId = eft.SalesHeader__r.Account__c;
        caseInstance.ContactId = eft.SalesHeader__r.Contact__c;
        caseInstance.RecordTypeId = devRecordTypeId;
        caseInstance.Origin = 'Internal';
        //caseInstance.Owner = 'AVS Queue';
        caseInstance.Reason = 'Address Did Not Verify';
        caseInstance.Status = 'New';
        caseInstance.Priority = 'High';
        caseInstance.Type = 'Address Did Not Verify';
        caseInstance.Subject = eft.SalesHeader__r.Account__r.Name+' '+caseInstance.Type;
        caseInstance.SalesHeader__c =eft.SalesHeader__c;
        caseInstance.Transaction_Status__c = eft.Transaction_Status__c;
        caseInstance.Order_Date__c = eft.Transaction_Date__c;
        return caseInstance;
    }
    
    
}