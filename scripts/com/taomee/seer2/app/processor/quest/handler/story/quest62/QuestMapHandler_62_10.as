package com.taomee.seer2.app.processor.quest.handler.story.quest62
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_62_10 extends QuestMapHandler
   {
      
      private static var _flag1:int;
      
      private static var _flag2:int;
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _shep:Vector.<MovieClip>;
      
      private var _fightStatus:Boolean;
      
      private var _index:Vector.<int>;
      
      private var _totalNum:int;
      
      public function QuestMapHandler_62_10(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.addAlarm();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep1);
         }
         ServerBufferManager.getServerBuffer(ServerBufferType.LEIYI_CENTURY_FIGHT,function(param1:ServerBuffer):void
         {
            _flag1 = param1.readDataAtPostion(9);
            if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false && _flag1 == 1)
            {
               nextStep();
            }
         });
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               this._fightStatus = false;
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  this.win();
               }
               else
               {
                  this.noWin();
               }
               return;
            }
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep2);
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.addMother();
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "62_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
            QuestManager.accept(_quest.id);
         }
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         this.addAlarm();
      }
      
      private function addAlarm() : void
      {
         this.onClickAlarmHandler(null);
      }
      
      private function onClickAlarmHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("62_0"),function():void
         {
            NpcDialog.show(1,"辛迪船长",[[0,"S应该是冲着他的妈妈来的！对了赛尔！S的妈妈恢复得怎么样了？"]],["不是很好，还在昏迷中"],[function():void
            {
               NpcDialog.show(1,"辛迪船长",[[0,"我们要跟S把事情说清楚，在没有任何危险的情况下让S和他的妈妈见面。"]],["但是这需要一点时间"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("62_1"),function():void
                  {
                     if(_mc_0)
                     {
                        DisplayUtil.removeForParent(_mc_0);
                     }
                     _mc_0 = _processor.resLib.getMovieClip("talk");
                     _map.front.addChild(_mc_0);
                     MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1Handler);
                        QuestManager.completeStep(_quest.id,1);
                     },true);
                  },true,false,2);
               }]);
            }]);
         },true,false,2);
      }
      
      private function onStep1Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Handler);
         ModuleManager.toggleModule(URLUtil.getAppModule("CallEveryOneHelpPanel"),"正在打开面板...");
      }
      
      private function onStep1(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "62_1")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("CallEveryOneHelpPanel"),"正在打开面板...");
         }
      }
      
      private function nextStep() : void
      {
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Handler);
         QuestManager.completeStep(_quest.id,2);
      }
      
      private function onStep2Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Handler);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep2);
      }
      
      private function onStep2(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep2);
         this._shep = new Vector.<MovieClip>([]);
         this._index = new Vector.<int>([]);
         if((event.content as DialogPanelEventData).params == "62_2")
         {
            if(this._mc_0)
            {
               DisplayUtil.removeForParent(this._mc_0);
            }
            this._mc_0 = _processor.resLib.getMovieClip("fight");
            _map.front.addChild(this._mc_0);
            MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
            {
               addSheps();
            },true);
         }
      }
      
      private function addSheps() : void
      {
         var _loc1_:MovieClip = null;
         this._shep.length = 0;
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("hit");
         _map.front.addChild(this._mc_0);
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = this._mc_0["shep" + _loc2_];
            _loc1_.gotoAndStop(1);
            _loc1_.buttonMode = true;
            _loc1_.addEventListener(MouseEvent.CLICK,this.onFightShepHandler);
            this._shep.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function onFightShepHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = this._shep.indexOf(param1.currentTarget as MovieClip);
         this._index.push(_loc2_);
         FightManager.startFightWithWild(211);
         this._fightStatus = true;
      }
      
      private function win() : void
      {
         var index:int = 0;
         _processor.hideMouseClickHint();
         ++this._totalNum;
         if(this._totalNum == 4)
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("62_3"),function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3Handler);
               QuestManager.completeStep(_quest.id,3);
            },true,false,2);
         }
         else
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("62_2"),function():void
            {
               addSheps();
               var _loc1_:int = 0;
               while(_loc1_ < _index.length)
               {
                  index = _index[_loc1_];
                  _mc_0["shep" + index].visible = false;
                  _loc1_++;
               }
            },true,false,2);
         }
      }
      
      private function noWin() : void
      {
         this.addSheps();
      }
      
      private function onStep3Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Handler);
         this.addMother();
         this.motherTalk();
      }
      
      private function addMother() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("ma");
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onClickMaHandler);
      }
      
      private function onClickMaHandler(param1:MouseEvent) : void
      {
         this.motherTalk();
      }
      
      private function motherTalk() : void
      {
         this._mc_1 = _processor.resLib.getMovieClip("talk5");
         _map.front.addChild(this._mc_1);
         MovieClipUtil.playMc(this._mc_1,1,this._mc_1.totalFrames,function():void
         {
            NpcDialog.show(1,"辛迪船长",[[0,"不好！s的妈妈还没有完全恢复过来，刚刚经过这么一折腾又晕倒了！"]],[],[function():void
            {
               NpcDialog.show(1,"辛迪船长",[[0,"为了s的妈妈现在我们只能先停止交战！快把s的妈妈送到医务室接受紧急治疗！"]],[],[function():void
               {
                  NpcDialog.show(1,"辛迪船长",[[0,"萨伦是S家族的仇人这个疑团相信只有等她醒过来才能够揭晓了！在她醒来之前，赛尔们保持警惕！暂时休战！"]],[],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.COMPLETE,onStep4Handler);
                     QuestManager.completeStep(_quest.id,4);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function onStep4Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep4Handler);
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Handler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Handler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Handler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep4Handler);
      }
   }
}
