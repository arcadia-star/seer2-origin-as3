package com.taomee.seer2.app.processor.quest.handler.story.quest15
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_15_500 extends QuestMapHandler
   {
       
      
      private var _mc_1:MovieClip;
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_15_500(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id) && QuestManager.isAccepted(_quest.id) == false)
         {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
            this._mc_1 = _processor.resLib.getMovieClip("mc_1");
            this._mc_1.x = 645;
            this._mc_1.y = 404;
            _map.front.addChild(this._mc_1);
            this._mc_1.gotoAndStop(1);
         }
      }
      
      private function onShowAnimation(param1:DialogCloseEvent) : void
      {
         var event:DialogCloseEvent = param1;
         if(event.params == "15_0")
         {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            NpcDialog.show(440,"暗伊特",[[0,"我是伊特的哥哥……我从星球的另一边千里迢迢赶过来，就为了寻找我失散多年的弟弟……"]],["说来听听？"],[function():void
            {
               MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("15_0"),3,[[1,0]],function():void
               {
                  NpcDialog.show(429,"伊特",[[3,"什么乱七八糟的！那个鬼地方我再也不要回去！走开！！"]],["等等！"],[function():void
                  {
                     NpcDialog.show(440,"暗伊特",[[0,"前面是恶魔大鼻子军队的埋伏点啊！弟弟，等等我！"]],["（不管了，先去乌黑矿坑！）"],[function():void
                     {
                        _npc = MobileManager.getMobile(429,MobileType.NPC);
                        _npc.visible = false;
                        _mc_1.x = 600;
                        MovieClipUtil.playMc(_mc_1,41,_mc_1.totalFrames,function():void
                        {
                           QuestManager.accept(_quest.id);
                        },true);
                     }]);
                  }]);
               });
            }]);
         }
      }
      
      private function onQuestAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
         }
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onQuestAccept);
         DisplayUtil.removeForParent(this._mc_1);
         this._mc_1 = null;
         if(this._npc)
         {
            this._npc.visible = true;
         }
         this._npc = null;
      }
   }
}
