package com.taomee.seer2.app.processor.quest.handler.main.quest97
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.geom.Point;
   
   public class QuestMapHandler_97_3848 extends QuestMapHandler
   {
       
      
      private var _mouse:MouseClickHintSprite;
      
      private var _teleport:Teleport;
      
      public function QuestMapHandler_97_3848(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._teleport = AnimateElementManager.getElement(2) as Teleport;
         this.hideTeleport();
         if(!QuestManager.isAccepted(questID))
         {
            RightToolbarConter.instance.hide();
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         }
         else if(QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false)
         {
            RightToolbarConter.instance.hide();
            if(QuestManager.isStepComplete(questID,1) == false)
            {
               this.showTeleport();
            }
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         var evt:QuestEvent = param1;
         if(evt.questId == 97)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("DarkSecret/DarkSecret0"),function callBack():void
            {
               showTeleport();
            },true,true,2,true);
         }
      }
      
      private function showTeleport() : void
      {
         if(this._teleport)
         {
            SeatTipsManager.registerSeat(new Point(920,180),3848);
            this._teleport.visible = true;
         }
      }
      
      private function hideTeleport() : void
      {
         if(this._teleport)
         {
            this._teleport.visible = false;
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this._teleport)
         {
            SeatTipsManager.removeSeat(new Point(920,180),3848);
            this._teleport = null;
         }
         if(this._mouse)
         {
            this._mouse = null;
         }
         super.processMapDispose();
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         RightToolbarConter.instance.show();
      }
   }
}
