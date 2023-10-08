package com.taomee.seer2.app.processor.quest.handler.main.quest11
{
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_11_211 extends QuestMapHandler
   {
       
      
      private var _npc_10_11:MovieClip;
      
      private var _blackAnimation:MovieClip;
      
      public function QuestMapHandler_11_211(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            this._npc_10_11 = _processor.resLib.getMovieClip("mc_1");
            this._npc_10_11.gotoAndStop(1);
            this._npc_10_11.x = -312;
            this._npc_10_11.y = -18.5;
            _map.front.addChild(this._npc_10_11);
            this.addBlackAnimation();
         }
      }
      
      private function addBlackAnimation() : void
      {
         this._blackAnimation = _processor.resLib.getMovieClip("mc_3");
         _map.front.addChild(this._blackAnimation);
         MovieClipUtil.playMc(this._blackAnimation,1,this._blackAnimation.totalFrames,function():void
         {
            _blackAnimation.stop();
            DisplayObjectUtil.removeFromParent(_blackAnimation);
            _npc_10_11.gotoAndStop(3);
            _npc_10_11.x = _npc_10_11.y = 0;
            _npc_10_11.addFrameScript(2,function():void
            {
               var mc:MovieClip;
               _npc_10_11.addFrameScript(2,null);
               mc = _npc_10_11["mc"] as MovieClip;
               MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
               {
                  DisplayObjectUtil.removeFromParent(_npc_10_11);
                  _npc_10_11 = null;
                  _processor.showMouseHintAt(887,370);
                  QuestManager.completeStep(_quest.id,2);
               });
            });
         },true);
      }
   }
}
