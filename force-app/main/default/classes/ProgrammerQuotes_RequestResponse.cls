public class ProgrammerQuotes_RequestResponse {
    
    private static final String CERTS_URL_BASE = 'https://programming-quotes-api.herokuapp.com/quotes/page/';
    private static final String DUMMY_APPLICANT_ENDPOINT = CERTS_URL_BASE + '1';
    
    private static final Integer MIN_NUM_CERTS = 2;
    private static final Integer MAX_NUM_CERTS = 6;
    
    @InvocableMethod // Let's us call it from internal processes (flows, process builders)
    public static void updateCerts(List<Id> applicantIds)
    {
        Set<Id> applicantSet = new Set<Id>();
        
        for(Id applicantId : applicantIds)
        {
            applicantSet.add(applicantId);
            // If we reach 100 applicants
            if(applicantSet.size() == 100)
            {
                callCertAuthority(applicantSet);
                applicantSet.clear();
            }
        }
        
        // Run with any remaining applicants
        if(applicantSet.size() > 0)
        {
            callCertAuthority(applicantSet);
        }
        
    }
    
    // This method can only handle 100 callouts at a time
    // a future method can be called multiples times for multiple future threads
    // however if the future method has a callout in it, it can only call outside 100 times
    @future(callout = true)
    public static void callCertAuthority(Set<Id> applicantIds)
    {
        // Declarations
        Map<Id, Applicant__c> applicantsById = new Map<Id, Applicant__c>();
        List<Id> certsToDelete = new List<Id>();
        List<Certification__c> certsToAdd = new List<Certification__c>();
        
        // Map applicants by id
        for(Applicant__c each : [SELECT Id,
                                 (SELECT Name, Certification_Id__c, Id, Applicant__c
                                  FROM Certifications__r)
                                 FROM Applicant__c WHERE Id IN :applicantIds])
        {
            applicantsById.put(each.Id, each);
        }
        
        // Iterate through applicant Ids
        for(Id appId : applicantsById.keySet())
        {
            // Send our request
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setMethod('GET');
            request.setEndpoint(DUMMY_APPLICANT_ENDPOINT);
            HttpResponse response = http.send(request);
            
            // If response is good
            if(response.getStatusCode() == 200) 
            {
                // Deserialize JSON response
                List<CertDetails> certs = (List<CertDetails>)JSON.deserialize(
                    response.getBody().replace('"_id":', '"id_x":'),
                    List<CertDetails>.class
                );
                // Pick random subset from callout's returned certs
                Set<CertDetails> certsFound = CertValueResponseFaker.pickApplicantCerts(certs, MIN_NUM_CERTS, MAX_NUM_CERTS);
                
                // Get applicant's certs that will be added/removed
                Map<String, List<Object>> comparisonResult = compareCerts(certsFound, applicantsById.get(appId));
                // Add them to the master lists
                certsToAdd.addall( (List<Certification__c>)comparisonResult.get('add') );
                certsToDelete.addall( (List<Id>)comparisonResult.get('delete') );
            }
        }
        // Update DB & pray
        Database.delete(certsToDelete);
        insert certsToAdd;
    }
    
    /**
* Compares an applicant's existing certs with the certs returned by the callout
* 
* RETURN two lists wrapped in a map: 
* applicantCertsToAdd | type=Certification__c | key='add'
* applicantCertsToDelete | type=Id | key='delete'
* 
* PARAMETERS
* certsFound - Set of CertDetails returned by the callout
* applicant - applicant we made the callout for
*/ 
    @testVisible
    private static Map<String, List<Object>> compareCerts(Set<CertDetails> certsFound, Applicant__c applicant)
    {
        // Declarations
        Map<String, List<Object>> result = new Map<String, List<Object>>();
        List<Id> applicantCertsToDelete = new List<Id>();
        List<Certification__c> applicantCertsToAdd = new List<Certification__c>();
        
        // Map Applicant's existing Cert's Ids by their external Id
        Map<String, Id> appCertIdsByExternalId = new Map<String, Id>();
        for(Certification__c eachCert : applicant.Certifications__r)
        {
            appCertIdsByExternalId.put(eachCert.Certification_Id__c, eachCert.Id);
        }
        
        // Iterate through callout's returned Certs
        for(CertDetails eachCert : certsFound)
        {
            // Find Cert Id if Applicant already has it
            Id appCertId = appCertIdsByExternalId.get(eachCert.id_x);
            
            // If applicant didn't have this cert, add it
            if(appCertId == NULL)
            {
                applicantCertsToAdd.add(new Certification__c(
                    Applicant__c = applicant.Id,
                    Certification_Id__c = eachCert.id_x,
                    Name='Whats my name??'
                ));
            }
            
            // Remove that cert from the map; we are done with it
            appCertIdsByExternalId.remove(eachCert.id_x);
        }
        
        // Any certs left in appCertIdsByExternalId were NOT returned by the Cert Authority; remove them from the applicant
        for(Id certId : appCertIdsByExternalId.values())
        {
            applicantCertsToDelete.add(certId);
        }
        
        // Wrap results and return
        result.put('add', applicantCertsToAdd);
        result.put('delete', applicantCertsToDelete);
        return result;
    }
}