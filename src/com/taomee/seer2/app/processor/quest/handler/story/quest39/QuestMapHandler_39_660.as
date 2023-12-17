package com.taomee.seer2.app.processor.quest.handler.story.quest39
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   import flash.errors.IllegalOperationError;
   
   public class QuestMapHandler_39_660 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _mc_2:MovieClip;
      
      private var _mc_3:MovieClip;
      
      private var _mc_4:MovieClip;
      
      private var _teleport:Teleport;
      
      public function QuestMapHandler_39_660(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._teleport = AnimateElementManager.getElement(5) as Teleport;
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this._teleport.visible = false;
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this._teleport.visible = false;
            this.intMc();
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.initMc();
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "39_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            this._mc_0 = _processor.resLib.getMovieClip("mc_0");
            _map.content.addChild(this._mc_0);
            MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
            {
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"啊！！财务官！！他要干啥！！？！"]],["这么鬼鬼祟祟的样子！！"],[function():void
               {
                  DisplayUtil.removeForParent(_mc_0);
                  _mc_0 = _processor.resLib.getMovieClip("mc_1");
                  _map.front.addChild(_mc_0);
                  MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                  {
                     QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
                     QuestManager.accept(_quest.id);
                  },true);
               }]);
            },true);
         }
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         this.stewardTalk();
      }
      
      private function stewardTalk() : void
      {
         NpcDialog.show(97,"财务官",[[0,"呵——呵——呃……这不是星际使者和萨伯尔兵团长嘛……今天天气挺好的，怎么样，在看风景聊天吗"]],[" 你再装好了……"],[function():void
         {
            NpcDialog.show(83,"萨伯尔兵团长",[[2,"很抱歉，财务官大人……不，我似乎不应该在这么称呼你了。总督大人已经明令逮捕你！放弃抵抗，束手就擒吧！"]],["嗯，嗯！"],[function():void
            {
               NpcDialog.show(97,"财务官",[[0,"逮捕我？我想你是搞错了吧？？呵——呵——咳，为了飞翼氏族的财务，我也献出过青春，不算我是功臣，居然还要逮捕我？"]],["你脸皮是有多厚啊……"],[function():void
               {
                  NpcDialog.show(83,"萨伯尔兵团长",[[2,"我也不愿意这样……抱歉了！！"]],["抓住他！抓住他！"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("39_0"),function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepConpleteHandler);
                        QuestManager.completeStep(_quest.id,1);
                     },true,false,2);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function intMc() : void
      {
         if(this._mc_0 != null)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_2");
         this._mc_1 = _processor.resLib.getMovieClip("mc_3");
         _map.content.addChild(this._mc_0);
         _map.ground.addChild(this._mc_1);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onStewardTalk);
      }
      
      private function onStewardTalk(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(97,"财务官",[[0,"呵——呵——呃……这不是星际使者和萨伯尔兵团长嘛……今天天气挺好的，怎么样，在看风景聊天吗"]],[" 你再装好了……"],[function():void
         {
            NpcDialog.show(83,"萨伯尔兵团长",[[2,"很抱歉，财务官大人……不，我似乎不应该在这么称呼你了。总督大人已经明令逮捕你！放弃抵抗，束手就擒吧！"]],["嗯，嗯！"],[function():void
            {
               NpcDialog.show(97,"财务官",[[0,"逮捕我？我想你是搞错了吧？？呵——呵——咳，为了飞翼氏族的财务，我也献出过青春，不算我是功臣，居然还要逮捕我？"]],["你脸皮是有多厚啊……"],[function():void
               {
                  NpcDialog.show(83,"萨伯尔兵团长",[[2,"我也不愿意这样……抱歉了！！"]],["抓住他！抓住他！"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("39_0"),function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepConpleteHandler);
                        QuestManager.completeStep(_quest.id,1);
                     },true,false,2);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStepConpleteHandler(param1:QuestEvent) : void
      {
         this._mc_0.removeEventListener(MouseEvent.CLICK,this.onStewardTalk);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepConpleteHandler);
         this._teleport.visible = true;
         SceneManager.changeScene(SceneType.LOBBY,720);
      }
      
      private function initMc() : void
      {
         this._mc_3 = _processor.resLib.getMovieClip("mc_8");
         this._mc_4 = _processor.resLib.getMovieClip("mc_9");
         _map.content.addChild(this._mc_3);
         _map.content.addChild(this._mc_4);
         this._mc_4.addEventListener(MouseEvent.CLICK,this.onStewardTalkAgain);
      }
      
      private function onStewardTalkAgain(param1:MouseEvent) : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 22
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         if(param1.questId == 39)
         {
            DisplayUtil.removeForParent(this._mc_0);
            DisplayUtil.removeForParent(this._mc_1);
            DisplayUtil.removeForParent(this._mc_3);
            DisplayUtil.removeForParent(this._mc_4);
         }
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._mc_0);
         DisplayUtil.removeForParent(this._mc_1);
         DisplayUtil.removeForParent(this._mc_2);
         DisplayUtil.removeForParent(this._mc_3);
         DisplayUtil.removeForParent(this._mc_4);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepConpleteHandler);
      }
   }
}
