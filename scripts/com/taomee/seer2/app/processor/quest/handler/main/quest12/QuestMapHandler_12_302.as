package com.taomee.seer2.app.processor.quest.handler.main.quest12
{
   import com.taomee.seer2.app.animationInteractive.DigStoneAnimation;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_12_302 extends QuestMapHandler
   {
       
      
      private var _digStone:DigStoneAnimation;
      
      private var _mc_2:MovieClip;
      
      private var _mc_4:MovieClip;
      
      public function QuestMapHandler_12_302(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         DialogPanel.addCloseEventListener(this.onShowAnimation);
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,4))
         {
            this._mc_4 = _processor.resLib.getMovieClip("mc_4");
            _map.front.addChild(this._mc_4);
         }
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var evt:DialogCloseEvent = param1;
         var params:String = evt.params;
         if(params == "12_2")
         {
            this._mc_2 = _processor.resLib.getMovieClip("mc_2");
            _map.front.addChild(this._mc_2);
            MovieClipUtil.playMc(this._mc_2,1,this._mc_2.totalFrames,function():void
            {
               NpcDialog.show(34,"麦铁",[[0,"想要知道也可以！但是你必须找出石头中的特殊宝石！有没有缘分就看你的了!"]],["我一会再来！我需要热身！","谁怕谁上吧！"],[function():void
               {
                  QuestManager.completeStep(_quest.id,2);
               },function():void
               {
                  QuestManager.completeStep(_quest.id,2);
                  addDigStone();
               }]);
            },true);
         }
         else if(params == "12_3")
         {
            this.addDigStone();
         }
         else if(params == "12_4")
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("12_1"),function():void
            {
               NpcDialog.show(34,"麦铁",[[0,"相信只有它才能帮助巴尔卡重拾信心！只要有一天他需要我，我麦铁糟老头就一定会出现！"]],["（快去残骸通道交给巴尔卡吧！）"],[function():void
               {
                  QuestManager.completeStep(_quest.id,4);
               }]);
            });
         }
      }
      
      private function addDigStone() : void
      {
         this._digStone = new DigStoneAnimation();
         this._digStone.setup("digStone",function(param1:Boolean):void
         {
            var isSuccess:Boolean = param1;
            if(isSuccess)
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("12_0"),function():void
               {
                  QuestManager.completeStep(_quest.id,3);
               });
            }
            else
            {
               NpcDialog.show(34,"麦铁",[[0,"怎样？放弃了吗？现在的年轻人真缺少一种坚忍不拔的精神！哎！"]],["我一会还会来！","我又没说要放弃！继续！"],[null,function():void
               {
                  addDigStone();
               }]);
            }
         });
      }
      
      private function removeDigStone() : void
      {
         if(this._digStone)
         {
            this._digStone.dispose();
            this._digStone = null;
         }
      }
      
      override public function processMapDispose() : void
      {
         this.removeDigStone();
         if(this._mc_2)
         {
            DisplayObjectUtil.removeFromParent(this._mc_2);
         }
         if(this._mc_4)
         {
            DisplayObjectUtil.removeFromParent(this._mc_4);
         }
      }
   }
}
