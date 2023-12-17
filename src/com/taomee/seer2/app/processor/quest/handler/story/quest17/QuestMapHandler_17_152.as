package com.taomee.seer2.app.processor.quest.handler.story.quest17
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.gameRule.fish.FishEventDispatcher;
   import com.taomee.seer2.app.gameRule.fish.FishingEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_17_152 extends QuestMapHandler
   {
       
      
      private var _mc_1:MovieClip;
      
      public function QuestMapHandler_17_152(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.onAnimation();
         }
      }
      
      private function onAnimation() : void
      {
         FishEventDispatcher.getInstance().addEventListener(FishingEvent.FISHING,this.onFishing);
      }
      
      private function onFishing(param1:FishingEvent) : void
      {
         var event:FishingEvent = param1;
         if(event.itemId == 400806)
         {
            return;
         }
         FishEventDispatcher.getInstance().removeEventListener(FishingEvent.FISHING,this.onFishing);
         ModuleManager.toggleModule(URLUtil.getAppModule("FishPanel"),"正在打开钓鱼面板...");
         NpcDialog.show(11,"多罗",[[1,"哦呵呵呵！亮晶晶第七小队头号钓鱼大师我，多罗！！有我在，就不怕钓不到鱼！"]],["（你只说了几句“队长加油”而已）"],[function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("17_0"),function():void
            {
               _mc_1 = _processor.resLib.getMovieClip("mc_1");
               _map.front.addChild(_mc_1);
               MovieClipUtil.playMc(_mc_1,1,_mc_1.totalFrames,function():void
               {
                  NpcDialog.show(11,"多罗",[[4,"谁！谁抢了我的鱼！谁抢走了我的劳动成果！"]],["……（默默捡起地上的信封）"],[function():void
                  {
                     DisplayUtil.removeForParent(_mc_1);
                     _mc_1 = null;
                     NpcDialog.show(11,"多罗",[[4,"这是什么……？哇！好冷，上面都是雪花儿！队长，这种情况下，我们还是不要追究了，先告诉舒尔现在的情况吧！"]],["怎么会有雪花儿呢？"],[function():void
                     {
                        NpcDialog.show(10,"巴蒂",[[0,"队长，这封信看起来不一般，我有一种不好的预感……我们还是先回去吧。"]],["巴蒂都这么说？那我们还是回七味小屋吧"],[function():void
                        {
                           QuestManager.completeStep(_quest.id,1);
                        }]);
                     }]);
                  }]);
               },true);
            });
         }]);
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._mc_1);
         this._mc_1 = null;
         FishEventDispatcher.getInstance().removeEventListener(FishingEvent.FISHING,this.onFishing);
      }
   }
}
