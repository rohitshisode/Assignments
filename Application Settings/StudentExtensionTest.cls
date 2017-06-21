@isTest
private class StudentExtensionTest {

    @testSetup
    static void datafactory() {
       List<Language__c> languageList = new List<Language__c>();
       Language__c obj = new Language__c();
       obj.Code__c='en';
       obj.Name='English';
       languageList.add(obj);
       Language__c obj2 = new Language__c();
       obj2.Code__c='fr';
       obj2.Name='French';
       languageList.add(obj2);
       Language__c obj3 = new Language__c();
       obj3.Code__c='es';
       obj3.Name='Spanish';
       languageList.add(obj3);
       insert languageList;
       Student__c student = new Student__c();

       
   }

   public testMethod static void testStudent(){
       Student__c student = new Student__c();
       student.Student_Name__c = 'Rohit';
       student.Gender__c = 'Male';
       student.Course_Applying_for__c = 'B.E.';
       student.HSC__c = 80.00;
       student.SSC__c = 80.00;
       Apexpages.StandardController sc = new Apexpages.StandardController(student);
       StudentExtension cObj = new StudentExtension(sc);
       test.startTest();
       cObj.selectedLang='English';
       cObj.selectChange();
       System.assertequals('en',cObj.languageCode);
       cObj.selectedLang='French';
       cObj.selectChange();
       System.assertequals('fr',cObj.languageCode);
       cObj.selectedLang='Spanish';
       cObj.selectChange();
       System.assertequals('es',cObj.languageCode);
       cObj.saveNew();
       test.stopTest();
       System.assertEquals(student.Student_Name__c,cObj.student.Student_Name__c);
       System.assertEquals(student.Gender__c,cObj.student.Gender__c);
       System.assertEquals(student.Course_Applying_for__c,cObj.student.Course_Applying_for__c);
       System.assertEquals(student.HSC__c,cObj.student.HSC__c);
       System.assertEquals(student.SSC__c,cObj.student.SSC__c);
       
   }
}