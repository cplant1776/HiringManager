@isTest
public class Tester_TEST {
    @isTest
    public static void tester()
    {
        System.debug('START Tester_Test::tester()');
        List<Account> accs = new List<Account>();
        List<Contact> cons = new List<Contact>();
        List<Opportunity> opps = new List<Opportunity>();
        
        for(Integer i = 0; i < 100; i++)
        {
            accs.add(new Account(Name='testerAcc'+i));
        }
        
        for(Integer i = 0; i < 2000; i++)
        {
            cons.add(new Contact(LastName='testerman' + i));
        }
        
        for(Integer i = 0; i < 500; i++)
        {
            opps.add(new Opportunity(Name='testerOpp'+i,
                                     CloseDate=Date.today(),
                                     StageName='Prospecting'));
        }
        try{
            System.debug('start TRY');
            database.insert(accs, false);
            insert cons;
            insert opps;
            System.debug('Acc: ' + accs.size() + ' Con: ' + cons.size() + ' Opp:' + opps.size());
        }
        finally
        {
            System.debug('Reach FINALLY');
            //Test.startTest();
            Integer accSize = [SELECT Count() FROM Account];
            Integer conSize = [SELECT Count() FROM Contact];
            Integer oppSize = [SELECT Count() FROM Opportunity];
            System.debug('Reach DEBUG');
            System.debug('Acc: ' + accSize + ' Con: ' + conSize + ' Opp:' + oppSize);
            //Test.stopTest();
        }
        
    }
}