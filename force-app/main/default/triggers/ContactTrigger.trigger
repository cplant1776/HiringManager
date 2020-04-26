trigger ContactTrigger on Contact (before insert, after insert) {
    if (trigger.isBefore && trigger.isInsert) {
        system.debug('inside contact trigger before insert');
        ContactTrigger_Helper.isBeforeInsert(Trigger.New); 
    } else if (trigger.isAfter && trigger.isInsert) {
        system.debug('inside contact trigger after insert');
    } 
}