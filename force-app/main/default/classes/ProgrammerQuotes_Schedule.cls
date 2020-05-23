global class ProgrammerQuotes_Schedule implements Schedulable {
    
    // Run every monday at 03:00
    public static final String CRON_STRING = '0 0 3 ? * MON *';
    
    /* Example of how to use:
       
      ProgrammerQuotes_Schedule mySchedulable = new ProgrammerQuotes_Schedule();
      String jobId = System.schedule('Sync Applicant Credentials', 
      								  ProgrammerQuotes_Schedule.CRON_STRING,
									  mySchedulable);
     */
    
    global void execute(SchedulableContext context) {
        Set<Id> applicantIdsSet = new Map<Id,Applicant__c>([SELECT Name FROM Applicant__c]).keySet();
        List<Id> applicantIdsList = new List<Id>(applicantIdsSet);
        ProgrammerQuotes_RequestResponse.updateCerts(applicantIdsList);
    }
    
}