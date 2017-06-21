@isTest
private class ScheduleDuplicateLeadRemovalBatchTest {

    static testMethod void ScheduleDuplicateLeadRemovalBatcExecuteTest() {
        Test.startTest();
        ScheduleDuplicateLeadRemovalBatch schedule = new ScheduleDuplicateLeadRemovalBatch();
        String cronExp = '0 0 0/3 * * ? *';
        String JobId = System.schedule('Schedule_Batch_for_DuplicateLeadRemovalBatch', cronExp, schedule);
        CronTrigger ct = [SELECT Id
                               , CronExpression
                               , TimesTriggered
                               , NextFireTime
                          FROM CronTrigger
                          WHERE id = :jobId];
        Test.stopTest();
        System.assert(JobId != null);
        System.assertEquals('0 0 0/3 * * ? *',ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
}