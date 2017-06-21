/**************************************************************************************************
 * Class : LeadFactory
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Utility class for inserting leads
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   10/06/2017    Initial Development
 **************************************************************************************************/
@isTest
public class LeadFactory {
/*
*Create leads based on count provided
*/
    public static List<Lead> createLeads(Integer count)
    {
        List<Lead> leadList = new List<Lead>();
        for (Integer i = 1; i <= count; i++)
        {
            Lead leadRecord = new Lead();
            leadRecord.FirstName = 'Demo';
            leadRecord.LastName = 'Lead#'+i;
            leadRecord.Company = 'ESPL';
            leadRecord.Status = 'Open - Not Contacted';
            leadRecord.Email = 'abc' + i + '@gmail.com';
            leadRecord.Phone = '12345' + i;
            leadList.add(leadRecord);
        }
        return leadList;
    }
/*
*Create and insert leads based on count
*/
    public static List<Lead> createAndInsertLeads(Integer count) {
        List<Lead> leadList = createLeads(count);
        return insertData(leadList);
    }
/*
*Insert leads
*/
    public static List<Lead> insertData(List<Lead> leadList)
    {
        insert leadList;
        return leadList;
    }
}