package com.taomee.seer2.app.processor.quest.handler.story.quest25
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_25_470 extends QuestMapHandler
   {
       
      
      private var _diNpc:MovieClip;
      
      public function QuestMapHandler_25_470(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id) && QuestManager.isAccepted(_quest.id) == false)
         {
            this.createAcceptNpc();
            this._diNpc.addEventListener(MouseEvent.CLICK,this.onAcceptClick);
         }
         else if(QuestManager.isAccepted(_quest.id) && QuestManager.isComplete(_quest.id) == false)
         {
            this.createInprogressNpc();
            this._diNpc.addEventListener(MouseEvent.CLICK,this.onInterimNpcClick);
         }
      }
      
      private function onAcceptClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(55,"神月老大",[[0,"哼！沙爪的财奴！居然送来了挑战书！以为洒家是谁？？"]],["挑战书？"],[function():void
         {
            NpcDialog.show(55,"神月老大",[[0,"前几天……我手下的小弟给了洒家一封密函！神爪那个混蛋，居然挑衅洒家……！"]],["到底说什么呢……"],[function():void
            {
               MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("25_0"),1,[[1,0]],function():void
               {
                  NpcDialog.show(55,"神月老大",[[0,"所以，洒家决定到约定的地点去和他好好算算！这位小哥，看你胳膊腿结实，帮洒家跑个腿！以后有什么困难，报洒家名字就是！"]],["（……）"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.ACCEPT,onAccepted);
                     QuestManager.accept(_quest.id);
                  }]);
               });
            }]);
         }]);
      }
      
      private function onAccepted(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
            this._diNpc.removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
            this.onInterimNpcClick(null);
         }
      }
      
      private function onInterimNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(55,"神月老大",[[0,"大板牙那厮还在乌黑矿坑忙活？让他告知所有族人，地月反击沙爪的时候到了！赶紧的！"]],["（唉，去乌黑矿坑找大板牙。）"],[function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,520);
         }]);
      }
      
      private function createInprogressNpc() : void
      {
         this._diNpc = _processor.resLib.getMovieClip("npc_0_1");
         this._diNpc.x = 434;
         this._diNpc.y = 413;
         _map.content.addChild(this._diNpc);
         this._diNpc.buttonMode = true;
      }
      
      private function createAcceptNpc() : void
      {
         this._diNpc = _processor.resLib.getMovieClip("npc_0_0");
         this._diNpc.x = 434;
         this._diNpc.y = 413;
         _map.content.addChild(this._diNpc);
         this._diNpc.buttonMode = true;
      }
      
      private function clearDiNpc() : void
      {
         if(this._diNpc)
         {
            this._diNpc.removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
            this._diNpc.removeEventListener(MouseEvent.CLICK,this.onInterimNpcClick);
            DisplayObjectUtil.removeFromParent(this._diNpc);
            this._diNpc = null;
         }
      }
      
      override public function processMapDispose() : void
      {
         this.clearDiNpc();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
         super.processMapDispose();
      }
   }
}
