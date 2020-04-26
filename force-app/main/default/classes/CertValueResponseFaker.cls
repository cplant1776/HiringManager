public class CertValueResponseFaker {
    
    /**
     * Returns a randomized subset of ids from the passed CertDetails list
     * certList - full list of CertDetails to pick from
     * minNum - smallest number of certs that will be returned
     * maxNum - largest number of certs that will be returned
     */
    public static Set<CertDetails> pickApplicantCerts(List<CertDetails> certList, Integer minNum, Integer maxNum)
    {
        // Declarations
        Set<CertDetails> result = new Set<CertDetails>();
        
        // Get number of certs to return
        Integer numOfCertsToPull = generateNumOfCerts(minNum, maxNum);
        
        // Get random indices to pull out
        Set<Integer> indices = generateCertIndices(certList.size(), numOfCertsToPull);
        
        // Pull out CertDetails
        for(Integer index : indices)
        {
            result.add(certList[index]);
        }
        
        return result;
    }
    
    /**
     * Returns random integer lower than range
     */
    public static Integer generateRandomInteger(Integer range)
    {
        Double result = -1;
        while (result <= 0)
        {
            result = math.random() * (range);
        }
		return result.intValue();
    }
    
    /**
     * Returns number of certs we will generate, between minNum and maxNum
     */ 
    @testVisible
    private static Integer generateNumOfCerts(Integer minNum, Integer maxNum)
    {
        Integer result = -1;
        while(result < minNum || result > maxNum)
        {
            result = generateRandomInteger(maxNum+1);
        }
        return result;
    }
    
    @testVisible
    private static Set<Integer> generateCertIndices(Integer certListSize, Integer numOfCertsToPull)
    {
        Set<Integer> result = new Set<Integer>();
        while(result.size() < numOfCertsToPull)
        {
            result.add(generateRandomInteger(certListSize));
        }
        return result;
    }
}