public with sharing class StudentExtension {
   public List<SelectOption> langList{get; set;}
   public String selectedLang {get; set;}
   public String languageCode {get; set;}
   public Student__c student;
   public StudentExtension(ApexPages.StandardController abc){
       student = (Student__c)abc.getRecord();
       langList = new  List<SelectOption>();
       if(Language__c.getAll().values().size()> 0){
           for(Language__c setting : Language__c.getAll().values()){
               langList.add(new SelectOption(setting.Name, setting.Name));
           }
           selectedLang = Language__c.getAll().values()[1].Name;
           languageCode = Language__c.getAll().values()[1].Code__c;
       }
   }

   public void selectChange(){
       for(Language__c setting : Language__c.getAll().values()){
           if(setting.Name==selectedLang){
               languageCode = setting.Code__c;
           }
       }
   }

   public PageReference saveNew() {
    insert student;
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,System.Label.Student_Registration));
    student = new Student__c();
    //student.Id = null;
    /*PageReference pgeRef = new PageReference('/apex/StudentRegistrationDemo');
    pgeRef.setRedirect(true);
    return pgeRef;*/
    return null;
}
}