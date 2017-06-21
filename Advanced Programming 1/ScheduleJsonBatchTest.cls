@isTest
private class ScheduleJsonBatchTest {

    static testMethod void ScheduleJsonBatchExecuteTest() {
        Test.startTest();
        ScheduleJsonBatch schedule = new ScheduleJsonBatch();
        String cronExp = '0 15 * * * ? *';
        String JobId = System.schedule('Schedule_Batch_for_JSONBatch', cronExp, schedule);
        CronTrigger ct = [SELECT Id
                               , CronExpression
                               , TimesTriggered
                               , NextFireTime
                          FROM CronTrigger
                          WHERE id = :jobId];
        Test.stopTest();
        System.assert(JobId != null);
        System.assertEquals('0 15 * * * ? *',ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
}