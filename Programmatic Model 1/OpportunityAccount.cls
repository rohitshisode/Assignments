public with sharing class OpportunityAccount {   
    public static void OpportunityAccountId(){
        List<Opportunity> opp= new List<Opportunity>([SELECT Id, name, AccountId FROM Opportunity WHERE AccountId != null AND StageName LIKE 'Closed%']);
        List<Id> oppId = new List<Id>();
        Set<Id> accId = new Set<Id>();
        Map<Id,Id> oppAccMap = new Map<Id,Id>();
        for(Opportunity o: opp){
            oppId.add(o.Id);
            accId.add(o.AccountId);
            oppAccMap.put(o.Id,o.AccountId);
        }
        
        System.debug('Opportunity Id are:'+oppId);
        System.debug('Account Id are:'+accId);
        System.debug('Map is:'+oppAccMap);
        
        
    }  
}