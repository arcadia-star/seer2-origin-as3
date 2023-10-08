package com.taomee.seer2.app.processor.quest.handler.branch.quest10196
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10196_1071 extends QuestMapHandler
   {
       
      
      private var _npc:MovieClip;
      
      public function QuestMapHandler_10196_1071(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isComplete(_quest.id))
         {
            this.showNpc();
         }
      }
      
      private function showNpc() : void
      {
         this._npc = _processor.resLib.getMovieClip("npc");
         _map.content.addChild(this._npc);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpcTalkHandler);
      }
      
      private function onNpcTalkHandler(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.LOBBY,80030);
      }
      
      override public function processMapDispose() : void
      {
         if(this._npc)
         {
            DisplayUtil.removeForParent(this._npc);
         }
      }
   }
}
