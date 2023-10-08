package com.taomee.seer2.app.processor.quest.handler.main.quest12
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_12_192 extends QuestMapHandler
   {
       
      
      private var _mc_1:MovieClip;
      
      public function QuestMapHandler_12_192(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(_quest.id))
         {
            this._mc_1 = _processor.resLib.getMovieClip("mc_1");
            _map.front.addChild(this._mc_1);
            MovieClipUtil.playMc(this._mc_1,1,this._mc_1.totalFrames,null,true);
         }
         DialogPanel.addCloseEventListener(this.onShowAnimation);
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var evt:DialogCloseEvent = param1;
         var params:String = evt.params;
         if(params == "12_5")
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("12_0"),4,[[1,0]],function():void
            {
               QuestManager.completeStep(_quest.id,5);
            });
         }
         else if(params == "12_0")
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[2,"啊切……当我们傻的啊？！我就不信调查不出你了！第七小分队！走！去火幻氏族！"]],["我就不信有什么能难倒我！"],[function():void
            {
               NpcDialog.show(31,"巴尔卡",[[2,"你们爱去不去！当心那个洛克就是了……"]],["（前往火幻氏族）"],[function():void
               {
                  QuestManager.accept(_quest.id);
               }]);
            }]);
         }
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
         DisplayObjectUtil.removeFromParent(this._mc_1);
      }
   }
}
