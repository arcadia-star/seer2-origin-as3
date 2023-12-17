package com.taomee.seer2.app.processor.quest.handler.branch.quest10131
{
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10131_891 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _game:Game10131;
      
      private var _resLib:ResourceLibrary;
      
      public function QuestMapHandler_10131_891(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this.playFullScreen();
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.playRubberMC();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.playFullMCAgain();
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.bibiTalk();
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.salunTalk();
         }
      }
      
      private function playFullScreen() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10131_0"),function():void
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("DrawNewMapPanel"),"正在打开面板...");
            ModuleManager.addEventListener("DrawNewMapPanel","DrawNewMapOK",onSucessPanel);
         },true,false,2);
      }
      
      private function onSucessPanel(param1:ModuleEvent) : void
      {
         var evt:ModuleEvent = param1;
         ModuleManager.removeEventListener("DrawNewMapPanel","DrawNewMapOK",this.onSucessPanel);
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         _map.front.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            _mc_1 = _processor.resLib.getMovieClip("mc_1");
            _map.front.addChild(_mc_1);
            MovieClipUtil.playMc(_mc_1,1,_mc_1.totalFrames,function():void
            {
               QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
               QuestManager.accept(_quest.id);
            },true);
         },true);
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         this.addRubberMC();
         this.tubberTalkFirst();
      }
      
      private function playRubberMC() : void
      {
         this.addRubberMC();
      }
      
      private function addRubberMC() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_2");
         _map.content.addChild(this._mc_0);
         var _loc1_:MovieClip = this._mc_0["rubber"];
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onRubberTalkHandler);
      }
      
      private function onRubberTalkHandler(param1:MouseEvent) : void
      {
         this.tubberTalkFirst();
      }
      
      private function tubberTalkFirst() : void
      {
         NpcDialog.show(520,"橡橡",[[0,"哎，赶紧把那些乱糟糟的东西都收拾干净吧！"]],["（点击场景里发光的物品）"],[function():void
         {
            if(_mc_0)
            {
               DisplayUtil.removeForParent(_mc_0);
            }
            _mc_0 = _processor.resLib.getMovieClip("mc_3");
            _map.content.addChild(_mc_0);
            MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
            {
               if(_mc_0)
               {
                  DisplayUtil.removeForParent(_mc_0);
               }
               _game = new Game10131(function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1Complete);
                  QuestManager.completeStep(_quest.id,1);
               });
            },true);
         }]);
      }
      
      private function onStep1Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
         this.playFullMCAgain();
      }
      
      private function playFullMCAgain() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10131_1"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Complete);
            QuestManager.completeStep(_quest.id,2);
         },false);
      }
      
      private function onStep2Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         this.bibiTalk();
      }
      
      private function bibiTalk() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("bibi");
         _map.content.addChild(this._mc_0);
         NpcDialog.show(521,"神笔马良",[[0,"我…我… 橡橡，这！这！这可怎么办呢？？"]],["……"],[function():void
         {
            NpcDialog.show(521,"神笔马良",[[0,"我有点不知所措啦！橡橡，呜呜……"]],["……"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10131_2"),function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3Complete);
                  QuestManager.completeStep(_quest.id,3);
               },true,false,2);
            }]);
         }]);
      }
      
      private function onStep3Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
         this.salunTalk();
      }
      
      private function salunTalk() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("all");
         _map.content.addChild(this._mc_0);
         NpcDialog.show(32,"萨伦小兵",[[0,"小家伙，想赚大钱吗？只要你给我画画，我就会给你很多很多的赛尔豆哦！"]],["……"],[function():void
         {
            if(_mc_0)
            {
               DisplayUtil.removeForParent(_mc_0);
            }
            _mc_0 = _processor.resLib.getMovieClip("mc_4");
            _map.front.addChild(_mc_0);
            MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
            {
               NpcDialog.show(32,"萨伦小兵",[[0," 额……那，那你想认识美女吗？只要你给我画画，我就介绍很多美女给你。"]],["……"],[function():void
               {
                  if(_mc_0)
                  {
                     DisplayUtil.removeForParent(_mc_0);
                  }
                  _mc_0 = _processor.resLib.getMovieClip("mc_5");
                  _map.front.addChild(_mc_0);
                  MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                  {
                     NpcDialog.show(32,"萨伦小兵",[[0,"这家伙真难搞定啊！嘿嘿，有了！这次的激将法一定行！"]],["……"],[function():void
                     {
                        NpcDialog.show(32,"萨伦小兵",[[0,"哼哼！别以为你的画很好看，哥哥我随便画一张就要气死你！"]],["……"],[function():void
                        {
                           NpcDialog.show(521,"神笔马良",[[0,"哈！哈！哈！哈！瞧你那白痴样，你画呀！你画呀！哈哈哈！"]],["……"],[function():void
                           {
                              NpcDialog.show(32,"萨伦小兵",[[0,"到底谁白痴，等着瞧吧！"]],["……"],[function():void
                              {
                                 if(_mc_0)
                                 {
                                    DisplayUtil.removeForParent(_mc_0);
                                 }
                                 _mc_0 = _processor.resLib.getMovieClip("mc_6");
                                 _map.front.addChild(_mc_0);
                                 MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                                 {
                                    NpcDialog.show(32,"萨伦小兵",[[0,"我们俩到底谁更白痴呢？哈哈哈！"]],["……"],[function():void
                                    {
                                       NpcDialog.show(521,"神笔马良",[[0,"你！你！这个坏蛋！利用我！"]],["……"],[function():void
                                       {
                                          NpcDialog.show(32,"萨伦小兵",[[0,"哼哼，万圣节有的好瞧咯，See you！"]],["……"],[function():void
                                          {
                                             if(_mc_0)
                                             {
                                                DisplayUtil.removeForParent(_mc_0);
                                             }
                                             _mc_0 = _processor.resLib.getMovieClip("mc_7");
                                             _map.content.addChild(_mc_0);
                                             MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                                             {
                                                NpcDialog.show(521,"神笔马良",[[0,"这！这！今天我真的是闯大祸了！！我该怎么办呢？？"]],["……"],[function():void
                                                {
                                                   QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestComplete);
                                                   QuestManager.completeStep(_quest.id,4);
                                                }]);
                                             },true);
                                          }]);
                                       }]);
                                    }]);
                                 },true);
                              }]);
                           }]);
                        }]);
                     }]);
                  },true);
               }]);
            },true);
         }]);
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
      }
      
      override public function processMapDispose() : void
      {
         ModuleManager.removeEventListener("DrawNewMapPanel","DrawNewMapOK",this.onSucessPanel);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
      }
      
      private function getURL() : void
      {
         var url:String = String(URLUtil.getActivityAnimation("machine/letter"));
         var resourceLoader:ResourceLibraryLoader = new ResourceLibraryLoader(url);
         resourceLoader.getLib(function(param1:ResourceLibrary):void
         {
            _resLib = param1;
         });
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return this._resLib.getMovieClip(param1);
         }
         return null;
      }
   }
}
