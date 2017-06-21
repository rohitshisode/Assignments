/**************************************************************************************************
 * Class : LeadManipulatorUsingSOAPTest
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Test class for LeadManipulatorUsingSOAPT class
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   12/06/2017    Initial Development
 **************************************************************************************************/
@isTest
private class LeadManipulatorUsingSOAPTest {

/*
*Test for insertLeads method
*/
    static testMethod void testInsertLeads() {
        LeadManipulatorUsingSOAP.ResponseLead response = new LeadManipulatorUsingSOAP.ResponseLead();
        test.startTest();
            response = LeadManipulatorUsingSOAP.insertLeads('Rohit','ESPL','Shisode','abc@gmail.com','2456897');
        test.stopTest();
        Lead lead = [SELECT Id,Name,Email,Phone,Company FROM LEAD][0];
        System.assertEquals('ESPL', lead.Company);
        System.assertEquals('Rohit Shisode', lead.Name);
        System.assertEquals('abc@gmail.com', lead.Email);
        System.assertEquals('2456897', lead.Phone);
        System.assertEquals(true,response.IsSuccess);
        System.assertEquals('Success',response.status);
        System.assertEquals(lead.Id,response.lead);
    }
/*
*Test for deleteLeads method
*/
    static testMethod void testDeleteLeads() {
        List<lead> leadList = LeadFactory.createAndInsertLeads(1);
        Lead lead = leadList[0];
        LeadManipulatorUsingSOAP.ResponseLead response = new LeadManipulatorUsingSOAP.ResponseLead();
        test.startTest();
            response = LeadManipulatorUsingSOAP.deleteLeads('Demo','Lead#1','abc1@gmail.com','123451');
        test.stopTest();
        System.assertEquals(true,response.IsSuccess);
        System.assertEquals('Success',response.status);
        System.assertEquals(lead.LastName,response.lead);
    }
/*
*Test for updateLeads method
*/
    static testMethod void testUpdateLeads() {
        List<lead> leadList = LeadFactory.createAndInsertLeads(1);
        Lead lead = leadList[0];
        LeadManipulatorUsingSOAP.ResponseLead response = new LeadManipulatorUsingSOAP.ResponseLead();
        test.startTest();
            response = LeadManipulatorUsingSOAP.updateLeads('Demo','Lead#1','updatedviarest@gmail.com','0000000');
        test.stopTest();
        lead = [SELECT Id,Name,Email,Phone,Company FROM LEAD][0];
        System.assertEquals('ESPL', lead.Company);
        System.assertEquals('updatedviarest@gmail.com', lead.Email);
        System.assertEquals('0000000', lead.Phone);
        System.assertEquals(true,response.IsSuccess);
        System.assertEquals('Success',response.status);
        System.assertEquals(lead.Id,response.lead);
    }
/*
*Test for insertLeads method expecting exception as company field is empty
*/
    static testMethod void testExceptionInsertLeads() {
        LeadManipulatorUsingSOAP.ResponseLead response = new LeadManipulatorUsingSOAP.ResponseLead();
        test.startTest();
            response = LeadManipulatorUsingSOAP.insertLeads('Rohit','','Shisode','abc@gmail.com','2456897');
        test.stopTest();
        System.assertEquals(false,response.IsSuccess);
        System.assertNOTEquals('Success',response.status);
        System.assertEquals('',response.lead);
    }
/*
*Test for deleteLeads method expecting exception as no row matching criteria is found
*/
    static testMethod void testExceptionDeleteLeads() {
        List<lead> leadList = LeadFactory.createAndInsertLeads(1);
        Lead lead = leadList[0];
        LeadManipulatorUsingSOAP.ResponseLead response = new LeadManipulatorUsingSOAP.ResponseLead();
        test.startTest();
            response = LeadManipulatorUsingSOAP.deleteLeads('Rohit','Lead#1','abc1@gmail.com','123451');
        test.stopTest();
        System.assertEquals(false,response.IsSuccess);
        System.assertNOTEquals('Success',response.status);
        System.assertEquals('',response.lead);
    }
/*
*Test for updateLeads method expecting exception as no row matching criteria is found
*/
    static testMethod void testExceptionUpdateLeads() {
        List<lead> leadList = LeadFactory.createAndInsertLeads(1);
        Lead lead = leadList[0];
        LeadManipulatorUsingSOAP.ResponseLead response = new LeadManipulatorUsingSOAP.ResponseLead();
        test.startTest();
            response = LeadManipulatorUsingSOAP.updateLeads('Rohit','Lead#1','updatedviarest@gmail.com','0000000');
        test.stopTest();
        System.assertEquals(false,response.IsSuccess);
        System.assertNOTEquals('Success',response.status);
        System.assertEquals('',response.lead);
    }
}