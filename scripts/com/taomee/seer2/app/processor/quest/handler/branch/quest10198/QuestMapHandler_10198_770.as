package com.taomee.seer2.app.processor.quest.handler.branch.quest10198
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10198_770 extends QuestMapHandler
   {
       
      
      private var hitTestArea:Sprite;
      
      private const LIMIT_ID:int = 202990;
      
      public function QuestMapHandler_10198_770(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(10198,1) == true && QuestManager.isStepComplete(10198,2) == false)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 517)
            {
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  this.complete();
               }
               else
               {
                  AlertManager.showAlert("线索中断，被精灵抢走，你要从头开始寻找了",function():void
                  {
                     ModuleManager.toggleModule(URLUtil.getAppModule("YiBeastPanel"),"","1");
                  });
               }
               return;
            }
            this.hitTestArea = _map.content["hitTestRect"];
            this.hitTestArea.buttonMode = true;
            ActiveCountManager.requestActiveCount(this.LIMIT_ID,this.getData);
         }
      }
      
      private function complete() : void
      {
         AlertManager.showAlert("哇，已经全部找到了。",function():void
         {
            QuestManager.completeStep(10198,2);
            NpcDialog.show(400,"小赛尔",[[1,"哎呀，经历前行万苦，终于找到这些发光物体。让我来仔细观看一下。"]],["仔细观察线索"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10198_1"),function():void
               {
                  NpcDialog.show(400,"小赛尔",[[4,"哎~不管了，先去找观察员纳格托告诉他我的发现吧！"]],["Go！Go！Go！"],[function():void
                  {
                     QuestManager.completeStep(10198,3);
                  }]);
               });
            }]);
         });
      }
      
      private function getData(param1:uint, param2:uint) : void
      {
         if(param1 == this.LIMIT_ID && param2 == 2)
         {
            this.hitTestArea.addEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:int = Math.random() * 100 < 80 ? 1 : 2;
         if(_loc2_ == 1)
         {
            FightManager.startFightWithWild(517);
         }
         else if(_loc2_ == 2)
         {
            SwapManager.swapItem(1661);
            this.complete();
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this.hitTestArea)
         {
            this.hitTestArea.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
         super.processMapDispose();
      }
   }
}
