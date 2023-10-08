package com.taomee.seer2.app.processor.quest.handler.branch.quest10238
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10238_80247 extends QuestMapHandler
   {
       
      
      private var _mc3:MovieClip;
      
      private var _mc4:MovieClip;
      
      private var _mc5:MovieClip;
      
      public function QuestMapHandler_10238_80247(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         MobileManager.hideMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         ActorManager.hideActor();
         MobileManager.hideMoileVec(MobileType.NPC);
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,1) && !QuestManager.isStepComplete(questID,2))
         {
            this.initStep1();
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc3 = null;
         this._mc4 = null;
         this._mc5 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.COPY,80246);
      }
      
      private function initStep1() : void
      {
         this._mc3 = _processor.resLib.getMovieClip("Mc10238_2");
         _map.front.addChild(this._mc3);
         this._mc3.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc3,1,this._mc3.totalFrames,function():void
         {
            NpcDialog.show(400,"小赛尔",[[0,"如果超梦没有和万劫魔尊他们对战过的话，怎么会输给你！"]],[" 超梦加油！"],[function():void
            {
               NpcDialog.show(692,"雷煞",[[0,"哼，总之已经没有人能阻止我们魔域军团了。"]],["会有的！"],[function():void
               {
                  NpcDialog.show(477,"雷伊",[[0,"雷煞，你高兴的太早了吧。?"]],["雷伊？！"],[function():void
                  {
                     DisplayObjectUtil.removeFromParent(_mc3);
                     initContinue();
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initContinue() : void
      {
         this._mc4 = _processor.resLib.getMovieClip("Mc10238_3");
         _map.front.addChild(this._mc4);
         this._mc4.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc4,1,this._mc4.totalFrames,function():void
         {
            NpcDialog.show(477,"雷伊",[[0,"战神联盟！雷神雷伊！参见！"]],["帅气！"],[function():void
            {
               NpcDialog.show(692,"雷煞",[[0,"雷伊，我可是从你的基因里诞生的，你也应该明白，现在的你绝不是我的对手。"]],["黑化的雷伊……"],[function():void
               {
                  NpcDialog.show(477,"雷伊",[[0,"经过约瑟对我们战神联盟的修行，我已经不是从前的我了，来战吧！雷煞！"]],["来战！"],[function():void
                  {
                     DisplayObjectUtil.removeFromParent(_mc4);
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10238_0"),function():void
                     {
                        initContinue2();
                     });
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initContinue2() : void
      {
         this._mc5 = _processor.resLib.getMovieClip("Mc10238_4");
         _map.front.addChild(this._mc5);
         MovieClipUtil.playMc(this._mc5,1,this._mc5.totalFrames,function():void
         {
            NpcDialog.show(812,"帝刃雷神",[[0,"             看来魔域军团联合了暗黑六煞，各大氏族真的危险了。"]],["那怎么办？"],[function():void
            {
               NpcDialog.show(812,"帝刃雷神",[[0,"         我们战神联盟会先尝试稳住局势，今天可能会是阿卡迪亚，最黑暗的一天……"]],["最黑暗的一天？"],[function():void
               {
                  NpcDialog.show(774,"超梦",[[0,"                   如果约瑟王现在没被困住的话……"]],["约瑟不知道怎么样了"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onComplete);
                     QuestManager.completeStep(questID,2);
                  }]);
               }]);
            }]);
         },true);
      }
   }
}
