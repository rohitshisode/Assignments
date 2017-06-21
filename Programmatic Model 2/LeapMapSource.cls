public with sharing class LeapMapSource {
	public static void mapLeadStatusSource(){
		List<AggregateResult> leadRecords = [
		  SELECT Status
		       , LeadSource
		       , COUNT(Name)
		    FROM Lead 
		GROUP BY Status 
		       , LeadSource
		];
		Map<String, Map<String,Integer>> leadMap = new Map<String,Map<String,Integer>>();
		for(AggregateResult r: leadRecords){
			String status = (String) r.get('Status');
			if(!leadMap.containsKey(status)){
				leadMap.put(status, new Map<String,Integer>());
			}
			String source = (String) r.get('LeadSource');
			Integer num = (Integer) r.get('expr0');
			leadMap.get(status).put(source,num);
		}
		for(String s:leadMap.keySet()){
		    System.debug('Lead Source::'+s);
		    for(String leadStatus: leadMap.get(s).keySet()){
		        System.debug('Lead Status::'+leadStatus);
		        System.debug(leadMap.get(s).get(leadStatus));
		    }
		}
		System.debug(leadMap);
	}
    
}