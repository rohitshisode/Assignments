global with sharing class JsonBatch implements Database.Batchable<SObject>,Database.stateful {
    String query = 'SELECT JSON__c, IsProcessed__c FROM Event__c WHERE IsProcessed__c = false';
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc, List<Event__c> eventList){
        JsonBatchHandler.executeMethod(eventList);
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
}