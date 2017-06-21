/**************************************************************************************************
 * Trigger : Opportunity_BeforeInsert
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Trigger to check for duplication in name of opportunity
 * Handler Class : Opportunity_BeforeInsertHandler
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   19/06/2017    Initial Development
 **************************************************************************************************/
trigger Opportunity_BeforeInsert on Opportunity (before insert) {
    
    Opportunity_Setting__c opportunitySetting = Opportunity_Setting__c.getInstance();
    if(!opportunitySetting.Disable_All__c){
        Opportunity_BeforeInsertHandler.checkOpportunityName(Trigger.new);
    }
}