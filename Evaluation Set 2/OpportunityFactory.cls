@isTest
public class OpportunityFactory {

    /**
     * Creates Account object data
     *
     * @param count   Number of records to be created
     *
     * @return accounts List of Accounts
     */
    public static List<Opportunity> createOpportunity(Integer count) {
        List<Opportunity> opportunityList = new List<Opportunity>();
        for (Integer i = 1; i <= count; i++) {
            Opportunity opportunityRecord = new Opportunity(Name = 'Opportunity'+string.valueOf(i), Amount = 15000, StageName= 'Closed Won', CloseDate= System.today());
            opportunityList.add(opportunityRecord);
        }
        return opportunityList;
    }

    /**
     * Creates and insert Account records.
     *
     * @param count   Number of records to be created
     *
     * @return accounts List of Accounts
     */
     public static List<Opportunity> createAndInsertOpportunity(Integer count) {
        List<Opportunity> opportunityList = createOpportunity(count);
        return insertData(opportunityList);
    }

    /**
     * Insert Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<Opportunity> insertData(List<Opportunity> accounts) {
        insert accounts;
        return accounts;
    }

    /**
     * Update Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<Opportunity> updateData(List<Opportunity> accounts) {
        update accounts;
        return accounts;
    }
}