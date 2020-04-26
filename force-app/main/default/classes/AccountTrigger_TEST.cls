@isTest
private class AccountTrigger_TEST {
    
	@isTest
    static void doesAccountCreateThreeContacts()
    {
        Account acc = new Account(Name = 'aaa Company');
        insert acc;
        
        // Check for Name capitalization
        List<Account> checkAccount = [SELECT Name FROM Account LIMIT 1];
        System.assertEquals('Aaa Company', checkAccount[0].Name);

        // Check for 3 Contacts
        List<Contact> checkCons = [SELECT MailingState, MailingCity FROM Contact];
        System.assertEquals(3, checkCons.size());
        
        // Check for capitalization on Contacts
        System.assertEquals('KS', checkCons[0].MailingState);
        System.assertEquals('Wichita', checkCons[0].MailingCity);
    }
}