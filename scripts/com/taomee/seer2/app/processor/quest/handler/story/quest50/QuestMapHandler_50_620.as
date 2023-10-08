package com.taomee.seer2.app.processor.quest.handler.story.quest50
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import com.taomee.seer2.core.utils.effect.EffectShake;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_50_620 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _fightStatus:Boolean;
      
      public function QuestMapHandler_50_620(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            if(this._fightStatus)
            {
               this.initTifflun();
            }
            else
            {
               this.initSnow();
            }
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initNpc();
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.initNpcAgain();
         }
      }
      
      private function initSnow() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_2");
         _map.content.addChild(this._mc_0);
         var _loc1_:MovieClip = this._mc_0["snow"];
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.ParryComingHandler);
      }
      
      private function ParryComingHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_3");
         _map.content.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            EffectShake.addShake(LayerManager.root,20,20,99,99);
            if(_mc_0)
            {
               DisplayUtil.removeForParent(_mc_0);
            }
            _mc_0 = _processor.resLib.getMovieClip("mc_4");
            _map.content.addChild(_mc_0);
            MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
            {
               var mc:MovieClip = null;
               NpcDialog.show(122,"派瑞",[[1,"不是吧真被我说中了！文森特还真被堆在雪人里了！"]],["不是高兴的时候，它们好像很生气……"],[function():void
               {
                  NpcDialog.show(122,"派瑞",[[2,"这位家长，请听我解释，我只是想和你的孩子一起堆雪人，没想到它不太合群，呃……"]],["呃，它看起来更生气了……！"],[function():void
                  {
                     _fightStatus = true;
                     FightManager.startFightBinaryWild(110);
                  }]);
               }]);
               mc = _mc_0["parry"] as MovieClip;
               mc.buttonMode = true;
               mc.addEventListener(MouseEvent.CLICK,parryTalkHandler);
            },true);
         },true);
      }
      
      private function parryTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(122,"派瑞",[[1,"不是吧真被我说中了！文森特还真被堆在雪人里了！"]],["不是高兴的时候，它们好像很生气……"],[function():void
         {
            NpcDialog.show(122,"派瑞",[[2,"这位家长，请听我解释，我只是想和你的孩子一起堆雪人，没想到它不太合群，呃……"]],["呃，它看起来更生气了……！"],[function():void
            {
               _fightStatus = true;
               FightManager.startFightBinaryWild(110);
            }]);
         }]);
      }
      
      private function initTifflun() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_5");
         _map.content.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepOneHandler);
            QuestManager.completeStep(_quest.id,1);
         },true);
      }
      
      private function onStepOneHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOneHandler);
         this.TifflunTalk();
      }
      
      private function initNpc() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_6");
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.TifflunTalkHandler);
         this._mc_1 = _processor.resLib.getMovieClip("mc_7");
         _map.content.addChild(this._mc_1);
      }
      
      private function TifflunTalkHandler(param1:MouseEvent) : void
      {
         this.TifflunTalk();
      }
      
      private function TifflunTalk() : void
      {
         NpcDialog.show(114,"蒂芙伦",[[0,"呃，这个精灵，真难控制……"]],["波利不是全体迁移到地月氏族的地铁站去了么？"],[function():void
         {
            NpcDialog.show(114,"蒂芙伦",[[0,"是啊，我刚抓的，还不太掌握得了技巧……啊，这不是文森特大人吗？我们赶快救他吧！"]],["（奇怪，那么短的时间内，难道她去过地月氏族？）"],[function():void
            {
               if(_mc_0)
               {
                  DisplayUtil.removeForParent(_mc_0);
               }
               if(_mc_1)
               {
                  DisplayUtil.removeForParent(_mc_1);
               }
               _mc_0 = _processor.resLib.getMovieClip("mc_8");
               _map.content.addChild(_mc_0);
               MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
               {
                  NpcDialog.show(123,"文森特",[[1,"嗯……这段和声不错。令人联想到圣洁的神殿……"]],["看来，用歌声真的可以唤醒被冰冻的族人呢！"],[function():void
                  {
                     NpcDialog.show(122,"派瑞",[[1,"文森特，你在酝酿情绪的时候绝对想不到会被冰住吧？还不赶快谢谢救了你的玉树临风的我！"]],["=。=……"],[function():void
                     {
                        NpcDialog.show(123,"文森特",[[1,"嗯，这一次詹姆斯没有走调，不错！哎？那位大婶，你是……？"]],["那是蒂芙伦，原来你们不认识？"],[function():void
                        {
                           NpcDialog.show(122,"派瑞",[[0,"的确，这位大婶登场了很多次，我也不认识。不对！文森特，居然无视我前面说的话！"]],["（可是蒂芙伦一口一个大人的好像早就认识似的？）"],[function():void
                           {
                              if(_mc_0)
                              {
                                 DisplayUtil.removeForParent(_mc_0);
                              }
                              _mc_0 = _processor.resLib.getMovieClip("mc_9");
                              _map.front.addChild(_mc_0);
                              MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                              {
                                 QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepTwoHandler);
                                 QuestManager.completeStep(_quest.id,2);
                              },true);
                           }]);
                        }]);
                     }]);
                  }]);
               },true);
            }]);
         }]);
      }
      
      private function onStepTwoHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepTwoHandler);
         this.AllTalk();
      }
      
      private function initNpcAgain() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_10");
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.ParryTalkAgainHandler);
         this._mc_1 = _processor.resLib.getMovieClip("mc_11");
         _map.content.addChild(this._mc_1);
      }
      
      private function ParryTalkAgainHandler(param1:MouseEvent) : void
      {
         this.AllTalk();
      }
      
      private function AllTalk() : void
      {
         NpcDialog.show(122,"派瑞",[[0,"嗯，现在文森特、詹姆斯都已经凝聚到我身边了，虽然还有很多伙伴没有救出来，但以我的高——瞻远瞩，未来一定很美好！"]],["不用强调“高”这个字……"],[function():void
         {
            NpcDialog.show(123,"文森特",[[0,"这位，嗯，铁制品……你是谁？是来和我们交流音乐方面的事情的吗？"]],["（把自己的经历告诉他。）"],[function():void
            {
               NpcDialog.show(123,"文森特",[[0,"很感谢你，而且看得出你很强力。我们还有很多伙伴需要解救，你愿意继续帮助我们吗？"]],["嗯，肯定的！"],[function():void
               {
                  NpcDialog.show(122,"派瑞",[[0,"又忽略我！！算了，我胸襟广阔不计较了。不过，那位大婶究竟是谁呢，怎么都想不起来我们氏族有这么一个人。"]],["可能是太大众脸了？"],[function():void
                  {
                     NpcDialog.show(123,"文森特",[[0,"…………（仿佛在思索着什么）"]],["总之慢慢将伙伴们都揪出来吧！"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("50_0"),function():void
                        {
                           QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestComplete);
                           QuestManager.completeStep(_quest.id,3);
                        },true,false,2);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         if(param1.questId == 50)
         {
            DisplayUtil.removeForParent(this._mc_0);
            DisplayUtil.removeForParent(this._mc_1);
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOneHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepTwoHandler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
      }
   }
}
