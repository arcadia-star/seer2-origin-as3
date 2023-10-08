package com.taomee.seer2.app.processor.quest.handler.branch.quest10033
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10033_350 extends QuestMapHandler
   {
       
      
      private var _npc:MovieClip;
      
      public function QuestMapHandler_10033_350(param1:QuestProcessor)
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
         this._npc.x = 683;
         this._npc.y = 175;
         _map.front.addChild(this._npc);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(207,"沙皇鸟",[[0,"兄弟！还记得这里嘛？"]],["（我只看看不说话）"],[function():void
         {
            NpcDialog.show(206,"巨锤莫古",[[0,"这可能是我一辈子都难以忘怀的地方吧……"]],["（我只看看不说话）"],[function():void
            {
               NpcDialog.show(207,"沙皇鸟",[[0,"命运是掌握在自己手上的！"]],["（我只看看不说话）"],[function():void
               {
                  NpcDialog.show(206,"巨锤莫古",[[0,"每天能够看到阳光、每天都活着！这就是幸福！"]],["（我只看看不说话）"],[function():void
                  {
                     QuestManager.completeStep(_quest.id,1);
                     DisplayUtil.removeForParent(_npc);
                  }]);
               }]);
            }]);
         }]);
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._npc);
      }
   }
}
