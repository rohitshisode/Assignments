/**************************************************************************************************
 * Class : Opportunity_BeforeInsertHandler
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Trigger handler class to check for duplication in name of opportunity
 * Test Class : Opportunity_BeforeInsertHandlerTest
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   19/06/2017    Initial Development
 **************************************************************************************************/

public with sharing class Opportunity_BeforeInsertHandler {

/*
*Gets list of opportunity from trigger and processes it for name duplication
*@param: List of opportunity(From Trigger.new)
*/
    public static void checkOpportunityName(List<Opportunity> opportunityList){
        Set<String>uniqueNameSet = new Set<String>();
        Opportunity_Setting__c opportunitySetting = Opportunity_Setting__c.getInstance();
        if(!opportunitySetting.Disable_Opportunity_Before_Insert__c){
            for(Opportunity oppVar : opportunityList){
                if(uniqueNameSet.contains(oppVar.Name)){
                    oppVar.addError('A opportunity with same name exist in new records');
                } else{
                    uniqueNameSet.add(oppVar.Name);
                }
            }
            Set<String> uniqueNames = new Set<String>();
            List<Opportunity> duplicateOpportunity = [SELECT Id, Name FROM Opportunity WHERE Name = :uniqueNameSet];
            if(duplicateOpportunity != null){
                for(Opportunity oppVar : duplicateOpportunity){
                    uniqueNames.add(oppVar.Name);
                }
                for(Opportunity oppVar : opportunityList){
                    if(uniqueNames.contains(oppVar.Name)){
                        oppVar.addError('A opportunity with same name exist in organization');
                    }
                }
            }
        }
    }
}