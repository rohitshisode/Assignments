public with sharing class ContactFactory {
    /**
     * Creates Account object data
     *
     * @param count   Number of records to be created
     *
     * @return accounts List of Accounts
     */
    public static List<Contact> createContacts(Integer count) {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 1; i <= count; i++) {
            Contact contact = new Contact();
            contact.LastName = 'Contact'+i;
            contact.Phone = '23366'+String.valueof(i);
            //contact.Email = 'a_'+String.valueof(i)+'@gmail.com';
            contact.Email = 'abc@espl.com';
            contacts.add(contact);
        }
        return contacts;
    }

    /**
     * Creates and insert Account records.
     *
     * @param count   Number of records to be created
     *
     * @return accounts List of Accounts
     */
     public static List<Contact> createAndInsertContacts(Integer count) {
        List<Contact> cnt = createContacts(count);
        return insertData(cnt);
    }

    /**
     * Insert Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<Contact> insertData(List<Contact> contacts) {
        insert contacts;
        return contacts;
    }

    /**
     * Update Account
     *
     * @param accounts List of Accounts
     *
     * @return accounts List of Accounts
     */
     public static List<Contact> updateData(List<Contact> contacts) {
        update contacts;
        return contacts;
    }
}