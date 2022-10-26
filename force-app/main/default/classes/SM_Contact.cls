/**
 * @description       : Service layer for Contact Object
 * @author            : Hamza ASKOUR
 * @group             : 
 * @last modified on  : 10-19-2022
 * @last modified by  : Hamza ASKOUR
**/
public with sharing class SM_Contact {

    /**
    * @description : Return list of Contacts where account Id field exist in list of Ids
    * @author Hamza ASKOUR | 10-19-2022 
    * @param accountIds 
    * @return List<Contact> 
    **/
    public static List<Contact> getContactsByAccountIds(List<Id> accountIds){
        return DM_Contact.getContactsByAccountIds(accountIds);
    }
}
