@isTest
public with sharing class AsyncExternalServiceTest {

    public static String phoneOrigin = 'Phone' ;
    
    @TestSetup
    static void setup(){
        
        List<Account> accountRelatedToPhoneCase = TestDataFactory.createAccounts(1);
        insert accountRelatedToPhoneCase ;

        List<Contact> contactsRelatedToPhoneAccount = TestDataFactory.createContactsInAccount(2,accountRelatedToPhoneCase[0].Id);
        insert contactsRelatedToPhoneAccount ;

        List<Case> phoneCases = TestDataFactory.createCases(1,accountRelatedToPhoneCase[0].Id , phoneOrigin);
        insert phoneCases ;
    }

    @isTest
    public static void executeAsyncExternalServiceTest(){
        Test.startTest();        
        List<Case> cases = [SELECT Id, AccountId FROM Case];
        System.debug('number of cases : ' + cases.size() ) ;
        Test.setMock(HttpCalloutMock.class, new ExternalSystemServiceMock()); 
        System.enqueueJob(new AsyncExternalService(cases));
        Test.stopTest();
        List<Task> tasks  = [SELECT Id FROM task] ;
        System.debug('number of tasks : ' + tasks.size() ) ;
        System.assertEquals(tasks.size(), 2, 'Error : size expected is 2 and actual size is :'+tasks.size() );

    }


}
