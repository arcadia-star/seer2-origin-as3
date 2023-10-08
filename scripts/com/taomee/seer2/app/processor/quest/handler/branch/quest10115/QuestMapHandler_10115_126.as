package com.taomee.seer2.app.processor.quest.handler.branch.quest10115
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10115_126 extends QuestMapHandlerDream
   {
       
      
      private var talkMc:MovieClip;
      
      private var fulaMc:MovieClip;
      
      private var resultMc:MovieClip;
      
      public function QuestMapHandler_10115_126(param1:QuestProcessor)
      {
         super(param1);
         _questID = 10115;
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isComplete(_quest.id))
         {
            ActorManager.showRemoteActor = false;
         }
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
         {
            this.initStep1();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            this.initStep2();
         }
      }
      
      private function initStep1() : void
      {
         this.talkMc = _processor.resLib.getMovieClip("talkMc");
         LayerManager.topLayer.addChild(this.talkMc);
         MovieClipUtil.playMc(this.talkMc,1,this.talkMc.totalFrames,function():void
         {
            (SceneManager.active as LobbyScene).hideToolbar();
            NpcDialog.show(149,"小时候的S",[[0,"唧唧歪歪！婆婆妈妈！你是谁啊你！"]],["这是S？小时候？"],[function():void
            {
               (SceneManager.active as LobbyScene).hideToolbar();
               NpcDialog.show(149,"小时候的S",[[0,"你一定也跟他们一样看不起我和妈妈！我要让你们尝尝我的厉害！"]],["什么嘛！"],[function():void
               {
                  (SceneManager.active as LobbyScene).hideToolbar();
                  DisplayUtil.removeForParent(talkMc);
                  fulaMc = _processor.resLib.getMovieClip("fulaMc");
                  _map.content.addChild(fulaMc);
                  resultMc = _processor.resLib.getMovieClip("resultMc");
                  resultMc.stop();
                  MovieClipUtil.playMc(fulaMc,1,fulaMc.totalFrames,function():void
                  {
                     fulaMc.gotoAndStop(fulaMc.totalFrames);
                     _map.front.addChild(resultMc);
                     MovieClipUtil.playMc(resultMc,1,67,function():void
                     {
                        fulaMc.addEventListener(MouseEvent.CLICK,findFula);
                        NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"……我要怎么办？定下心来看一看……"]],["一定可以的！"],[function():void
                        {
                           (SceneManager.active as LobbyScene).hideToolbar();
                           DisplayObjectUtil.removeFromParent(resultMc);
                        }]);
                     });
                  });
               }]);
            }]);
         },true);
      }
      
      private function findFula(param1:MouseEvent) : void
      {
         var target:MovieClip = null;
         var vanishMc:MovieClip = null;
         var event:MouseEvent = param1;
         target = event.target as MovieClip;
         if(!target)
         {
            return;
         }
         if(target.name == "exact")
         {
            _map.front.addChild(this.resultMc);
            DisplayObjectUtil.removeFromParent(this.fulaMc);
            MovieClipUtil.playMc(this.resultMc,68,this.resultMc.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(resultMc);
               NpcDialog.show(149,"小时候的S",[[0,"下一个梦！你不会这么容易通过的！你将永远被困在这里！"]],["到底是谁！"],[function():void
               {
                  (SceneManager.active as LobbyScene).hideToolbar();
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteStep1);
                  QuestManager.completeStep(_quest.id,1);
               }]);
            },true);
         }
         else
         {
            vanishMc = _processor.resLib.getMovieClip("Vanish");
            vanishMc.stop();
            vanishMc.x = target.x;
            vanishMc.y = target.y;
            DisplayObjectUtil.removeFromParent(target);
            this.fulaMc.addChild(vanishMc);
            MovieClipUtil.playMc(vanishMc,1,vanishMc.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(vanishMc);
            });
            NpcDialog.show(149,"小时候的S",[[0,"嘻嘻嘻！有个精灵已经从这个世界上消失咯！因为你！"]],["我一定能找到！"],[function():void
            {
               (SceneManager.active as LobbyScene).hideToolbar();
            }]);
         }
      }
      
      private function onCompleteStep1(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
            this.initStep2();
         }
      }
      
      private function initStep2() : void
      {
         showStone();
      }
      
      override protected function clickStone(param1:MouseEvent) : void
      {
         stoneMc.removeEventListener(MouseEvent.CLICK,this.clickStone);
         ModuleManager.toggleModule(URLUtil.getAppModule("StonePanel"),"打开中...",{
            "toHome":true,
            "completeQuestId":10115,
            "completeStep":2
         });
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteStep1);
         super.processMapDispose();
      }
   }
}
