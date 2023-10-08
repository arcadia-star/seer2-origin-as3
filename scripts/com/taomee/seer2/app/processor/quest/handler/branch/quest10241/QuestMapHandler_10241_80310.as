package com.taomee.seer2.app.processor.quest.handler.branch.quest10241
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
   
   public class QuestMapHandler_10241_80310 extends QuestMapHandler
   {
       
      
      private var _mc10241_0:MovieClip;
      
      private var _mc10240_2:MovieClip;
      
      public function QuestMapHandler_10241_80310(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         ActorManager.hideActor();
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
         {
            this.init();
         }
         if(QuestManager.isStepComplete(questID,1) && !QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc10241_0 = null;
         this._mc10240_2 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.COPY,80311);
      }
      
      private function init() : void
      {
         this._mc10241_0 = _processor.resLib.getMovieClip("Mc10241_0");
         _map.content.addChild(this._mc10241_0);
         this._mc10241_0.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc10241_0,1,this._mc10241_0.totalFrames,function():void
         {
            NpcDialog.show(816,"创世大帝",[[0,"睡的好舒服…………"]],["诶？"],[function():void
            {
               NpcDialog.show(774,"超梦",[[0,"请问，你是创世大帝吗？"]],["感觉不太靠谱的样子"],[function():void
               {
                  NpcDialog.show(816,"创世大帝",[[0,"恩……是啊……你们来找我有事吗？"]],["有急事！！"],[function():void
                  {
                     NpcDialog.show(400,"小赛尔",[[0,"创世大帝！邪神又出现在阿卡迪亚了！"]],["邪神降临！"],[function():void
                     {
                        NpcDialog.show(816,"创世大帝",[[0,"那么麻烦的事……不要找我啦……"]],["啊？！！！！"],[function():void
                        {
                           initStep1();
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         });
      }
      
      private function initStep1() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10241_0"),function():void
         {
            NpcDialog.show(816,"创世大帝",[[0,"只要带一只美女精灵来这，我就告诉你们击败邪神的方法！"]],["啊？！！！！"],[function():void
            {
               NpcDialog.show(400,"小赛尔",[[0,"好吧……你等着，我们去去就来！"]],["大帝好不靠谱！"],[function():void
               {
                  DisplayObjectUtil.removeFromParent(_mc10241_0);
                  QuestManager.completeStep(questID,1);
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onComplete);
               }]);
            }]);
         },true);
      }
   }
}
