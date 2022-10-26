@isTest
public with sharing class SM_ContactTest {
   
    @TestSetup
    static void setup(){
        List<Account> accounts = TestDataFactory.createAccounts(1);
        insert accounts ;
        List<Contact> contacts = TestDataFactory.createContactsInAccount(3,accounts[0].Id);
        insert contacts ;
        
    }

    @isTest
    public static void getAccountsByIdsTest() {
        Test.startTest();
        Account acc = [SELECT Id FROM Account LIMIT 1];
        List<Contact> contacts = SM_Contact.getContactsByAccountIds(new List<Id>{acc.Id});
        Test.stopTest();
        System.assertEquals(contacts.size(), 3, 'Error : size expected is 3 and actual size is :'+contacts.size() );
    }
}
