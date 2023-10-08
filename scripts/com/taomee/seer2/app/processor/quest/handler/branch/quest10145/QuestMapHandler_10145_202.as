package com.taomee.seer2.app.processor.quest.handler.branch.quest10145
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10145_202 extends QuestMapHandler
   {
       
      
      private var _npcAnmiya:MovieClip;
      
      private var _npcLanhujin:MovieClip;
      
      private const POS:Array = [[645,150],[100,187]];
      
      public function QuestMapHandler_10145_202(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && !QuestManager.isStepComplete(_quest.id,3))
         {
            this.addRes1();
         }
         else if(QuestManager.isStepComplete(_quest.id,3) && !QuestManager.isStepComplete(_quest.id,4))
         {
            this.addRes2();
         }
      }
      
      private function addRes1() : void
      {
         this._npcAnmiya = _processor.resLib.getMovieClip("npc_7");
         this._npcAnmiya.x = this.POS[0][0];
         this._npcAnmiya.y = this.POS[0][1];
         _map.content.addChild(this._npcAnmiya);
         this._npcAnmiya.buttonMode = true;
         this._npcAnmiya.addEventListener(MouseEvent.CLICK,this.onAnmiyaClick);
      }
      
      private function onAnmiyaClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(412,"安迷亚",[[0,"你…你…你们是什么人？你们想干嘛？！"]],["借你的头罩一用吧"],[function():void
         {
            FightManager.startFightWithWild(241);
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSceneSwitchComplete);
         }]);
      }
      
      private function onSceneSwitchComplete(param1:SceneEvent) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == 241)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSceneSwitchComplete);
            DisplayUtil.removeForParent(this._npcAnmiya);
            this._npcAnmiya.removeEventListener(MouseEvent.CLICK,this.onAnmiyaClick);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepThreeComplete);
            QuestManager.completeStep(_quest.id,3);
         }
      }
      
      private function onSceneSwitchComplete1(param1:SceneEvent) : void
      {
         var evt:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == 242)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSceneSwitchComplete1);
            DisplayUtil.removeForParent(this._npcLanhujin);
            this._npcLanhujin.removeEventListener(MouseEvent.CLICK,this.onLanhujinClick);
            NpcDialog.show(11,"多罗",[[1,"这家伙真硬吧！巴蒂应该也找到东西了！我们现在回雪人村吧！"]],["好！现在就走！"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepFourComplete);
               QuestManager.completeStep(_quest.id,4);
            }]);
         }
      }
      
      private function onStepThreeComplete(param1:QuestEvent) : void
      {
         var evt:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepThreeComplete);
         NpcDialog.show(11,"多罗",[[1,"安迷亚的头罩还蛮透明的，接下来我们去找蓝喵的硬壳吧！"]],["好的！"],[function():void
         {
            addRes2();
         }]);
      }
      
      private function onStepFourComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepFourComplete);
         SceneManager.changeScene(SceneType.LOBBY,10108);
      }
      
      private function addRes2() : void
      {
         if(_map.content == null)
         {
            return;
         }
         this._npcLanhujin = _processor.resLib.getMovieClip("npc_8");
         this._npcLanhujin.x = this.POS[1][0];
         this._npcLanhujin.y = this.POS[1][1];
         _map.content.addChild(this._npcLanhujin);
         this._npcLanhujin.buttonMode = true;
         this._npcLanhujin.addEventListener(MouseEvent.CLICK,this.onLanhujinClick);
      }
      
      private function onLanhujinClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(413,"蓝虎鲸",[[0,"你们这是干嘛？我可没空理你们，我还要挑战阿卡纳斯去呢！"]],["嘿嘿，先留下你的硬壳吧。"],[function():void
         {
            FightManager.startFightWithWild(242);
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSceneSwitchComplete1);
         }]);
      }
      
      private function desolveRes() : void
      {
         if(Boolean(this._npcAnmiya) && Boolean(this._npcAnmiya.parent))
         {
            DisplayUtil.removeForParent(this._npcAnmiya);
            this._npcAnmiya.removeEventListener(MouseEvent.CLICK,this.onAnmiyaClick);
            this._npcAnmiya = null;
         }
         if(Boolean(this._npcLanhujin) && Boolean(this._npcLanhujin.parent))
         {
            DisplayUtil.removeForParent(this._npcLanhujin);
            this._npcLanhujin.removeEventListener(MouseEvent.CLICK,this.onLanhujinClick);
            this._npcLanhujin = null;
         }
      }
      
      override public function processMapDispose() : void
      {
         this.desolveRes();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepThreeComplete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepFourComplete);
      }
   }
}
