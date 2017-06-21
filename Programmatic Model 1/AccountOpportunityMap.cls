public with sharing class AccountOpportunityMap {
    public static void displayMap(){
        List<Account> acc= new List<Account>([SELECT Id,(SELECT Id FROM Opportunities) FROM Account]);
        List<Id> oppId;
        Map<Id,List<Id>> accOppMap = new Map<Id,List<Id>>();
        for(Account a: acc){
        	oppId  = new List<Id>();
        	for(Integer i=0;i<a.Opportunities.size();i++)
        	{
        		oppId.add(a.Opportunities[i].Id);
        	}
            accOppMap.put(a.Id,oppId);
        }
        /*for(Account account :accountList){
            if(accountToOpportunityMap.containsKey(account.Id)) {
                accountToOpportunityMap.get(account.Id).add(account.opportunities);
            } else {
                accountToOpportunityMap.put(account.id, new List<Id>{});
            }
        }*/
        System.debug(accOppMap);
    }
}