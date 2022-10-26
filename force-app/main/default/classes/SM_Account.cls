/**
 * @description       : Service layer for Account Object
 * @author            : Hamza ASKOUR
 * @group             : 
 * @last modified on  : 10-19-2022
 * @last modified by  : Hamza ASKOUR
**/
public with sharing class SM_Account {

    /**
    * @description : Return list of Contacts where Id in list of Ids
    * @author Hamza ASKOUR | 10-19-2022 
    * @param accountIds 
    * @return List<Account> 
    **/
    public static List<Account> getAccountsByIds(List<Id> accountIds){
       return DM_Account.getAccountsByIds(accountIds) ;
    }
}
