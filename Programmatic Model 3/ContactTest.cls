/**************************************************************************************************
 * Test Class : ContactTest
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : class to check functionality of CotactTrigger
 * Trigger : ContactTrigger
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 *   1.0      Rohit Shisode   19/05/2016    Initial Development
 **************************************************************************************************/
@isTest
private class ContactTest {
    
//  Checks for records that are not duplicate but are bulk in nature

    static testMethod void testContactforDuplicates() {
        Test.startTest();
            List<Contact> cont = ContactFactory.createAndInsertContacts(200);
        Test.stopTest();
        List<Contact> cnt = [SELECT Id,LastName FROM Contact WHERE LastName LIKE 'Contact%'];
        System.assertEquals(cnt.size(),200);
    }
    
//Checks for record that is not duplicate
    static testMethod void testSingleContactforDuplicates() {
        Test.startTest();
            List<Contact> cont = ContactFactory.createAndInsertContacts(1);
        Test.stopTest();
        List<Contact> cnt = [SELECT Id,LastName FROM Contact WHERE LastName LIKE 'Contact%'];
        System.assertEquals(cnt.size(),1);
    }
//Checks for records that have mail duplicates in new records with ALL NULL
    
    static testMethod void testContactWithMailNullDuplicates(){
        Test.startTest();
            List<Contact> cont = ContactFactory.createContacts(20);
        Test.stopTest();
        for(Contact c:cont){
            c.Email=null;
        }
        cont = ContactFactory.insertData(cont);
        List<Contact> cnt = [SELECT Id,LastName FROM Contact WHERE LastName LIKE 'Contact%'];
        System.assertEquals(cnt.size(),20);
    }

//Checks for records that have PHONE DUPLICATE in NEW RECORD with ALL NULL
   
    static testMethod void testContactWithPhoneNullDuplicates(){
        Test.startTest();
            List<Contact> cont = ContactFactory.createContacts(20);
        Test.stopTest();
        for(Contact c:cont){
            c.Phone=null;
        }
        cont = ContactFactory.insertData(cont);
        List<Contact> cnt = [SELECT Id,LastName FROM Contact WHERE LastName LIKE 'Contact%'];
        System.assertEquals(cnt.size(),20);
    }

//Checks for records that have FEW NULL values and few accepted values
    
    static testMethod void testContactWithPartialNullDuplicates(){
        Test.startTest();
            List<Contact> cont = ContactFactory.createContacts(20);
        Test.stopTest();
        Boolean flag = true;
        for(Contact c:cont){
            if(flag){
                c.Email=null;
                flag=false;
            }else{
                flag=true;
            }
        }
        cont = ContactFactory.insertData(cont);
        List<Contact> cnt = [SELECT Id,LastName FROM Contact WHERE LastName LIKE 'Contact%'];
        System.assertEquals(cnt.size(),20);
    }

//Checks for records that have PHONE DUPLICATE in NEW RECORD
    static testMethod void testContactWithPhoneDuplicates(){
        Test.startTest();
            List<Contact> cont = ContactFactory.createContacts(20);
        Test.stopTest();
        for(Contact c:cont){
            c.Phone='2336699';
        }
        //cont = ContactFactory.insertData(cont);
        try{
            insert cont;
        }catch(DMLException e){
            System.assertEquals('A contact with same email or phone exist in new records', e.getDmlMessage(0));
        }
    }

//Checks for records that have EMAIL DUPLICATE in NEW RECORD    
    static testMethod void testContactWithMailDuplicates(){
        Test.startTest();
            List<Contact> cont = ContactFactory.createContacts(20);
        Test.stopTest();
        for(Contact c:cont){
            c.Email='a@gmail.com';
        }
        //cont = ContactFactory.insertData(cont);
        try{
            insert cont;
        }catch(DMLException e){
            System.assertEquals('A contact with same email or phone exist in new records', e.getDmlMessage(0));
        }
    }
    
//Checks for records that have PHONE DUPLICATE in EXISTING RECORD
    static testMethod void testContactWithPhoneExistingDuplicates(){
        Test.startTest();
            List<Contact> cont = ContactFactory.createAndInsertContacts(20);
            Contact singleContact = new Contact(LastName='DUP',Email='avfg_18@gmail.com',Phone=cont[0].Phone);
        Test.stopTest();
        //cont = ContactFactory.insertData(cont);
        try{
            insert singleContact;
        }catch(DMLException e){
            System.assertEquals('A contact with same phone already exist in the system', e.getDmlMessage(0));
        }
    }

//Checks for records that have EMAIL DUPLICATE in EXISTING RECORD    
    static testMethod void testContactWithMailExistingDuplicates(){
        Test.startTest();
            List<Contact> cont = ContactFactory.createAndInsertContacts(20);  
            Contact singleContact = new Contact(LastName='DUP',Email='a_18@gmail.com',Phone='2589741');
        Test.stopTest();
        /*for(Contact c:cont){
            c.Email='abg@gmail.com';
        }*/
        //cont = ContactFactory.insertData(cont);
        try{
            insert singleContact;
        }catch(DMLException e){
            System.assertEquals(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION, e.getDmlType(0));
            System.assertEquals('A contact with same email already exist in the system', e.getDmlMessage(0));
        }
    }
}