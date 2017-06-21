public with sharing class AccountCreatedIn90Days {
	public static void deleteInactiveAccount(){
		List<Account> acc = [SELECT Active__c,CreatedDate,Id,Name,(SELECT Id,Name,StageName FROM Opportunities) FROM Account WHERE CreatedDate = LAST_90_DAYS AND Active__c = 'No'];
		List<Opportunity> opp = new List<Opportunity>();
		for(Account a: acc){
			for(Opportunity o: a.Opportunities){
				if(o.StageName == 'Closed Won'){
					opp.add(o);
				}
			}
		}
		System.debug('Inactive accounts created in last 90 days are::'+acc);
		delete opp;
		delete acc;
	}   
}