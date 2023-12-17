package com.taomee.seer2.app.processor.quest.handler.story.quest16
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_16_330 extends QuestMapHandler
   {
       
      
      private var _mc_3:MovieClip;
      
      private var _mc_5:MovieClip;
      
      public function QuestMapHandler_16_330(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.showAnimation();
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isComplete(_quest.id) == false)
         {
            this.addMouseClickHint();
         }
         if(QuestManager.isStepComplete(_quest.id,4) && QuestManager.isStepComplete(_quest.id,5) == false)
         {
            this.showMC5();
         }
      }
      
      private function showAnimation() : void
      {
         this._mc_3 = _processor.resLib.getMovieClip("mc_3");
         _map.front.addChild(this._mc_3);
         MovieClipUtil.playMc(this._mc_3,1,this._mc_3.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_mc_3);
            _mc_3 = null;
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onQuestStep);
            QuestManager.completeStep(_quest.id,3);
         },true);
      }
      
      private function onQuestStep(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onQuestStep);
         this.addMouseClickHint();
      }
      
      private function addMouseClickHint() : void
      {
         if(QuestManager.isStepComplete(_quest.id,3) && !QuestManager.isCompletable(_quest.id))
         {
            _processor.showMouseHintAt(856,412);
         }
      }
      
      private function showMC5() : void
      {
         this._mc_5 = _processor.resLib.getMovieClip("mc_5");
         _map.front.addChild(this._mc_5);
         this._mc_5.buttonMode = true;
         this._mc_5.addEventListener(MouseEvent.CLICK,this.onClickMC5);
      }
      
      private function onClickMC5(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_5.removeEventListener(MouseEvent.CLICK,this.onClickMC5);
         NpcDialog.show(441,"阿布布",[[2,"暗大哥……还是算了吧，小弟，小弟还是躲回黑暗中去好了……"]],["终于被我抓住了！"],[function():void
         {
            NpcDialog.show(440,"暗伊特",[[3,"你可别和我那不成器的弟弟伊特一样！浪费自己的一身才能，宁可躲在角落被人欺负！"]],["……请问……这位布条同学是……"],[function():void
            {
               NpcDialog.show(441,"阿布布",[[0,"我……我是阿布布……我和暗大哥，都是出生在那个实验室的……"]],["实验室，难道和伊特一样？"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("16_0"),function():void
                  {
                     NpcDialog.show(441,"阿布布",[[2,"直到有一天，暗大哥说要去找他的亲弟弟，离开了实验室……我就一路找到这里了……"]],["很感人……但你们一起捣蛋是不对的！"],[function():void
                     {
                        NpcDialog.show(440,"暗伊特",[[0,"嘻嘻，只要是有趣的事情，我暗伊特都不会放过！而且……只要我的宝贝弟弟还在这里……哼哼！阿布布，我们走，整蛊时间到了！"]],["情况越来越麻烦了……"],[function():void
                        {
                           DisplayUtil.removeForParent(_mc_5);
                           _mc_5 = null;
                           QuestManager.completeStep(_quest.id,5);
                        }]);
                     }]);
                  });
               }]);
            }]);
         }]);
      }
      
      override public function processMapDispose() : void
      {
         _processor.hideMouseClickHint();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onQuestStep);
         DisplayUtil.removeForParent(this._mc_3);
         this._mc_3 = null;
         DisplayUtil.removeForParent(this._mc_5);
         this._mc_5 = null;
      }
   }
}
