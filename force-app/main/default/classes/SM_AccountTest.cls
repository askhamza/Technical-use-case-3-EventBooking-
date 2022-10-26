@isTest
public with sharing class SM_AccountTest {
   

    @TestSetup
    static void setup(){
        List<Account> accounts = TestDataFactory.createAccounts(2);
        insert accounts ;
    }

    @isTest
    public static void getAccountsByIdsTest() {
        List<Id> accountsId = new List<Id>();
        for(Account acc : [SELECT Id FROM Account]){
            accountsId.add(acc.Id) ;
        }
        Test.startTest();
        List<Account> accounts = SM_Account.getAccountsByIds(accountsId);
        Test.stopTest();
        System.assertEquals(accounts.size(), 2, 'Error : size expected is 2 and actual size is :'+accounts.size() );
    }

}
