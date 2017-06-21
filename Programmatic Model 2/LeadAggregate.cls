public with sharing class LeadAggregate {
	public static void distinctLeadAggregate(){
		List<AggregateResult> leadDistinct = [SELECT LeadSource, COUNT_DISTINCT(Name) FROM Lead GROUP BY LeadSource HAVING COUNT_DISTINCT(Name)>10];
		System.debug(leadDistinct);
	}
    
}