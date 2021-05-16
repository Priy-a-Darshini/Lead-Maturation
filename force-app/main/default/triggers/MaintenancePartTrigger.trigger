trigger MaintenancePartTrigger on Maintenance_Part__c (after insert,after update,after delete) {
    if(Trigger.isDelete && Trigger.isAfter){
        MaintenancePartClass.decreaseQty(Trigger.old);
    }
    else if(Trigger.isInsert && Trigger.isAfter){
        MaintenancePartClass.increaseQty(Trigger.new);
    }    
}