public class ContactTrigger_Helper {
    public static void isBeforeInsert(List<Contact> cons)
    {
        System.debug('Inside method for working with before insert records');
        for(Contact con : cons)
            
        {
            if(con.MailingState != null)
            {
                con.MailingState = con.MailingState.toUpperCase();
            }
            if(con.MailingCity != null)
            {
                con.MailingCity = con.MailingCity.Capitalize();
            }
        }
    }
}