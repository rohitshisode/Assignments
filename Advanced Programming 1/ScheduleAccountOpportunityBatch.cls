/**************************************************************************************************
 * Class : ScheduleAccountOpportunityBatch
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Scheduler to call the AccountOpportunityBatch batch class as per schedule cron expression
 * Test Class : scheduledBatchableTest
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   09/06/2017    Initial Development
 **************************************************************************************************/

global with sharing class ScheduleAccountOpportunityBatch implements Schedulable{

/*
* execute function for current scope 
*/

    global void execute(SchedulableContext sc){

        AccountOpportunityBatch account = new AccountOpportunityBatch();
        Database.executeBatch(account);

    }

}