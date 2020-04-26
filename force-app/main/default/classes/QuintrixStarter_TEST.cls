@isTest
private class QuintrixStarter_TEST {

    @isTest
    static void DoesIsItNegativeReturnTrueForNegativeNumber()
    {
        List<Boolean> actuals = new List<Boolean>();
        
        // Run for 100 random negative integers in range [-1001, -1]
        for(Integer i=0; i < 100; i++)
        {
            Integer randomNegativeInteger = (Math.random() * 1000 * -1).intValue() - 1;
            actuals.add(QuintrixStarter.isItNegative(randomNegativeInteger));
        }
        
        // Ensure all results are true
        for(Boolean actual : actuals)
        {
            System.assertEquals(true, actual);
        }
    }
    
    @isTest
    static void DoesIsItNegativeReturnFalseForPositiveNumber()
    {
        List<Boolean> actuals = new List<Boolean>();
        
        // Run for 100 random positive integers in range [1, 1001]
        for(Integer i=0; i < 100; i++)
        {
            Integer randomPositiveInteger = (Math.random() * 1000).intValue() + 1;
            actuals.add(QuintrixStarter.isItNegative(randomPositiveInteger));
        }
        
        // Ensure all results are false
        for(Boolean actual : actuals)
        {
            System.assertEquals(false, actual);
        }
    }
    
}