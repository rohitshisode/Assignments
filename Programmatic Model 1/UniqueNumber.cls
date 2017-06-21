public with sharing class UniqueNumber {
    public void uniqueNumber(Integer[] numArray){
    	Integer count=0,setInt,lstInt;
    	List <Integer> uniqueArray = new List<Integer>();
    	List <Integer> lstInteger = new List <Integer>();
    	List <Integer> lstInteger1 = new List <Integer>();
    	Set <Integer> setInteger = new Set <Integer>();
    	lstInteger.addAll(numArray);
    	setInteger.addAll(numArray);
    	lstInteger1.addAll(setInteger);
    	for(Integer i=0;i<lstInteger1.size();i++){
    		for(Integer j=0;j<lstInteger.size();j++){
    			if(lstInteger1[i] == lstInteger[j]){
    				count++;
    			}
    		}
    		if(count<=1){
    			uniqueArray.add(lstInteger1[i]);
    		}
    		count=0;
    	}
    	System.debug('Unique array is '+uniqueArray);
    }
}