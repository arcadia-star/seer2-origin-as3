package com.taomee.seer2.app.processor.quest.handler.branch.quest10236
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
   
   public class QuestMapHandler_10236_80145 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      public function QuestMapHandler_10236_80145(param1:QuestProcessor)
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
         this._mc1 = null;
         this._mc2 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initStep1() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("Mc10236_1");
         _map.content.addChild(this._mc1);
         this._mc1.gotoAndStop(1);
         NpcDialog.show(400,"小赛尔",[[0,"小梦！你怎么变身了！"]],["进化了？"],[function():void
         {
            NpcDialog.show(774,"超梦",[[0,"我获得了星魂的力量，从现在开始，我叫作——超梦！！！！"]],["霸气！"],[function():void
            {
               NpcDialog.show(771,"梦神",[[0,"只是换了个名字，能有多厉害！?"]],["要不要来试试！"],[function():void
               {
                  MovieClipUtil.playMc(_mc1,1,_mc1.totalFrames,function():void
                  {
                     initStep2();
                  },true);
               }]);
            }]);
         }]);
      }
      
      private function initStep2() : void
      {
         NpcDialog.show(12,"萨伦",[[0,"不愧是星魂进化的能量……不过我们也不是毫无准备!"]],["萨伦帝国还有阴谋？"],[function():void
         {
            NpcDialog.show(12,"萨伦",[[0,"现身吧！我们的同盟！魔域军团！"]],["魔域军团？！"],[function():void
            {
               DisplayObjectUtil.removeFromParent(_mc1);
               initStep3();
            }]);
         }]);
      }
      
      private function initStep3() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("Mc10236_2");
         _map.content.addChild(this._mc1);
         MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
         {
            NpcDialog.show(12,"萨伦",[[0,"超梦，你一个人能战胜魔域军团吗？哈哈哈哈哈！"]],["太卑鄙了！"],[function():void
            {
               NpcDialog.show(774,"超梦",[[0,"放马过来！"]],["超梦小心！"],[function():void
               {
                  NpcDialog.show(764,"魔尊",[[0,"萨伦，说好的占领阿卡迪亚后分我们一半的承诺可别忘了?"]],["和萨伦的交易？"],[function():void
                  {
                     NpcDialog.show(12,"萨伦",[[0,"没问题，现在，让我们魔域军团开始杀戮吧！?"]],["魔域军团的入侵！"],[function():void
                     {
                        DisplayObjectUtil.removeFromParent(_mc1);
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10236_2"),function():void
                        {
                           QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                           QuestManager.completeStep(questID,2);
                        });
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
   }
}
