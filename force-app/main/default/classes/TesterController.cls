public class TesterController {
    /*
public String myString {
get {
if(myString == null) {
myString = 'a';
}
return myString;
}
private set;
}

public String getMyString() {
return 'getMyString';
}

public String getStringMethod() {
if (myString == null) {
myString = 'b';
}
return myString;
}
*/
    public String myString;
    
    public string getMyString(){
        return 'getMyString';
    }
    
    public string getStringMethod1(){
        return myString;
    }
    
    public string getStringMethod2(){
        if(myString == null)
            myString = 'Method2';
        return myString;
    }
}