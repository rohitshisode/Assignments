/**************************************************************************************************
 * Trigger : SampleLeadTrigger
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Trigger to check context variable for lead on after and before event for insert and update action
 * Test Class : 
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 *   1.0      Rohit Shisode   17/05/2016    Initial Development
 **************************************************************************************************/
trigger SampleLeadTrigger on Lead (after insert, after update, before insert, before update) {
    Lead_Setting__c leadSetting = Lead_Setting__c.getInstance();
    if(!leadSetting.Disable_All__c){
        if(Trigger.isBefore){
            if(Trigger.isInsert){
                if(!leadSetting.Disable_Lead_Before_Insert__c){
                    System.debug('Inside Before Insert::::');
                    System.debug('Trigger.New='+Trigger.New);
                }
            }else{
	            System.debug('Trigger.Old='+Trigger.old);
	        }
	    }else{
		    if(Trigger.isInsert){
		        System.debug('Inside After Insert::::');
		        if(!leadSetting.Disable_Lead_After_Insert__c){
		            System.debug('Trigger.NewMap='+Trigger.NewMap);
		        }
		    }else{
		          System.debug('Trigger.OldMap='+Trigger.oldMap);
		    }
		}
    }
}