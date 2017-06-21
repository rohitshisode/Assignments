public with sharing class StringReplace {
    public void replaceCharInString(String[] str,String replacement){
    	for(Integer i=0;i<str.size();i++){
            str[i] = str[i].replaceAll('a',replacement);
    		System.debug('New String is: '+str[i]);
    	}	
    }

}