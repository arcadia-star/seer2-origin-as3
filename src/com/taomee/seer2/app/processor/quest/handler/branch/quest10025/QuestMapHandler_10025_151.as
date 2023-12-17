package com.taomee.seer2.app.processor.quest.handler.branch.quest10025
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10025_151 extends QuestMapHandler
   {
       
      
      private var _npc:MovieClip;
      
      private var _npc2:MovieClip;
      
      private var _hor:SimpleButton;
      
      public function QuestMapHandler_10025_151(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initNpc();
            this.initHor();
         }
      }
      
      private function initNpc() : void
      {
         this._npc = _processor.resLib.getMovieClip("npc");
         _map.front.addChild(this._npc);
         this._npc.play();
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function initHor() : void
      {
         this._hor = _map.content["hor"];
         this._hor.addEventListener(MouseEvent.CLICK,this.onHor);
      }
      
      private function onHor(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(QuestManager.isComplete(_quest.id))
         {
            return;
         }
         this._hor.removeEventListener(MouseEvent.CLICK,this.onHor);
         DisplayUtil.removeForParent(this._npc);
         this._npc2 = _processor.resLib.getMovieClip("npc2");
         _map.front.addChild(this._npc2);
         MovieClipUtil.playMc(this._npc2,2,this._npc2.totalFrames,function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
            QuestManager.completeStep(_quest.id,1);
         },true);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         NpcDialog.show(409,"晓晓",[[0,"听说这里的花都很靓哟！最适合配我最最最最靓的月月了！可是鲜花在哪里呢？"]],["（注意看看周围吧）"]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         if(QuestManager.isComplete(10024) && QuestManager.isComplete(10025) && QuestManager.isComplete(10026))
         {
            QuestManager.accept(10027);
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         DisplayUtil.removeForParent(this._npc);
         DisplayUtil.removeForParent(this._npc2);
         this._npc = null;
         this._npc2 = null;
      }
   }
}
