/**
 * @description       : This Class contains all queries needed for Account object
 * @author            : Hamza ASKOUR
 * @group             : 
 * @last modified on  : 10-19-2022
 * @last modified by  : Hamza ASKOUR
**/

public with sharing class DM_Account {
   
    /**
    * @description : Return list of Account where acccount Id exist in list of Ids
    * @author Hamza ASKOUR | 10-19-2022 
    * @param accountIds 
    * @return List<Account> 
    **/
    public static List<Account> getAccountsByIds(List<Id> accountIds){
        return [ 
            SELECT ID, (select id from contacts) 
            FROM Account WHERE id IN : accountIds
            WITH SECURITY_ENFORCED
        ];
    }
}
