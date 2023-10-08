package com.taomee.seer2.app.processor.quest.handler.activity.quest30009
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30009_152 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      public function QuestMapHandler_30009_152(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.initMc();
         }
         if(QuestManager.isStepComplete(_quest.id,4) && QuestManager.isStepComplete(_quest.id,5) == false)
         {
            this.initFish();
         }
      }
      
      private function initMc() : void
      {
         var mc:MovieClip = null;
         this._mc_0 = _processor.resLib.getMovieClip("mc_3");
         _map.content.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_mc_0);
            NpcDialog.show(313,"钓鱼大师",[[0,"安啦安啦！有关部门说这个是自然现象！来陪哀家钓鱼垂钓，享受这自然风光吧!"]],["看来毫无收获……"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30009_0"),function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep4Complete);
                  QuestManager.completeStep(_quest.id,4);
               },true,false,2);
            }]);
         },true);
      }
      
      private function onStep4Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep4Complete);
         this.initFish();
      }
      
      private function initFish() : void
      {
         var mc:MovieClip = null;
         this._mc_0 = _processor.resLib.getMovieClip("mc_4");
         _map.front.addChild(this._mc_0);
         mc = this._mc_0["fish"] as MovieClip;
         mc.buttonMode = true;
         mc.addEventListener(MouseEvent.CLICK,function():void
         {
            MovieClipUtil.getChild(_mc_0,2,0,function(param1:DisplayObject):void
            {
               var $mc:MovieClip = null;
               var mc:DisplayObject = param1;
               $mc = mc as MovieClip;
               mc = null;
               mc = $mc["hand"] as SimpleButton;
               mc.addEventListener(MouseEvent.CLICK,function():void
               {
                  MovieClipUtil.getChild(_mc_0,3,0,function(param1:DisplayObject):void
                  {
                     var mc:DisplayObject = param1;
                     $mc = null;
                     $mc = mc as MovieClip;
                     MovieClipUtil.playMc($mc,1,$mc.totalFrames,function():void
                     {
                        DisplayUtil.removeForParent(_mc_0);
                        NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"……瓶子！瓶子……咦？刚才那块芯片呢？奇了怪了！"]],["钓鱼大师你旁边的是什么啊？"],[function():void
                        {
                           NpcDialog.show(313,"钓鱼大师",[[0,"额额额 ……这不是我的帽子耶！给你给你！这玩意似乎也不适合哀家！"]],[" 这头部装备还真不错。"],[function():void
                           {
                              _mc_0 = _processor.resLib.getMovieClip("mc_5");
                              _map.front.addChild(_mc_0);
                              MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                              {
                                 QuestManager.addEventListener(QuestEvent.COMPLETE,onStep5Complete);
                                 QuestManager.completeStep(_quest.id,5);
                              });
                           }]);
                        }]);
                     },true);
                  });
               });
            });
         });
      }
      
      private function onStep5Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep5Complete);
         ActorManager.showRemoteActor = true;
         if(param1.questId == 30009)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
      }
      
      override public function processMapDispose() : void
      {
         this._mc_0 = null;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep4Complete);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep5Complete);
      }
   }
}
