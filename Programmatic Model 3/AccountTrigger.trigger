/**************************************************************************************************
 * Trigger : AccountTrigger
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Trigger to make clone of account record when new record is inserted
 * Test Class : AccountTest
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 *   1.0      Rohit Shisode   17/05/2016    Initial Development
 **************************************************************************************************/
trigger AccountTrigger on Account (after insert) {
    TriggerSetting__c ts = TriggerSetting__c.getInstance();
    if(ts.Account__c){
        Account[] cloneAccount = new Account[]{};
        if(CheckRecursive.runOnce()){
            System.debug('Tigger.new:::'+Trigger.new);
            for(Account acc:Trigger.new){
                Account newAcc = new Account();
                newAcc = acc.clone(false,true,false,false);
                /*newAcc = acc;
                newAcc.Id = null;*/
                cloneAccount.add(newAcc);
            }
            insert cloneAccount;
        }
    }
}