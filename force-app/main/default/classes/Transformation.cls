public class Transformation {
    
	@InvocableMethod(label='Turn Zombie')
    
    public static void transform(List<id> ids){
        
        List<Creature__c> creatureList = [SELECT id, Bunker__r.Name, Bunker__c, (Select id from CreatureResources__r) FROM Creature__c WHERE  id in : ids];
        List<Creature_Resource__c> rcDeleteList = new List<Creature_Resource__c>();
        
        for(Creature__c cr : creatureList){
            
         String ZombieType = '';
            
         Integer rand = Math.mod(Integer.valueOf(Math.random()*100000),100);
            
         if(cr.RecordTypeId == '0125e000000AfmoAAC' || cr.RecordTypeId == Null){

            if(rand < 60 ){
            ZombieType = 'Slow';   
        	} 
            else if( rand < 90 ){
            ZombieType = 'Fast';
            }
            else {
            ZombieType = 'Fat';
            }
            cr.Zombie_Type__c = ZombieType;
             if(cr.CreatureResources__r != null)
            rcDeleteList.addAll(cr.CreatureResources__r);  
        }
    }
    update creatureList;   
    delete rcDeleteList;  
  }
}