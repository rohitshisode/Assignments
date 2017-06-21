public with sharing class C_John_A_B {
	public static void displayChildParent(){
		List<C__c> cJunction = [Select Name, Mother__r.Name, Mother__c, Father__r.Name, Father__c From C__c WHERE Name LIKE '%John%'];
    	for(C__c c:cJunction){
			System.debug('Child Name='+c.Name+' Father Name= '+c.Father__r.Name+' Mother Name='+c.Mother__r.Name);
    	}
	}
}