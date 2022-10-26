/**
 * @description      
 * @author            : Hamza ASKOUR
 * @group             : 
 * @last modified on  : 10-19-2022
 * @last modified by  : Hamza ASKOUR
**/
public with sharing class CaseTriggerHandler {
   

    /**
    * @description : check if number of attendees is valid
    * @author Hamza ASKOUR | 10-19-2022 
    * @param listCases 
    **/
    public static void checkReservation (List<Case> listCases){
        Set<Id> accountIds = new Set<Id>();
        Map<Case,Account> mapCaseAccount = new Map<Case,Account>();
        // check if the list is not empty
        if(!listCases.isEmpty()){

            for(Case reservation : listCases){
                if(reservation.AccountId != null){
                    accountIds.add(reservation.AccountId) ;
                }
            }
            System.debug('list of account ids is : ' + accountIds.size());
            if(!accountIds.isEmpty()){
                List<Account> accountList = SM_Account.getAccountsByIds(new List<Id>(accountIds));
                System.debug('accounts returned by query : ' + accountList);
                for(Case res : listCases){
                    for(Account account : accountList){
                        if(res.AccountId == account.Id ){
                            mapCaseAccount.put(res,account);
                        }
                    }
                    
                }
                System.debug('map : ' + mapCaseAccount);
            }

            if(!mapCaseAccount.isEmpty()){
                for (Case key : mapCaseAccount.keySet()) {
                    String origin = key.Origin ;
                    System.debug('origin : ' + origin) ;
                    Account acc = mapCaseAccount.get(key);
                    if(acc.Contacts.size() == 0){
                        key.addError('You cannot create a request for accounts without contacts');
                    }   else {
                        System.debug('accounts size : '+ acc.Contacts.size());
                        switch on origin  {
                            when 'Web' {
                                if(acc.Contacts.size() >= 2 ){
                                    key.addError('Web request are only allowed to have one attendee');
                                }
                            }
                            when 'Phone'{
                                if(acc.Contacts.size() >= 4 ){
                                    key.addError('Phone request are only allowed to have three attendee');
                                }
                            }
                        }    
                                    
                    }
                }
            }
            
        }
    }


    /**
    * @author Hamza ASKOUR | 10-20-2022 
    * @param newCases 
    * @param oldCases 
    **/
    public static void confirmReservation(List<Case> newCases , List<Case> oldCases){
        List<Case> closedCases = new List<Case>();
        if(!newCases.isEmpty() && !oldCases.isEmpty()){
            for(Case newCase : newCases){
                for(Case oldCase : oldCases){
                    if(newCase.Id == oldCase.Id){
                        if(newCase.Status != oldCase.Status && newCase.Status == 'Closed'){
                            System.debug('Case closed');
                            closedCases.add(newCase);
                        }
                    }
                }
            }
            AsyncExternalService service = new AsyncExternalService (closedCases);
            System.enqueueJob(service);
        }
    }
}
