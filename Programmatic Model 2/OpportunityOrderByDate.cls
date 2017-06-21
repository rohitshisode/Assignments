public with sharing class OpportunityOrderByDate {
    public static void displayOpportunityAmount(){
    	List<Opportunity> opp = [SELECT Amount,Id,Name FROM Opportunity WHERE Amount > 10000 ORDER BY CreatedDate ASC  LIMIT 100 OFFSET 50 ALL ROWS];
    	System.debug(opp);
    	System.debug(opp.size());
    }
}