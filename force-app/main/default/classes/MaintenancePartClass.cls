public class MaintenancePartClass {
    public static void increaseQty(List<Maintenance_Part__c> maintenancepartnList)
    {
        Integer qtyMaintenancepart=0;
        List<String> partinvList = new List<String>();
        Set<Id> mnidList = new Set<Id>();
        List<Part_Inventory__c> ptList=new List<Part_Inventory__c>();
        List<Part_Inventory__c> ptupdateList=new List<Part_Inventory__c>();
        
        for(Maintenance_Part__c MnPart : maintenancepartnList){
            partinvList.add(MnPart.Part_Inventory__c);
            mnidList.add(MnPart.Id);
        }
        ptList = [Select Id,Name,Part_Number__c,Quantity_is_Stock__c,
                  (select id,Name,Maintenance_Request__c,Part_Inventory__c,Quantity_Utilized__c from Maintenance_Parts__r)from Part_Inventory__c where Id IN:partinvList];
        for(Part_Inventory__c ptRec:ptList){
            for(Maintenance_Part__c MnPart : ptRec.Maintenance_Parts__r){
                if(mnidList.contains(MnPart.Id)){
                    qtyMaintenancepart =  qtyMaintenancepart + Integer.valueOf(MnPart.Quantity_Utilized__c);
                }    
            }
          ptRec.Quantity_is_Stock__c =  ptRec.Quantity_is_Stock__c - qtyMaintenancepart;
          ptupdateList.add(ptRec);  
        }  
        if(ptupdateList.size()>0){
            update ptupdateList;
        }  
    }
    public static void decreaseQty(List<Maintenance_Part__c> maintenancepartdList)
    {
        Integer qtyMaintenancepart=0;
        List<String> partinvList = new List<String>();
        Set<Id> mnidList = new Set<Id>();
        List<Part_Inventory__c> ptList=new List<Part_Inventory__c>();
        List<Part_Inventory__c> ptupdateList=new List<Part_Inventory__c>();
        
        for(Maintenance_Part__c MnPart : maintenancepartdList){
            partinvList.add(MnPart.Part_Inventory__c);
            mnidList.add(MnPart.Id);
        }
        system.debug('hit1'+ mnidList);
        ptList = [Select Id,Name,Part_Number__c,Quantity_is_Stock__c,
                  (select id,Name,Maintenance_Request__c,Part_Inventory__c,Quantity_Utilized__c from Maintenance_Parts__r)from Part_Inventory__c where Id IN:partinvList];
        for(Part_Inventory__c ptRec:ptList){
             system.debug('hit2');
            for(Maintenance_Part__c MnPart : ptRec.Maintenance_Parts__r){
                system.debug('hit3'+mnidList.contains(MnPart.Id));
                if(mnidList.contains(MnPart.Id)){
                   // system.debug('hit3'+mnidList.contains(MnPart.Id));
                    qtyMaintenancepart =  qtyMaintenancepart + Integer.valueOf(MnPart.Quantity_Utilized__c);
                    system.debug('qtyvaue'+qtyMaintenancepart);
                }    
            }
          ptRec.Quantity_is_Stock__c =  ptRec.Quantity_is_Stock__c + qtyMaintenancepart;
          ptupdateList.add(ptRec);  
        }  
        if(ptupdateList.size()>0){
            update ptupdateList;
        }  
    }
    public static Boolean qtyCheck(List<Part_Inventory__c> partinvenList)
    {
      	Boolean qtyMaintenancepart = true;
        List<Part_Inventory__c> ptList=new List<Part_Inventory__c>();
        List<Part_Inventory__c> ptupdateList=new List<Part_Inventory__c>();
        
        ptList = [Select Id,Name,Part_Number__c,Quantity_is_Stock__c,Min_Qty_Value_of_Child_Parts__c from Part_Inventory__c where Id IN:partinvenList];
         for(Part_Inventory__c ptRec : ptList){
             if(ptRec.Quantity_is_Stock__c > ptRec.Min_Qty_Value_of_Child_Parts__c){
                 qtyMaintenancepart = false;
             }
         }
        return qtyMaintenancepart;           
    }
}