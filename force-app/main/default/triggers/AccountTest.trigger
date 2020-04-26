trigger AccountTest on Account (before insert) {
	List<Contact> theContacts = new List<Contact>();
    for(Account a : Trigger.new) {
        for(Contact c : [SELECT id, Account_Date__c FROM Contact WHERE AccountID = :a.Id]) {
            c.Account_Date__c = Date.today();
            theContacts.add(c);
        }
    }
    update theContacts;
}