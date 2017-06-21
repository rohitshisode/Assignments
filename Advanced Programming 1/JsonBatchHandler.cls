/**************************************************************************************************
 * Class : JsonBatchHandler
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Handler class for JsonBatch class execute method, that processes Event object and creates generic record according to JOSN
 * Test Class : scheduledBatchableTest
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   10/06/2017    Initial Development
 **************************************************************************************************/
global with sharing class JsonBatchHandler {

    global static void executeMethod(List<Event__c> eventList){

        //List of sObjects that will be created according to JSON and inserted at the end.
        List<sObject> sObjectRecords = new List<sObject>();
        //Set of fields present on particular object, currently being processed by Handler class
        Set<String> recordFields;
        //Map of object name and all fields present on the object, used to cross referance with fields present in JSON
        Map<String,Schema.SObjectField> allFieldsPresentInObject;
        System.debug('Inside Batch Handler:::');
        System.debug('EventList:::'+eventList);
        //Iterate through the list of all unprocessed event records one by one, Creating and adding each record to sObjectRecords list
        for(Event__c event : eventList) {
            //Boolean variables used to validate particular JSON for valid fields and contains required fields or not, default true
            Boolean isValidField = true, containsRequiredFields = true;
            //Checks if JSON on event record is present or not, if not then adds appropriate message to error field
            if(event.JSON__c != NULL) {
                try {
                    //Map to deserialize the event record into JSON and Object Name as keys
                    Map<String, Object> jsonFieldMap = (Map<String, Object>)JSON.deserializeUntyped(event.JSON__c);
                    //Get and store the object name from above map into a string
                    String ObjectName = (String)jsonFieldMap.get('Object Name');
                    //Checks if object name is present or not
                    if(ObjectName != NULL) {
                        System.debug('Before SObject chcek:::');
                        //Checks if object specified is present in the org or not with the help of an SObjectUtil class, which returns true if object is present
                        if(SObjectUtil.isObjectExist(ObjectName)) {
                            System.debug('After SObject chcek:::');
                            //Checks if jsonFieldMap contains JSON key and it is not null
                            if(jsonFieldMap.containsKey('JSON') && jsonFieldMap.get('JSON')!='') {
                                //Again serializes JSON field of jsonFieldMap map
                                String objectJson = JSON.serialize(jsonFieldMap.get('JSON'));
                                //Deserializes inner JSON into a map of field label as key and its value as value
                                Map<String,String> jsonMap = (Map<String, String>)JSON.deserialize(objectJson, Map<String, String>.class);
                                //Gets the globalDesrcibe of an object that we are dealing with
                                Schema.SObjectType str = Schema.getGlobalDescribe().get(ObjectName);
                                //Creates a new instance of given sObject
                                sObject newSObjetcRecord = str.newSObject();
                                //Gets all fields present on that particular object
                                allFieldsPresentInObject = str.getDescribe().fields.getMap() ;
                                //Iterate through all fields present in a JSON
                                for(String field: jsonMap.keySet()) {
                                    //Checks if field given in JSON is present on that particular object or not, if not makes isValidField false and adds a error
                                    if(allFieldsPresentInObject.keySet().contains(field.toLowerCase())) {
                                        //If all ok then adds event record into a newSObjetcRecord instance which later will be added to sObjectRecords list
                                        newSObjetcRecord.put(field.toLowerCase() ,jsonMap.get(field));
                                    } else {
                                        isValidField = false;
                                        event.Error_If_Any__c = 'Invalid Field Names::'+field+' Please correct field names';
                                        break;
                                    }
                                }
                                //Checks if isValidField is still true
                                if(isValidField) {
                                    recordFields=new Set<String>();
                                    for(string s : jsonMap.keySet()) {
                                        recordFields.add(s.toLowerCase());
                                    }
                                    //Iterate through all fields present on an object and check if they are required or not AND JSON contains them or not, If not then containsRequiredFields is set to false
                                    for(String field : allFieldsPresentInObject.keyset()) {
                                        Schema.DescribeFieldResult desribeResult = allFieldsPresentInObject.get(field).getDescribe();
                                        if( desribeResult.isCreateable() && !desribeResult.isNillable()
                                            && !desribeResult.isDefaultedOnCreate()) {
                                            if(!recordFields.contains(field.toLowerCase())) {
                                                containsRequiredFields = false;
                                                event.Error_If_Any__c = 'Required fields missing, Please provide '+field+' field and other(if any) required fields';
                                                break;
                                            }
                                        }
                                    }
                                    //Checks if containsRequiredFields is still true and then add newSObjetcRecord to sObjectRecords list
                                    if(containsRequiredFields) {
                                        sObjectRecords.add(newSObjetcRecord);
                                        //Marks particular event record as processed so that in next process it wont be included again
                                        event.IsProcessed__c = true;
                                    }
                                }
                            } else {
                                event.Error_If_Any__c = 'JSON Not provided';
                            }
                        } else {
                            event.Error_If_Any__c = 'Invalid Object Name';
                        }
                    } else {
                        event.Error_If_Any__c = 'Object Name not provided';
                    }
                } catch(Exception e) {
                    event.Error_If_Any__c = 'JSON Formatting wrong';
                }
            } else {
                event.Error_If_Any__c = 'JSON Field is empty';
            }
        }
        try {
            //Insets the processed event records and updates the error field on other event records
            insert sObjectRecords;
            update eventList;
        } catch(Exception e) {
            System.debug('Error Occurred:: ' + e);
        }

    }

}