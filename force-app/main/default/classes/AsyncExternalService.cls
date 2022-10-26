/**
 * @description      
 * @author            : Hamza ASKOUR
 * @group             : 
 * @last modified on  : 10-20-2022
 * @last modified by  : Hamza ASKOUR
**/
public with sharing class AsyncExternalService implements Queueable, Database.AllowsCallouts {

    private List<Case> closedCases ;  

    public AsyncExternalService(List<Case> cases){
    	this.closedCases = cases ;
    }

    public void execute(QueueableContext context) {
       System.debug('[ AsyncExternalService : Execute ] ####### START #######');
       System.debug('list of cases : '+ this.closedCases);  
       ExternalSystemService.registerAttendees(this.closedCases);
       System.debug('[ AsyncExternalService : Execute ] ####### END #######');
    }  

}
