public with sharing class AccountRecordType {
    public static void accountWithOrganizationType(){
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();
        List<Account> acc = [SELECT Id,Name,RecordTypeId FROM Account WHERE RecordTypeId = :accRecordTypeId];
        System.debug('Accounts with Organization as record type are::'+acc);
    }
}