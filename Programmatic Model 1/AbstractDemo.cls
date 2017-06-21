public with sharing abstract class AbstractDemo {
	Integer number1=10;
	public void display(){
		System.debug('Abstract class Number='+number1);
	}
	public abstract void multiply();
}