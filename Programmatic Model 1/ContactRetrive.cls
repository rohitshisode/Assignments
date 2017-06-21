public with sharing class ContactRetrive {
    public static void retirveLastModifiedContact(){
    	List<Contact> cnt = new List<Contact>([SELECT Id,Name FROM Contact WHERE LastModifiedDate = LAST_WEEK]);
    	System.debug('Last Modified contact are:'+cnt);
    }
}