public with sharing class AccountOpportunity {
    public static void displayOpportunityAccount(){
    	List<Account> acc = [SELECT Id,Name,(SELECT Id,Name,StageName FROM Opportunities)
    	                     FROM Account WHERE Id IN (SELECT AccountId from Opportunity WHERE StageName='Closed Won')];
    	for(Account a:acc){
    		System.debug(a.Name+' Opportunities='+a.Opportunities);
    	}
    	
    }
}