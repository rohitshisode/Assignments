@isTest
private class ScheduleAccountOpportunityBatchTest {

    static testMethod void ScheduleAccountOpportunityBatchExecuteTest() {
        Test.startTest();
        ScheduleAccountOpportunityBatch schedule = new ScheduleAccountOpportunityBatch();
        String cronExp = '0 0 0 * * ? *';
        String JobId = System.schedule('Schedule_Batch_for_AccountOpportunityBatch', cronExp, schedule);
        CronTrigger ct = [SELECT Id
                               , CronExpression
                               , TimesTriggered
                               , NextFireTime
                          FROM CronTrigger
                          WHERE id = :jobId];
        Test.stopTest();
        System.assert(JobId != null);
        System.assertEquals('0 0 0 * * ? *',ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
}