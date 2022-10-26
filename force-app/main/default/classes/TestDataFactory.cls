/**
 * @description       : 
 * @author            : Hamza ASKOUR
 * @group             : 
 * @last modified on  : 10-20-2022
 * @last modified by  : Hamza ASKOUR
**/
public with sharing class TestDataFactory {

   
   /**
   * @description : Create account instances
   * @author Hamza ASKOUR | 10-20-2022 
   * @param numberOfAccounts 
   * @return List<Account> 
   **/
   public static List<Account> createAccounts( Integer numberOfAccounts) {
        List<Account> accounts = new List<Account>();
        for ( Integer i = 0 ; i < numberOfAccounts ; i++ ) {
            Account account = new Account( Name = 'Test Account' + Math.random()); 
            accounts.add( account);
        }
        return accounts;
    }

    /**
   * @description : Create contact instances
   * @author Hamza ASKOUR | 10-20-2022 
   * @param numberOfContacts 
   * @return List<Contact> 
   **/
    public static List<Contact> createContacts( Integer numberOfContacts) {
        List<Contact> contacts = new List<Contact>();
        for ( Integer i = 0 ; i < numberOfContacts ; i++ ) {
            Contact contact = new Contact(
                FirstName = 'Test Contact'+ Math.random(),
                LastName = 'Contact '+ Math.random() + '' + i,
                Email = 'noreplay'+i+'@test.com',
                Phone = '(212) 645-490960');
                contacts.add(contact);
        }
        return contacts;
    }

   
    /**
    * @description : Create contact instances related to account 
    * @author Hamza ASKOUR | 10-20-2022 
    * @param numberOfContacts 
    * @param accountId 
    * @return List<Contact> 
    **/
    public static List<Contact> createContactsInAccount( Integer numberOfContacts, Id accountId) {
        List<Contact> contacts = new List<Contact>();
        for ( Integer i = 0 ; i < numberOfContacts ; i++ ) {
            Contact contact = new Contact(
                FirstName = 'Test Contact '+ Math.random() + '' + i,
                LastName = 'Contact '+ Math.random() + '' + i,
                Email = 'noreplay'+ Math.random() +''+i+'@test.com',
                Phone = '(212) 645-490960',
                accountId = accountId );
                contacts.add(contact);
        }
        return contacts;
    }
    
    /**
    * @description 
    * @author Hamza ASKOUR | 10-20-2022 
    * @param numberOfCases 
    * @param accountId 
    * @return List<Case> 
    **/
    public static List<Case> createCases( Integer numberOfCases, Id accountId, String origin) {
        List<Case> cases = new List<Case>();
        for ( Integer i = 0 ; i < numberOfCases ; i++ ) {
            Case caseInstance = new Case(
                Origin = origin,
                Status = 'New',
                AccountId = accountId 
               );
            cases.add(caseInstance);
        }
        return cases;
    }

    
}
