package com.taomee.seer2.app.processor.quest.handler.story.quest66
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class QuestMapHandler_66_1230 extends QuestMapHandler
   {
      
      private static const uglyNpcId:int = 317;
      
      private static const uglyPostion:Point = new Point(550,370);
       
      
      private var _npc:Mobile;
      
      private var _flower:MovieClip;
      
      private var _door:MovieClip;
      
      private var _arrow0:MovieClip;
      
      private var _arrow1:MovieClip;
      
      private var _uglyMc:Mobile;
      
      public function QuestMapHandler_66_1230(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._npc = MobileManager.getMobile(316,MobileType.NPC);
         this._flower = _map.content["flower"];
         this._door = _map.content["door"];
         this._arrow0 = _map.content["arrow0"];
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
         {
            this._arrow0.visible = true;
         }
         else
         {
            this._arrow0.visible = false;
         }
         this._arrow1 = _map.content["arrow1"];
         if(QuestManager.isStepComplete(_quest.id,2) && !QuestManager.isStepComplete(_quest.id,3))
         {
            this._arrow1.visible = true;
         }
         else
         {
            this._arrow1.visible = false;
         }
         this._flower.buttonMode = true;
         this._door.buttonMode = true;
         this._flower.addEventListener(MouseEvent.CLICK,this.onFlower);
         this._door.addEventListener(MouseEvent.CLICK,this.onDoor);
         if(!QuestManager.isAccepted(_quest.id))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(QuestManager.isStepComplete(_quest.id,3) && !QuestManager.isStepComplete(_quest.id,4))
         {
            this.createUgly();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            QuestManager.completeStep(_quest.id,2);
            if(this._arrow1)
            {
               this._arrow1.visible = true;
            }
         }
      }
      
      private function onStepComplete(param1:QuestEvent = null) : void
      {
         if(param1.questId == _quest.id && param1.stepId == 1)
         {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            this.step1to2();
         }
      }
      
      private function step1to2() : void
      {
         NpcDialog.show(316,"匹喏曹",[[1,"哦？果真找到了，快看看标记的指示说公主在哪里？"]],["让我看看"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"好像，好像说是在树洞周围，我们去找找树洞周围有什么入口吗？"]],["走，一起找找"],[function():void
            {
               QuestManager.completeStep(_quest.id,2);
               if(_arrow1)
               {
                  _arrow1.visible = true;
               }
            }]);
         }]);
      }
      
      private function onFlower(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"哈哈，我好像找到了一个标记，让我来认真识别一下。"]],["仔细观察找到公主的标记哟"],[function():void
            {
               var _loc1_:* = {};
               _loc1_.func = onStepComplete;
               ModuleManager.showModule(URLUtil.getAppModule("FindPrincessGame"),"",_loc1_);
               if(_arrow0)
               {
                  _arrow0.visible = false;
               }
            }]);
         }
      }
      
      private function onDoor(param1:MouseEvent) : void
      {
         var mc:MovieClip = null;
         var e:MouseEvent = param1;
         if(QuestManager.isStepComplete(66,2) && !QuestManager.isStepComplete(66,3))
         {
            mc = _processor.resLib.getMovieClip("mc1");
            _processor.mapModel.front.addChild(mc);
            MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(mc);
               mc = null;
               createUgly();
               QuestManager.completeStep(_quest.id,3);
               if(_arrow1)
               {
                  _arrow1.visible = false;
                  _arrow1.stop();
               }
            },true);
         }
      }
      
      private function createUgly() : void
      {
         this._uglyMc = new Mobile();
         this._uglyMc.resourceUrl = URLUtil.getNpcSwf(uglyNpcId);
         this._uglyMc.buttonMode = true;
         this._uglyMc.addEventListener(MouseEvent.CLICK,this.onUglyClick);
         this._uglyMc.setPostion(uglyPostion);
         this._uglyMc.height = 100;
         this._uglyMc.x = 357 + 189;
         this._uglyMc.y = 190 + 126;
         MobileManager.addMobile(this._uglyMc,MobileType.NPC);
      }
      
      private function onUglyClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(uglyNpcId,"白雪公主",[[0,"啊？你们是谁，怎么找到了我？"]],["不要看我，我很丑"],[function():void
         {
            NpcDialog.show(316,"匹喏曹",[[0,"公主，别怕，他们是我的朋友，他们是来帮助我们的"]],["你给他们说说你的遭遇吧"],[function():void
            {
               NpcDialog.show(10,"巴蒂",[[0,"啊。你就是传说中的白雪公主"]],["哈哈哈哈哈"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("66_1"),function():void
                  {
                     NpcDialog.show(316,"匹喏曹",[[3,"啊，原来，你们骗我，你们是皇后的卧底。"]],["你们都是坏人"],[function():void
                     {
                        NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"不是，这发生了什么？巴蒂你住手！"]],["放开公主"],[function():void
                        {
                           MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("66_2"),function():void
                           {
                              QuestManager.completeStep(_quest.id,4);
                              if(_uglyMc)
                              {
                                 _uglyMc.removeEventListener(MouseEvent.CLICK,onUglyClick);
                                 MobileManager.removeMobile(_uglyMc,MobileType.NPC);
                              }
                           });
                        }]);
                     }]);
                  });
               }]);
            }]);
         }]);
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "66_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
            QuestManager.accept(_quest.id);
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(this._arrow0)
         {
            this._arrow0.visible = true;
         }
      }
      
      override public function processMapDispose() : void
      {
         this._flower.removeEventListener(MouseEvent.CLICK,this.onFlower);
         this._door.removeEventListener(MouseEvent.CLICK,this.onDoor);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         if(this._uglyMc)
         {
            this._uglyMc.removeEventListener(MouseEvent.CLICK,this.onUglyClick);
         }
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         super.processMapDispose();
      }
   }
}
