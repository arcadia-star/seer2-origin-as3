package com.taomee.seer2.app.processor.quest.handler.branch.quest10240
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
   
   public class QuestMapHandler_10240_80308 extends QuestMapHandler
   {
       
      
      private var _mc10239_3:MovieClip;
      
      private var _mc10240_1:MovieClip;
      
      public function QuestMapHandler_10240_80308(param1:QuestProcessor)
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
         this._mc10240_1 = null;
         this._mc10239_3 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.COPY,80307);
      }
      
      private function init() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10239_1"),function():void
         {
            _mc10239_3 = _processor.resLib.getMovieClip("Mc10240_3");
            _map.content.addChild(_mc10239_3);
            _mc10239_3.gotoAndStop(1);
            MovieClipUtil.playMc(_mc10239_3,1,_mc10239_3.totalFrames,function():void
            {
               NpcDialog.show(400,"小赛尔",[[0,"那可怎么办！邪神岂不是不可阻止了？"]],["无敌的邪神"],[function():void
               {
                  NpcDialog.show(774,"超梦",[[0,"如果是聚集阿卡迪亚所有邪恶的精灵，那只有创造这个世界邪恶和正义的存在才能封印他了吧。"]],["创造这个世界？"],[function():void
                  {
                     NpcDialog.show(814,"约瑟王",[[0,"没错超梦，只有创造这个世界的它们才有方法制服邪神。"]],["它们？！难道不是只有一只吗？！"],[function():void
                     {
                        NpcDialog.show(400,"小赛尔",[[0,"创造世界的！？那会是谁！？"]],["创造世界！！"],[function():void
                        {
                           NpcDialog.show(814,"约瑟王",[[0,"就是在五千年前那场大战中，将我和奎尔斯封印的那三位神。"]],["！！！！"],[function():void
                           {
                              DisplayObjectUtil.removeFromParent(_mc10239_3);
                              MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10240_0"),function():void
                              {
                                 _mc10240_1 = _processor.resLib.getMovieClip("Mc10240_0");
                                 _map.content.addChild(_mc10240_1);
                                 _mc10240_1.gotoAndStop(1);
                                 MovieClipUtil.playMc(_mc10240_1,1,_mc10240_1.totalFrames,function():void
                                 {
                                    DisplayObjectUtil.removeFromParent(_mc10240_1);
                                    initContinue();
                                 });
                              });
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            },true);
         });
      }
      
      private function initContinue() : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         QuestManager.completeStep(questID,1);
      }
   }
}
