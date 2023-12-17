package com.taomee.seer2.app.processor.quest.handler.branch.quest10212
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10212_80089 extends QuestMapHandler
   {
       
      
      private var sceneMc:MovieClip;
      
      public function QuestMapHandler_10212_80089(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(isAccepted() && isNeedCompleteStep(1))
         {
            this.initStep1();
         }
         if(isNeedCompleteStep(2))
         {
            this.initStep2();
         }
         if(isNeedCompleteStep(3))
         {
            this.initStep3();
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      private function initStep1() : void
      {
         this.sceneMc = _processor.resLib.getMovieClip("SceneMc1");
         _map.content.addChild(this.sceneMc);
         NpcDialog.show(11,"多罗",[[0,"啊~我们迷路了，你知道厕所往哪走吗？"]],["厕所……"],[function():void
         {
            NpcDialog.show(663,"希雅",[[0,"又是你们这群小兔崽子，活腻了吗？"]],["啊……她真可怕。"],[function():void
            {
               NpcDialog.show(647,"路奇",[[0,"呀呀呀~别跟他们废话了，让我去灭了他们吧。"]],["大家小心。"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                  QuestManager.completeStep(questID,1);
               }]);
            }]);
         }]);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(param1.questId == questID)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            if(param1.stepId == 1)
            {
               this.initStep2();
            }
            else if(param1.stepId == 2)
            {
               this.initStep3();
            }
         }
      }
      
      private function initStep3() : void
      {
         if(!this.sceneMc)
         {
            this.sceneMc = _processor.resLib.getMovieClip("SceneMc2");
            _map.content.addChild(this.sceneMc);
         }
         NpcDialog.show(647,"路奇",[[0,"可恶，这都躲的过，你是博尔特附体吗？"]],["小意思。"],[function():void
         {
            NpcDialog.show(664,"伯德",[[0,"我的弹药用完了，今天先放过你们，等我们的Boss复活了，你们一个都逃不掉，等着吧！"]],["我是勇敢的赛尔，我不怕你们。"],[function():void
            {
               NpcDialog.show(664,"伯德",[[0,"迪克，到时候你的下场就和你哥哥一样，啊哈哈哈哈哈……"]],[" 迪克的哥哥？"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10212_2"),function():void
                  {
                     NpcDialog.show(10,"巴蒂",[[0,"迪克，刚刚坏熊说的你哥哥是怎么回事呀？"]],["  你哥哥怎么了？"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10212_3"),function():void
                        {
                           QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                           QuestManager.completeStep(questID,3);
                        },false,false,1,false);
                     }]);
                  },false,false,1,false);
               }]);
            }]);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 10212)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
            SceneManager.changeScene(SceneType.LOBBY,3813);
         }
      }
      
      private function initStep2() : void
      {
         if(this.sceneMc)
         {
            DisplayObjectUtil.removeFromParent(this.sceneMc);
         }
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10212_1"),function():void
         {
            sceneMc = _processor.resLib.getMovieClip("SceneMc2");
            _map.content.addChild(sceneMc);
            NpcDialog.show(11,"多罗",[[0,"我们……死了吗？"]],["白痴。"],[function():void
            {
               NpcDialog.show(10,"巴蒂",[[0,"哇~又出现了一个天马四骑士吗？好man啊！"]],["好man！"],[function():void
               {
                  NpcDialog.show(663,"希雅",[[0,"怎么又来了个碍事的，给老娘滚开！"]],["大婶，生气容易长皱纹哦~"],[function():void
                  {
                     NpcDialog.show(664,"伯德",[[0,"原来是你，装了两块铁皮就以为自己是变形金刚了吗？"]],["变形金刚……我还铁胆火车侠呢。"],[function():void
                     {
                        NpcDialog.show(665,"迪克",[[0,"大家小心，赶快卧倒……"]],["哇塞，导弹又要飞过来了。"],[function():void
                        {
                           QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                           ModuleManager.toggleModule(URLUtil.getAppModule("DodgeMissilePanel"));
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         },false,false,1,false);
      }
   }
}
