public class ProgrammerQuote_V2 {
    @InvocableMethod
    public static void updateCerts(List<ID> applicantIds) {
        Set<ID> applicantSet = new Set<ID>();
       
        for(ID applicantId : applicantIds)
        {
            applicantSet.add(applicantId);
            if(applicantSet.size() == 100)
            {
                callCertAuthority(applicantSet);
                applicantSet.clear();
            }  
        }
        if(applicantSet.size() > 0)
        {
            callCertAuthority(applicantSet);
        }
       
       
    }
   
   
    //this method can only handle 100 callouts at a time
    //a future method can be called multiple times for multiple future threads
    //however if the future method has a callout in it, it can only call outside 100 times
    @future( callout = true)
    public static void callCertAuthority(Set<ID> applicantIds) {
        Map<Id, Applicant__c> applicantsById = new Map<Id, Applicant__c>();
        List<Certification__c> certsToDelete = new List<Certification__c>();
        List<Certification__c> certsToAdd = new List<Certification__c>();
        List<Cert_Value__c> certsFromRestCall = new List<Cert_Value__c>();
        List<Cert_Value__c> possibleCertList = [SELECT Name, ID_Hash__c FROM Cert_Value__c];
        Map<String, String> certNameByID = new Map<String, String>();
       
        for(Cert_Value__c each: possibleCertList) {
            certNameById.put(each.ID_Hash__c, each.Name);
        }
       
        for (Applicant__c each: [
            SELECT ID, First_Name__c,
            (SELECT Name, Certification_ID__c, ID
             FROM Certifications__r)
            FROM Applicant__c WHERE ID IN :applicantIDs])
        {
            applicantsById.put(each.Id, each);
        }
       
        for(ID appID: applicantsByID.keySet()) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://programming-quotes-api.herokuapp.com/quotes/page/1');
            request.setMethod('GET');
            HttpResponse response = http.send(request);
           
            if(response.getStatusCode() == 200) {
                List<CertDetails> certs = (List<CertDetails>)JSON.deserialize(
                    response.getBody().replace('"_id":', '"id_x":'),
                    List<CertDetails>.class
                );
                Integer numCerts = getRandomCertNumber();
                List<CertDetails> certsFound = getRandomCerts(certs,numCerts);
                //system.debug(certsFound);
                //system.debug('num certs: ' + certsFound.size());
                //system.debug('Applicant: ' + applicantsById.get(appID).First_Name__c);
               
               
                /*****   REMOVE CERTS OPERATION ********/
                //Loop through certs found on on applicants certs Related List
                //Compare against certs found for applicant on API
                //If API does not have the cert on the applicants list then it needs to be removed
                for(Certification__c theCert: applicantsById.get(appId).Certifications__r){
                    Boolean certExists = false;
                    for(CertDetails eachCert :certsFound) {
                        if(theCert.Certification_ID__c.contains(eachCert.ID)){
                            certExists = true;
                        }  
                }
                    if(!certExists) {
                       certsToDelete.add(theCert);
                    }
                }
               
              /*****   ADD CERTS OPERATION ********/
                //Loop through certs found on the api for this applicant t
                //Compare against certs found on this applicants certification list
                //If cert in api list does not exist in applicant list
                //Add it
                for(CertDetails eachCert :certsFound) {
                    Boolean certExists = false;
                    for(Certification__c theCert: applicantsById.get(appId).Certifications__r){
                        if(eachCert.ID.contains(theCert.Certification_ID__c)) {
                            certExists = true;
                        }  
                    }
                    if(!certExists) {
                        Certification__c addCert = new Certification__c(
                        Certification_ID__c = eachCert.ID,
                            Name = certNameById.get(eachCert.ID),
                            Applicant__c = appId
                        );
                    certsToAdd.add(addCert);
                    }
                }
            }
           
        }
       
        if(certsToAdd.size() > 0) {
            insert certsToAdd;
        }
       
        if(certsToDelete.size() > 0 ) {
            delete certsToDelete;
        }
       
    }
   
    //wrapper class
    public class CertDetails {
        public string id_x;
        public string id;
        public string sr;
        public string en;
        public string author;
        public decimal rating;
    }
   
    public static Integer getRandomCertNumber(){
        Double d = math.random() * 4;
        return d.intValue() + 1;
    }
   
    public static List<CertDetails> getRandomCerts(List<CertDetails> remainingCerts, Integer numReturned)
    {
        List<CertDetails> actualCerts = new List<CertDetails>();
        for(Integer i = 0; i < numReturned; i++) {
            Integer randomNumber = Integer.valueOf(math.random() * remainingCerts.size() -1);
            actualCerts.add(remainingCerts[randomNumber]);
            remainingCerts.remove(randomNumber);
        }
        return actualCerts;  
    }
   
}