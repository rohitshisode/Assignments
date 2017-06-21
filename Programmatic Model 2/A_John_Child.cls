public with sharing class A_John_Child {
    public static void displayParentChild(){
    	List<A__c> varA = [SELECT Name, (SELECT Name FROM Child_C__r) from A__c WHERE Id IN (SELECT Father__c FROM C__c WHERE Name LIKE '%John%')];
    	for(A__c a:varA){
    		for(C__c varC: a.Child_C__r){
    			System.debug('Father\'s Name= '+a.Name+' Child Name='+varC.Name);
    		}
    	}
    	
    }
}