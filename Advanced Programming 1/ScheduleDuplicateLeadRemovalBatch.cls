/**************************************************************************************************
 * Class : ScheduleDuplicateLeadRemovalBatch
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Scheduler to call the DuplicateLeadRemovalBatch batch class as per schedule cron expression
 * Test Class : ScheduleDuplicateLeadRemovalBatchTest
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   12/06/2017    Initial Development
 **************************************************************************************************/
global with sharing class ScheduleDuplicateLeadRemovalBatch implements Schedulable{
/*
* execute function for current scope 
*/

    global void execute(SchedulableContext sc){

        DuplicateLeadRemovalBatch lead = new DuplicateLeadRemovalBatch();
        Database.executeBatch(lead);

    }
}