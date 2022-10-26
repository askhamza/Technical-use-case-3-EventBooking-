/**
 * @description       : 
 * @author            : Hamza ASKOUR
 * @group             : 
 * @last modified on  : 10-25-2022
 * @last modified by  : Hamza ASKOUR
**/
public with sharing class ExternalSystemService {

    public static String webServiceURL = 'https://th-apex-http-callout.herokuapp.com/animals';   

    public static void registerAttendees(List<Case> listCases){
        Set<Id> accountIds = new Set<Id>();
        List<Contact> listContacts = new List<Contact>();
        if(!listCases.isEmpty()){
            for(Case cs :listCases ){
                if(cs.AccountId != null){
                    accountIds.add(cs.AccountId);
                }
            }
        }
        if(!accountIds.isEmpty()){
            listContacts = SM_Contact.getContactsByAccountIds(new List<Id>(accountIds)) ;
            System.debug('list of contacts : ' + listContacts) ;
            if(!listContacts.isEmpty()){
                String body = '';
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                System.debug('End point : '+ webServiceURL);
                request.setEndpoint(webServiceURL);
                request.setMethod('POST');
                request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                for(Contact  contact :listContacts ){
                    if(body == ''){
                        body += '[{"name":"'+ contact.Name + '-' + contact.Email  +'"}' ;
                    }else{
                        body += ',{"name":"'+ contact.Name + '-' + contact.Email  +'"}' ;
                    }
                }
                body += ']';
                request.setBody(body);
                System.debug('Body : ' + body);
                HttpResponse response = http.send(request);
                System.debug('Response : ' + response);
                System.debug('status code  : ' + response.getStatusCode());
                // Parse the JSON response
                if (response.getStatusCode() != 201) {
                    System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
                } else {
                   // Everything went as expected.
                   System.debug('Notify AttendeeByEmail');
                   notifyAttendeeByEmail(listContacts);
                }
            }
        }   
    } 

    
    public static void notifyAttendeeByEmail(List<Contact> contactList){
      
        List<Task> tasksToInsert = new  List<Task>();
        Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{} ;
        System.debug('size of list of contact : ' + contactList.size());
        System.debug('list of contact : ' + contactList);
        for(Contact contact : contactList){
            //Create Instance task
            Task task = new Task();
            task.Subject = 'Send Email To' + contact.Name;
            task.Status = 'Open';
            task.Priority = 'Normal';
            task.WhatId = contact.AccountId;
            tasksToInsert.add(task);
            Database.SaveResult[] result = Database.insert(tasksToInsert, false);
            
            if(contact.Email != null){
                String body = 'Hello <b>' + contact.Name + ',</b> <br> We confirm your registration <br> Thank you.' ;
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{contact.Email});
                email.setSubject('Registration confirmation');
                email.setHtmlBody(body);
                emails.add(email);
            }
        }
        if(emails.size() > 0){
            //Send Email
            System.debug('number of emails : ' + emails.size() );
            Messaging.sendEmail(emails);
        }
    } 

}
