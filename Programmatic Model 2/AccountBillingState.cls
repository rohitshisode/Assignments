public with sharing class AccountBillingState {
    public static void sortByState(){
    	List<Account> acc= new List<Account>([SELECT BillingState,Id,Name FROM Account WHERE BillingState NOT IN ('Maharashtra', 'Kerala') ORDER BY BillingState DESC NULLS LAST LIMIT 10000]);
    	System.debug('Account::'+acc);
    	    
    }
    
}