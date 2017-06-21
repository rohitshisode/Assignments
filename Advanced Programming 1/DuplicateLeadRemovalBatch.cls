/**************************************************************************************************
 * Class : DuplicateLeadRemovalBatch
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Batch class to check for duplicate leads based on configurable criteria and deleting duplicate leads
 * Test Class : DuplicateLeadRemovalBatchTest
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   12/06/2017    Initial Development
 **************************************************************************************************/
global with sharing class DuplicateLeadRemovalBatch implements Database.Batchable<SObject>,Database.stateful {
//Total count of duplicate leads found and deleted in a process
    global Integer TotalNumberOfDuplicateLeads=0;
    //Instance of custom setting that allows for searching criteria to be configurable
    CriteriaForDuplicateLead__c criteria;
    //Set to store the unique name email and phone first time they appear
    Set<String> uniqueRecordIdentifierField=new Set<String>();
    //Constructor to initialize count varible and get configurations form custom settings
    global DuplicateLeadRemovalBatch(){
        TotalNumberOfDuplicateLeads=0;
        criteria=CriteriaForDuplicateLead__c.getInstance();
    }
//start method to select leads from org that do not have null email or phone
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id,Name,Email,Phone FROM Lead where Email!=\'\' OR Phone!=\'\'');
    }
//Execute method for current scope
    global void execute(Database.BatchableContext BC, List<Lead> scope){
        //List of duplicate leads that are going to be deleted
        List<Lead> duplicateLeads = new List<Lead>();
        for(Lead lead : scope){
            //Check aginst name if name is true in configuration
            if(criteria.Name__c){
                if(lead.Name!=''){
                    if(!uniqueRecordIdentifierField.contains(lead.Name)){
                        uniqueRecordIdentifierField.add(lead.Name);
                    }
                    else{
                        duplicateLeads.add(lead);
                        continue;
                    }
                }
            }
            //Check aginst email if eamil is true in configuration
            if(criteria.Email__c){
                if(lead.Email!=''){
                    if(!uniqueRecordIdentifierField.contains(lead.Email)){
                        uniqueRecordIdentifierField.add(lead.Email);
                    }
                    else{
                        duplicateLeads.add(lead);
                        continue;
                    }
                }
            }
            //Check aginst phone if phone is true in configuration
            if(criteria.Phone__c){
                if(lead.Phone!=''){
                    if(!uniqueRecordIdentifierField.contains(lead.Phone)){
                        uniqueRecordIdentifierField.add(lead.Phone);
                    }
                    else{
                        duplicateLeads.add(lead);
                        continue;
                    }
                }
            }
        }
        if(!duplicateLeads.isEmpty()){
            TotalNumberOfDuplicateLeads = TotalNumberOfDuplicateLeads + duplicateLeads.size();
            delete duplicateLeads;
        }
    }

      global void finish(Database.BatchableContext BC){
          System.debug('Total Number of duplicate leads deleted are :'+TotalNumberOfDuplicateLeads);
          
  }
}