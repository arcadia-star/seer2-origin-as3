package com.taomee.seer2.app.processor.quest.handler.branch.quest10140
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10140_10106 extends QuestMapHandler
   {
       
      
      private var _mother:MovieClip;
      
      private var _s_mc:MovieClip;
      
      private var _talk1:MovieClip;
      
      private var _game:com.taomee.seer2.app.processor.quest.handler.branch.quest10140.Game10140;
      
      public function QuestMapHandler_10140_10106(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this.addMother();
            this.addTalk();
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.addMotherAgain();
         }
      }
      
      private function addMother() : void
      {
         this._mother = _processor.resLib.getMovieClip("ma");
         _map.content.addChild(this._mother);
         this.addS();
      }
      
      private function addS() : void
      {
         this._s_mc = _processor.resLib.getMovieClip("s");
         _map.content.addChild(this._s_mc);
      }
      
      private function addTalk() : void
      {
         this._talk1 = _processor.resLib.getMovieClip("talk1");
         LayerManager.topLayer.addChild(this._talk1);
         MovieClipUtil.playMc(this._talk1,1,this._talk1.totalFrames,function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10140_0"),function():void
            {
               _game = new com.taomee.seer2.app.processor.quest.handler.branch.quest10140.Game10140(_processor.resLib.getMovieClip("game10140"),gameComplete);
            },true,false,2);
         },true);
      }
      
      private function gameComplete() : void
      {
         QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAcceptComplete);
         QuestManager.accept(_quest.id);
      }
      
      private function onAcceptComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptComplete);
         this.addMotherAgain();
      }
      
      private function addMotherAgain() : void
      {
         if(this._mother)
         {
            DisplayUtil.removeForParent(this._mother);
         }
         this._mother = _processor.resLib.getMovieClip("ma1");
         _map.content.addChild(this._mother);
         this._mother.buttonMode = true;
         this._mother.addEventListener(MouseEvent.CLICK,this.onMotherTalkHandler);
         this.addS();
      }
      
      private function onMotherTalkHandler(param1:MouseEvent) : void
      {
         this.MotherTalk();
      }
      
      private function MotherTalk() : void
      {
         NpcDialog.show(171,"S的妈妈",[[0,"你看到这个房间中的那个雕像了吗？这曾经是你爸爸使用的精灵，他怕精灵被坏人利用，就把它封存在石像里了。"]],["准备好了！来吧！"],[function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10140_1"),function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1Complete);
               QuestManager.completeStep(_quest.id,1);
            },true,false,2);
         }]);
      }
      
      private function onStep1Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
         SceneManager.changeScene(SceneType.LOBBY,1070);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mother)
         {
            DisplayUtil.removeForParent(this._mother);
         }
         if(this._s_mc)
         {
            DisplayUtil.removeForParent(this._s_mc);
         }
         if(this._talk1)
         {
            DisplayUtil.removeForParent(this._talk1);
         }
         if(this._game)
         {
            this._game.dispose();
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptComplete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
      }
   }
}
