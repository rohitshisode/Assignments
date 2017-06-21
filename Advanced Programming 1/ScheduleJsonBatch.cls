/**************************************************************************************************
 * Class : ScheduleJsonBatch
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Scheduler to call the JsonBatch batch class as per schedule cron expression
 * Test Class : ScheduleJsonBatchTest
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   12/06/2017    Initial Development
 **************************************************************************************************/
global with sharing class ScheduleJsonBatch implements Schedulable {

/*
* execute function for current scope 
*/

    global void execute(SchedulableContext sc){

        JsonBatch event = new JsonBatch();
        Database.executeBatch(event);

    }

}