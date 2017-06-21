public with sharing class ContactQuery {
    public static void queryOnContact(){
    	List<Contact> cnt= new List<Contact>([SELECT Id,Name FROM Contact]);
    	System.debug(cnt); 
    }
}