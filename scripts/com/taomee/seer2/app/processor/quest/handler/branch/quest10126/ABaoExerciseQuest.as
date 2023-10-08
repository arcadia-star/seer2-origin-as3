package com.taomee.seer2.app.processor.quest.handler.branch.quest10126
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.miniGame.MiniGameEvent;
   import com.taomee.seer2.app.miniGame.MiniGameManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.NumDisplayUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class ABaoExerciseQuest
   {
      
      private static var _instance:com.taomee.seer2.app.processor.quest.handler.branch.quest10126.ABaoExerciseQuest;
       
      
      private var countDownSp:Sprite;
      
      private var _mobile:Mobile;
      
      private var _questID:int = 10126;
      
      private var overNum:int = 0;
      
      private var timeP:Point;
      
      public var isIngStep1:Boolean = false;
      
      public function ABaoExerciseQuest()
      {
         super();
      }
      
      public static function get instance() : com.taomee.seer2.app.processor.quest.handler.branch.quest10126.ABaoExerciseQuest
      {
         if(!_instance)
         {
            _instance = new com.taomee.seer2.app.processor.quest.handler.branch.quest10126.ABaoExerciseQuest();
         }
         return _instance;
      }
      
      public function setup(param1:int) : void
      {
         if(param1 == 1)
         {
            this.initStep1();
         }
         else if(param1 == 3)
         {
            this.initStep3();
         }
         else if(param1 == 5)
         {
            this.initStep5();
         }
      }
      
      private function initStep1() : void
      {
         if(Tick.instance.hasRender(this.updateTime))
         {
            return;
         }
         this._mobile = new Mobile();
         this._mobile.resourceUrl = URLUtil.getPetSwf(51);
         this.timeP = new Point((ActorManager.getActor().animation as DisplayObject).x / 2 - 10,-ActorManager.getActor().height);
         ActorManager.getActor().addCarriedMobile(this._mobile,80);
         Tick.instance.addRender(this.updateTime,1000);
         this.updateTime(0);
         this.isIngStep1 = true;
      }
      
      private function updateTime(param1:Number) : void
      {
         var cnt:Number = param1;
         if(this.countDownSp)
         {
            DisplayUtil.removeForParent(this.countDownSp);
            this.countDownSp = null;
         }
         ++this.overNum;
         cnt = 120 - this.overNum;
         if(cnt < 0)
         {
            cnt = 0;
         }
         this.countDownSp = NumDisplayUtil.getNumDisplay(cnt,"UI_NumberCoin",14);
         this.countDownSp.y = this.timeP.y - 10;
         this.countDownSp.x = this.timeP.x - this.countDownSp.width / 2;
         ActorManager.getActor().addChild(this.countDownSp);
         if(cnt == 0)
         {
            this.isIngStep1 = false;
            Tick.instance.removeRender(this.updateTime);
            DisplayUtil.removeForParent(this.countDownSp);
            ActorManager.getActor().removeCarriedMobile(this._mobile);
            NpcDialog.show(405,"阿宝",[[0,"哇喔，我感觉散步的锻炼效果很明显啊！好了先到这吧，我想休息会了。"]],[" ……你的运动量可真大。"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep);
               QuestManager.completeStep(_questID,1);
            }]);
         }
      }
      
      private function initStep3() : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameIntroPanel"),"正在打开" + "小游戏" + "...",{"gameId":5});
         MiniGameManager.addEventListener(MiniGameEvent.END_PLAY_GAME,this.playEnd);
      }
      
      private function initStep5() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.switchComplete);
         FightManager.startFightWithNPC(41);
      }
      
      private function switchComplete(param1:SceneEvent) : void
      {
         if(SceneManager.active.type == SceneType.LOBBY)
         {
            this.checkResult();
         }
      }
      
      private function checkResult() : void
      {
         if(FightManager.isJustWinFight())
         {
            NpcDialog.show(405,"阿宝",[[0,"胜利永远是属于正义的一方！呕耶！"]],[" 哈哈哈。"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
               QuestManager.completeStep(_questID,5);
            }]);
         }
         else if(SceneManager.prevSceneType == SceneType.ARENA && !FightManager.isWinWar())
         {
            NpcDialog.show(405,"阿宝",[[0,"可恶！我不会轻易放弃的！"]],[" 先休息一会"," 继续对战"],[function():void
            {
               SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,switchComplete);
            },function():void
            {
               FightManager.startFightWithNPC(41);
            }]);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10126)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.switchComplete);
         }
      }
      
      private function playEnd(param1:MiniGameEvent) : void
      {
         var event:MiniGameEvent = param1;
         if(event.gameInfo.gate >= 2)
         {
            NpcDialog.show(405,"阿宝",[[0,"跳呀跳，飞呀飞，我是不是身轻如燕啊？哇哈哈！"]],["嗯，你在空中的姿势真优美。"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep);
               QuestManager.completeStep(_questID,3);
            }]);
         }
      }
      
      private function onCompleteStep(param1:QuestEvent) : void
      {
         if(param1.questId == this._questID)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep);
            ModuleManager.toggleModule(URLUtil.getAppModule("ABaoExercisePanel"));
         }
      }
   }
}
