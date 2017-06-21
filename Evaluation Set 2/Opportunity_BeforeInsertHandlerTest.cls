/**************************************************************************************************
 * Test Class : Opportunity_BeforeInsertHandlerTest
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Trigger : Opportunity_BeforeInsert
 * Description : Tests Opportunity_BeforeInsert trigger for various scenarios
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   19/06/2017    Initial Development
 **************************************************************************************************/
@isTest
private class Opportunity_BeforeInsertHandlerTest {
/*
*Inserts single record with proper name
*No error expected
*/
    static testMethod void testInsertOpportunityWithProperName() {
        Opportunity newOpportunity = new Opportunity();
        newOpportunity.Name = 'Demo Opportunity';
        newOpportunity.Amount = 5000;
        newOpportunity.CloseDate = System.today();
        newOpportunity.StageName = 'Needs Analysis';
        Test.startTest();
        insert newOpportunity;
        Opportunity opp = [SELECT opp.Name,opp.Amount,opp.CloseDate,opp.StageName FROM Opportunity opp WHERE opp.Name LIKE '%Demo%'];
        Test.stopTest();
        System.assertEquals(newOpportunity.Name,opp.Name);
        System.assertEquals(newOpportunity.Amount,opp.Amount);
        System.assertEquals(newOpportunity.CloseDate,opp.CloseDate);
        System.assertEquals(newOpportunity.StageName,opp.StageName);
    }

/*
*Inserts single record with proper name and another record with same name
*Error expected
*/
    static testMethod void testInsertOpportunityWithDuplicateName() {
        Test.startTest();
        List<Opportunity> oppList = OpportunityFactory.createAndInsertOpportunity(1);
        Test.stopTest();
        Opportunity newOpportunity = new Opportunity();
        newOpportunity.Name = 'Opportunity1';
        newOpportunity.Amount = 5000;
        newOpportunity.CloseDate = System.today();
        newOpportunity.StageName = 'Needs Analysis';
        try{
            insert newOpportunity;
        }catch(DMLException e){
            System.assertEquals('A opportunity with same name exist in organization', e.getDmlMessage(0));
        }
        Opportunity opp = [SELECT opp.Name,opp.Amount,opp.CloseDate,opp.StageName FROM Opportunity opp WHERE opp.Name LIKE '%Opportunity1%'];
        System.assertEquals(oppList[0].Name,opp.Name);
        System.assertEquals(oppList[0].Amount,opp.Amount);
        System.assertEquals(oppList[0].CloseDate,opp.CloseDate);
        System.assertEquals(oppList[0].StageName,opp.StageName);
    }

/*
*Inserts records in bulk with proper name and another bulk of records with duplicate name
*Error expected
*/
    static testMethod void testBulkInsertOpportunityWithDuplicateName() {
        Test.startTest();
        List<Opportunity> oppList = OpportunityFactory.createAndInsertOpportunity(250);
        List<Opportunity> duplicateOppList = OpportunityFactory.createOpportunity(200);
        Test.stopTest();
        try{
            insert duplicateOppList;
        }catch(DMLException e){
            System.assertEquals('A opportunity with same name exist in organization', e.getDmlMessage(0));
        }
        Opportunity opp = [SELECT opp.Name,opp.Amount,opp.CloseDate,opp.StageName FROM Opportunity opp WHERE opp.Name = 'Opportunity1'];
        List<Opportunity> insertedOpportunityList = [SELECT Name,Amount,CloseDate,StageName FROM Opportunity WHERE Name LIKE '%Opportunity%'];
        System.assertEquals(oppList[0].Name,opp.Name);
        System.assertEquals(oppList[0].Amount,opp.Amount);
        System.assertEquals(oppList[0].CloseDate,opp.CloseDate);
        System.assertEquals(oppList[0].StageName,opp.StageName);
        System.assertEquals(250, insertedOpportunityList.size());
    }
/*
*Inserts bulk records with dupliocations in new records itself
*Error expected
*/
    static testMethod void testBulkInsertInNewRecordDuplicate() {
        Test.startTest();
        List<Opportunity> duplicateOppList = OpportunityFactory.createOpportunity(200);
        Boolean flag = true;
        for(Opportunity oppVar : duplicateOppList){
            if(flag){
                oppVar.Name = 'Opportunity1';
                flag=false;
            } else{
                flag=true;
            }
        }
        Test.stopTest();
        try{
            insert duplicateOppList;
        }catch(DMLException e){
            System.assertEquals('A opportunity with same name exist in new records', e.getDmlMessage(0));
        }
        List<Opportunity> insertedOpportunityList = [SELECT Name,Amount,CloseDate,StageName FROM Opportunity];
        System.debug('Opportunity are:::'+insertedOpportunityList);
        System.assertEquals(0,insertedOpportunityList.size());
    }

/*
*Inserts bulk records with dupliocations in new records itself
*Error expected but partial insert is allowed so one record of similar name will be inserted
*/
    static testMethod void testBulkPartialInsertInNewRecordDuplicate() {
        Test.startTest();
        List<Opportunity> duplicateOppList = OpportunityFactory.createOpportunity(200);
        Boolean flag = true;
        for(Opportunity oppVar : duplicateOppList){
            if(flag){
                oppVar.Name = 'Opportunity1';
                flag=false;
            } else{
                flag=true;
            }
        }
        Test.stopTest();
        try{
            Database.insert(duplicateOppList,false);
        }catch(DMLException e){
            System.assertEquals('A opportunity with same name exist in new records', e.getDmlMessage(0));
        }
        List<Opportunity> insertedOpportunityList = [SELECT Name,Amount,CloseDate,StageName FROM Opportunity WHERE Name = 'Opportunity1'];
        System.debug('Opportunity are:::'+insertedOpportunityList);
        System.assertEquals(1,insertedOpportunityList.size());
    }
}