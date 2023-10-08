package com.taomee.seer2.app.processor.quest.handler.branch.quest10137
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
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10137_320 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      public function QuestMapHandler_10137_320(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,6) && QuestManager.isStepComplete(_quest.id,7) == false)
         {
            this.addLande();
         }
      }
      
      private function addLande() : void
      {
         _processor.showMouseHintAt(568,302);
         this._mc_0 = _processor.resLib.getMovieClip("lande");
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onPlayFullHandler);
      }
      
      private function onPlayFullHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10137_2"),function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"兰德终于知道自己人生前进的方向！搞定！三个许愿瓶都完工咯~ "]],["我这就去找瑞瑞克"],[function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep7Handler);
               QuestManager.completeStep(_quest.id,7);
            }]);
         },true,false,2);
      }
      
      private function onStep7Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep7Handler);
         SceneManager.changeScene(SceneType.LOBBY,152);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep7Handler);
      }
   }
}
