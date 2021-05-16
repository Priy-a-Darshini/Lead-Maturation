trigger PartInventoryTrigger on Part_Inventory__c (after insert,after update) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        Boolean qtyMaintenancepart;
        qtyMaintenancepart = MaintenancePartClass.qtyCheck(Trigger.new);
        for(Part_Inventory__c pt:Trigger.new){
            if(qtyMaintenancepart == false){
                pt.addError('The Quantity in Stock should not be greater than the Min Qty Value of Child Parts');
            }
            
        }
    }  
}