package com.taomee.seer2.app.processor.quest.handler.activity.quest30006
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_30006_340 extends QuestMapHandler
   {
       
      
      private var wangManager:MovieClip;
      
      private var flySkillName:String = "FlySkill";
      
      public function QuestMapHandler_30006_340(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.initQuestStep4();
         }
      }
      
      private function initQuestStep4() : void
      {
         this.wangManager = _processor.resLib.getMovieClip("WangManager");
         this.wangManager.buttonMode = true;
         _map.front.addChild(this.wangManager);
         this.wangManager.addEventListener(MouseEvent.CLICK,this.wangManagerDialogue);
      }
      
      private function wangManagerDialogue(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(43,"汪总管",[[3,"捣蛋鬼！你给我下来！！吃了多少次霸王餐了！！天啊……大老板知道了就完蛋了啊T.T"]],["发生什么事情了？"],[function():void
         {
            NpcDialog.show(476,"飞伊特",[[1,"不要那么刻板嘛~好东西大家分享嘛=v="]],["吃霸王餐还嘴硬……"],[function():void
            {
               NpcDialog.show(43,"汪总管",[[3,"为了把帐摆平，你知道我为你垫了多少钱？！"]],["好可怜……"],[function():void
               {
                  NpcDialog.show(476,"飞伊特",[[1,"嘿~那边的铁皮，一起来喝下午茶，我请客~"]],["最后还不是总管请客！！"],[function():void
                  {
                     var skill:* = undefined;
                     wangManager.flyEeetsMc.visible = false;
                     wangManager.removeEventListener(MouseEvent.CLICK,wangManagerDialogue);
                     skill = _processor.resLib.getMovieClip("FlySkill");
                     skill.gotoAndStop(1);
                     _map.front.addChild(skill);
                     MovieClipUtil.playMc(skill,1,skill.totalFrames,function():void
                     {
                        _map.front.removeChild(skill);
                        NpcDialog.show(43,"汪总管",[[3,"这种捣蛋分子应该被坚决取缔掉！！真是我的财务生涯中凄惨的一笔……！"]],["我得先去异蘑小径看看！"],[toNextScene]);
                     },true);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function toNextScene() : void
      {
         _map.front.removeChild(this.wangManager);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         QuestManager.completeStep(_quest.id,4);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id && param1.stepId == 4)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            SceneManager.changeScene(SceneType.LOBBY,123);
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this.wangManager)
         {
            if(_map.front.contains(this.wangManager))
            {
               _map.front.removeChild(this.wangManager);
            }
            this.wangManager.removeEventListener(MouseEvent.CLICK,this.wangManagerDialogue);
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
      }
   }
}
