package com.taomee.seer2.app.processor.quest.handler.branch.quest10227
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10227_80145 extends QuestMapHandler
   {
      
      public static var haveBattle:Boolean = true;
       
      
      private var _mc2:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var _mc4:MovieClip;
      
      private var _mc5:MovieClip;
      
      private var _mack:AcceptableMark;
      
      public function QuestMapHandler_10227_80145(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(!haveBattle)
         {
            return;
         }
         super.processMapComplete();
         if(QuestManager.isAccepted(10227) && QuestManager.isStepComplete(10227,2) == false)
         {
            _map.content.visible = false;
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc2 = _processor.resLib.getMovieClip("mc2");
         _map.front.addChild(this._mc2);
         MovieClipUtil.playMc(this._mc2,2,this._mc2.totalFrames,function():void
         {
            onSpeak1();
         },true);
      }
      
      private function onSpeak1() : void
      {
         NpcDialog.show(616,"观星者",[[0,"黑武士，噬神界回来了，看来战争又要开始了。 "]],["   萨伦帝国的精灵……"],[function():void
         {
            NpcDialog.show(694,"黑武士",[[0,"观星，看来事隔200多年，又要并肩作战了吗？"]],[" 制造黑洞！？"],[function():void
            {
               NpcDialog.show(616,"观星者",[[0,"200年前的那场战争吗，还真是怀念那。不过现在不是提这个的时候。"]],["200年前的战争？！"],[function():void
               {
                  NpcDialog.show(694,"黑武士",[[0,"哼，真是麻烦。那就让我来帮助你们吧。需要的东西准备好了吧观星，展开黑洞所需的红莲之火。"]],["需要的东西？"],[function():void
                  {
                     NpcDialog.show(616,"观星者",[[0,"准备好了，炎星的小王子，麻烦你，请释放些许你的火焰。"]],[" 需要赫的火焰！"],[function():void
                     {
                        NpcDialog.show(736,"赫",[[0,"没问题，乐意效劳。"]],[" 加油，赫！"],[function():void
                        {
                           DisplayUtil.removeForParent(_mack);
                           DisplayUtil.removeForParent(_mc2);
                           initStep2();
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function initStep2() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc3 = _processor.resLib.getMovieClip("mc3");
         _map.front.addChild(this._mc3);
         MovieClipUtil.playMc(this._mc3,2,this._mc3.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_mack);
            DisplayUtil.removeForParent(_mc3);
            initStep3();
         },true);
      }
      
      private function initStep3() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10227_1"),function():void
         {
            initStep4();
         },true,true);
      }
      
      private function initStep4() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc4 = _processor.resLib.getMovieClip("mc4");
         _map.front.addChild(this._mc4);
         MovieClipUtil.playMc(this._mc4,2,this._mc4.totalFrames,function():void
         {
            onSpeak2();
         },true);
      }
      
      private function onSpeak2() : void
      {
         NpcDialog.show(748,"巴比隆",[[0,"自我介绍一下，我是NO.38的巴比隆，负责守卫噬神界的大门！  "]],["   NO.38！"],[function():void
         {
            NpcDialog.show(694,"黑武士",[[0,"观星，这个巴比隆就先交给我吧，你们快进入噬神界，再慢可就来不及了。"]],["  黑武士……"],[function():void
            {
               DisplayUtil.removeForParent(_mack);
               DisplayUtil.removeForParent(_mc4);
               initStep5();
            }]);
         }]);
      }
      
      private function initStep5() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc5 = _processor.resLib.getMovieClip("mc5");
         _map.front.addChild(this._mc5);
         MovieClipUtil.playMc(this._mc5,2,this._mc5.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_mack);
            DisplayUtil.removeForParent(_mc5);
            initStep6();
         },true);
      }
      
      private function initStep6() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10227_2"),function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onStepComplete);
            QuestManager.completeStep(10227,2);
            initStep4();
         },true,true);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         MobileManager.showMoileVec(MobileType.NPC);
         ActorManager.showRemoteActor = true;
         ActorManager.getActor().isShow = true;
         ActorManager.getActor().blockNoNo = false;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         DisplayUtil.removeForParent(this._mc2);
         DisplayUtil.removeForParent(this._mc3);
         DisplayUtil.removeForParent(this._mc4);
         DisplayUtil.removeForParent(this._mc5);
         DisplayUtil.removeForParent(this._mack);
      }
   }
}
