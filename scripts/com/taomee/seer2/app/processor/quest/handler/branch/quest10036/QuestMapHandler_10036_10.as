package com.taomee.seer2.app.processor.quest.handler.branch.quest10036
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10036_10 extends QuestMapHandler
   {
       
      
      private var _npc:MovieClip;
      
      public function QuestMapHandler_10036_10(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.initNpc();
         }
      }
      
      private function initNpc() : void
      {
         if(QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this._npc = _processor.resLib.getMovieClip("npc");
            this._npc.gotoAndStop(1);
         }
         else if(QuestManager.isStepComplete(_quest.id,2))
         {
            this._npc = _processor.resLib.getMovieClip("npc2");
         }
         else
         {
            this._npc = _processor.resLib.getMovieClip("npc");
            this._npc.gotoAndStop(2);
         }
         _map.front.addChild(this._npc);
         this._npc.x = 772;
         this._npc.y = 369;
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(QuestManager.isStepComplete(_quest.id,1) == false)
         {
            NpcDialog.show(9,"卫兵",[[0,"维持船舱的治安这个是我的职责！圣诞节了！我怕萨伦帝国的家伙们虎视眈眈！我需要多巡逻几次！"]],["（前往船舱各个场景巡逻）"],[function():void
            {
               QuestManager.completeStep(_quest.id,1);
               _npc.gotoAndStop(2);
            }]);
         }
         else if(QuestManager.isStepComplete(_quest.id,2))
         {
            NpcDialog.show(9,"卫兵",[[0,"希望一切都能顺利！这就是我圣诞节的愿望……"]],["忠于职守的卫兵叔叔！敬礼！"],[function():void
            {
               QuestManager.completeStep(_quest.id,3);
               DisplayUtil.removeForParent(_npc);
            }]);
         }
         else
         {
            NpcDialog.show(9,"卫兵",[[0,"维持船舱的治安这个是我的职责！圣诞节了！我怕萨伦帝国的家伙们虎视眈眈！我需要多巡逻几次！"]],["（前往船舱各个场景巡逻）"]);
         }
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._npc);
         this._npc = null;
      }
   }
}
