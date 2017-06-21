/**************************************************************************************************
 * Trigger : SampleOpportunityTrigger
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Trigger to check context variable for opporuntity on Update
 * Test Class : 
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 *   1.0      Rohit Shisode   17/05/2016    Initial Development
 **************************************************************************************************/
trigger SampleOpportuniyTrigger on Opportunity (after update) {
    TriggerSetting__c ts = TriggerSetting__c.getInstance();
    if(ts.Opportunity__c){
        System.debug(Trigger.new);
        System.debug(Trigger.old);
        System.debug(Trigger.newMap);
        System.debug(Trigger.oldMap);
    }
    
}