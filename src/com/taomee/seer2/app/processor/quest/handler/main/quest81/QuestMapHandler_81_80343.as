package com.taomee.seer2.app.processor.quest.handler.main.quest81
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
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_81_80343 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      public function QuestMapHandler_81_80343(param1:QuestProcessor)
      {
         super(param1);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         ActorManager.hideActor();
         super.processMapComplete();
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,1) && QuestManager.isStepComplete(questID,2) && QuestManager.isStepComplete(questID,3) && QuestManager.isStepComplete(questID,4) && QuestManager.isStepComplete(questID,5) && QuestManager.isStepComplete(questID,6) && !QuestManager.isStepComplete(questID,7))
         {
            this.initStep();
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc1 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initStep() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("81_1"),function():void
         {
            initContinue();
         });
      }
      
      private function initContinue() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("Mc81_0");
         _map.front.addChild(this._mc1);
         this._mc1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
         {
            NpcDialog.show(1020,"达斯维达",[[0,"这飞船倒是比我想象的要坚固，受到我的打击，居然坚持到现在还没有破裂。"]],["你！"],[function():void
            {
               NpcDialog.show(10,"巴蒂",[[3,"你是谁！为什么要搞破坏！"]],["看他满身邪气的样子，一定不是好人！"],[function():void
               {
                  NpcDialog.show(1020,"达斯维达",[[0,"我为什么不能搞破坏？哼，你们不也在我的治下搞破坏吗？"]],["治下？你是超能氏族的统治者？"],[function():void
                  {
                     NpcDialog.show(1020,"达斯维达",[[0,"哼，我是超能氏族的族长。你们居然和反萨联盟那帮反动者搅在一起，破坏我的统治，还妄图破坏萨伦大王的大计，可恶！"]],["  身为族长，却出卖族人，为萨伦卖命，你才可恶！"],[function():void
                     {
                        NpcDialog.show(1020,"达斯维达",[[0,"少废话，交出反萨联盟的所有成员名单，或许我还可以放你们一条生路。不然的话，你们猜，这艘“诺亚方舟”，还能禁得住几下我们的攻击？到时候，你们的小命可就……嘿嘿"]],[" 你休想！"],[function():void
                        {
                           initStep1();
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initStep1() : void
      {
         this._mc2 = _processor.resLib.getMovieClip("Mc81_1");
         _map.front.addChild(this._mc2);
         this._mc2.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc2,1,this._mc2.totalFrames,function():void
         {
            NpcDialog.show(1020,"达斯维达",[[0,"哼，你们是打不到我的，因为这里的我，不过是我的意识体，可以任意变化重聚。既然你们敬酒不吃吃罚酒，那么，魔念黯灵，上吧！"]],["是，主人"],[function():void
            {
               initStep2();
            }]);
         },true);
      }
      
      private function initStep2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("81_2"),function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
            QuestManager.completeStep(questID,7);
         });
      }
   }
}
