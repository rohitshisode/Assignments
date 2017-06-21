public with sharing class TestSOSL {
    public static void testSoslAccountContactLead(){
    	List<List<sObject>> varTest = [FIND 'test*' IN Name FIELDS RETURNING Account(id,Name),Contact(id,LastName),Lead(Name),User(Name)];
    	System.debug(varTest);
    }
}