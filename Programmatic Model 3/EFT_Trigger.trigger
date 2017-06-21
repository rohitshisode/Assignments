/**************************************************************************************************
 * Trigger : EFT_Trigger
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Trigger to check EFT record for appropriate case creation
 * Test Class : EFT_Test
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 *   1.0      Rohit Shisode   19/05/2016    Initial Development
 **************************************************************************************************/
trigger EFT_Trigger on EFT_Transaction_Status__c (after insert) {
    TriggerSetting__c ts = TriggerSetting__c.getInstance();
    if(ts.EFT__c){
        EftHandler.checkEftAndAddCases(Trigger.new);
    }
}