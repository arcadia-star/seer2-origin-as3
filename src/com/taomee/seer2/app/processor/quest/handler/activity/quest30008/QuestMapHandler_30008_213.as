package com.taomee.seer2.app.processor.quest.handler.activity.quest30008
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30008_213 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _currCount:uint;
      
      private var _mobile:Mobile;
      
      private var _mineAnimation:MovieClip;
      
      public function QuestMapHandler_30008_213(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         }
         if(QuestManager.isStepComplete(_quest.id,2) && !QuestManager.isStepComplete(_quest.id,3))
         {
            this.processor2();
         }
         if(QuestManager.isStepComplete(_quest.id,3) && !QuestManager.isStepComplete(_quest.id,4))
         {
            this.processor3();
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         if(_quest.id == param1.questId && param1.stepId == 2)
         {
            this.processor2();
         }
         if(_quest.id == param1.questId && param1.stepId == 3)
         {
            this.processor3();
         }
      }
      
      private function processor2() : void
      {
         this._currCount = 0;
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         this._mc_0.buttonMode = true;
         _map.front.addChild(this._mc_0);
         TooltipManager.addCommonTip(this._mc_0,"青玉矿脉");
         _processor.showMouseHintAt(769,375);
         this._mineAnimation = UIManager.getMovieClip("UI_mineAnimation");
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         _map.front.addChild(this._mineAnimation);
         this._mineAnimation.x = 769;
         this._mineAnimation.y = 375;
         MovieClipUtil.playMc(this._mineAnimation,1,this._mineAnimation.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_mineAnimation);
            ++_currCount;
            if(_currCount == 1)
            {
               _processor.hideMouseClickHint();
               ServerMessager.addMessage("已经采集到" + _currCount + "个青玉石，还需要采集" + (3 - _currCount) + "个青玉石");
            }
            if(_currCount == 2)
            {
               ServerMessager.addMessage("已经采集到" + _currCount + "个青玉石，还需要采集" + (3 - _currCount) + "个青玉石");
            }
            if(_currCount == 3)
            {
               ServerMessager.addMessage("已经采集到3个青玉石啦，去交给占卜婆婆把！");
               _mc_0.removeEventListener(MouseEvent.CLICK,onClick);
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
               QuestManager.completeStep(_quest.id,3);
            }
         },true);
      }
      
      private function processor3() : void
      {
         DisplayUtil.removeForParent(this._mc_0);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "30008_1")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30008_1"),6,[[1,0]],function():void
            {
               NpcDialog.show(27,"占卜婆婆",[[0,"虽然我们只有一面之缘，但他强壮的体魄以及身体散发出的迷人香味，我永远都不会忘怀！"]],["……"],[function():void
               {
                  NpcDialog.show(27,"占卜婆婆",[[0,"为了更深入的了解救命恩人，这一年来我四处搜集有关他的资料。哈哈哈，今年6月我将迎接他的归来！"]],["哇！漂亮婆婆，把你知道的都告诉我吧。"],[function():void
                  {
                     NpcDialog.show(27,"占卜婆婆",[[0,"哎，年纪大了，容易疲劳啊！我好累，今天就说到这！你自己一边玩去吧。"]],["……"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30008_0"),function():void
                        {
                           QuestManager.completeStep(_quest.id,4);
                        },false);
                     }]);
                  }]);
               }]);
            });
         }
      }
      
      override public function processMapDispose() : void
      {
         _processor.hideMouseClickHint();
         DisplayUtil.removeForParent(this._mc_0);
         DisplayUtil.removeForParent(this._mineAnimation);
         this._mineAnimation = null;
         this._mc_0 = null;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         super.processMapDispose();
      }
   }
}
