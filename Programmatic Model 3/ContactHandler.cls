/**************************************************************************************************
 * Class : ContactHandler
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Helper class for ContactTigger, checks for duplication in contact records against email and phone fields and
 *               prevents record creation.
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 *   1.0      Rohit Shisode   18/05/2016    Initial Development
 **************************************************************************************************/
public with sharing class ContactHandler {
    /**
     * Validates contact records against their email and phone to prevent deuplication
     *
     * @param contacts  Recieved list of contacts from trigger(before insert) that are being inserted.
     *
     */
    public static void validateContactForDuplication(List<Contact> contacts){
        Set<String>mailSet = new Set<String>();
        Set<String>phoneSet = new Set<String>();
        for(Contact cnt:contacts){
             //Checking for null in both fields so as to exit here only.
            if(cnt.Email!=null || cnt.Phone!=null){
                //Checking for null individually so that null are not treated as duplicates in new record.
                if((cnt.Email!=null && mailSet.contains(cnt.Email))||(cnt.Phone!=null && phoneSet.contains(cnt.Phone))){
                    cnt.addError('A contact with same email or phone exist in new records');
                }else{
                    mailSet.add(cnt.Email);
                    phoneSet.add(cnt.Phone);
                }
            }
        }
        List<Contact> duplicateContact = [SELECT ID,Email,Phone FROM Contact WHERE Email =:mailSet OR Phone =:phoneSet];
        System.debug(duplicateContact);
        Set<String> dupSetCnt =new Set<String>();
        Set<String> dupSetCntPhone =new Set<String>();
        for(Contact c:duplicateContact){
            dupSetCnt.add(c.Email);
            dupSetCntPhone.add(c.Phone);
        }
        for(Contact c: contacts){
            if(c.Email!=null){
                if(dupSetCnt.contains(c.Email)){
                    c.addError('A contact with same email already exist in the system');
                }
            }
            if(c.Phone!=null){
                if(dupSetCntPhone.contains(c.Phone)){
                    c.addError('A contact with same phone already exist in the system');
                }
            }
        }
        /*Map<Id,Contact> contactMap = new Map<Id,Contact>([SELECT Id,Name,Email,Phone FROM Contact WHERE Email != null OR Phone != null]);
        for(Contact cnt:Trigger.new){
             if(cnt.Email == contactMap.get(cnt.Id).Email || cnt.Phone == contactMap.get(cnt.Id).Phone){
                 cnt.addError('A contact with same email or phone already exist in the system');
             }
        }*/
    }
}