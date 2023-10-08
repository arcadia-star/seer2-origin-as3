package com.taomee.seer2.app.processor.quest.handler.branch.quest10245
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
   
   public class QuestMapHandler_10245_80331 extends QuestMapHandler
   {
       
      
      private var _mc10245_0:MovieClip;
      
      public function QuestMapHandler_10245_80331(param1:QuestProcessor)
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
         this._mc10245_0 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.COPY,80332);
      }
      
      private function init() : void
      {
         this._mc10245_0 = _processor.resLib.getMovieClip("Mc10245_0");
         _map.content.addChild(this._mc10245_0);
         this._mc10245_0.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc10245_0,1,this._mc10245_0.totalFrames,function():void
         {
            NpcDialog.show(400,"小赛尔",[[0,"开元大帝！创世和混沌已经支撑不住了！"]],[" 快帮帮他们吧！"],[function():void
            {
               NpcDialog.show(817,"开元大帝",[[0,"即使这颗星球毁灭，也与我无关。"]],["开元怎么这样？"],[function():void
               {
                  NpcDialog.show(27,"占卜婆婆",[[0,"开！！！！元！！！！你怎么那么不争气！！！！"]],["婆婆……"],[function():void
                  {
                     NpcDialog.show(27,"占卜婆婆",[[0,"约瑟与奎尔斯的事件已经过去那么久了！你能不能正面面对！"]],["对的！"],[function():void
                     {
                        NpcDialog.show(27,"占卜婆婆",[[0,"你现在这样！对得起三帝的名号吗！"]],["三帝的名号"],[function():void
                        {
                           MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10245_0"),function():void
                           {
                              initContinue();
                           });
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initContinue() : void
      {
         NpcDialog.show(27,"占卜婆婆",[[0,"你忘了，几百年前，你是怎么答应我的了吗！"]],["诶？原来那个人是婆婆？"],[function():void
         {
            NpcDialog.show(27,"占卜婆婆",[[0,"阿卡迪亚的开元大帝啊！！！！！！！！！！"]],["开元！"],[function():void
            {
               NpcDialog.show(817,"开元大帝",[[0,"…………"]],["…………"],[function():void
               {
                  NpcDialog.show(817,"开元大帝",[[0,"小赛尔，超梦。带路"]],["开元终于肯出战了！"],[function():void
                  {
                     NpcDialog.show(817,"开元大帝",[[0,"谢谢你，水系氏族的子民，你的忠言我会永远铭记在心的。"]],["谢谢婆婆！"],[function():void
                     {
                        NpcDialog.show(817,"开元大帝",[[0,"十分期待再次相见。"]],["恩！"],[function():void
                        {
                           NpcDialog.show(27,"占卜婆婆",[[0,"哈哈，我会努力活到那个时候的。"]],["出发！大战邪神！"],[function():void
                           {
                              DisplayObjectUtil.removeFromParent(_mc10245_0);
                              QuestManager.completeStep(questID,1);
                              QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onComplete);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
   }
}
