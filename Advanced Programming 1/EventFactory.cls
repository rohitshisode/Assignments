@isTest
public class EventFactory {

    public static List<Event__c> createEvents(Integer count, String jsonField, Boolean toBeInserted) {
        List<Event__c> events = new List<Event__c>();
        for (Integer i = 1; i <= count; i++) {
            Event__c event = new Event__c();
            event.JSON__c = jsonField;
            events.add(event);
        }
        if(toBeInserted) {
            insert events;
        }
        return events;
    }
}