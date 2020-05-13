@isTest
public class CertValueResponseFaker_TEST {

    private static Integer MIN_NUM_CERTS = 2;
    private static Integer MAX_NUM_CERTS = 6;
    private static Integer CERTS_FOUND_SIZE = 20;
    
    @isTest
    private static void doesGenerateNumOfCertsReturnProperRange()
    {
        // Bools to ensure range is inclusive
        Boolean maxNumWasReturned = False;
        Boolean minNumWasReturned = False;
        
        for(Integer i=0; i < 100; i++)
        {
            Integer randInt = CertValueResponseFaker.generateNumOfCerts(MIN_NUM_CERTS, MAX_NUM_CERTS);
            System.assert(randInt >= MIN_NUM_CERTS && randInt <= MAX_NUM_CERTS);
            
            if(randInt == MIN_NUM_CERTS)
                minNumWasReturned = True;
            if(randInt == MAX_NUM_CERTS)
                maxNumWasReturned = True;
        }
        
        System.assert(minNumWasReturned && maxNumWasReturned);
    }
    
    @isTest
    private static void doesGenerateCertIndicesReturnProperRange()
    {
        Set<Integer> indices = CertValueResponseFaker.generateCertIndices(CERTS_FOUND_SIZE, CERTS_FOUND_SIZE);
                
        // Ensure result contains all indices: [0-(CERTS_FOUND_SIZE-1)]
        for(Integer i=0; i < CERTS_FOUND_SIZE; i++)
        {
            System.assert(indices.Contains(i));
            indices.remove(i);
        }
        
        // Ensure no indices outside of range
        System.assertEquals(0, indices.size());
    }
}