@isTest
public class MaintenancePartClassTest {
    @isTest
    static  void createTestData(){
        List<Part_Inventory__c> ptList=new List<Part_Inventory__c>();
        List<Part_Inventory__c> ptList2=new List<Part_Inventory__c>();
        List<Maintenance_Part__c> mtList=new List<Maintenance_Part__c>();
        
        Account testAccount = new Account();
        testAccount.Name = 'TestAccount';
        insert testAccount;
        
        Contact testContact = new Contact();
        testContact.Salutation = 'Mr.';
        testContact.LastName = 'TestLastName';
        testContact.AccountId = testAccount.Id;
        insert testContact;
        
        Vehicle__c testVehicle = new Vehicle__c();
        testVehicle.Color__c = 'Black';
        testVehicle.Model__c = 'R8';
        testVehicle.Make__c = 'Audi';
        testVehicle.Contact__c = testContact.Id;
        insert testVehicle;
        
        Maintenance_Request__c mainReq = new Maintenance_Request__c();
        mainReq.Vehicle__c = testVehicle.Id;
        mainReq.Last_Service_Date__c = System.Today()-260;
        mainReq.Odometer_Reading__c = 12000;
        insert mainReq;
        
        Part_Inventory__c partInven2 = new Part_Inventory__c();
        partInven2.Quantity_is_Stock__c = 4;
        insert partInven2;
        ptList.add(partInven2);
        
        Part_Inventory__c partInven = new Part_Inventory__c();
        partInven.Quantity_is_Stock__c = 2;
        partInven.Name = 'BrakeParts';    
        partInven.Parent_Inventory__c = partInven2.Id;
        insert partInven;
        ptList.add(partInven);
        
        Maintenance_Part__c part1= new Maintenance_Part__c();
        part1.Maintenance_Request__c =  mainReq.Id;
        part1.Quantity_Utilized__c = 4;
        part1.Part_Inventory__c = partInven.Id;
        insert part1;
        mtList.add(part1);
        
        Maintenance_Part__c part2= new Maintenance_Part__c();
        part2.Maintenance_Request__c =  mainReq.Id;
        part2.Quantity_Utilized__c = 2;
        part2.Part_Inventory__c = partInven.Id;
        insert part2;
        mtList.add(part2);
        
        Maintenance_Part__c part3= new Maintenance_Part__c();
        part3.Maintenance_Request__c =  mainReq.Id;
        part3.Quantity_Utilized__c = 7;
        part3.Part_Inventory__c = partInven.Id;
        insert part3;
        mtList.add(part3);
        
        MaintenancePartClass.increaseqty(mtList);
        MaintenancePartClass.decreaseQty(mtList);
        
        partInven2.Quantity_is_Stock__c = 20;
        update partInven2;
        ptList2.add(partInven2);
        system.assertEquals(true, MaintenancePartClass.qtyCheck(ptList2));
        
        
    }
}