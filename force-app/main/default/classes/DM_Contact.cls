/**
 * @description       : This Class contains all queries needed for Contact object
 * @author            : Hamza ASKOUR
 * @group             : 
 * @last modified on  : 10-19-2022
 * @last modified by  : Hamza ASKOUR
**/
public with sharing class DM_Contact {
    
    /**
    * @description : Return list of Contacts where acccountId field exist in list of Ids
    * @author Hamza ASKOUR | 10-19-2022 
    * @param accountIds 
    * @return List<Contact> 
    **/
    public static List<Contact> getContactsByAccountIds(List<Id> accountIds){
        return [ 
            SELECT  Id, Name, Email, AccountId 
            FROM  Contact 
            WHERE AccountId IN :accountIds  
            WITH SECURITY_ENFORCED
            ] ;
    }
}
