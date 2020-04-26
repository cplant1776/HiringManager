@isTest
private class CheckUsersPermissions_TEST {
    
    @isTest
    static void testRunAs()
    {
        User testUser = generateTestUser('Hiring Manager - Rep');
        insertInterview();
        
        List<Interview__c> sysIntvs = [SELECT Name, Id FROM Interview__c];
        List<Applicant__c> sysApps = [SELECT Name, Id FROM Applicant__c];
        List<Position__c> sysPos = [SELECT Name, Id FROM Position__c];
        
        System.debug('=== System ===');
        System.debug('Interview: ' + sysIntvs);
        System.debug('Applicant: ' + sysApps);
        System.debug('Position: ' + sysPos);
        
        System.runAs(testUser)
        {
            List<Interview__c> userIntvs = [SELECT Name, Id FROM Interview__c];
            List<Applicant__c> userApps = [SELECT Name, Id FROM Applicant__c];
            List<Position__c> userPos = [SELECT Name, Id FROM Position__c];
            
            System.debug('=== User ===');
            System.debug('Interview: ' + userIntvs);
        	System.debug('Applicant: ' + userApps);
            System.debug('Position: ' + userPos);
        }
        
    }
    
    private static User generateTestUser(String profileName)
    {
        String uniqueUserName = 'Userdude' + DateTime.now().getTime() + '@testorg.com';
        
        Profile prof = [SELECT Id from Profile WHERE Name = :profileName];
        
        if(prof == null)
        {
            prof = [SELECT Id from Profile WHERE Name = 'Standard User'];
        }
        
        User newUser = new User(
            Alias = 'sdffsd', Email = 'udude@testorg.com',
            EmailEncodingKey = 'UTF-8', LastName = 'Testerman',
            LocaleSidKey = 'en_US', LanguageLocaleKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles',
            ProfileId = prof.id,
            UserName = uniqueUserName
        );
        
        return newUser;
    }
    
    private static void insertInterview()
    {
        
        Position__c pos = new Position__c(
            Title__c='Sales VP', Available__c=1,
            Min_Salary__c=200, Max_Salary__c=500,
            Location__c='Houston', Job_Type__c='Contract');
        
        Applicant__c app = new Applicant__c(
            First_Name__c='Mike', Last_Name__C='Jones',
            Email__c = 'mike@tester.com', Phone_Number__c='2813308004',
            Status__c='Applicant');
        
        insert app;
        insert pos;
        
        Interview__c intv = new Interview__c(
            Position__c=pos.id, Applicant__c=app.id,
            Interview_Date__c=Date.today()
        );
        
        insert intv;
    }
    
}