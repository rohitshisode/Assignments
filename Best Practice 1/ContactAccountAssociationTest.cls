/**************************************************************************************************
 * Test Class : ContactAccountAssociationTest
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Test class to check functionality of CotactTrigger that associates contacts with respective account based on their email field.
 * Trigger : ContactTrigger
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 *   1.0      Rohit Shisode   20/05/2016    Initial Development
 **************************************************************************************************/
@isTest
private class ContactAccountAssociationTest {

    static testMethod void contactAccountAssociationForProperContact() {
        Test.startTest();
            AccountFactory.createAccountsWithDomain(true);
            List<Contact> contacts = ContactFactory.createAndInsertContacts(200);
        Test.stopTest();
        contacts = [SELECT Id,Name,AccountId,Account.Name FROM Contact];
        for(Contact c: contacts){
            System.assertEquals('AccountSample',c.Account.Name);
        }
    }
    static testMethod void contactAccountAssociationForNullEmailContact() {
        Test.startTest();
            AccountFactory.createAccountsWithDomain(true);
            List<Contact> contacts = ContactFactory.createContacts(200);
            for(Contact c: contacts){
                c.Email = null;
                System.debug(c);
            }
            insert contacts;
        Test.stopTest();
        contacts = [SELECT Id,Name,AccountId,Account.Name FROM Contact];
        for(Contact c: contacts){
            System.assertEquals(null,c.Account.Name);
        }
    }
    
    static testMethod void contactAccountAssociationForFewNullEmailContact() {
        Test.startTest();
            AccountFactory.createAccountsWithDomain(true);
            List<Contact> contacts = ContactFactory.createContacts(200);
            Boolean flag = true;
            for(Contact c: contacts){
                if(flag){
                    c.Email = null;
                    flag=false;
                }else{
                    flag=true;
                }
            }
            insert contacts;
        Test.stopTest();
        contacts = [SELECT Id,Name,AccountId,Account.Name FROM Contact];
        Integer count=0;
        for(Contact c: contacts){
            if(c.AccountId != null){
                count++;
            }
        }
        System.assertEquals(100,count);
    }
    
    static testMethod void contactAccountAssociationForNoDomainAccount() {
        Test.startTest();
            AccountFactory.createAccountsWithDomain(true);
            List<Contact> contacts = ContactFactory.createContacts(200);
            for(Contact c: contacts){
                c.Email = 'xyz@pqr.com';
            }
            insert contacts;
        Test.stopTest();
        contacts = [SELECT Id,Name,AccountId,Account.Name FROM Contact];
        for(Contact c: contacts){
            System.assertNOTEquals('AccountSample',c.Account.Name);
        }
    }
    
    static testMethod void contactAccountAssociationForNullDomain() {
        Test.startTest();
            AccountFactory.createAccountsWithDomain(false);
            List<Contact> contacts = ContactFactory.createContacts(200);
            for(Contact c: contacts){
                c.Email = 'xyz@pqr.com';
            }
            insert contacts;
        Test.stopTest();
        contacts = [SELECT Id,Name,AccountId,Account.Name FROM Contact];
        for(Contact c: contacts){
            System.assertEquals(null,c.AccountId);
        }
    }
    
    
}