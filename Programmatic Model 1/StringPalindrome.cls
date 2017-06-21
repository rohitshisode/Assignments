public with sharing class StringPalindrome {
    public void palindromeCheck(String str){
		String reverseString;
		if(!String.isBlank(str)){
			reverseString=str.reverse();	
		}
		if(str == reverseString){
			System.debug('String is a palindrome');
		} else{
			System.debug('String is NOT a palindrome');
		}
	}
}