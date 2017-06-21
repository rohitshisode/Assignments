/**************************************************************************************************
 * Class : LeadManipulatorTest
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Test class to check funstionality of LeadManipulator class
 * Test Class : LeadManipulatorTest
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   11/06/2017    Initial Development
 **************************************************************************************************/

@isTest
private class LeadManipulatorTest {

/*
*Test for HttpGet method by providing ID of lead record
*/
    static testMethod void testGetLeads() {
        List<lead> leadList = LeadFactory.createAndInsertLeads(1);
        ID recordId = leadList[0].Id;
        RestRequest request = new RestRequest();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Leads/'+recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Lead lead = LeadManipulator.getLeads();
        System.assert(lead != null);
        System.assertEquals('Open - Not Contacted', lead.Status);
    }
/*
*Test for HttpPost method
*/
    static testMethod void testInsertLeads() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Leads/';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        test.startTest();
            Id leadId = LeadManipulator.insertLeads('Rohit','ESPL','Shisode','abc@gmail.com','2456897');
        test.stopTest();
        System.assert(leadId != null);
        Lead lead = [SELECT Id,Name,Email,Phone,Company FROM LEAD WHERE Id = : leadId];
        System.assertEquals('ESPL', lead.Company);
        System.assertEquals('Rohit Shisode', lead.Name);
        System.assertEquals('abc@gmail.com', lead.Email);
        System.assertEquals('2456897', lead.Phone);
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);
        System.assertEquals('True',mapResponse.get('IsSuccess'));
        System.assertEquals('Success',mapResponse.get('Status'));
        System.assertEquals(lead.Id,mapResponse.get('Lead'));
    }
/*
*Test for HttpDelete Method
*/
    static testMethod void testDeleteLeads() {
        List<lead> leadList = LeadFactory.createAndInsertLeads(1);
        Lead lead = leadList[0];
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Leads?firstName='+lead.FirstName+'&lastName='+lead.LastName+'&Email='+lead.Email+'&Phone='+lead.Phone;
        request.params.put('firstName',lead.FirstName);
        request.params.put('lastName',lead.LastName);
        request.params.put('Email',lead.Email);
        request.params.put('Phone',lead.Phone);
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        RestContext.response = response;
        LeadManipulator.deleteLeads();
        System.debug('Response is::'+RestContext.response);
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);
        System.assertEquals('True',mapResponse.get('IsSuccess'));
        System.assertEquals('Success',mapResponse.get('Status'));
        System.assertEquals(lead.LastName,mapResponse.get('Lead'));
    }
/*
*Test for HttpPatch method
*/
    static testMethod void testUpdateLeads() {
        List<lead> leadList = LeadFactory.createAndInsertLeads(1);
        Lead lead = leadList[0];
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Leads/';
        request.httpMethod = 'Patch';
        RestContext.request = request;
        RestContext.response = response;
        test.startTest();
            LeadManipulator.updateLeads('Demo','Lead#1','updatedviarest@gmail.com','0000000');
        test.stopTest();
        lead = [SELECT Id,Name,Email,Phone,Company FROM LEAD WHERE Id = : lead.Id];
        System.assertEquals('ESPL', lead.Company);
        System.assertEquals('updatedviarest@gmail.com', lead.Email);
        System.assertEquals('0000000', lead.Phone);
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);
        System.assertEquals('True',mapResponse.get('IsSuccess'));
        System.assertEquals('Success',mapResponse.get('Status'));
        System.assertEquals(lead.Id,mapResponse.get('Lead'));
    }
/*
*Test for exception while inserting lead into salesforce with required field missing
*/
        static testMethod void testExceptionForInsertLeads() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Leads/';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = response;
        test.startTest();
            Id leadId = LeadManipulator.insertLeads('Rohit','','Shisode','abc@gmail.com','2456897');
        test.stopTest();
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);
        System.assertEquals('false',mapResponse.get('IsSuccess'));
        System.assertNOTEquals('Success',mapResponse.get('Status'));
        System.assertEquals('',mapResponse.get('Lead'));
    }
/*
*Test for exception in deleting record of lead
*/
    static testMethod void testExceptionDeleteLeads() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Leads';
        request.params.put('firstName','Ro');
        request.params.put('lastName','Sh');
        request.params.put('Email','a@a.com');
        request.params.put('Phone','00000');
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        RestContext.response = response;
        LeadManipulator.deleteLeads();
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);
        System.assertEquals('false',mapResponse.get('IsSuccess'));
        System.assertNOTEquals('Success',mapResponse.get('Status'));
        System.assertEquals('',mapResponse.get('Lead'));
    }
/*
*Test for exception for update of lead record
*/
    static testMethod void testExceptionUpdateLeads() {
        List<lead> leadList = LeadFactory.createAndInsertLeads(1);
        Lead lead = leadList[0];
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = 'https://ap5.salesforce.com/services/apexrest/Leads/';
        request.httpMethod = 'Patch';
        RestContext.request = request;
        RestContext.response = response;
        test.startTest();
            LeadManipulator.updateLeads('Rohit','Shisode','updatedviarest@gmail.com','0000000');
        test.stopTest();
        String responseString = EncodingUtil.base64Decode(EncodingUtil.base64Encode(RestContext.response.responseBody)).toString();
        Map<String, String> mapResponse = (Map<String, String>)JSON.deserialize(responseString, Map<String, String>.class);
        System.assertEquals('false',mapResponse.get('IsSuccess'));
        System.assertNOTEquals('Success',mapResponse.get('Status'));
        System.assertEquals('',mapResponse.get('Lead'));
    }
}