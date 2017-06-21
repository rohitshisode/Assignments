public with sharing class AbstractDemoChild extends AbstractDemo{
    Integer childNumber=20;
    public void displayChild(){
    	System.debug('Numer='+childNumber);
    }
    public override void multiply(){
    	childNumber*=childNumber;
    }
}