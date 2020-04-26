public class AccountTrigger_Helper{
    
    public static void beforeInsert(List<Account> newAccList)
    {
        System.debug('Inside method for working with before insert records');
        for(Account acc : newAccList)
        {
            if(acc.Name != null)
            {
                acc.Name = acc.Name.Capitalize();
            }
        }
    }
    
    public static void afterInsert(List<Account> newAccList)
    {
        System.debug('Inside method for working with after insert records');
        // Do some post-insert stuff
        List<Contact> cons = new List<Contact>();
        
        for(Account acc : newAccList)
        {
            for(Integer i = 0; i < 3; i++)
            {
                Contact con = new Contact(
                    FirstName = Quintrix_Util.generateRandomString(10),
                    LastName = Quintrix_Util.generateRandomString(10),
                    AccountId = acc.Id,
                    Email = Quintrix_Util.generateRandomString(8) + '@test.com',
                    MailingStreet = '123 Main St',
                    MailingState = 'ks',
                    MailingCity = 'wichita'
                );
                cons.add(con);
            }
        }
        
        System.debug('Added contacts: ' + cons);
        insert cons;
    }
}