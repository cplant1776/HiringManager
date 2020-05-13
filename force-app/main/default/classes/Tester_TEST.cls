public class Tester_TEST {
    static Integer bla(){
        return -1;
    }
    
    
    public static void willThisExplode()
    {
        List<Account> accs = new List<Account>();
        for(Integer i=0; i < 100; i++)
        {
            accs.add(new Account(Name='bla'+i));
        }
        
        database.Insert(accs, false);
        
        List<Contact> cons = new List<Contact>();
        for(Integer i=0; i < 2000; i++)
        {
            cons.add(new Contact(LastName='blablabla'+i));
        }
        insert cons;
        
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i=0; i < 500; i++)
        {
            // No stage name
            opps.add(new Opportunity(Name='blablabla'+i));
        }
        insert opps;        
    }
}