package com.taomee.seer2.app.processor.quest.handler.activity.quest30039
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.processor.quest.handler.activity.quest30034.Game30034;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30039_640 extends QuestMapHandler
   {
       
      
      private var _wolf:MovieClip;
      
      private var _wolfBaby:MovieClip;
      
      private var _baby:MovieClip;
      
      public function QuestMapHandler_30039_640(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.initFullMc();
         }
      }
      
      private function initFullMc() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30039_0"),function():void
         {
            _wolf = _processor.resLib.getMovieClip("wolf");
            _map.content.addChild(_wolf);
            _wolf.buttonMode = true;
            _wolf.addEventListener(MouseEvent.CLICK,onWolfTalkHandler);
         },true,false,2);
      }
      
      private function onWolfTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(518,"狼妖",[[0,"你这个铁壳！一看就不好消化！我不想吃你，你快滚吧！"]],["你…你…看我怎么收拾你！"],[function():void
         {
            var game:* = new Game30034(function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30039_1"),function():void
               {
                  NpcDialog.show(518,"狼妖",[[2,"饶了我吧…其实我也是身不由己的！你听我说…"]],["我要代表阿卡迪亚星消灭你！"],[function():void
                  {
                     MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30039_0"),5,[[1,0]],function():void
                     {
                        NpcDialog.show(518,"狼妖",[[2,"你能帮帮我吗！我真的不愿意再做出对我家园的精灵有害的事情了!"]],["我要怎么帮你！"],[function():void
                        {
                           NpcDialog.show(518,"狼妖",[[2,"听说你们要去骰子星上？那里有能破解咒语的方法！求求你们带上我吧！"]],["你怎么知道我们要去骰子星的！"],[function():void
                           {
                              NpcDialog.show(518,"狼妖",[[2,"这个…这个…我也是听说的！求求你了带上我吧，哦再也不想伤害无辜的小精灵了…"]],["说的也是，带上你你要老老实实的！"],[function():void
                              {
                                 NpcDialog.show(518,"狼妖",[[2,"嗯…我一定听话！"]],["好吧！到时候来找我吧！"],[function():void
                                 {
                                    NpcDialog.show(518,"狼妖",[[2,"大哥！好！我一定对你百依百顺…的…嘿嘿嘿……"]],["嗯！好吧！"],[function():void
                                    {
                                       if(_wolf)
                                       {
                                          DisplayUtil.removeForParent(_wolf);
                                       }
                                       _wolfBaby = _processor.resLib.getMovieClip("wolfBaby");
                                       _map.content.addChild(_wolfBaby);
                                       MovieClipUtil.playMc(_wolfBaby,1,_wolfBaby.totalFrames,function():void
                                       {
                                          DisplayUtil.removeForParent(_wolfBaby);
                                          _baby = _processor.resLib.getMovieClip("baby");
                                          _map.content.addChild(_baby);
                                          _processor.showMouseHintAt(374,394);
                                          _baby.buttonMode = true;
                                          _baby.addEventListener(MouseEvent.CLICK,onSeerTalkHandler);
                                       },true);
                                    }]);
                                 }]);
                              }]);
                           }]);
                        }]);
                     });
                  }]);
               },true,false,2);
            });
         }]);
      }
      
      private function onSeerTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"这是什么东西…从狼妖身上掉下来的，先收着吧！以后没准有大用处！"]],["（完成任务）"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onStep4CompleteHandler);
            QuestManager.completeStep(_quest.id,4);
         }]);
      }
      
      private function onStep4CompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep4CompleteHandler);
         if(this._baby)
         {
            DisplayUtil.removeForParent(this._baby);
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this._wolf)
         {
            DisplayUtil.removeForParent(this._wolf);
         }
         if(this._wolfBaby)
         {
            DisplayUtil.removeForParent(this._wolfBaby);
         }
         if(this._baby)
         {
            DisplayUtil.removeForParent(this._baby);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep4CompleteHandler);
      }
   }
}
