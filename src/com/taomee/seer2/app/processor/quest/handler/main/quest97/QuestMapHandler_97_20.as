package com.taomee.seer2.app.processor.quest.handler.main.quest97
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_97_20 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      private var _mouse:MouseClickHintSprite;
      
      private var _oldNpc:Mobile;
      
      private var _newNpc:Mobile;
      
      public function QuestMapHandler_97_20(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false)
         {
            RightToolbarConter.instance.hide();
            ActorManager.getActor().blockFollowingPet = false;
            ActorManager.getActor().blockNoNo = false;
            if(QuestManager.isStepComplete(questID,3) == false)
            {
               this.changeNpc();
            }
         }
      }
      
      private function showMouseHintAtMonster(param1:Mobile) : void
      {
         var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
         _loc2_.y = -_loc2_.height - 50;
         _loc2_.x = (param1.width - param1.width) / 2;
         param1.addChild(_loc2_);
      }
      
      private function changeNpc() : void
      {
         this._oldNpc = MobileManager.getMobile(2,MobileType.NPC);
         this._oldNpc.visible = false;
         this._newNpc = new Mobile();
         this._newNpc.width = this._oldNpc.width;
         this._newNpc.height = this._oldNpc.height;
         this._newNpc.label = this._oldNpc.label;
         this._newNpc.setPostion(new Point(this._oldNpc.x,this._oldNpc.y));
         this._newNpc.resourceUrl = this._oldNpc.resourceUrl;
         this._newNpc.buttonMode = true;
         this.showMouseHintAtMonster(this._newNpc);
         MobileManager.addMobile(this._newNpc,MobileType.NPC);
         this._newNpc.addEventListener(MouseEvent.CLICK,this.onClickNpc);
      }
      
      private function afterFinish() : void
      {
         if(this._newNpc)
         {
            this._newNpc.removeEventListener(MouseEvent.CLICK,this.onClickNpc);
            DisplayUtil.removeForParent(this._newNpc);
            this._newNpc = null;
         }
         if(this._oldNpc)
         {
            this._oldNpc.visible = true;
         }
      }
      
      private function onClickNpc(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this.afterFinish();
         MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("DarkSecret/DarkSecret1"),function callBack():void
         {
            QuestManager.completeStep(questID,3);
         },true,true,2,true);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mouse)
         {
            DisplayObjectUtil.removeFromParent(this._mouse);
            this._mouse = null;
         }
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onClickNpc);
            this._npc = null;
         }
         super.processMapDispose();
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         RightToolbarConter.instance.show();
      }
   }
}
