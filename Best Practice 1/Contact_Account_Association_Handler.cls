public with sharing class Contact_Account_Association_Handler {
    public static void contactAccountAssociation(List<Contact> contacts){
        Set<String> emailDomains = new Set<String>();
        for (Contact cnt : contacts) {
            if (cnt.Email == null) {
                continue;
            }
            emailDomains.add(cnt.Email.split('@').get(1));
        }
        emailDomains.remove(null);
        if (!emailDomains.isEmpty()) {
            Map<String, Account> emailDomainToAccountMap = new Map<String, Account>();
            for (Account a : [SELECT Email_Domain__c,Id FROM Account 
                              WHERE Email_Domain__c IN :emailDomains]) {
                emailDomainToAccountMap.put(a.Email_Domain__c, a);
            }
            for (Contact cnt : contacts) {
                if (cnt.Email == null) {
                    continue;
                }
                String domain = cnt.Email.split('@').get(1);
                if (!emailDomainToAccountMap.containsKey(domain)) {
                    continue;
                }
                cnt.AccountId = emailDomainToAccountMap.get(domain).Id;
            }
        }
    }
}