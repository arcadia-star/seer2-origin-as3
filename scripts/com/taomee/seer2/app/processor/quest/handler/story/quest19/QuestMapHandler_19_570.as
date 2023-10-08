package com.taomee.seer2.app.processor.quest.handler.story.quest19
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_19_570 extends QuestMapHandler
   {
       
      
      private var _mc4:MovieClip;
      
      private var _mc5:MovieClip;
      
      private var _mc6:MovieClip;
      
      public function QuestMapHandler_19_570(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isComplete(_quest.id) == false)
         {
            this._mc4 = _processor.resLib.getMovieClip("mc_4");
            this._mc4.gotoAndStop(1);
            _map.content.addChild(this._mc4);
            if(!QuestManager.isStepComplete(_quest.id,3))
            {
               this.stepThree();
            }
            else
            {
               this.stepFour();
            }
         }
      }
      
      private function stepThree() : void
      {
         this._mc5 = _processor.resLib.getMovieClip("mc_5");
         _map.content.addChild(this._mc5);
         this._mc5.buttonMode = true;
         this._mc5.addEventListener(MouseEvent.CLICK,this.onMc5Click);
      }
      
      private function onMc5Click(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._mc5.buttonMode = false;
         this._mc5.removeEventListener(MouseEvent.CLICK,this.onMc5Click);
         this._mc5.gotoAndStop(1);
         NpcDialog.show(444,"目之魂",[[0,"酋长……趁现在……快走！"]],["（全都到齐了）"],[function():void
         {
            NpcDialog.show(49,"冰系酋长",[[0,"我不走……我要自己面对萨伦帝国……！不相干的人不要插手！"]],["喂！我们可是好心来救你！"],[function():void
            {
               NpcDialog.show(32,"小兵",[[0,"你……你赶快走吧！"]],["你好像很眼熟？"],[function():void
               {
                  NpcDialog.show(32,"小兵",[[0,"我就是被冰冻在冰之谷的那个人……我无论如何都无法原谅他们的作为！阿修队长这边……我来争取时间！"]],["你这个，难道是报恩？"],[function():void
                  {
                     NpcDialog.show(13,"阿修",[[1,"报恩？哼，多可笑的字眼！"]],["不懂得报恩的人才可笑！"],[function():void
                     {
                        NpcDialog.show(32,"小兵",[[0,"我……我曾经以为，我应该把我的一生都献给帝国！但是……你们知道吗……为了你们的目的，已经牺牲了多少战士！！"],[0,"就像小赛尔们说的，我们也有亲人在等我们回家！！所以……请不要……不要再……"]],["（泪……）"],[function():void
                        {
                           MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("19_1"),function():void
                           {
                              NpcDialog.show(32,"小兵",[[0,"我再也无法忍受这样的事情了！！"]],["击败阿修！！"],[function():void
                              {
                                 QuestManager.completeStep(_quest.id,3);
                                 stepFour();
                              }]);
                           });
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function stepFour() : void
      {
         this._mc4.gotoAndPlay(2);
         this._mc4.buttonMode = true;
         this._mc4.addEventListener(MouseEvent.CLICK,this.onMc4Click);
         this._mc6 = _processor.resLib.getMovieClip("mc_6");
         this._mc6.gotoAndStop(1);
         _map.content.addChild(this._mc6);
         if(this._mc5)
         {
            DisplayObjectUtil.removeFromParent(this._mc5);
         }
      }
      
      private function onMc4Click(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._mc4.gotoAndStop(1);
         this._mc4.buttonMode = false;
         this._mc4.removeEventListener(MouseEvent.CLICK,this.onMc4Click);
         NpcDialog.show(13,"阿修",[[1,"叛国者，死！阻我步伐者，死！！"]],["那你就试试看！"],[function():void
         {
            MovieClipUtil.playMc(_mc6,1,_mc6.totalFrames,function():void
            {
               NpcDialog.show(13,"阿修",[[1,"沁灵兽！！"]],["（冰系守护兽？！）"],[function():void
               {
                  NpcDialog.show(447,"沁灵兽",[[0,"你不是沁之魂……是目之魂……是你唤醒我……"]],["原来还有沁之魂？"],[function():void
                  {
                     NpcDialog.show(447,"沁灵兽",[[0,"我本是精灵王的心脏……但是我的心……沁之魂又在哪里？"]],["（这么说来，精魂是守护兽的心？）"],[function():void
                     {
                        NpcDialog.show(444,"目之魂",[[0,"伙伴们都不见了……只有我一个人……这颗星球，就要被它们……！！冰封之轴已经解封，只有你才能扼制它！"]],["沁灵兽！救救冰沁氏族！"],[function():void
                        {
                           NpcDialog.show(13,"阿修",[[1,"区区一个躯壳……失去沁之魂的你，能遏制灾难一般的暴风雪么？"]],["没有守护兽做不到的事！"],[function():void
                           {
                              NpcDialog.show(49,"冰系酋长",[[0,"我们冰沁氏族全族，都会毫不犹豫地拿起武器捍卫家园！耗尽全力……在所不辞！"]],["我们也来帮忙！"],[function():void
                              {
                                 NpcDialog.show(13,"阿修",[[1,"可笑！下次再见时，你们就会知道……你们的力量是多么的卑微！"]],["我们团结在一起，不会怕你！"],[function():void
                                 {
                                    QuestManager.completeStep(_quest.id,4);
                                    disposeMC();
                                 }]);
                              }]);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            },true);
         }]);
      }
      
      private function disposeMC() : void
      {
         if(this._mc4)
         {
            this._mc4.removeEventListener(MouseEvent.CLICK,this.onMc4Click);
            DisplayObjectUtil.removeFromParent(this._mc4);
            this._mc4 = null;
         }
         if(this._mc5)
         {
            this._mc5.removeEventListener(MouseEvent.CLICK,this.onMc5Click);
            DisplayObjectUtil.removeFromParent(this._mc5);
            this._mc5 = null;
         }
         if(this._mc6)
         {
            DisplayObjectUtil.removeFromParent(this._mc6);
            this._mc6 = null;
         }
      }
      
      override public function processMapDispose() : void
      {
         this.disposeMC();
         super.processMapDispose();
      }
   }
}
