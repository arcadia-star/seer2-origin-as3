package com.taomee.seer2.app.processor.quest.handler.story.quest33
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_33_500 extends QuestMapHandler
   {
       
      
      private var _mc:MovieClip;
      
      public function QuestMapHandler_33_500(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.questProcessor2();
         }
      }
      
      private function questProcessor2() : void
      {
         this._mc = _processor.resLib.getMovieClip("mc_2");
         _map.front.addChild(this._mc);
         this._mc.buttonMode = true;
         this._mc.addEventListener(MouseEvent.CLICK,this.onMc);
      }
      
      private function onMc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(NpcUtil.getSeerNpcId(),ActorManager.actorInfo.nick,[[0,"应该就是这把钥匙了，这中间究竟有什么秘密呢？返回时镜之岛问问萨伯尔吧！"]],["（现在就去时镜之岛）"],[function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,700);
         }]);
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._mc);
         this._mc = null;
      }
   }
}
