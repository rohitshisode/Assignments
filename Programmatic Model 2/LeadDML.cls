public with sharing class LeadDML {
	public static void insertLeadRecords(){   
		List<Lead> leadRecords = new List<Lead>();
		List<Log__c> logRecords = new List<Log__c>();
		Lead newLead;
		Log__c newLog;
		AssignmentRule ar = new AssignmentRule();
		ar = [SELECT Id FROM AssignmentRule WHERE SobjectType ='Lead' AND Active = true LIMIT 1];
		Database.DMLOptions dmlOptions = new Database.DMLOptions();
		dmlOptions.assignmentRuleHeader.assignmentRuleId = ar.Id;
		for(Integer i=31; i<=38; i++){
			newLead = new Lead(FirstName='Demo#'+String.valueof(i),
							   LastName='Lead#'+String.valueof(i),
							   Company='Eternus',
							   City='Pune',
							   Status='Open - Not Contacted');
			newLead.setOptions(dmlOptions);
			leadRecords.add(newLead);
		}
		for(Integer i=39; i<=40; i++){
			newLead = new Lead(FirstName='Demo#'+String.valueof(i),
							   LastName='Lead#'+String.valueof(i),
							   City='Pune',
							   Status='Open - Not Contacted');
			newLead.setOptions(dmlOptions);
			leadRecords.add(newLead);
		}
		Database.SaveResult[] srList = Database.insert(leadRecords, false);
		for (Database.SaveResult sr : srList) {
			String errorMessage;
			    if (!(sr.isSuccess())) {
			    	for(Database.Error err : sr.getErrors()) {
			    		errorMessage=+ err.getMessage();
			         }
			    newLog = new Log__c(Error__c = errorMessage);
			    logRecords.add(newLog);
		        }	
		}
		insert logRecords;	
	}
}