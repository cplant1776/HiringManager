@isTest
private class HiringManagerObjectExists_TEST {
    
    @isTest
    private static void shouldCheckApplicantFieldsExist() {
        //Use the SObjectType type to get the Schema for Applicant obj
        SObjectType applicantSchema = Schema.getGlobalDescribe().get('Applicant__c');
        Map<String,Schema.SObjectField> applicantFieldsByAPIName = applicantSchema.getDescribe().fields.getMap();
        
        //Check to make sure that each field is named correctly
        System.assertEquals(true, applicantFieldsByAPIName.containsKey('Email__c'));
        System.assertEquals(true, applicantFieldsByAPIName.containsKey('Decline_Reason__c'));
        System.assertEquals(true, applicantFieldsByAPIName.containsKey('First_Name__c'));
        System.assertEquals(true, applicantFieldsByAPIName.containsKey('Last_Name__c'));
        System.assertEquals(true, applicantFieldsByAPIName.containsKey('Mailing_Address__c'));
        System.assertEquals(true, applicantFieldsByAPIName.containsKey('Mailing_State__c'));
        System.assertEquals(true, applicantFieldsByAPIName.containsKey('Mailing_City__c'));
        System.assertEquals(true, applicantFieldsByAPIName.containsKey('Mailing_Zip__c'));
        System.assertEquals(true, applicantFieldsByAPIName.containsKey('Status__c'));
        
        
        //Itirate through the Status Picklist, add to a List for later processing
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Applicant__c.Status__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple) {
            options.add(f.getLabel());
        }
        
        //Check for -->
        //Applicant, Interview, Hired, Declined
        System.assertEquals(true, options.contains('Applicant'));
        System.assertEquals(true, options.contains('Declined'));
        System.assertEquals(true, options.contains('Hired'));
        System.assertEquals(true, options.contains('Interview'));
    }
    
    @isTest
    private static void shouldCheckPositionFieldsExist() {
        
        //Use the SObjectType type to get the Schema for Position obj
        SObjectType positionSchema = Schema.getGlobalDescribe().get('Position__c');
        Map<String,Schema.SObjectField> positionFieldsByAPIName = positionSchema.getDescribe().fields.getMap();
        
        //Check to make sure that each field is named correctly
        System.assertEquals(true, positionFieldsByAPIName.containsKey('Available__c'));
        System.assertEquals(true, positionFieldsByAPIName.containsKey('Inactive__c'));
        System.assertEquals(true, positionFieldsByAPIName.containsKey('Job_Description__c'));
        System.assertEquals(true, positionFieldsByAPIName.containsKey('Job_Type__c'));
        System.assertEquals(true, positionFieldsByAPIName.containsKey('Location__c'));
        System.assertEquals(true, positionFieldsByAPIName.containsKey('Max_Salary__c'));
        System.assertEquals(true, positionFieldsByAPIName.containsKey('Min_Salary__c'));
        System.assertEquals(true, positionFieldsByAPIName.containsKey('Salary_Type__c'));
        System.assertEquals(true, positionFieldsByAPIName.containsKey('Title__c'));
        
        //Itirate through the Job Type Picklist, add to a List for later processing
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult2 = Position__c.Job_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple2 = fieldResult2.getPicklistValues();
        for( Schema.PicklistEntry f : ple2) {
            options.add(f.getLabel());
        }
        
        //Check for -->
        //Permanent, Contract, Vendor, Part-Time
        System.assertEquals(true, options.contains('Permanent'));
        System.assertEquals(true, options.contains('Contract'));
        System.assertEquals(true, options.contains('Vendor'));
        System.assertEquals(true, options.contains('Part-Time'));
        
        //Itirate through the Salary Type Picklist, add to a List for later processing
        List<String> salaryOptions = new List<String>();
        Schema.DescribeFieldResult fieldResult3 = Position__c.Salary_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple3 = fieldResult3.getPicklistValues();
        for( Schema.PicklistEntry f : ple3) {
            salaryOptions.add(f.getLabel());
        }
        
        //Check for -->
        //Yearly, Hourly
        System.assertEquals(true, salaryOptions.contains('Yearly'));
        System.assertEquals(true, salaryOptions.contains('Hourly'));
    }
    
    @isTest
    private static void shouldCheckInterviewFieldsExist() {
        
        //Use the SObjectType type to get the Schema for Interview obj
        SObjectType interviewSchema = Schema.getGlobalDescribe().get('Interview__c');
        Map<String,Schema.SObjectField> interviewFieldsByAPIName = interviewSchema.getDescribe().fields.getMap();
        
        //Check to make sure that each field is named correctly
        System.assertEquals(true, interviewFieldsByAPIName.containsKey('Applicant__c'));
        System.assertEquals(true, interviewFieldsByAPIName.containsKey('Applicant_Full_Name__c'));
        System.assertEquals(true, interviewFieldsByAPIName.containsKey('Interview_Date__c'));
        System.assertEquals(true, interviewFieldsByAPIName.containsKey('Interview_Type__c'));
        System.assertEquals(true, interviewFieldsByAPIName.containsKey('Location__c'));
        System.assertEquals(true, interviewFieldsByAPIName.containsKey('Position__c'));
        System.assertEquals(true, interviewFieldsByAPIName.containsKey('Position_Title__c'));
        System.assertEquals(true, interviewFieldsByAPIName.containsKey('Recommendation_Reason__c'));
        System.assertEquals(true, interviewFieldsByAPIName.containsKey('Recommended__c'));
        
        //Itirate through the Recommended Picklist, add to a List for later processing
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult2 = Interview__c.Recommended__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult2.getPicklistValues();
        for( Schema.PicklistEntry f : ple) {
            options.add(f.getLabel());
        }
        
        //Check for -->
        //Yes, No
        System.assertEquals(true, options.contains('Yes'));
        System.assertEquals(true, options.contains('No'));
    }
}