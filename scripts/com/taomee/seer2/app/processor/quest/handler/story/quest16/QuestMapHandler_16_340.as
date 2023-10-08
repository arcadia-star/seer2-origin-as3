package com.taomee.seer2.app.processor.quest.handler.story.quest16
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
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
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_16_340 extends QuestMapHandler
   {
      
      private static var _flghtIndex:int = 0;
       
      
      private var _mc_4:MovieClip;
      
      private var _npc:Mobile;
      
      private var _mc_7:MovieClip;
      
      public function QuestMapHandler_16_340(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id,4) == false && _flghtIndex == 1)
         {
            this.showAnimation();
            if(FightManager.fightWinnerSide == FightSide.LEFT && _flghtIndex == 1)
            {
               _flghtIndex = 0;
               this.win();
            }
            else
            {
               _flghtIndex = 0;
               this.noWin();
            }
            return;
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.showAnimation();
            this.showNpc();
         }
         if(QuestManager.isStepComplete(_quest.id,4) && QuestManager.isComplete(_quest.id) == false)
         {
            this.addMouseClickHint();
         }
      }
      
      private function showNpc() : void
      {
         this._npc = MobileManager.getMobile(438,MobileType.NPC);
         if(this._npc)
         {
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
         else
         {
            setTimeout(function():void
            {
               _mc_7 = _processor.resLib.getMovieClip("mc_7");
               _map.front.addChild(_mc_7);
               _mc_7.x = 230;
               _mc_7.y = 190;
               _npc = MobileManager.getMobile(438,MobileType.NPC);
               _npc.addEventListener(MouseEvent.CLICK,onNpcClick);
            },500);
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
         NpcDialog.show(438,"爆炸头",[[3,"Hey you！！让出这舞台，万万不可能~~！"]],["爆炸头你没事儿吧！"],[function():void
         {
            NpcDialog.show(440,"暗伊特",[[0,"嘻嘻~说唱已经过时了，快把舞台让出来，让我和我的兄弟玩玩！"]],["兄弟？"],[function():void
            {
               NpcDialog.show(441,"阿布布",[[4,"舞，舞台……？暗大哥，小弟从来没有在光天化日之下……好害羞啊……"]],["你……布条人！！我晕了……"],[function():void
               {
                  NpcDialog.show(438,"爆炸头",[[3,"Listen！我绝对~~不可能~~让出这~~~大舞台！！"]],["爆炸头，我帮你！"],[function():void
                  {
                     startFight();
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function startFight() : void
      {
         if(PetInfoManager.getFirstPetInfo().hp <= 1)
         {
            AlertManager.showAlert("您的首发精灵体力不够");
            this._mc_4.buttonMode = true;
            this.addFightMouseClickHint();
            this._mc_4.addEventListener(MouseEvent.CLICK,this.onMC4Click);
            return;
         }
         _flghtIndex = 1;
         FightManager.startFightWithNPC(2);
      }
      
      private function onMC4Click(param1:MouseEvent) : void
      {
         this._mc_4.removeEventListener(MouseEvent.CLICK,this.onMC4Click);
         this.startFight();
      }
      
      private function win() : void
      {
         NpcDialog.show(440,"暗伊特",[[0,"不好玩！不好玩！！不好玩！！！"]],["别走！！"],[function():void
         {
            MovieClipUtil.playMc(_mc_4,2,_mc_4.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_mc_4);
               _mc_4 = null;
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onQuestStep);
               QuestManager.completeStep(_quest.id,4);
            },true);
         }]);
      }
      
      private function onQuestStep(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onQuestStep);
         DisplayUtil.removeForParent(this._mc_7);
         this._mc_7 = null;
         this.addMouseClickHint();
      }
      
      private function addMouseClickHint() : void
      {
         _processor.showMouseHintAt(495,451);
      }
      
      private function addFightMouseClickHint() : void
      {
         if(QuestManager.isStepComplete(_quest.id,3) && !QuestManager.isCompletable(_quest.id))
         {
            _processor.showMouseHintAt(302,309);
         }
      }
      
      private function noWin() : void
      {
         this._mc_4.buttonMode = true;
         this.addFightMouseClickHint();
         this._mc_4.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            var event:MouseEvent = param1;
            _mc_4.removeEventListener(MouseEvent.CLICK,arguments.callee);
            NpcDialog.show(438,"爆炸头",[[3,"不论如何~~捍卫到底！！"]],["捍卫到底！！"],[function():void
            {
               startFight();
            }]);
         });
      }
      
      private function showAnimation() : void
      {
         this._mc_4 = _processor.resLib.getMovieClip("mc_4");
         _map.front.addChild(this._mc_4);
         this._mc_4.x = 313;
         this._mc_4.y = 336;
         this._mc_4.gotoAndStop(1);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onQuestStep);
         _processor.hideMouseClickHint();
         DisplayUtil.removeForParent(this._mc_4);
         this._mc_4 = null;
         DisplayUtil.removeForParent(this._mc_7);
         this._mc_7 = null;
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            this._npc = null;
         }
      }
   }
}
