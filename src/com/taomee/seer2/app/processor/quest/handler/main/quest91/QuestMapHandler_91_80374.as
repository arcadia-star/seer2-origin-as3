package com.taomee.seer2.app.processor.quest.handler.main.quest91
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class QuestMapHandler_91_80374 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      private var _mouseHint:MouseClickHintSprite;
      
      private var _teleport:Sprite;
      
      public function QuestMapHandler_91_80374(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         RightToolbarConter.instance.hide();
         _map.content["npcMc"].visible = false;
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,1) && !QuestManager.isStepComplete(questID,2))
         {
            this.createNpc();
         }
         if(QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
      }
      
      private function createNpc() : void
      {
         this._npc = new Mobile();
         this._npc.setPostion(new Point(668,328));
         this._npc.resourceUrl = URLUtil.getNpcSwf(847);
         this._npc.buttonMode = true;
         MobileManager.addMobile(this._npc,MobileType.NPC);
         var _loc1_:AcceptableMark = new AcceptableMark();
         this._npc.addChild(_loc1_);
         _loc1_.y = -130;
         this._npc.addEventListener(MouseEvent.CLICK,this.dialogShow);
      }
      
      private function dialogShow(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(847,"虚弱的极梦",[[0,"小赛尔……你们完成任务了吗？  "]],["能量转化装置被破坏了。你伤的很严重！"],[function():void
         {
            NpcDialog.show(847,"虚弱的极梦",[[0,"我没事……我……差一点就能战胜远古地魔了！ "]],["我这就带你回阿尔达要塞！"],[function():void
            {
               if(_npc != null)
               {
                  MobileManager.removeMobile(_npc,MobileType.NPC);
               }
               createTeleport();
            }]);
         }]);
      }
      
      private function createTeleport() : void
      {
         this._teleport = UIManager.getSprite("UI_Teleport");
         this._teleport.buttonMode = true;
         this._teleport.addEventListener(MouseEvent.CLICK,this.onClickTeleport);
         this._teleport.x = 868;
         this._teleport.y = 246;
         _map.front.addChild(this._teleport);
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.x = 0;
         this._mouseHint.y = -30;
         this._teleport.addChild(this._mouseHint);
      }
      
      private function onClickTeleport(param1:MouseEvent) : void
      {
         QuestManager.completeStep(questID,2);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.stepCompleted);
      }
      
      private function stepCompleted(param1:QuestEvent) : void
      {
         SceneManager.changeScene(SceneType.COPY,80375);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         RightToolbarConter.instance.show();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         RightToolbarConter.instance.show();
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         super.processMapDispose();
      }
   }
}
