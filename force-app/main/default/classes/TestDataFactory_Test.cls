@isTest
public with sharing class TestDataFactory_Test {

    @TestSetup
    static void setup(){
        List<Account> accounts = TestDataFactory.createAccounts(1);
        Database.insert(accounts, false);
    }

    @isTest
	static void createAccountsTest(){
		Test.startTest();
		List<Account> accounts = TestDataFactory.createAccounts(2);
		Test.stopTest();
		System.assertNotEquals(null,accounts,'List of Accounts is expected to not be null');
        System.assertEquals(accounts.size(), 2, 'Error : size expected is 2 and actual size is :'+accounts.size() );

	}

    @isTest
	static void createContactsTest(){
		Test.startTest();
		List<Contact> contacts = TestDataFactory.createContacts(2);
		Test.stopTest();
		System.assertNotEquals(null,contacts,'List of Contacts is expected to not be null');
        System.assertEquals(contacts.size(), 2, 'Error : size expected is 2 and actual size is :'+contacts.size() );
	}

    @isTest
	static void createContactsInAccountTest(){
		Test.startTest();
        Account account = [SELECT Id FROM Account LIMIT 1];
		List<Contact> contacts = TestDataFactory.createContactsInAccount(2,account.Id);
		Test.stopTest();
        System.assertEquals(contacts.size(), 2, 'Error : size expected is 2 and actual size is :'+contacts.size() );
	}

    @isTest
	static void createCasesTest(){
		Test.startTest();
        Account account = [SELECT Id FROM Account LIMIT 1];
		List<Case> cases = TestDataFactory.createCases(3,account.Id,'Phone');
		Test.stopTest();
        System.assertEquals(cases.size(), 3, 'Error : size expected is 3 and actual size is :'+cases.size() );
	}

}
