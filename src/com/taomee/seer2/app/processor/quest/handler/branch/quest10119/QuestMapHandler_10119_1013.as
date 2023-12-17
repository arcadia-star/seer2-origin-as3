package com.taomee.seer2.app.processor.quest.handler.branch.quest10119
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.processor.quest.handler.branch.quest10118.QuestMapHandler_10118_1012;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class QuestMapHandler_10119_1013 extends QuestMapHandler
   {
       
      
      private var _questUi:MovieClip;
      
      private var _ballClickCount:int = 0;
      
      private var _progressBar:MovieClip;
      
      private var _timer:Timer;
      
      private var _stoneMc:MovieClip;
      
      public function QuestMapHandler_10119_1013(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isComplete(_quest.id))
         {
            this.initUI();
            this.startTalk();
         }
      }
      
      private function startTalk() : void
      {
         NpcDialog.show(NpcUtil.getSeerNpcId(),"赛尔",[[0,"我怎么突然到信奉广场了，而且这里的颜色变得好昏暗啊！诡异！诡异呀！！"]],["......"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"赛尔",[[0,"哇！还有发光的球体！是些什么东西呢？"]],["（点击场景中3个发亮的光球）"],[function():void
            {
               QuestMapHandler_10118_1012.hideToolBar();
            }]);
         }]);
      }
      
      private function initUI() : void
      {
         this._questUi = _processor.resLib.getMovieClip("QuestUI_10119");
         this._questUi["petking"].visible = false;
         this._questUi["petking"].addEventListener(MouseEvent.CLICK,this.unlockPetKing);
         this._questUi["b1"].addEventListener(MouseEvent.CLICK,this.ballStartMove);
         this._questUi["b2"].addEventListener(MouseEvent.CLICK,this.ballStartMove);
         this._questUi["b3"].addEventListener(MouseEvent.CLICK,this.ballStartMove);
         this._questUi["petking"].buttonMode = true;
         this._questUi["b1"].buttonMode = true;
         this._questUi["b2"].buttonMode = true;
         this._questUi["b3"].buttonMode = true;
         this._progressBar = this._questUi["petking"]["progressbar"] as MovieClip;
         if(null == this._timer)
         {
            this._timer = new Timer(800);
            this._timer.addEventListener(TimerEvent.TIMER,this.changeProgressBaseState);
         }
         LayerManager.uiLayer.addChild(this._questUi);
      }
      
      private function changeProgressBaseState(param1:TimerEvent) : void
      {
         this._progressBar.nextFrame();
      }
      
      private function ballStartMove(param1:MouseEvent) : void
      {
         var mc:MovieClip = null;
         var event:MouseEvent = param1;
         mc = event.currentTarget as MovieClip;
         mc.removeEventListener(MouseEvent.CLICK,this.ballStartMove);
         ++this._ballClickCount;
         if(3 == this._ballClickCount)
         {
            mc.addFrameScript(mc.totalFrames - 1,function():void
            {
               DisplayObjectUtil.removeFromParent(_questUi["b1"]);
               DisplayObjectUtil.removeFromParent(_questUi["b2"]);
               DisplayObjectUtil.removeFromParent(_questUi["b3"]);
               mc.stop();
               _questUi["petking"].visible = true;
               startTalkII();
            });
         }
         mc.gotoAndPlay(2);
      }
      
      private function startTalkII() : void
      {
         NpcDialog.show(NpcUtil.getSeerNpcId(),"赛尔",[[0,"三个光球竟然合为一体变成目灵兽石像！这太不可思议了！"]],["......"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"赛尔",[[0,"而且目灵兽和这条锁链都在震动，它们似乎正互相对抗呢！"]],["我把锁链解开，看看会发生什么！"],[function():void
            {
               QuestMapHandler_10118_1012.hideToolBar();
               _progressBar.gotoAndStop(_progressBar.totalFrames);
               _timer.start();
            }]);
         }]);
      }
      
      private function unlockPetKing(param1:MouseEvent) : void
      {
         this._progressBar.prevFrame();
         if(this._progressBar.currentFrame == 1)
         {
            this._timer.stop();
            this.playFullMovie();
         }
      }
      
      private function playFullMovie() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getRes("/active/fullScreen/10119_2.swf"),function():void
         {
            DisplayObjectUtil.removeFromParent(_questUi);
            showStone();
         });
      }
      
      protected function showStone() : void
      {
         this._stoneMc = _processor.resLib.getMovieClip("stoneMc");
         this._stoneMc.buttonMode = true;
         _map.front.addChild(this._stoneMc);
         MovieClipUtil.playMc(this._stoneMc,1,this._stoneMc.totalFrames,function():void
         {
            _stoneMc.gotoAndStop(_stoneMc.totalFrames);
            _stoneMc.addEventListener(MouseEvent.CLICK,clickStone);
         },true);
      }
      
      protected function clickStone(param1:MouseEvent) : void
      {
         this._stoneMc.removeEventListener(MouseEvent.CLICK,this.clickStone);
         ModuleManager.toggleModule(URLUtil.getAppModule("StonePanel"),"打开中...",{
            "toHome":true,
            "completeQuestId":10119,
            "completeStep":1
         });
      }
      
      override public function processMapDispose() : void
      {
         DisplayObjectUtil.removeFromParent(this._questUi);
         this._questUi = null;
         this._progressBar = null;
      }
   }
}
