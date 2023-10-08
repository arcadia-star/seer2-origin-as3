package com.taomee.seer2.app.processor.quest.handler.branch.quest10031
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10031_550 extends QuestMapHandler
   {
       
      
      private var _npc:MovieClip;
      
      private var _npc2:MovieClip;
      
      public function QuestMapHandler_10031_550(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initNpc();
         }
      }
      
      private function initNpc() : void
      {
         this._npc = _processor.resLib.getMovieClip("npc");
         _map.front.addChild(this._npc);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(203,"霍克努尔",[[0,"哎呦我的霍克妈妈呀！这里怎么这么冷呀！一二三四！二二三四！三二三四！我要多动动暖和下身体！"]],["O(∩_∩)O做广播操吗？"],[function():void
         {
            DisplayUtil.removeForParent(_npc);
            _npc2 = _processor.resLib.getMovieClip("npc2");
            _map.front.addChild(_npc2);
            MovieClipUtil.playMc(_npc2,2,_npc2.totalFrames,function():void
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
               QuestManager.completeStep(_quest.id,1);
               DisplayUtil.removeForParent(_npc2);
            },true);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         if(QuestManager.isComplete(10028) && QuestManager.isComplete(10029) && QuestManager.isComplete(10030) && QuestManager.isComplete(10031))
         {
            QuestManager.accept(10032);
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         DisplayUtil.removeForParent(this._npc);
         this._npc = null;
         DisplayUtil.removeForParent(this._npc2);
         this._npc2 = null;
      }
   }
}
