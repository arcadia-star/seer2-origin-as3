package com.taomee.seer2.app.processor.quest.handler.story.quest67
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_67_1210 extends QuestMapHandler
   {
       
      
      private var _fightStatus:Boolean;
      
      private var _mc_0:MovieClip;
      
      private var _myself:Actor;
      
      public function QuestMapHandler_67_1210(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            if(this._fightStatus)
            {
               this._fightStatus = false;
               if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  this.winFight();
               }
               else
               {
                  DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepHandler);
               }
               return;
            }
            this.palyMc();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepHandler);
         }
      }
      
      private function onStepHandler(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "67_1")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepHandler);
            this._fightStatus = true;
            FightManager.startFightWithWild(488);
         }
      }
      
      private function palyMc() : void
      {
         MobileManager.getMobile(315,MobileType.NPC).visible = false;
         this._myself = ActorManager.getActor();
         this._myself.hide();
         this._mc_0 = _processor.resLib.getMovieClip("mc0");
         _map.front.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            if(_mc_0)
            {
               DisplayUtil.removeForParent(_mc_0);
            }
            MobileManager.getMobile(315,MobileType.NPC).visible = true;
            _myself.show();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,onStepHandler);
         },true);
      }
      
      private function winFight() : void
      {
         NpcDialog.show(315,"皇后",[[0,"你们，你们居然为了一个白雪公主和我翻脸，我的统一大业就这样被你们毁了！"]],["真不知好歹"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"统一大业？哼，你把虫族破坏成这个样子，还好意思统一？"]],["你就是个恶人"],[function():void
            {
               NpcDialog.show(315,"皇后",[[0,"不和你们啰嗦，咱们走着瞧。哼！"]],["我还会回来的"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepTwoComplete);
                  QuestManager.completeStep(_quest.id,2);
               }]);
            }]);
         }]);
      }
      
      private function onStepTwoComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepTwoComplete);
         SceneManager.changeScene(SceneType.LOBBY,1240);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepTwoComplete);
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepHandler);
         super.processMapDispose();
      }
   }
}
