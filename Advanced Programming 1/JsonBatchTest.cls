@isTest
private class JsonBatchTest {

    static testMethod void bulkJSONFieldEmpty() {
        String jsonField = '';
        EventFactory.createEvents(100, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, Error_If_Any__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals('JSON Field is empty', event.Error_If_Any__c);
        }
    }

    static testMethod void bulkNoObjectInJSON() {
        String jsonField = '{"JSON":{"Name":"Rohit"}}';
        EventFactory.createEvents(100, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, Error_If_Any__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals('Object Name not provided', event.Error_If_Any__c);
        }
    }

    static testMethod void bulkInvalidObjectNameInJSON() {
        String jsonField = '{"JSON":{"Name":"Rohit"},"Object Name":"Account1"}';
        EventFactory.createEvents(100, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, Error_If_Any__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals('Invalid Object Name', event.Error_If_Any__c);
        }
    }

    static testMethod void bulkNoJSON() {
        String jsonField = '{"Object Name":"Account"}';
        EventFactory.createEvents(100, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, Error_If_Any__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals('JSON Not provided', event.Error_If_Any__c);
        }
    }

    static testMethod void bulkEmptyJSON() {
        String jsonField = '{"JSON":"","Object Name":"Account"}';
        EventFactory.createEvents(100, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, Error_If_Any__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals('JSON Not provided', event.Error_If_Any__c);
        }
    }

    static testMethod void bulkInvalidFieldInJSON() {
        String jsonField = '{"JSON":{"Name":"Rohit", "AccountNumber1":"456"},"Object Name":"Account"}';
        EventFactory.createEvents(100, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, Error_If_Any__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals('Invalid Field Names, Please correct field names', event.Error_If_Any__c);
        }
    }

    static testMethod void bulkRequiredFieldNotProvidedInJSON() {
        String jsonField = '{"JSON":{"AccountNumber":"456"},"Object Name":"Account"}';
        EventFactory.createEvents(100, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, Error_If_Any__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals('Required fields missing, Please provide all required fields', event.Error_If_Any__c);
        }
    }

    static testMethod void bulkSuccess() {
        String jsonField = '{"JSON":{"Name":"Rohit", "AccountNumber":"456", "Phone":"0240669955"},"Object Name":"Account"}';
        EventFactory.createEvents(100, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, Error_If_Any__c from Event__c];
        List<Account> accounts = [SELECT Name, AccountNumber,Phone FROM Account];
        for(Account acc : accounts){
            System.assertEquals('Rohit',acc.Name);
            System.assertEquals('456',acc.AccountNumber);
            System.assertEquals('0240669955',acc.Phone);
           
        }
        for(Event__c event : events) {
            System.assertEquals(true, event.IsProcessed__c);
            System.assertEquals(null, event.Error_If_Any__c);
        }
    }
    static testMethod void bulkException() {
        String jsonField = '{"JSON":{"Name":"Rohit", "Owner":"abcd"},"Object Name":"Account"}';
        EventFactory.createEvents(100, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, Error_If_Any__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
        }
    }

    static testMethod void singleInvalidJSONFormatting() {
        String jsonField = '{"JSON":{"Name":"Rohit"}"Object Name":"Account"}';
        EventFactory.createEvents(1, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        Event__c event = [Select IsProcessed__c, Error_If_Any__c from Event__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals('JSON Formatting wrong', event.Error_If_Any__c);
    }

    static testMethod void singleJSONFieldEmpty() {
        String jsonField = '';
        EventFactory.createEvents(1, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        Event__c event = [Select IsProcessed__c, Error_If_Any__c from Event__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals('JSON Field is empty', event.Error_If_Any__c);
    }

    static testMethod void singleNoObjectInJSON() {
        String jsonField = '{"JSON":{"Name":"Rohit"}}';
        EventFactory.createEvents(1, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        Event__c event = [Select IsProcessed__c, Error_If_Any__c from Event__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals('Object Name not provided', event.Error_If_Any__c);
    }

    static testMethod void singleInvalidObjectNameInJSON() {
        String jsonField = '{"JSON":{"Name":"Rohit"},"Object Name":"Account1"}';
        EventFactory.createEvents(1, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        Event__c event = [Select IsProcessed__c, Error_If_Any__c from Event__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals('Invalid Object Name', event.Error_If_Any__c);
    }

    static testMethod void singleNoJSON() {
        String jsonField = '{"Object Name":"Account"}';
        EventFactory.createEvents(1, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        Event__c event = [Select IsProcessed__c, Error_If_Any__c from Event__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals('JSON Not provided', event.Error_If_Any__c);
    }

    static testMethod void singleEmptyJSON() {
        String jsonField = '{"JSON":"","Object Name":"Account"}';
        EventFactory.createEvents(1, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        Event__c event = [Select IsProcessed__c, Error_If_Any__c from Event__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals('JSON Not provided', event.Error_If_Any__c);
    }

    static testMethod void singleInvalidField() {
        String jsonField = '{"JSON":{"Name":"Rohit", "AccountNumber1":"456"},"Object Name":"Account"}';
        EventFactory.createEvents(1, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        Event__c event = [Select IsProcessed__c, Error_If_Any__c from Event__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals('Invalid Field Names, Please correct field names', event.Error_If_Any__c);
    }

    static testMethod void singleRequiredFieldNotProvided() {
        String jsonField = '{"JSON":{"AccountNumber":"456"},"Object Name":"Account"}';
        EventFactory.createEvents(1, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        Event__c event = [Select IsProcessed__c, Error_If_Any__c from Event__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals('Required fields missing, Please provide all required fields', event.Error_If_Any__c);
    }

    static testMethod void singleSuccess() {
        String jsonField = '{"JSON":{"Name":"Rohit", "AccountNumber":"456", "Phone":"0240669955"},"Object Name":"Account"}';
        EventFactory.createEvents(1, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        Event__c event = [Select IsProcessed__c, Error_If_Any__c from Event__c][0];
        Account account = [SELECT Name, AccountNumber,Phone FROM Account][0];
        System.assertEquals('Rohit',account.Name);
        System.assertEquals('456',account.AccountNumber);
        System.assertEquals('0240669955',account.Phone);
        System.assertEquals(true, event.IsProcessed__c);
        System.assertEquals(null, event.Error_If_Any__c);
    }

    static testMethod void singleException() {
        String jsonField = '{"JSON":{"Name":"Rohit", "ParentId":"abcd"},"Object Name":"Account"}';
        EventFactory.createEvents(1, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        Event__c event = [Select IsProcessed__c, Error_If_Any__c from Event__c][0];
        System.assertEquals(false, event.IsProcessed__c);
    }

    static testMethod void bulkInvalidJSONFormatting() {
        String jsonField = '{"JSON":{"Name":"Rohit"}"Object Name":"Account"}';
        EventFactory.createEvents(100, jsonField, true);
        test.startTest();
            JsonBatch b = new JsonBatch();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, Error_If_Any__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals('JSON Formatting wrong', event.Error_If_Any__c);
        }
    }
}