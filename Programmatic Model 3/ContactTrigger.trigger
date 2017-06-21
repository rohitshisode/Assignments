/**************************************************************************************************
 * Trigger : ContactTrigger
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Trigger to check duplication in contact records against email and phone field.
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 *   1.0      Rohit Shisode   17/05/2016    Initial Development
 **************************************************************************************************/
trigger ContactTrigger on Contact (before insert, before update, after insert) {
    TriggerSetting__c ts = TriggerSetting__c.getInstance();
    if(ts.Contact__c){
        if(Trigger.isBefore){
        ContactHandler.validateContactForDuplication(Trigger.new);
        //Contact_Account_Association_Handler.contactAccountAssociation(Trigger.new);
        }
        /*if(Trigger.isAfter){
            Contact_Account_Association_Handler.contactAccountAssociation(Trigger.new);
        }*/
        
    }
}