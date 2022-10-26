trigger CaseTrigger on Case (before insert, before update) {

    if(trigger.isInsert){
        if(trigger.isBefore){
            CaseTriggerHandler.checkReservation(Trigger.new);
        }
    }

    if(trigger.isUpdate){
            CaseTriggerHandler.confirmReservation(Trigger.new, Trigger.old);
    }
}