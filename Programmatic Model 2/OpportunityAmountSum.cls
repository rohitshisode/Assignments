public with sharing class OpportunityAmountSum {
	public static void opportunitySum(){
		Integer currentYear = System.today().year();
		list<AggregateResult> opp = [SELECT SUM(Amount) FROM Opportunity WHERE CloseDate = THIS_FISCAL_YEAR AND StageName = 'Closed Won'];
		Map<Integer,Object> sum = new Map<Integer,Object>();
		sum.put(currentYear,opp[0].get('expr0'));
		System.debug(sum);
	}
    
}