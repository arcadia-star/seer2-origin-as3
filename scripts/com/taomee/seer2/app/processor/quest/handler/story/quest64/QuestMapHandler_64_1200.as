package com.taomee.seer2.app.processor.quest.handler.story.quest64
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
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_64_1200 extends QuestMapHandler
   {
       
      
      private var _lan:MovieClip;
      
      private var _mcs:Vector.<MovieClip>;
      
      private var _num:int;
      
      public function QuestMapHandler_64_1200(param1:QuestProcessor)
      {
         this._mcs = new Vector.<MovieClip>();
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepOne);
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepTwo);
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "64_1")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"啊？她好像不敢理我，发生什么了，我得找她搭讪一下。"]],["怎么搭讪呢？"],[function():void
            {
               NpcDialog.show(10,"巴蒂",[[0,"她好像在认真的采蘑菇，我们可以帮她采点蘑菇，顺便问问情况。"]],["好主意！"],[function():void
               {
                  MobileManager.getMobile(200,MobileType.NPC).visible = false;
                  pickMushroom();
               }]);
            }]);
         }
      }
      
      private function pickMushroom() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = _processor.resLib.getMovieClip("mo" + _loc2_);
            _map.content.addChild(_loc1_);
            _loc1_.buttonMode = true;
            _loc1_.addEventListener(MouseEvent.CLICK,this.onPickUpHandler);
            this._mcs.push(_loc1_);
            _loc2_++;
         }
         this._lan = _processor.resLib.getMovieClip("lan");
         this._lan.gotoAndStop(1);
         _map.front.addChild(this._lan);
      }
      
      private function onPickUpHandler(param1:MouseEvent) : void
      {
         ++this._num;
         if(this._num >= 3)
         {
            if(this._lan)
            {
               DisplayUtil.removeForParent(this._lan);
            }
            this.onSucessPickPanel();
         }
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:int = this._mcs.indexOf(_loc2_);
         if(this._mcs[_loc3_])
         {
            DisplayUtil.removeForParent(this._mcs[_loc3_]);
         }
         this._lan.gotoAndStop(_loc3_ + 2);
      }
      
      private function onStepOne(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "64_2" && QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepOne);
            this.npcTalkOne();
         }
      }
      
      private function onStepTwo(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "64_3" && QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepTwo);
            this.npcTalkTwo();
         }
      }
      
      private function onSucessPickPanel() : void
      {
         MobileManager.getMobile(200,MobileType.NPC).visible = true;
         NpcDialog.show(10,"巴蒂",[[0,"Hi，小红帽，我帮你采了很多蘑菇哟，不用谢谢我。"]],["拿去"],[function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("64_0"),function():void
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteOneHandler);
               QuestManager.completeStep(_quest.id,1);
            },true,false,2);
         }]);
      }
      
      private function onCompleteOneHandler(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteOneHandler);
         NpcDialog.show(200,"小红帽",[[0,"谢谢你的蘑菇。"]],["我要回家了"],[function():void
         {
            npcTalkOne();
         }]);
      }
      
      private function npcTalkOne() : void
      {
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"喂喂，别走啊，我有事情想要咨询你，你为什么这么害怕我们呢？"]],["这是怎么了？"],[function():void
         {
            NpcDialog.show(200,"小红帽",[[0,"这说来话长，看在你帮我摘蘑菇的份上我就告诉你吧。"]],["慢慢听着"],[function():void
            {
               MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("64_1"),3,[[1,0]],function():void
               {
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"哇，这里还藏着这么一个恐怖的公主，真是吓人。"]],["我们要小心"],[function():void
                  {
                     NpcDialog.show(200,"小红帽",[[0,"对啊，这样吧，看你们也是好人，那我带你们去见我们的黑桃皇后吧，也许她会帮助你们。"]],["跟我走"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("64_1"),function():void
                        {
                           QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteTwoHandler);
                           QuestManager.completeStep(_quest.id,2);
                        },true,false,2);
                     }]);
                  }]);
               });
            }]);
         }]);
      }
      
      private function onCompleteTwoHandler(param1:QuestEvent) : void
      {
         var evt:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteTwoHandler);
         NpcDialog.show(11,"多罗",[[0,"啊？这是什么暗器？差点伤到我们，不好，巴蒂好像被划伤。"]],["巴蒂，你还好吗？"],[function():void
         {
            npcTalkTwo();
         }]);
      }
      
      private function npcTalkTwo() : void
      {
         NpcDialog.show(11,"巴蒂",[[0,"啊？这是什么暗器？差点伤到我们，不好，巴蒂好像被划伤。"]],["巴蒂，你还好吗？"],[function():void
         {
            NpcDialog.show(10,"巴蒂",[[0,"没事，一点点小伤，划伤了而已。"]],["那就好"],[function():void
            {
               NpcDialog.show(200,"小红帽",[[0,"哎呀，受伤了，可能是那个邪恶的公主所为，你可能中毒了，不过皇后会帮助你们的，走吧，我们去见皇后。"]],["走吧"],[function():void
               {
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"巴蒂小心，我们先跟着小红帽吧。"]],["好的"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("64_2"),function():void
                     {
                        QuestManager.addEventListener(QuestEvent.COMPLETE,onCompleteHandler);
                        QuestManager.completeStep(_quest.id,3);
                     },true,false,2);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteOneHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteTwoHandler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
      }
   }
}
