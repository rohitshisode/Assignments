public with sharing class MapAccountName {
    public static void mapAccount(){
    	List<Account> acc = new List<Account>([SELECT AccountNumber,Id,Name FROM Account]);
    	Map<String,Id> idAcc = new Map<String,Id>();
    	Map<Id,Account> accMap = new Map<Id,Account>();
    	for(Account a: acc){
    		idAcc.put(a.Name,a.Id);
    		accMap.put(a.Id,a);
    	}
    	System.debug('Map-1:'+idAcc);
    	System.debug('Map-2:'+accMap);
    	
    }
}