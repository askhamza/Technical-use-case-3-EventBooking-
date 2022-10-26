@isTest
public with sharing class CaseTriggerHandlerTest {

    public static String webOrigin = 'Web' ;
    public static String phoneOrigin = 'Phone' ;

    @TestSetup
    static void setup(){

        //Web Case with 1 attendee
        List<Account> accountRelatedToWebCase = TestDataFactory.createAccounts(1);
        Database.insert(accountRelatedToWebCase, false);

        List<Contact> contactsRelatedToWebAccount = TestDataFactory.createContactsInAccount(1,accountRelatedToWebCase[0].Id);
        Database.insert(contactsRelatedToWebAccount, false);

        List<Case> webCases = TestDataFactory.createCases(2,accountRelatedToWebCase[0].Id , webOrigin);
        Database.insert(webCases, false);

         //Phone Case with 3 attendees
        List<Account> accountRelatedToPhoneCase = TestDataFactory.createAccounts(1);
        Database.insert(accountRelatedToPhoneCase, false);

        List<Contact> contactsRelatedToPhoneAccount = TestDataFactory.createContactsInAccount(3,accountRelatedToPhoneCase[0].Id);
        Database.insert(contactsRelatedToPhoneAccount, false);

        List<Case> phoneCases = TestDataFactory.createCases(1,accountRelatedToPhoneCase[0].Id , phoneOrigin);
        Database.insert(phoneCases, false);

        //Account without contacts 
        List<Account> account = TestDataFactory.createAccounts(1);
        Database.insert(account, false);
        List<Case> caseTest = TestDataFactory.createCases(1,account[0].Id,phoneOrigin);
        Database.insert(caseTest, false);

        //Web Case with more than 1 attendee
        List<Account> accountRelatedToWebCases = TestDataFactory.createAccounts(1);
        Database.insert(accountRelatedToWebCases, false);

        List<Contact> contactsRelatedToWebAccounts = TestDataFactory.createContactsInAccount(2,accountRelatedToWebCases[0].Id);
        Database.insert(contactsRelatedToWebAccounts, false);

        List<Case> webCase = TestDataFactory.createCases(1,accountRelatedToWebCases[0].Id , webOrigin);
        Database.insert(webCase, false);

        //Phone Case with more than 3 attendees
        List<Account> accountRelatedToPhoneCases = TestDataFactory.createAccounts(1);
        Database.insert(accountRelatedToPhoneCases, false);

        List<Contact> contactsRelatedToPhoneAccounts = TestDataFactory.createContactsInAccount(4,accountRelatedToPhoneCases[0].Id);
        Database.insert(contactsRelatedToPhoneAccounts, false);

        List<Case> phoneCase = TestDataFactory.createCases(1,accountRelatedToPhoneCases[0].Id , phoneOrigin);
        Database.insert(phoneCase, false);


    }

    @isTest
    public static void confirmReservationTest(){
        Test.startTest();
        List<Case> cases = [SELECT Id, AccountId,Origin,Status FROM Case];
        List<Case> newCases = new List<Case>();
        for(Case oldCase : cases){
            Case newCase = new Case(Id = oldCase.Id,Status = 'Closed', AccountId = oldCase.AccountId);
            newCases.add(newCase);
        }
        Test.setMock(HttpCalloutMock.class, new ExternalSystemServiceMock()); 
        CaseTriggerHandler.confirmReservation(newCases,cases);
        List<Task> tasks = [SELECT Id FROM Task];
        System.debug('le nombre des task est : ' + tasks.size());
        Test.stopTest();
    }

}
