/**************************************************************************************************
 * Class : LeadManipulator
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : A class that exposes RESTful services to an end point allowing external system to manipulate leads in salesforce system
 * Test Class : LeadManipulatorTest
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   11/06/2017    Initial Development
 **************************************************************************************************/

@RestResource(urlMapping = '/Leads/*')
global with sharing class LeadManipulator {
    
    @HttpGet
    global static Lead getLeads(){
        RestRequest request = RestContext.request;
        String leadId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Lead lead = [SELECT Id,Name,Email,Phone,Status FROM LEAD WHERE Id = : leadId];
        return lead;
    }

    @httpPost

    global static Id insertLeads(String FirstName, String Company, String LastName, String Email, String Phone){
        Lead lead = new Lead();
        lead.FirstName = FirstName;
        lead.Company = Company;
        lead.LastName = LastName;
        lead.Email = Email;
        lead.Phone = Phone;
        try{
            insert lead;
            RestContext.response.addHeader('Content-Type','application/json');
            RestContext.response.responseBody = Blob.valueof('{"Lead":"'+lead.Id+'", "IsSuccess":"True","Status":"Success"}');
        }catch(Exception e){
            RestContext.response.addHeader('Content-Type','application/json');
            RestContext.response.responseBody = Blob.valueof('{"Lead":"", "IsSuccess":"false","Status":"'+e.getMessage()+'"}');
        }
        return lead.Id;
    }

    @httpDelete

    global static void deleteLeads(){
        String firstName = RestContext.request.params.get('firstName');
        String lastName = RestContext.request.params.get('lastName');
        String email = RestContext.request.params.get('Email');
        String phone = RestContext.request.params.get('Phone');
        System.debug('Request URI'+RestContext.request);
        System.debug('Parameters received are::'+firstName+' '+lastName+' '+email+' '+phone+' ');
        try{
            Lead lead = [SELECT Id,LastName FROM Lead WHERE FirstName = :firstName AND LastName = :lastName AND Email = :email AND Phone = :phone];
            delete lead;
            RestContext.response.addHeader('Content-Type','application/json');
            RestContext.response.responseBody = Blob.valueof('{"Lead":"'+lead.LastName+'", "IsSuccess":"True","Status":"Success"}');
        }catch(Exception e){
            RestContext.response.addHeader('Content-Type','application/json');
            System.debug('Error is::'+e.getMessage());
            RestContext.response.responseBody = Blob.valueof('{"Lead":"", "IsSuccess":"false","Status":"'+e.getMessage()+'"}');
        }
    }

    @httpPatch

    global static void updateLeads(String FirstName, String LastName, String Email, String Phone){
        try{
            Lead lead = [SELECT Id,Name FROM Lead WHERE FirstName = :FirstName AND LastName = :LastName];
            lead.Email = Email;
            lead.Phone = Phone;
            update lead;
            RestContext.response.addHeader('Content-Type','application/json');
            RestContext.response.responseBody = Blob.valueof('{"Lead":"'+lead.Id+'", "IsSuccess":"True","Status":"Success"}');
        }catch(Exception e){
            RestContext.response.addHeader('Content-Type','application/json');
            RestContext.response.responseBody = Blob.valueof('{"Lead":"", "IsSuccess":"false","Status":"'+e.getMessage()+'"}');
        }
    }

}