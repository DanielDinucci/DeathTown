public with sharing class BunkerDefence {
    
    public BunkerDefence() {

        List<Bunker__c> bunkerList = [SELECT id, Name, Protection_Level__c, Bunker__c ,Capture_Cage__c, Capacity__c FROM Bunker__c];






    }
}
