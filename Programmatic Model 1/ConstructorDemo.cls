public with sharing class ConstructorDemo {
	private Integer number1,number2;
	public ConstructorDemo(){
		number1=number2=10;
	}
	public ConstructorDemo(Integer n){
		number1=n;
	}
    public ConstructorDemo(Integer n1,Integer n2){
		number1=n1;
		number2=n2;
	}
	public void displayNumber(){
		System.debug('Number-1='+number1+' Number-2='+number2);
	}
}