public with sharing class ContactIndustry {
    public static void contactAccountIndustry(){
    	List<Contact> cnt = [SELECT Id, LastName, Account.Name, Account.Industry FROM Contact WHERE Account.Industry = 'Media' AND Account.Active__c = 'Yes'];
    	Map<Id,List<Contact>> mapAccountContact = new Map<Id,List<Contact>>();
    	for(Contact c:cnt){
    	    if(!mapAccountContact.containsKey(c.AccountId)){
    	        mapAccountContact.put(c.AccountId,new List<Contact>{c});
    	    } else{
    	         mapAccountContact.get(c.AccountId).add(c);
    	    }
    	   
    	}
    	System.debug(mapAccountContact);
    	for(Contact c:cnt){
    		System.debug('Account= '+c.Account.Name+' Industry= '+c.Account.Industry+' Contact='+c.LastName);
    	}
    }
}