@isTest
private class QuintrixUtil_TEST {
    
	@isTest
    static void doesGenerateRandomStringReturnCorrectLength()
    {
        for(Integer i = 1; i < 10; i++)
        {
            Integer randomPositiveInteger = (Math.random() * 100).intValue() + 1; // [1, 101]
            String randStr = Quintrix_Util.generateRandomString(randomPositiveInteger);
            System.assertEquals(randomPositiveInteger, randStr.length());
        }
    }
    
    @isTest
    static void doesGenerateRandomStringReturnEmptyForNegativeValues()
    {
        for(Integer i = 0; i < 10; i++)
        {
            Integer randomNegativeInteger = (Math.random() * 100 * -1).intValue() - 1; // [-100, 0]
            String randStr = Quintrix_Util.generateRandomString(randomNegativeInteger);
            System.assertEquals('', randStr);
        }
    }
}