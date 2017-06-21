@isTest
public class AccountContactRoleFactory {

/**
* Creates Account object data
*
* @param count   Number of records to be created
*
* @return accounts List of Accounts
*/
    public static List<AccountContactRole> createAccountContactRoles(Integer count) {
        List<Account> accountList = AccountFactory.createAndInsertAccounts(count);
        List<Contact> contactList = ContactFactory.createAndInsertContacts(count);
        List<Opportunity> opportunityList = OpportunityFactory.createAndInsertOpportunity(count);
        List<AccountContactRole> AccountContactRole_List = new List<AccountContactRole>();
        for(Integer i = 0;i<count;i++){
            AccountContactRole role = new AccountContactRole();
            contactList[i].AccountId = accountList[i].Id;
            role.AccountId = contactList[i].AccountId;
            opportunityList[i].AccountId = accountList[i].Id;
            role.ContactId = contactList[i].Id;
            role.role = 'Other';
            role.IsPrimary = true; 
            AccountContactRole_List.add(role);
        }
        update contactList;
        update opportunityList;
        return AccountContactRole_List;
    }

    /**
     * Creates and insert Account records.
     *
     * @param count   Number of records to be created
     *
     * @return accounts List of Accounts
     */
     public static List<AccountContactRole> createAndInsertAccountContactRoles(Integer count) {
        List<AccountContactRole> AccountContactRole_List = createAccountContactRoles(count);
        return insertData(AccountContactRole_List);
    }

    /**
     * Insert Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<AccountContactRole> insertData(List<AccountContactRole> AccountContactRole_List) {
        insert AccountContactRole_List;
        return AccountContactRole_List;
    }

    /**
     * Update Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<AccountContactRole> updateData(List<AccountContactRole> AccountContactRole_List) {
        update AccountContactRole_List;
        return AccountContactRole_List;
    }
}