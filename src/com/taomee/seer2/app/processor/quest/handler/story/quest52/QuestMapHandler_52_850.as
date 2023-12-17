package com.taomee.seer2.app.processor.quest.handler.story.quest52
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_52_850 extends QuestMapHandler
   {
       
      
      private var _hasFight:Boolean;
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      public function QuestMapHandler_52_850(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            if(this._hasFight)
            {
               this.NpcLeave();
            }
            else
            {
               this.intMc();
            }
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initSword();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepHandler);
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.initSword();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onTwoHandler);
         }
      }
      
      private function intMc() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         _map.front.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            _hasFight = true;
            FightManager.startFightWithWild(114);
            if(_mc_0)
            {
               DisplayUtil.removeForParent(_mc_0);
            }
         },true);
      }
      
      private function NpcLeave() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_1");
         _map.front.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            NpcDialog.show(494,"萨兰古尔",[[0,"令人悲哀的愚钝……没有实力却任性妄为的家伙，到最后只会被自己所依赖的力量反噬而已"]],["那个，你好……"],[function():void
            {
               NpcDialog.show(494,"萨兰古尔",[[0,"你就是那个传闻中得到了5块璞玉的勇士？你也想来挑战一下，能否将这柄宝剑拔出来？"]],["额，我还没来得及这么想……"],[function():void
               {
                  NpcDialog.show(494,"萨兰古尔",[[0,"当“萨兰古尔之剑是一柄能够劈开天空的宝剑”的谣传铺散开来，就有各路不自量力的人士想要来夺取这股力量。"]],[],[function():void
                  {
                     NpcDialog.show(494,"萨兰古尔",[[0,"他们却不知道，如果自身不够强大到能将宝剑拔起，他也没有资格去驾驭萨兰古尔之剑。"]],["（原来萨伦帝国也看上了这柄剑）"],[function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepOneHandler);
                        QuestManager.completeStep(_quest.id,1);
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function onStepOneHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOneHandler);
         this.initSword();
         this.CreatChange();
      }
      
      private function initSword() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_2");
         _map.content.addChild(this._mc_0);
      }
      
      private function CreatChange() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_3");
         _map.content.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            NpcDialog.show(494,"萨兰古尔",[[0,"你……！你身上，难道携带者刚铎的巨锤？你，你认识刚铎吧？？"]],["我的确认识，怎么了吗？"],[function():void
            {
               NpcDialog.show(494,"萨兰古尔",[[0,"他还好吗？他强力了吗？应该变强了不少吧，当年都那样约定了……"]],["（将自己在飞翼氏族的经历告诉它）"],[function():void
               {
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"游历阿卡迪亚星球至今，唯一一个不携带精灵也能够发挥出如此强大力量的人就是他了。"]],["话说他为什么不带精灵呢，真是偏执=。="],[function():void
                  {
                     NpcDialog.show(494,"萨兰古尔",[[0,"那是因为……他的精灵，从头到尾都只有我一个。"]],["啥？！？！？！"],[function():void
                     {
                        MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("52_0"),4,[[1,0]],function():void
                        {
                           NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"然后你就离开他来到了能源之树？难道当年刚铎放弃总兵团长的身份，是因为这件事情？"]],["难怪刚铎没有精灵啊！"],[function():void
                           {
                              NpcDialog.show(494,"萨兰古尔",[[2,"是的，那时我愤然想要离开。痛彻心扉的刚铎知道无法阻拦我，便和我定下了一个约定。"]],["什么约定？"],[function():void
                              {
                                 NpcDialog.show(494,"萨兰古尔",[[2,"当刚铎能够成为一个不依赖任何人的强者的时候，我就会原谅他。我想，今天你所带来的消息，足以让我尽释前嫌了。"]],["对了，这柄宝剑，难道可以心电感应什么的？"],[function():void
                                 {
                                    NpcDialog.show(494,"萨兰古尔",[[2,"呵呵，这个嘛……"]],["别卖关子啦，快告诉我吧！"],[function():void
                                    {
                                       QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepTwoHandler);
                                       QuestManager.completeStep(_quest.id,2);
                                    }]);
                                 }]);
                              }]);
                           }]);
                        });
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function onStepHandler(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "52_1")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStepHandler);
            this.CreatChange();
         }
      }
      
      private function onStepTwoHandler(param1:QuestEvent) : void
      {
         var evt:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepTwoHandler);
         NpcDialog.show(494,"萨兰古尔",[[0,"其实，这柄宝剑原本就是我所使用的兵器。我只是放在这里，希望刚铎能够有一天来将他拔起。"]],["=。=这样啊"],[function():void
         {
            NpcDialog.show(494,"萨兰古尔",[[0,"不过，他既然已经把巨锤赠送给你，一定是十分认可你。所以……请接收最后一块璞玉。"]],["最后一块璞玉？集齐之后会发生什么吗？"],[function():void
            {
               playFullMc();
            }]);
         }]);
      }
      
      private function playFullMc() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("52_0"),function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestCompleteHandler);
            QuestManager.completeStep(_quest.id,3);
         },true,false,2);
      }
      
      private function onTwoHandler(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "52_2")
         {
            this.playFullMc();
         }
      }
      
      private function onQuestCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestCompleteHandler);
         if(param1.questId == 52)
         {
            if(this._mc_0)
            {
               DisplayUtil.removeForParent(this._mc_0);
            }
            if(this._mc_1)
            {
               DisplayUtil.removeForParent(this._mc_1);
            }
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOneHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepTwoHandler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestCompleteHandler);
      }
   }
}
