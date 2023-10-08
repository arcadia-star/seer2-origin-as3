package com.taomee.seer2.app.processor.quest.handler.main.quest87
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_87_80369 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _npc:MovieClip;
      
      public function QuestMapHandler_87_80369(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(questID))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccepted);
         }
         else if(QuestManager.isAccepted(questID) && !QuestManager.isComplete(questID))
         {
            this.initStep1();
         }
      }
      
      private function showNpc() : void
      {
         if(QuestManager.isComplete(85) && !QuestManager.isAccepted(questID))
         {
            _map.content["npc1025"]["t"].visible = true;
         }
         else
         {
            _map.content["npc1025"]["t"].visible = false;
         }
      }
      
      private function onAccepted(param1:QuestEvent) : void
      {
         this.initStep1();
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._npc = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initStep2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("87_0"),function():void
         {
            ModuleManager.showModule(URLUtil.getAppModule("DuoZhangAiPanel"),"打开保护的挑战面板...",{"fun":initStep4});
         },false);
      }
      
      private function initStep3() : void
      {
         ModuleManager.closeForName("DuoZhangAiPanel");
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("87_1"),function():void
         {
            initStep4();
         },false);
      }
      
      private function initStep4() : void
      {
         ModuleManager.closeForName("DuoZhangAiPanel");
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("87_2"),function():void
         {
            initStep1Complete();
         },false);
      }
      
      private function initStep1() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("mc_87");
         _map.front.addChild(this._mc1);
         this._mc1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
         {
            NpcDialog.show(830,"雷霆",[[0,"好强大……地球上为什么也会有精灵？"]],["地心兽是什么来头?"],[function():void
            {
               NpcDialog.show(825,"超梦",[[0,"快跑！现在不是废话的时候！"]],[" ……"],[function():void
               {
                  NpcDialog.show(825,"超梦",[[0,"找到人类的防卫区域我们就安全了。"]],["快跑！"],[function():void
                  {
                     _map.front.removeChild(_mc1);
                     _mc1 = null;
                     initStep2();
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initStep1Complete() : void
      {
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onComplete1);
         QuestManager.completeStep(questID,1);
      }
      
      private function onComplete1(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete1);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function createNpc() : void
      {
         var _loc1_:InProgressMark = null;
         if(!this._npc)
         {
            this._npc = _map.content["npc1025"];
            this._npc.buttonMode = true;
            _loc1_ = new InProgressMark();
            _loc1_.y = -120;
            this._npc.addChild(_loc1_);
            this._npc.addEventListener(MouseEvent.CLICK,this.initStep2Continue);
         }
      }
      
      private function initStep2Continue(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(1025,"废品分装队长",[[0,"我是废品分装队长——在地球清理行动中负责分装回收机器人收集来的垃圾。"]],[["（主线）废墟下的恐怖 "],["你加油！！"]],[function():void
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,onAccepted);
            QuestManager.accept(questID);
         },function():void
         {
         }]);
      }
      
      private function initStep2FullScreenAnimation2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("84_1"),function():void
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,onComplete);
            QuestManager.accept(questID);
         },false);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.initStep2Continue);
         }
         this._npc = null;
         super.processMapDispose();
      }
   }
}
