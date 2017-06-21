public with sharing class CampaignRetrive {
    public static void retriveCampaign(){
    	List<Campaign> camp= new List<Campaign>([SELECT ExpectedRevenue,Id,Name FROM Campaign ORDER BY ExpectedRevenue ASC LIMIT 10]);
    	System.debug('Campaign In ascending order(Expected Revenue)::'+camp);
    	camp = [SELECT ExpectedRevenue,Id,Name FROM Campaign ORDER BY ExpectedRevenue DESC LIMIT 10];
    	System.debug('Campaign Descending order(Expected Revenue)::'+camp);
    }
}