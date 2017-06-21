/**************************************************************************************************
 * Class : LeadManipulatorUsingSOAP
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Exposed this apex class as webservice and it allows for insertion,deletion and updation of lead records
 * Test Class : LeadManipulatorUsingSOAPTest
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   12/06/2017    Initial Development
 **************************************************************************************************/

global with sharing class LeadManipulatorUsingSOAP {

/*
*Inner class that will hold the response values
*/
    global class ResponseLead{
        webService String lead;
        webService Boolean IsSuccess;
        webService String status;
    }
    
/*
*Exposed method for inserting lead records
*params: Stipulated fields for lead object
*/
    webService static ResponseLead insertLeads(String FirstName, String Company, String LastName, String Email, String Phone){
        Lead lead = new Lead();
        System.debug('INside insert');
        lead.FirstName = FirstName;
        lead.Company = Company;
        lead.LastName = LastName;
        lead.Email = Email;
        lead.Phone = Phone;
        ResponseLead responseObj = new ResponseLead();
        try{
            insert lead;
            responseObj.lead = lead.Id;
            responseObj.IsSuccess = true;
            responseObj.status = 'Success';
            return responseObj;
        }catch(Exception e){
            responseObj.lead = '';
            responseObj.IsSuccess = false;
            responseObj.status = e.getMessage();
            return responseObj;
        }
    }
/*
*Exposed method for deleting lead records
*params: filter fields for lead object to be filtered
*/
    webService static ResponseLead deleteLeads(String FirstName, String LastName, String Email, String Phone){
        ResponseLead responseObj = new ResponseLead();
        try{
            Lead lead = [SELECT Id,LastName FROM Lead WHERE FirstName = :FirstName AND LastName = :LastName AND Email = :Email AND Phone = :Phone][0];
            delete lead;
            responseObj.lead = lead.LastName;
            responseObj.IsSuccess = true;
            responseObj.status = 'Success';
            return responseObj;
        }catch(Exception e){
            responseObj.lead = '';
            responseObj.IsSuccess = false;
            responseObj.status = e.getMessage();
            return responseObj;
        }
    }
/*
*Exposed method for updating lead records
*params: filter fields for lead object to be filtered and fields to be updated
*/
    webService static ResponseLead updateLeads(String FirstName, String LastName, String NewEmail, String NewPhone){
        ResponseLead responseObj = new ResponseLead();
        try{
            Lead lead = [SELECT Id,Name FROM Lead WHERE FirstName = :FirstName AND LastName = :LastName][0];
            lead.Email = NewEmail;
            lead.Phone = NewPhone;
            update lead;
            responseObj.lead = lead.Id;
            responseObj.IsSuccess = true;
            responseObj.status = 'Success';
            return responseObj;
        }catch(Exception e){
            responseObj.lead = '';
            responseObj.IsSuccess = false;
            responseObj.status = e.getMessage();
            return responseObj;
        }
    }
}