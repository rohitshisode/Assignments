@isTest
private class DuplicateLeadRemovalBatchTest {

    static testMethod void nothingChecked() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new CriteriaForDuplicateLead__c(Email__c = false,
                                               Phone__c = false,
                                               Name__c = false);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(200, leadList.size());
    }

    static testMethod void onlyName() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new CriteriaForDuplicateLead__c(Email__c = false,
                                               Phone__c = false,
                                               Name__c = true);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void onlyNameWithNoNameDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Phone = leads[i + 1].Phone;
            leads[i].Email = leads[i + 1].Email;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = false,
                                               Phone__c = false,
                                               Name__c = true);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void onlyEmail() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                               Phone__c = false,
                                               Name__c = false);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void onlyEmailWithNoEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Phone = leads[i + 1].Phone;
            leads[i].LastName = leads[i + 1].LastName;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                               Phone__c = false,
                                               Name__c = false);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void onlyPhone() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new CriteriaForDuplicateLead__c(Email__c = false,
                                               Phone__c = true,
                                               Name__c = false);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void onlyPhoneWithNoPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Email = leads[i + 1].Email;
            leads[i].LastName = leads[i + 1].LastName;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = false,
                                          Phone__c = true,
                                          Name__c = false);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void phoneNameChecked() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new CriteriaForDuplicateLead__c(Email__c = false,
                                          Phone__c = true,
                                          Name__c = true);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void phoneNameCheckedWithPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Phone = leads[i + 1].Phone;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = false,
                                          Phone__c = true,
                                          Name__c = true);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(50, leadList.size());
    }

    static testMethod void phoneNameCheckedWithNameDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].LastName = leads[i + 1].LastName;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = false,
                                          Phone__c = true,
                                          Name__c = true);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(50, leadList.size());
    }

    static testMethod void phoneNameCheckedWithEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Email = leads[i + 1].Email;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = false,
                                          Phone__c = true,
                                          Name__c = true);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void phoneEmailChecked() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                          Phone__c = true,
                                          Name__c = false);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void phoneEmailCheckedWithPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Phone = leads[i + 1].Phone;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                          Phone__c = true,
                                          Name__c = false);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(50, leadList.size());
    }

    static testMethod void phoneEmailCheckedWithEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Email = leads[i + 1].Email;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                          Phone__c = true,
                                          Name__c = false);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(50, leadList.size());
    }

    static testMethod void phoneEmailCheckedWithNameDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].LastName = leads[i + 1].LastName;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                          Phone__c = true,
                                          Name__c = false);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void nameEmailChecked() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                          Phone__c = false,
                                          Name__c = true);
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(200,leadList.size());
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void nameEmailCheckedWithEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Email = leads[i + 1].Email;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                          Phone__c = false,
                                          Name__c = true);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(50, leadList.size());
    }

    static testMethod void nameEmailCheckedWithNameDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].LastName = leads[i + 1].LastName;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                          Phone__c = false,
                                          Name__c = true);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(50, leadList.size());
    }

    static testMethod void nameEmailCheckedWithPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Phone = leads[i + 1].Phone;
        }
        insert leads;
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                          Phone__c = false,
                                          Name__c = true);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void allCheckedNoDuplicates() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                          Phone__c = true,
                                          Name__c = true);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }


    static testMethod void allCheckedWithDuplicates() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new CriteriaForDuplicateLead__c(Email__c = true,
                                          Phone__c = true,
                                          Name__c = true);
        test.startTest();
            DuplicateLeadRemovalBatch b = new DuplicateLeadRemovalBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
}