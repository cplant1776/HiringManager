trigger TaskTesterTrigger on Task (before insert) {
    List<task> followuptasks = new list<task>();
    for(Task theTask : Trigger.New)
    {
                Task newTask = new Task(status = 'New',priority = 'Normal');
        newTask.subject = 'follow-up for ' + theTask.subject;
        newTask.activityDate = Date.today().adddays(30);
        followupTasks.add(newTask);
    }
    
    Insert followupTasks;
    
}