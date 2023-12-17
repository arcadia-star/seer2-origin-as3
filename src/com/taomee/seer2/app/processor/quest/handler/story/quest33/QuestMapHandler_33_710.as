package com.taomee.seer2.app.processor.quest.handler.story.quest33
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_33_710 extends QuestMapHandler
   {
       
      
      private var _mc:MovieClip;
      
      public function QuestMapHandler_33_710(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isComplete(_quest.id) == false)
         {
            this.questProcessor2();
         }
      }
      
      private function questProcessor2() : void
      {
         this._mc = _processor.resLib.getMovieClip("mc_3");
         _map.front.addChild(this._mc);
         this._mc.buttonMode = true;
         this._mc.addEventListener(MouseEvent.CLICK,this.onMc);
      }
      
      private function onMc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(463,"萨伯尔",[[0,"这……这是遗忘之岛的真实样貌吗？！！！"]],["怎么了那么惊慌失措？"],[function():void
         {
            NpcDialog.show(463,"萨伯尔",[[0,"数百年来，我族都没有登上过这座岛屿……随着时间流淌，几乎所有族人都将这里遗忘了。"]],["明明是你们的地盘，怎么会遗忘呢……"],[function():void
            {
               NpcDialog.show(463,"萨伯尔",[[0,"我不能多说了。我要将这些情况汇报给兵团长。"]],["（遗忘之岛……究竟有什么秘密呢？）"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestComplete);
                  QuestManager.completeStep(_quest.id,2);
               }]);
            }]);
         }]);
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         DisplayUtil.removeForParent(this._mc);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         DisplayUtil.removeForParent(this._mc);
         this._mc = null;
      }
   }
}
