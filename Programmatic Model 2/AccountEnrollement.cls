public with sharing class AccountEnrollement {
    public static void enrollement_2010(){
    	List<Account> acc = new List<Account>([SELECT En__c,Id,Name FROM Account WHERE En__c INCLUDES ('2010')]);
    	System.debug('Account with enrollment year 2010 are:'+acc);
    }
    public static void enrollement_2013(){
    	List<Account> acc = new List<Account>([SELECT En__c,Id,Name FROM Account WHERE En__c INCLUDES('2010') OR (En__c INCLUDES ('2013') AND  En__c INCLUDES('2014'))]);
    	System.debug('Account with enrollment year 2010 are:'+acc);
    }
}