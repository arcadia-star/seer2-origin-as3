package com.taomee.seer2.app.processor.quest.handler.story.quest13
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_13_500 extends QuestMapHandler
   {
       
      
      private var _mc_1:MovieClip;
      
      private var _mc1Index:int = 0;
      
      private var _mc_4:MovieClip;
      
      private var _mc_5:MovieClip;
      
      private var _mc_10:MovieClip;
      
      public function QuestMapHandler_13_500(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this.addMouseClickHint();
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
         {
            this.initAnimation();
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onQuestStep);
         }
         if(QuestManager.isStepComplete(_quest.id,4) && QuestManager.isStepComplete(_quest.id,5) == false)
         {
            this.initStep4Animation();
         }
      }
      
      private function initStep4Animation() : void
      {
         this._mc_10 = _processor.resLib.getMovieClip("mc_10");
         this._mc_10.x = 676;
         this._mc_10.y = 344;
         _map.front.addChild(this._mc_10);
         _processor.showMouseHintAt(550,290);
         this._mc_10.buttonMode = true;
         this._mc_10.addEventListener(MouseEvent.CLICK,this.onClickMC10);
      }
      
      private function onClickMC10(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_10.removeEventListener(MouseEvent.CLICK,this.onClickMC10);
         this._mc_10.buttonMode = false;
         _processor.hideMouseClickHint();
         NpcDialog.show(429,"伊特",[[0,"别说些教育我的话！没错！之前乌黑矿坑的几个家伙也是被我整得！我是个没爹娘的坏孩子！没朋友！没教养！！！但是请别丢下我一个人！！我能跟你走吗？！"]],["看来它也吓到了……"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"（原来这个捣蛋鬼跟我说的故事是真的……这家伙也挺可怜的！可是皮皮格这里又要怎么办？皮格还活着吗？）"]],["（不管怎么说！保护好伊特！）"],[function():void
            {
               QuestManager.completeStep(_quest.id,5);
               _map.front.removeChild(_mc_10);
               _mc_10 = null;
            }]);
         }]);
      }
      
      private function initAnimation() : void
      {
         this._mc_1 = _processor.resLib.getMovieClip("mc_1");
         this._mc_1.x = 525;
         this._mc_1.y = 65;
         this._mc_1.gotoAndStop(1);
         _map.front.addChild(this._mc_1);
         this.isCloseMC(this._mc_1,false);
         this._mc_1.addEventListener(MouseEvent.CLICK,this.onClickMC1);
      }
      
      private function onClickMC1(param1:MouseEvent) : void
      {
         var start:int = 0;
         var end:int = 0;
         var event:MouseEvent = param1;
         ++this._mc1Index;
         this.isCloseMC(this._mc_1,true);
         if(this._mc1Index == 4)
         {
            NpcDialog.show(429,"伊特",[[2,"呜呜呜呜……人家不玩了啦……一点都不好玩！……你欺负人家没有爸爸妈妈！！"]],["别……别哭啊……我没欺负你……"],[function():void
            {
               NpcDialog.show(429,"伊特",[[3,"闭嘴！没看到人家正在哭鼻子啊！啊呜呜呜呜……这个日子没办法过啦……"]],["囧……这个就是神奇精灵？"],[function():void
               {
                  addPlayAnimation();
               }]);
            }]);
            return;
         }
         switch(this._mc1Index)
         {
            case 1:
               start = 1;
               end = 18;
               break;
            case 2:
               start = 70;
               end = 98;
               break;
            case 3:
               start = 130;
               end = 149;
         }
         MovieClipUtil.playMc(this._mc_1,start,end,function():void
         {
            isCloseMC(_mc_1,false);
         },true);
      }
      
      private function addPlayAnimation() : void
      {
         this._mc_4 = _processor.resLib.getMovieClip("mc_4");
         _map.front.addChild(this._mc_4);
         MovieClipUtil.playMc(this._mc_4,1,this._mc_4.totalFrames,function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("13_1"),3,[[1,0]],function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("13_0"),function():void
               {
                  NpcDialog.show(429,"伊特",[[0,"拿开你的脏手！要我不哭，你就帮我把金灿灿奶嘴抢回来！！！要不……要不我就一直哭下去！！哼哼哼！！！！"]],["真是个小孩子……哪里有金灿灿奶嘴"],[function():void
                  {
                     _map.front.removeChild(_mc_1);
                     _mc_1 = null;
                     _mc_5 = _processor.resLib.getMovieClip("mc_5");
                     _map.front.addChild(_mc_5);
                     _mc_5.x = 507;
                     _mc_5.y = 65;
                     MovieClipUtil.playMc(_mc_5,1,_mc_5.totalFrames,function():void
                     {
                        QuestManager.completeStep(_quest.id,1);
                     },true);
                  }]);
               });
            });
         },true);
      }
      
      private function onQuestStep(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            this.addMouseClickHint();
         }
      }
      
      private function addMouseClickHint() : void
      {
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isCompletable(_quest.id))
         {
            _processor.showMouseHintAt(400,490);
         }
      }
      
      private function isCloseMC(param1:MovieClip, param2:Boolean) : void
      {
         if(param2)
         {
            param1.mouseChildren = false;
            param1.mouseEnabled = false;
            param1.buttonMode = false;
         }
         else
         {
            param1.mouseChildren = true;
            param1.mouseEnabled = true;
            param1.buttonMode = true;
         }
      }
      
      override public function processMapDispose() : void
      {
         this._mc1Index = 0;
         if(this._mc_1)
         {
            if(this._mc_1.parent)
            {
               this.isCloseMC(this._mc_1,true);
               this._mc_1.removeEventListener(MouseEvent.CLICK,this.onClickMC1);
               _map.front.removeChild(this._mc_1);
            }
            this._mc_1 = null;
         }
         if(this._mc_4)
         {
            if(this._mc_4.parent)
            {
               _map.front.removeChild(this._mc_4);
            }
            this._mc_4 = null;
         }
         if(this._mc_5)
         {
            if(this._mc_5.parent)
            {
               _map.front.removeChild(this._mc_5);
            }
            this._mc_5 = null;
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onQuestStep);
         _processor.hideMouseClickHint();
         if(this._mc_10)
         {
            if(this._mc_10.parent)
            {
               this._mc_10.buttonMode = false;
               _map.front.removeChild(this._mc_10);
               this._mc_10.removeEventListener(MouseEvent.CLICK,this.onClickMC10);
            }
            this._mc_10 = null;
         }
      }
   }
}
