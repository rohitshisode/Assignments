/**************************************************************************************************
 * Class : CheckRecursive
 * Created By : Rohit Shisode
 --------------------------------------------------------------------------------------------------
 * Description : Checks for recursion in triggers.
 **************************************************************************************************/
public with sharing class CheckRecursive {
    private static boolean run = true;
    public static boolean runOnce(){
        if(run){
            run = false;
            return true;
        }else{
            run = true;
            return false;
        }
    }
}