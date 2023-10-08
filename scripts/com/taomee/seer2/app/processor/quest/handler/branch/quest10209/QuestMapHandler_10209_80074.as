package com.taomee.seer2.app.processor.quest.handler.branch.quest10209
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10209_80074 extends QuestMapHandler
   {
       
      
      private var _mc2:MovieClip;
      
      private var _mc2_2:MovieClip;
      
      private var _process:AcceptableMark;
      
      private var _quest10209Game1:com.taomee.seer2.app.processor.quest.handler.branch.quest10209.Quest10209Game1;
      
      private var _game1:MovieClip;
      
      public function QuestMapHandler_10209_80074(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(10209,1) && QuestManager.isStepComplete(10209,2) == false)
         {
            this.initQuest2();
         }
      }
      
      private function initQuest2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10209_2"),function():void
         {
            _mc2 = _processor.resLib.getMovieClip("mc2");
            _map.content.addChild(_mc2);
            _process = new AcceptableMark();
            _map.front.addChild(_process);
            _process.x = 584;
            _process.y = 365;
            _mc2_2 = _processor.resLib.getMovieClip("mc2_2");
            _map.content.addChild(_mc2_2);
            _mc2.buttonMode = true;
            _mc2.addEventListener(MouseEvent.CLICK,onMC2);
         },true,true,2);
      }
      
      private function yesFun() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10209_3"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(10209,2);
         },true,true,2);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.COPY,80075);
      }
      
      private function onMC2(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(10,"巴蒂",[[0,"这个是什么呀？会不会是小当家留下的线索呢？"]],["快去看看吧！"],[function():void
         {
            NpcDialog.show(11,"多罗",[[0,"咦！这不是冰沁宫殿的照片吗？"]],["是的！"],[function():void
            {
               NpcDialog.show(10,"巴蒂",[[0,"但是总感觉好像哪里有些不一样，赶快找找吧！"]],["好！"],[function():void
               {
                  _game1 = _processor.resLib.getMovieClip("game1");
                  LayerManager.topLayer.addChild(_game1);
                  _quest10209Game1 = new com.taomee.seer2.app.processor.quest.handler.branch.quest10209.Quest10209Game1(_game1,yesFun);
               }]);
            }]);
         }]);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         DisplayUtil.removeForParent(this._process);
         if(this._mc2)
         {
            this._mc2.removeEventListener(MouseEvent.CLICK,this.onMC2);
         }
         DisplayUtil.removeForParent(this._mc2_2);
         DisplayUtil.removeForParent(this._mc2);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
   }
}
