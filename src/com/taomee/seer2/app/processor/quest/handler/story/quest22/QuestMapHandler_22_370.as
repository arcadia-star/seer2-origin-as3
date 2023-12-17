package com.taomee.seer2.app.processor.quest.handler.story.quest22
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_22_370 extends QuestMapHandler
   {
       
      
      private var _mc_7:MovieClip;
      
      private var _mc_8:MovieClip;
      
      public function QuestMapHandler_22_370(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.initQuest4();
         }
      }
      
      private function initQuest4() : void
      {
         this._mc_7 = _processor.resLib.getMovieClip("mc_7");
         _map.front.addChild(this._mc_7);
         this._mc_7.buttonMode = true;
         this._mc_7.addEventListener(MouseEvent.CLICK,this.onMC5Click);
         this._mc_8 = _processor.resLib.getMovieClip("mc_8");
         _map.front.addChild(this._mc_8);
         this._mc_8.gotoAndStop(1);
      }
      
      private function onMC5Click(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_7.removeEventListener(MouseEvent.CLICK,this.onMC5Click);
         NpcDialog.show(52,"蒂萨特",[[1,"哇……好漂亮哦……这个地方，我以前都没有来过呢……真的是神鸟的感觉呢……"]],["看看写的什么？"],[function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("22_3"),1,[[1,0]],function():void
            {
               NpcDialog.show(52,"蒂萨特",[[0,"和之前的风格不一样……兰德德肯定在沙之迷穴……可是为什么要我们不要去？"]],["（我有不好的预感）"],[function():void
               {
                  NpcDialog.show(52,"蒂萨特",[[2,"兰德德……兰德德肯定有危险……我感觉很不好呀！我一定要去看一看……我们是，朋友啊！"]],["对，朋友！（去沙之迷穴！）"],[function():void
                  {
                     MovieClipUtil.playMc(_mc_8,2,_mc_8.totalFrames,function():void
                     {
                        QuestManager.completeStep(_quest.id,4);
                        _processor.showMouseHintAt(414,238);
                     },true);
                  }]);
               }]);
            });
         }]);
      }
      
      override public function processMapDispose() : void
      {
         _processor.hideMouseClickHint();
         DisplayUtil.removeForParent(this._mc_7);
         DisplayUtil.removeForParent(this._mc_8);
         this._mc_7 = null;
         this._mc_8 = null;
      }
   }
}
