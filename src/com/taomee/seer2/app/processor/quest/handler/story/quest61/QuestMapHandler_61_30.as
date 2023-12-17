package com.taomee.seer2.app.processor.quest.handler.story.quest61
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_61_30 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      public function QuestMapHandler_61_30(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         var flag_1:int = 0;
         var flag_2:int = 0;
         var flag_3:int = 0;
         var flag_4:int = 0;
         var flag_5:int = 0;
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this.addMother();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         ServerBufferManager.getServerBuffer(ServerBufferType.LEIYI_CENTURY_FIGHT,function(param1:ServerBuffer):void
         {
            flag_1 = param1.readDataAtPostion(1);
            flag_2 = param1.readDataAtPostion(2);
            flag_3 = param1.readDataAtPostion(3);
            flag_4 = param1.readDataAtPostion(4);
            flag_5 = param1.readDataAtPostion(5);
            if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false && flag_1 == 1 && flag_2 == 1 && flag_3 == 1 && flag_4 == 1 && flag_5 == 1)
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepConpleteHandler);
               QuestManager.completeStep(_quest.id,1);
            }
         });
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.addMotherAgain();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.addMother();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep1);
         }
      }
      
      private function onStepConpleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepConpleteHandler);
         this.addMother();
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep1);
      }
      
      private function addMother() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("ma6");
         _map.content.addChild(this._mc_0);
      }
      
      private function addMotherAgain() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("ma7");
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onMoutherHandler);
      }
      
      private function onMoutherHandler(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("FindSeanPanel"),"正在打开面板...");
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "61_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
            NpcDialog.show(171,"SEAN的妈妈",[[0,"小战士你是赛尔号2飞船上哪一个小队的？"]],["啊？"],[function():void
            {
               NpcDialog.show(171,"SEAN的妈妈",[[0,"你知道大名鼎鼎的赛尔大分队队长在哪儿吗？"]],["这个…还真没听说过"],[function():void
               {
                  NpcDialog.show(171,"SEAN的妈妈",[[0,"啧啧…这都没听过！那你们的赛尔英雄SEAN你一定认识吧？快快快，不跟你多说了，先去见我的宝贝儿子去！"]],["你串错门儿了吧？"],[function():void
                  {
                     NpcDialog.show(171,"SEAN的妈妈",[[0,"我宝贝儿子可是你们的大英雄！难道他起个艺名？当英雄就是不一样呀！"]],["那他有什么特点呀…"],[function():void
                     {
                        NpcDialog.show(171,"SEAN的妈妈",[[0,"嗯…高大、英俊、优雅、博学、幽默、强大……"]],["这……应该是谁呢？"],[function():void
                        {
                           ModuleManager.toggleModule(URLUtil.getAppModule("FindSeanPanel"),"正在打开面板...");
                           QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
                           QuestManager.accept(_quest.id);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         this.addMotherAgain();
      }
      
      private function onStep1(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "61_1")
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("ShowPersonPanel"),"正在打开面板...");
            ModuleManager.addEventListener("ShowPersonPanel","showWrong",this.onWrongHandler);
            ModuleManager.addEventListener("ShowPersonPanel","showRight",this.onRightHandler);
         }
      }
      
      private function onWrongHandler(param1:ModuleEvent) : void
      {
         var evt:ModuleEvent = param1;
         ModuleManager.removeEventListener("ShowPersonPanel","showWrong",this.onWrongHandler);
         ModuleManager.removeEventListener("ShowPersonPanel","showRight",this.onRightHandler);
         NpcDialog.show(171,"SEAN的妈妈",[[0,"这……这哪是我的儿子SEAN呀！不是不是！"]],["那我再试试看……"],[function():void
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("ShowPersonPanel"),"正在打开面板...");
            ModuleManager.addEventListener("ShowPersonPanel","showWrong",onWrongHandler);
            ModuleManager.addEventListener("ShowPersonPanel","showRight",onRightHandler);
         }]);
      }
      
      private function onRightHandler(param1:ModuleEvent) : void
      {
         var evt:ModuleEvent = param1;
         ModuleManager.removeEventListener("ShowPersonPanel","showWrong",this.onWrongHandler);
         ModuleManager.removeEventListener("ShowPersonPanel","showRight",this.onRightHandler);
         NpcDialog.show(171,"SEAN的妈妈",[[0,"瞧！这才是我的儿子！啧啧…你瞧长得多好呀！唉…我可想死他了！"]],["你…你真的确定这是你的儿子吗？"],[function():void
         {
            NpcDialog.show(171,"SEAN的妈妈",[[0,"那可不！他是你们的超级无敌霹雳大英雄吧！哈哈！别担心，见到他我给你说点好话的，让你也当个小分队队长什么的！"]],["其实他是…萨伦帝国的亲信…是我们的大敌人！"],[function():void
            {
               NpcDialog.show(171,"SEAN的妈妈",[[0,"啧啧…小战士也学会开玩笑了！快带我去找他，我真想赶紧把亲手做的衣服和点心交给他！终于见到……"]],["千真万确！赛尔是没有撒谎功能的！！"],[function():void
               {
                  NpcDialog.show(171,"SEAN的妈妈",[[0,"这…怎么…不可能…不可能…"]],["老婆婆你怎么了！"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("61_1"),function():void
                     {
                        NpcDialog.show(7,"娜威拉",[[0,"她竟然是S的妈妈！赛尔！快去通报船长，让飞船一进入级警备状态！"]],["好的！"],[function():void
                        {
                           QuestManager.addEventListener(QuestEvent.COMPLETE,onCompleteHandler);
                           QuestManager.completeStep(_quest.id,2);
                        }]);
                     },true,false,2);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onCompleteHandler(param1:QuestEvent) : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep1);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepConpleteHandler);
         ModuleManager.removeEventListener("ShowPersonPanel","showWrong",this.onWrongHandler);
         ModuleManager.removeEventListener("ShowPersonPanel","showRight",this.onRightHandler);
      }
   }
}
