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
   
   public class QuestMapHandler_22_360 extends QuestMapHandler
   {
       
      
      private var _mc_5:MovieClip;
      
      private var _mc_6:MovieClip;
      
      public function QuestMapHandler_22_360(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.initQuest3();
         }
      }
      
      private function initQuest3() : void
      {
         this._mc_5 = _processor.resLib.getMovieClip("mc_5");
         _map.front.addChild(this._mc_5);
         this._mc_5.buttonMode = true;
         this._mc_5.addEventListener(MouseEvent.CLICK,this.onMC5Click);
         this._mc_6 = _processor.resLib.getMovieClip("mc_6");
         _map.front.addChild(this._mc_6);
         this._mc_6.gotoAndStop(1);
         this._mc_6.buttonMode = true;
         this._mc_6.addEventListener(MouseEvent.CLICK,this.onQuest1);
      }
      
      private function onQuest1(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(52,"蒂萨特",[[2,"给你个提示留心场景中发亮的物体哦！"]],["谢谢！"],[function():void
         {
         }]);
      }
      
      private function onMC5Click(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_5.removeEventListener(MouseEvent.CLICK,this.onMC5Click);
         NpcDialog.show(52,"蒂萨特",[[1,"哈哈，它看起来真的在笑呢！真的是绿巨人先生……"]],["看看写的什么？"],[function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("22_2"),1,[[1,0]],function():void
            {
               NpcDialog.show(52,"蒂萨特",[[0,"神鸟……神鸟……这，我不知道呀……兰德德……是什么呀……"]],["如果神鸟是沙皇鸟，那就是海市蜃楼！"],[function():void
               {
                  NpcDialog.show(52,"蒂萨特",[[4,"哇！你真聪明！不过，天亮了，就是白天的意思吧？牢笼……牢笼……走！"]],["（在白天去海市蜃楼找找线索！）"],[function():void
                  {
                     MovieClipUtil.playMc(_mc_6,2,_mc_6.totalFrames,function():void
                     {
                        QuestManager.completeStep(_quest.id,3);
                        _processor.showMouseHintAt(-25,400);
                     },true);
                  }]);
               }]);
            });
         }]);
      }
      
      override public function processMapDispose() : void
      {
         _processor.hideMouseClickHint();
         DisplayUtil.removeForParent(this._mc_5);
         DisplayUtil.removeForParent(this._mc_6);
         this._mc_5 = null;
         this._mc_6 = null;
      }
   }
}
