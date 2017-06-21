@isTest
private class CustomSettingControllerTest {

    @testSetup
    static void datafactory(){
       List<City__c> cityList = new List<City__c>();
       for(Integer i=0;i<3;i++){
            City__c record = new City__c();
           record.Name='Mumbai'+i;
           record.Country__c='India';
           cityList.add(record);
       }
       for(Integer i=0;i<2;i++){
        City__c record = new City__c();
           record.Name='New York'+i;
           record.Country__c='USA';
           cityList.add(record);
       }
       insert cityList;
    }
  /* Tests whether if the selected country 
   * display required city
   */
    public testMethod static void testCustomSetting(){
       test.startTest();
       CustomSettingController obj = new CustomSettingController();
       obj.selectedCountry='India';
       obj.getCountryList();
       obj.fetchCity();
       System.assertEquals(3,obj.listSelectedCity.size());
       System.assertEquals('Mumbai0',obj.listSelectedCity[0].getvalue());
       System.assertEquals('Mumbai1',obj.listSelectedCity[1].getvalue());
       System.assertEquals('Mumbai2',obj.listSelectedCity[2].getvalue());
       obj.listSelectedCity.clear();
       obj.selectedCountry='USA';
       obj.getCountryList();
       obj.fetchCity();
       System.assertEquals(2,obj.listSelectedCity.size());
       System.assertEquals('New York0',obj.listSelectedCity[0].getvalue());
       System.assertEquals('New York1',obj.listSelectedCity[1].getvalue());
       test.stopTest();
   }
}