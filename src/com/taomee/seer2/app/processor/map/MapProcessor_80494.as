package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   
   public class MapProcessor_80494 extends MapProcessor
   {
      
      private static const FIGHT_LIST:Vector.<int> = Vector.<int>([1710,1711,1712]);
      
      private static const RES_LIST:Array = [[273,275,343],[254,780,511],[153,403,414],[376,522,381],[370,349,837],[54,110,533],[357,355,852],[118,295,223],[244,363,397],[256,250,178],[534,753,457],[180,238,281],[261,300,360],[391,85,137]];
      
      private static const ACT_TIME:Array = [[new Date(2016,0,29),new Date(2016,1,4,23,59,59)],[new Date(2016,1,5),new Date(2016,1,11,23,59,59)],[new Date(2016,1,12),new Date(2016,1,18,23,59,59)],[new Date(2016,1,19),new Date(2016,1,25,23,59,59)],[new Date(2016,1,26),new Date(2016,2,3,23,59,59)],[new Date(2016,2,4),new Date(2016,2,10,23,59,59)],[new Date(2016,2,11),new Date(2016,2,17,23,59,59)],[new Date(2016,2,18),new Date(2016,2,24,23,59,59)],[new Date(2016,2,25),new Date(2016,2,31,23,59,59)],[new Date(2016,3,1),new Date(2016,3,7,23,59,59)],[new Date(2016,3,8),new Date(2016,3,14,23,59,59)],[new Date(2016,3,15),new Date(2016,3,21,23,59,59)],[new Date(2016,3,22),new Date(2016,3,28,23,59,59)],[new Date(2016,3,29),new Date(2016,4,5,23,59,59)]];
       
      
      public function MapProcessor_80494(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         var _timeIndex:int = 0;
         var i:int = 0;
         var index:int = 0;
         var randomPet:SpawnedPet = null;
         if(SceneManager.prevSceneType == SceneType.ARENA && FIGHT_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
         {
            TweenNano.delayedCall(1,function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
               TweenNano.delayedCall(2,function():void
               {
                  ModuleManager.showAppModule("SimplePetParkPanel");
               });
            });
         }
         else
         {
            _timeIndex = -1;
            i = 0;
            while(i < ACT_TIME.length)
            {
               if(DateUtil.isInTime(ACT_TIME[i][0],ACT_TIME[i][1]))
               {
                  _timeIndex = i;
                  break;
               }
               i++;
            }
            if(_timeIndex == -1)
            {
               return;
            }
            index = ActsHelperUtil.getRandom(0,2);
            randomPet = new SpawnedPet(RES_LIST[_timeIndex][index],FIGHT_LIST[index],0);
            randomPet.x = 200;
            randomPet.y = 300;
            MobileManager.addMobile(randomPet,MobileType.SPAWNED_PET);
         }
      }
   }
}
