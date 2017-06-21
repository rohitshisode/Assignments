public with sharing class DatabaseDemo {
    public static void queryDemo(){
    	String nameStartingWithU = 'u%';
    	String query = 'SELECT Id, Name FROM Account WHERE Name LIKE :nameStartingWithU';
    	List<Account> acc = Database.query(query);
    	System.debug('Account::'+acc);
    }
    public static void searchDemo(){
    	String nameStartingWithU = 'u%';
    	String searchQuery = 'FIND \'test*\' IN ALL FIELDS RETURNING Account(id,name),Employee__c';
    	List<List<sObject>> searchList = search.query(searchQuery);
    	List<Account> acc = ((List<Account>)searchList[0]);
    	List<Employee__c> emp = ((List<Employee__c>)searchList[1]);
    	System.debug('List of account is:'+acc);
    	System.debug('List of Employee is:'+emp);
    }
}