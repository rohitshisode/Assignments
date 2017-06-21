/**************************************************************************************************
 * Class : AccountOpportunityBatch
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Batch class to mail the details of closed won opportunities of the day to primary contact of an account
 * Test Class : scheduledBatchableTest
 --------------------------------------------------------------------------------------------------
 * Version History:
 * Version  Developer Name    Date          Detail Features
 * 1.0      Rohit Shisode   08/06/2017    Initial Development
 **************************************************************************************************/
global with sharing class AccountOpportunityBatch implements Database.Batchable<SObject>, Database.Stateful {

/*
* Stateful map that will hold accountId as key and another map as value 
* in which its primary contacts mailId will be key and list of opportunities as value
*/ 
    global Map<Id,Map<String,List<Opportunity>>> mapContactOpportunity =new Map<Id,Map<String,List<Opportunity>>>();

/*
* Map that will hold accountId as key and aggregate of amount of its related opportunities
*/
    global Map<Id,Double> aggregateAmountOnAccount = new Map<Id,Double>();

/*
* Start the batch and generate the QueryLocator based on the queryString.
*/

    global Database.QueryLocator start (Database.BatchableContext bc){

        return Database.getQueryLocator('SELECT Id'+
                                             ', (SELECT Name'+
                                                     ', Amount'+
                                               ' FROM Opportunities'+ 
                                               ' WHERE StageName=\'Closed Won\''+
                                                 ' AND CloseDate=today)'+
                                             ', (SELECT Contact.Email'+
                                              ' From AccountContactRoles'+
                                              ' WHERE IsPrimary = true)'+
                                       ' FROM Account'+ 
                                       ' WHERE Id IN (SELECT AccountId'+
                                                    ' FROM Opportunity'+
                                                    ' WHERE StageName= \'Closed Won\''+
                                                      ' AND CloseDate =today)'+
                                       ' AND Id IN (SELECT AccountId'+
                                                  ' FROM AccountContactRole'+
                                                  ' WHERE IsPrimary = true)'
        );

    }

/*
* Execute function for current scope
*/

    global void execute(Database.BatchableContext bc, List<Account> scope){

        Double total;
        for(Account acc : scope){
            total = 0.0;
            mapContactOpportunity.put(acc.Id,new Map<String,List<Opportunity>>());
            mapContactOpportunity.get(acc.Id).put(acc.AccountContactRoles[0].Contact.Email,acc.Opportunities);
            for(Opportunity opp : acc.Opportunities){
                if(opp.Amount!=null){
                    total = total + opp.Amount;
                }
            }
            aggregateAmountOnAccount.put(acc.Id,total);
        }

    }

/* 
* Execute finish function for current scope and send emails
*/

    global void finish(Database.BatchableContext bc){
        Boolean isMailIdNull = false;
        String mailBody='';
        String[] mailAddress=new String[]{};
        List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();
        for(String Id : mapContactOpportunity.keySet()){
            isMailIdNull = false;
            mailBody = '';
            mailAddress.clear();
            for(String MailId : mapContactOpportunity.get(Id).keySet()){
                if(MailId != null){
                    mailAddress.add(MailId);
	                for(Opportunity opp : mapContactOpportunity.get(Id).get(MailId)){
	                    mailBody += 'Opportunity:::'+opp.Name+'\n';
	                    mailBody += 'Amount:::'+opp.Amount+'\n';
	                }
	                mailBody += 'Total of the Day:::'+ aggregateAmountOnAccount.get(Id) + '\n\n\n';
	                mailBody += 'Thank You';
                }else{
                    isMailIdNull = true;
                }
            }
            if(!isMailIdNull){
	            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	            mail.setToAddresses(mailAddress);
	            mail.setSubject('Report of all closed won opportunities for your account today');
	            mail.setPlainTextBody('Hello,\n Following are details of opportunities that were closed won for you account today\n'+mailBody);
	            listMail.add(mail);
            }
        }
        Messaging.sendEmail(listMail);

    }

}