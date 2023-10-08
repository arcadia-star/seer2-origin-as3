package com.taomee.seer2.app.processor.quest.handler.activity.quest30039
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30039_620 extends QuestMapHandler
   {
       
      
      private var _hat:MovieClip;
      
      private var _feet:MovieClip;
      
      public function QuestMapHandler_30039_620(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.initHatMc();
         }
      }
      
      private function initHatMc() : void
      {
         this._hat = _processor.resLib.getMovieClip("hat");
         _map.content.addChild(this._hat);
         _processor.showMouseHintAt(439,409);
         this._hat.buttonMode = true;
         this._hat.addEventListener(MouseEvent.CLICK,this.onMySelfTalkHandler);
      }
      
      private function onMySelfTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._hat)
         {
            DisplayUtil.removeForParent(this._hat);
         }
         _processor.hideMouseClickHint();
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"这个看起来好像是皮皮格的帽子怎么会掉在这里呢？"]],[],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"再看看前面有什么线索吧！"]],[],[function():void
            {
               var foot:* = undefined;
               foot = _processor.resLib.getMovieClip("feet");
               _map.content.addChild(foot);
               MovieClipUtil.playMc(foot,1,foot.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(foot);
                  _feet = _processor.resLib.getMovieClip("feets");
                  _map.content.addChild(_feet);
                  _processor.showMouseHintAt(305,414);
                  _feet.buttonMode = true;
                  _feet.addEventListener(MouseEvent.CLICK,onSeeTalkHandler);
               },true);
            }]);
         }]);
      }
      
      private function onSeeTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._feet)
         {
            DisplayUtil.removeForParent(this._feet);
         }
         _processor.hideMouseClickHint();
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"看来狼妖一定就在前面！"]],[],[function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3CompleteHandler);
            QuestManager.completeStep(_quest.id,3);
         }]);
      }
      
      private function onStep3CompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3CompleteHandler);
         SceneManager.changeScene(SceneType.LOBBY,640);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this._hat)
         {
            DisplayUtil.removeForParent(this._hat);
         }
         if(this._feet)
         {
            DisplayUtil.removeForParent(this._feet);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3CompleteHandler);
      }
   }
}
