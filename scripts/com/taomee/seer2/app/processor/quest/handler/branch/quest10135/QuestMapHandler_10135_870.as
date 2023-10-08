package com.taomee.seer2.app.processor.quest.handler.branch.quest10135
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10135_870 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _game:com.taomee.seer2.app.processor.quest.handler.branch.quest10135.Game10135;
      
      public function QuestMapHandler_10135_870(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.addLockMaliangMC();
            this.addTalk();
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.addMalingMC();
         }
      }
      
      private function addLockMaliangMC() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("lockmaliang");
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onPlayGameHandler);
      }
      
      private function addTalk() : void
      {
         this._mc_1 = _processor.resLib.getMovieClip("talk2");
         _map.front.addChild(this._mc_1);
         MovieClipUtil.playMc(this._mc_1,1,this._mc_1.totalFrames,function():void
         {
            NpcDialog.show(520,"橡橡",[[0,"哼！只有我可以欺负马良！谁允许你困住它的呀！看我擦擦擦!"]],["（使劲擦）"],[function():void
            {
               _game = new com.taomee.seer2.app.processor.quest.handler.branch.quest10135.Game10135(_processor.resLib.getMovieClip("game"),0,gameComplete);
            }]);
         },true);
      }
      
      private function onPlayGameHandler(param1:MouseEvent) : void
      {
         this._game = new com.taomee.seer2.app.processor.quest.handler.branch.quest10135.Game10135(_processor.resLib.getMovieClip("game"),0,this.gameComplete);
      }
      
      private function gameComplete() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10135_2"),function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3Complete);
            QuestManager.completeStep(_quest.id,3);
         },true,false,2);
      }
      
      private function onStep3Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
         this.addMalingMC();
         this.maliangTalk();
      }
      
      private function addMalingMC() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("ma");
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onClickMaliangTalkHandler);
      }
      
      private function onClickMaliangTalkHandler(param1:MouseEvent) : void
      {
         this.maliangTalk();
      }
      
      private function maliangTalk() : void
      {
         NpcDialog.show(521,"神笔马良",[[0,"切！也不看看我马良是靠什么吃饭的！我这就画个机械手来救你！!"]],["（画机械手）"],[function():void
         {
            _game = new com.taomee.seer2.app.processor.quest.handler.branch.quest10135.Game10135(_processor.resLib.getMovieClip("game"),1,game2Complete);
         }]);
      }
      
      private function game2Complete() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10135_3"),function():void
         {
            NpcDialog.show(166,"黑衣人",[[0,"BI……@……*&#@#马良！橡皮神君！速速返回星球！!"]],["……“神马”人物？"],[function():void
            {
               NpcDialog.show(521,"神笔马良",[[0,"呀！星球使者来找我们了！好啦！不胡闹了！橡皮！走了！我们回家了！<font color=\'#ffcc00\'>{$name}</font>谢谢你！!"]],["……（舍不得你们）"],[function():void
               {
                  NpcDialog.show(520,"橡橡",[[0,"有马良的地方就有我！嘻嘻！走咯！！！铁皮罐子！再见！!"]],["再见！!"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10135_4"),function():void
                     {
                        if(_mc_0)
                        {
                           DisplayUtil.removeForParent(_mc_0);
                        }
                        if(_mc_1)
                        {
                           DisplayUtil.removeForParent(_mc_1);
                        }
                        _mc_0 = _processor.resLib.getMovieClip("letterUI");
                        _map.content.addChild(_mc_0);
                        _mc_0.buttonMode = true;
                        _mc_0.addEventListener(MouseEvent.CLICK,onOpenLetterHandler);
                        onOpenLetterHandler(null);
                     },true,false,2);
                  }]);
               }]);
            }]);
         },true,false,2);
      }
      
      private function onOpenLetterHandler(param1:MouseEvent) : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("letter");
         _map.front.addChild(this._mc_0);
         var _loc2_:SimpleButton = this._mc_0["closeBtn"];
         _loc2_.addEventListener(MouseEvent.CLICK,this.onCloseLetterHandler);
      }
      
      private function onCloseLetterHandler(param1:MouseEvent) : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onStep4Complete);
         QuestManager.completeStep(_quest.id,4);
      }
      
      private function onStep4Complete(param1:QuestEvent) : void
      {
         AlertManager.showAlert("恭喜你获得了橡皮神君种子！");
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep4Complete);
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
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStep4Complete);
      }
   }
}
