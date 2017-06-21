public with sharing class StringLength {
    public void calculateStringLength(String str){
    	Integer count=0;
    	String [] strArray = str.split('');
    	for(Integer i=0;i<strArray.size();i++)
    	{
    		count++;
    	}
    	System.debug('Length of string is '+count);
    }
}