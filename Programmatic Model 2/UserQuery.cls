public with sharing class UserQuery {
    public static void queryOnUser(){
    	Map<Id,User> userMap = new Map<Id,User>([SELECT Name FROM User WHERE isActive = true]);
    	System.debug(userMap);
    }
}