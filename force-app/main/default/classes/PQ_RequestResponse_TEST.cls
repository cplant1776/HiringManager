@isTest
public class PQ_RequestResponse_TEST {
    @testSetup
    private static void testSetup()
    {
        List<Applicant__c> apps = new List<Applicant__c>();
        Applicant__c app = new Applicant__c(First_Name__c='John', Last_Name__c='Testerman',
                                            Email__c='abc@def.com', Phone_Number__c='1234567890',
                                            Status__c='Applicant');
        insert app;
        
        List<Certification__c> certs = new List<Certification__c>();
        certs.add(new Certification__c(Certification_Id__c='5a6ce86e2af929789500e7e4',
                                       Applicant__c=app.id));
        certs.add(new Certification__c(Certification_Id__c='5a6ce86e2af929789500e7d7',
                                       Applicant__c=app.id));
        insert certs;
    }
    
    @isTest
    private static void doesCompareCertsReturnCorrectLists()
    {
        // Construct fake callout response
        Set<CertDetails> certsFound = new Set<CertDetails>();
        CertDetails certA = new CertDetails(); // Exists on applicant
        certA.id_x = '5a6ce86e2af929789500e7e4';
        certsFound.add(certA);
        CertDetails certB = new CertDetails(); // Does NOT exist on applicant
        certB.id_x = '5a6ce86f2af929789500e7f3';
        certsFound.add(certB);
        
        // Pull out applicant
        Applicant__c applicant = [SELECT Id, 
                                  (SELECT Name, Certification_Id__c, Id, Applicant__c
                                   FROM Certifications__r)
                                  FROM Applicant__c 
                                  WHERE Email__c='abc@def.com' LIMIT 1];
        
        // Debug Statements
        System.debug('Applicant\'s certs:');
        for(Certification__c eachCert : applicant.Certifications__r)
        {
            System.debug('id_x: ' + eachCert.Certification_Id__c + ' | id: ' + eachCert.Id);
        }
        System.debug('Callout\'s certs:');
        for(CertDetails eachCert : certsFound)
        {
            System.debug('id_x: ' + eachCert.id_x);
        }
        
        Test.startTest();
        // Run comparison
        Map<String, List<Object>> comparisonResult = ProgrammerQuotes_RequestResponse.compareCerts(certsFound, applicant);
        Test.stopTest();
        
        // Check DELETE list
        Certification__c actualCertToDelete = [SELECT Id FROM 
                                               Certification__c 
                                               WHERE Certification_Id__c='5a6ce86e2af929789500e7d7' LIMIT 1];
        List<Id> idsToDelete = (List<Id>)comparisonResult.get('delete');
        System.assertEquals(actualCertToDelete.Id, idsToDelete[0]);
        
        // Check ADD list
        List<Certification__c> certsToAdd = (List<Certification__c>)comparisonResult.get('add');
        System.assertEquals(applicant.Id, certsToAdd[0].Applicant__c);
        System.assertEquals('5a6ce86f2af929789500e7f3', certsToAdd[0].Certification_Id__c);
        
        // Make sure applicant's existing cert is unchanged
        Certification__c existingCert = [SELECT Id
                                         FROM Certification__c
                                         WHERE Certification_Id__c='5a6ce86e2af929789500e7e4'
                                         LIMIT 1];
        System.assert(existingCert != NULL);
        
        // Update DB and check applicant's final certs
        Database.delete((List<Id>)comparisonResult.get('delete'));
        insert (List<Certification__c>)comparisonResult.get('add');
        
        System.debug('Applicant\'s final certs:');
        applicant = [SELECT Id, 
                                  (SELECT Name, Certification_Id__c, Id, Applicant__c
                                   FROM Certifications__r)
                                  FROM Applicant__c 
                                  WHERE Email__c='abc@def.com' LIMIT 1];
		for(Certification__c eachCert : applicant.Certifications__r)
        {
            System.debug('id_x: ' + eachCert.Certification_Id__c + ' | id: ' + eachCert.Id);
        }
    }
}