trigger AccountTrigger on Account (before insert, after insert) {
    if (trigger.isBefore && trigger.isInsert) {
        system.debug('inside account trigger before insert');
        AccountTrigger_Helper.beforeInsert(trigger.new);   
    } else if (trigger.isAfter && trigger.isInsert) {
        AccountTrigger_Helper.afterInsert(trigger.new);
        system.debug('inside account trigger after insert');
    } 
}