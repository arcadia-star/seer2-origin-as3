package com.taomee.seer2.app.processor.quest.handler.branch.quest10137
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10137_153 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _battle:MovieClip;
      
      private var _voice:MovieClip;
      
      private var _letter:MovieClip;
      
      private var _myself:Actor;
      
      public function QuestMapHandler_10137_153(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this.hideMySelf();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.addBottle();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.addNewBottle();
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.addNewBottleAgain();
         }
      }
      
      private function hideMySelf() : void
      {
         this._myself = ActorManager.getActor();
         this._myself.hide();
      }
      
      private function addBottle() : void
      {
         _processor.showMouseHintAt(295,332);
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         _map.content.addChild(this._mc_0);
         this._battle = this._mc_0["bottle"];
         this._voice = this._mc_0["voice"];
         this._voice.visible = false;
         this._battle.buttonMode = true;
         this._battle.addEventListener(MouseEvent.CLICK,this.onOpenBottleHandler);
      }
      
      private function onOpenBottleHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._battle.gotoAndStop(2);
         this._voice.visible = true;
         setTimeout(function():void
         {
            _battle.removeEventListener(MouseEvent.CLICK,onOpenBottleHandler);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1Handler);
            QuestManager.completeStep(_quest.id,1);
            _processor.hideMouseClickHint();
         },3700);
      }
      
      private function onStep1Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Handler);
         this.addNewBottle();
      }
      
      private function addNewBottle() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._battle)
         {
            DisplayUtil.removeForParent(this._battle);
         }
         if(this._voice)
         {
            DisplayUtil.removeForParent(this._voice);
         }
         _processor.showMouseHintAt(716,282);
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         _map.content.addChild(this._mc_0);
         this._battle = this._mc_0["bottle"];
         this._voice = this._mc_0["voice"];
         this._battle.gotoAndStop(2);
         this._voice.buttonMode = true;
         this._voice.addEventListener(MouseEvent.CLICK,this.onOpenVoiceHandler);
      }
      
      private function onOpenVoiceHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._voice)
         {
            DisplayUtil.removeForParent(this._voice);
         }
         _processor.hideMouseClickHint();
         NpcDialog.show(524,"瑞克克",[[0,"别碰我主人的瓶子……那是我主人的……"]],["主人？瓶子？"],[function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10137_0"),6,[[1,0]],function():void
            {
               NpcDialog.show(524,"瑞克克",[[0,"3个瓶子……还差3个瓶子……呜呜呜呜……"]],["我来帮你完成吧！"],[function():void
               {
                  _voice.removeEventListener(MouseEvent.CLICK,onOpenVoiceHandler);
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Handler);
                  QuestManager.completeStep(_quest.id,2);
                  _processor.hideMouseClickHint();
               }]);
            });
         }]);
      }
      
      private function onStep2Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Handler);
         this.addNewBottleAgain();
      }
      
      private function addNewBottleAgain() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._battle)
         {
            DisplayUtil.removeForParent(this._battle);
         }
         if(this._voice)
         {
            DisplayUtil.removeForParent(this._voice);
         }
         _processor.showMouseHintAt(688,224);
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         _map.content.addChild(this._mc_0);
         this._battle = this._mc_0["redBottle"];
         this._battle.buttonMode = true;
         this._battle.addEventListener(MouseEvent.CLICK,this.onOpenRedBottleHandler);
      }
      
      private function onOpenRedBottleHandler(param1:MouseEvent) : void
      {
         var closeBtn:SimpleButton;
         var evt:MouseEvent = param1;
         this._letter = _processor.resLib.getMovieClip("letter");
         _map.front.addChild(this._letter);
         closeBtn = this._letter["closeBtn"];
         closeBtn.addEventListener(MouseEvent.CLICK,function():void
         {
            DisplayUtil.removeForParent(_letter);
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"任务1：去幻彩珊瑚寻找乌达，让乌达成为占卜婆婆的精灵！"]],["事不宜迟！GO！"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3Handler);
               QuestManager.completeStep(_quest.id,3);
               _processor.hideMouseClickHint();
            }]);
         });
      }
      
      private function onStep3Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Handler);
         SceneManager.changeScene(SceneType.LOBBY,211);
      }
      
      override public function processMapDispose() : void
      {
         this._myself.show();
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._battle)
         {
            DisplayUtil.removeForParent(this._battle);
         }
         if(this._voice)
         {
            DisplayUtil.removeForParent(this._voice);
         }
         if(this._letter)
         {
            DisplayUtil.removeForParent(this._letter);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Handler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Handler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Handler);
      }
   }
}
