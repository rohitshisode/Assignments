public with sharing class AccountContacts {
	public static void displayAccountContacts(){    
		List<Account> acc = [SELECT Name,(SELECT Id,LastName FROM Contacts) FROM Account WHERE Name LIKE '%John%'];
		for(Account a:acc){
			System.debug(a+' Contacts= ' +a.Contacts);
		}
	}
}