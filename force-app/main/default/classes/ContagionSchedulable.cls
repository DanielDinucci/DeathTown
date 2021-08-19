global class ContagionSchedulable implements Schedulable 
{
    global void execute(SchedulableContext SC) 
    {
        this.contagiar(); 
    }
    
    private void contagiar(){
        List<Creature__c> humanList = [SELECT id, RecordTypeId, Bunker__r.Protection_Level__c, Bunker__c , 
                                       (SELECT id , DefenseUpgrade__c FROM CreatureResources__r) 
                                       FROM Creature__c WHERE recordtypeId = '0125e000000AfmUAAS'];
        
        List<Creature__c> zombieList = [SELECT id FROM Creature__c WHERE recordtypeId = '0125e000000AfmoAAC'];
        
        for(Creature__c zb : zombieList){
            if(humanList.size() == 0) break;
            Creature__c hmn1 = humanList.get(Math.mod(Integer.valueOf(Math.random()*1000), humanList.size()));
            Decimal defense = 0;
            if(hmn1.recordtypeId != '0125e000000AfmoAAC'){
               
                if(hmn1.bunker__c != null){
                    defense += hmn1.Bunker__r.Protection_Level__c;
                }
                if(hmn1.CreatureResources__r != null){
                    for(Creature_Resource__c creatR : hmn1.CreatureResources__r){
                        defense += creatR.DefenseUpgrade__c;
                    }
                }
            }
            Integer diceRoll = Math.mod(Integer.valueOf(Math.random()*100000), 100)+1;
           
            if(diceRoll > defense){

                hmn1.recordtypeId = '0125e000000AfmoAAC';
                hmn1.TransformationDate__c = Date.today();
            }

            defense = 0;

            Creature__c hmn2 = humanList.get(Math.mod(Integer.valueOf(Math.random()*1000), humanList.size()));
             if(hmn2.recordtypeId != '0125e000000AfmoAAC'){
                
                if(hmn2.Bunker__c != null){
                    defense += hmn2.Bunker__r.Protection_Level__c;
                }
                if(hmn2.CreatureResources__r != null){
                    for(Creature_Resource__c creatR : hmn2.CreatureResources__r){
                        defense += creatR.DefenseUpgrade__c;
                    }
                }
            }
            if(diceRoll > defense){

                hmn2.recordtypeId = '0125e000000AfmoAAC';
                hmn2.TransformationDate__c = Date.today();
            }
        }
        update humanList;
    }
}