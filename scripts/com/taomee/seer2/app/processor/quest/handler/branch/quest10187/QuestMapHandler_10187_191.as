package com.taomee.seer2.app.processor.quest.handler.branch.quest10187
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10187_191 extends QuestMapHandler
   {
       
      
      private var _markMc:MouseClickHintSprite;
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      public function QuestMapHandler_10187_191(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this.playMovieForReview();
         }
      }
      
      private function playMovieForReview() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10187_0"),function():void
         {
            _mc_0 = _processor.resLib.getMovieClip("mc_0");
            _map.content.addChild(_mc_0);
            _mc_0.buttonMode = true;
            _mc_0.addEventListener(MouseEvent.CLICK,onSTalk);
         },true,false,2);
      }
      
      private function onSTalk(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(192,"S",[[0,"爸到底会在哪里？半个星球都被我翻遍了，一点线索都没有！"]],["S别着急……"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"听！好像那边有人窃窃私语……"]],["哪里？"],[function():void
            {
               _mc_0.buttonMode = false;
               _mc_0.removeEventListener(MouseEvent.CLICK,onSTalk);
               playTalkMovie();
            }]);
         }]);
      }
      
      private function playTalkMovie() : void
      {
         this._mc_1 = _processor.resLib.getMovieClip("mc_1");
         _map.front.addChild(this._mc_1);
         setTimeout(function():void
         {
            _markMc = new MouseClickHintSprite();
            _map.front.addChild(_markMc);
            _markMc.x = 721;
            _markMc.y = 134;
            _mc_1.buttonMode = true;
            _mc_1.addEventListener(MouseEvent.CLICK,onPlayTalk);
         },2000);
      }
      
      private function onPlayTalk(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         DisplayObjectUtil.removeFromParent(this._markMc);
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10187_1"),function():void
         {
            NpcDialog.show(192,"S",[[0,"我有预感，那地方一定和萨伦有关！或许有我爸爸的线索！"]],["我和你一起去！"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
               QuestManager.accept(_quest.id);
            }]);
         },true,false,2);
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         SceneManager.changeScene(SceneType.LOBBY,2);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
      }
   }
}
