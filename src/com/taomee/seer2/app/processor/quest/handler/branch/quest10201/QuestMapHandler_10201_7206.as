package com.taomee.seer2.app.processor.quest.handler.branch.quest10201
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10201_7206 extends QuestMapHandler
   {
      
      private static const FIGHT_LIST:Array = [532,533,534,535,536];
      
      private static const LIMIT_ID:int = 203002;
       
      
      private var npc:Mobile;
      
      private var currentIndex:int = -1;
      
      public function QuestMapHandler_10201_7206(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         var _loc1_:int = 0;
         if(QuestManager.isStepComplete(10201,3) == false)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
         }
         if(QuestManager.isStepComplete(10201,3) == true && QuestManager.isStepComplete(10201,4) == false)
         {
            this.onStep();
            return;
         }
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            _loc1_ = int(FightManager.currentFightRecord.initData.positionIndex);
            if(FIGHT_LIST.indexOf(_loc1_) != -1 && FightManager.fightWinnerSide == FightSide.LEFT && _loc1_ != FIGHT_LIST[4])
            {
            }
         }
         ActiveCountManager.requestActiveCount(LIMIT_ID,this.getData);
      }
      
      private function getData(param1:uint, param2:uint) : void
      {
         var type:uint = param1;
         var count:uint = param2;
         if(type == LIMIT_ID)
         {
            if(count >= 5)
            {
               if(QuestManager.isStepComplete(10201,3) == false)
               {
                  AlertManager.showAlert("真厉害，你已经收集齐全部的碎片咯！",function():void
                  {
                     QuestManager.completeStep(10201,3);
                  });
               }
            }
            else
            {
               this.currentIndex = count;
               this.createNpc();
            }
         }
      }
      
      private function onStep(param1:QuestEvent = null) : void
      {
         var e:QuestEvent = param1;
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10201_2"),function():void
         {
            QuestManager.completeStep(10201,4);
         });
      }
      
      private function createNpc() : void
      {
         if(this.npc == null)
         {
            this.npc = new Mobile();
            this.npc.resourceUrl = URLUtil.getNpcSwf(335);
            this.npc.x = 190;
            this.npc.y = 345;
            this.npc.buttonMode = true;
            MobileManager.addMobile(this.npc,MobileType.NPC);
            this.npc.addEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(FIGHT_LIST[this.currentIndex])
         {
            FightManager.startFightWithWild(FIGHT_LIST[this.currentIndex]);
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this.npc)
         {
            this.npc.removeEventListener(MouseEvent.CLICK,this.onClick);
            MobileManager.removeMobile(this.npc,MobileType.NPC);
            this.npc = null;
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep);
      }
   }
}
