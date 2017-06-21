public with sharing class AccountName {
    public static void AccountNameUpdate(){
    	List<Account> acc = new List<Account>([SELECT Id,Name FROM Account WHERE Name LIKE 'a%']);
    	System.debug('Accounts that start with a  count='+acc.size()+'are::'+acc);
    	for(Account a: acc){
    		a.Name='Updated via Update DML Operation';
    	}
    	try{
    		update acc;
    	}catch(Exception e){
    		System.debug(e);
    	}
    	
    	System.debug('Updated Accounts are::'+acc);
    }
}