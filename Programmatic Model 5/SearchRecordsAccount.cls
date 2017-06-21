public with sharing class SearchRecordsAccount {
    public String getstring{get;set;}
    public String alphabet{get;set;}
    public List<String> alphabets{get;set;}
    public static List<Account> accounts{get;set;}
    public Integer Length{get;set;}
    public static Account account{get;set;}

/* Constructor to initialize the alphabets string*/
    public SearchRecordsAccount(ApexPages.StandardSetController ac){
        accounts = ac.getRecords();
        Length=accounts.size();
        alphabets=new List<String>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','All'};
    }

/*Search method for search keywords entered in searchbox*/
    public void searchAccounts(){
        if(getstring!=null && getstring.length() >= 3){
            accounts=Database.query('SELECT Id,Name,Email__c,Phone,Website from Account WHERE Name Like \'%'+getstring+'%\'');
            Length=accounts.size();
        }else if(getstring.length() <= 3 || getstring==null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter atleast 3 characters'));
        }
    }

/*Method to display all records when page loads or all link is clicked*/
    public void displayAllRecords(){
        getstring=null;
        accounts=[select id,Name,Email__c,Phone,Website from Account];
        Length=accounts.size();
    }

/*Method to search for accounts starting with certain alphabet*/
    public void searchByAlphabet(){
        if(alphabet=='All'){
            accounts=[Select id,Name,Email__c,Phone,Website from Account];
            Length=accounts.size();
        }else{
            accounts=[Select Id,Name,Email__c,phone,Website from Account where name Like :alphabet+'%'];
            Length=accounts.size();
        }
    }

/*RemoteAction method that is called when delete link is clicked*/
    @RemoteAction
    public static void deleteAcc(Id acc){
        account=[select id from Account where Id=:acc];
        delete account;
    }
}