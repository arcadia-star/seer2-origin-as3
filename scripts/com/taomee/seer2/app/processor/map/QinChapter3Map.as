package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QinChapter3Map extends CopyMapProcessor
   {
       
      
      private var currentIndex:int;
      
      private const mapsID:Array = [5708,5709,5710,5711];
      
      private const monsterID:uint = 40;
      
      private const fightID:uint = 402;
      
      private const limitID:int = 202224;
      
      private var _countArray:Array;
      
      private var npc:Mobile;
      
      public function QinChapter3Map(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.currentIndex = this.mapsID.indexOf(_map.id);
         ActiveCountManager.requestActiveCount(this.limitID,this.getCount);
      }
      
      private function readBit(param1:uint) : void
      {
         this._countArray = [];
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            this._countArray.push(param1 >>> _loc2_ & 1);
            _loc2_++;
         }
      }
      
      private function getCount(param1:uint, param2:uint) : void
      {
         var i:int = 0;
         var type:uint = param1;
         var count:uint = param2;
         if(type == this.limitID)
         {
            if(count == 15)
            {
               AlertManager.showAlert("你已经找齐所有的密码，快去输入电脑吧",function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep);
                  QuestManager.completeStep(10181,2);
               });
               return;
            }
            this.readBit(count);
            i = 0;
            while(i < 4)
            {
               if(this._countArray[i] != 1)
               {
                  this.currentIndex = i;
                  this.createMonster();
                  break;
               }
               if(_map.id == this.mapsID[i])
               {
                  if(i < 3)
                  {
                     AlertManager.showAlert("你已经取得了该层的密码，快去看看下一层吧！",function():void
                     {
                        ModuleManager.toggleModule(URLUtil.getAppModule("QinBeastPanel"),"","3");
                     });
                  }
                  break;
               }
               i++;
            }
         }
      }
      
      private function onCompleteStep(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep);
         SceneManager.changeScene(SceneType.LOBBY,5712);
      }
      
      private function createMonster() : void
      {
         this.npc = new Mobile();
         this.npc.resourceUrl = URLUtil.getNpcSwf(40);
         this.npc.buttonMode = true;
         this.npc.x = 380;
         this.npc.y = 320;
         this.npc.addEventListener(MouseEvent.CLICK,this.toFight);
         MobileManager.addMobile(this.npc,MobileType.NPC);
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(this.fightID);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep);
         if(this.npc)
         {
            this.npc.removeEventListener(MouseEvent.CLICK,this.toFight);
            this.npc = null;
         }
      }
   }
}
