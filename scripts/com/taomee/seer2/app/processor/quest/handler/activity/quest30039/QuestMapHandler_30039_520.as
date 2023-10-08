package com.taomee.seer2.app.processor.quest.handler.activity.quest30039
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30039_520 extends QuestMapHandler
   {
       
      
      private var _pig1:MovieClip;
      
      private var _pig2:MovieClip;
      
      private var _pig3:MovieClip;
      
      private var _pig:MovieClip;
      
      private var _ClickNum:int;
      
      public function QuestMapHandler_30039_520(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initFirstMc();
         }
      }
      
      private function initFirstMc() : void
      {
         this._pig1 = _processor.resLib.getMovieClip("pig1");
         _map.content.addChild(this._pig1);
         _processor.showMouseHintAt(869,264);
         this._pig1.buttonMode = true;
         this._pig1.addEventListener(MouseEvent.CLICK,this.onPigShowHandler);
      }
      
      private function onPigShowHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._pig1)
         {
            DisplayUtil.removeForParent(this._pig1);
         }
         this._pig2 = _processor.resLib.getMovieClip("pig2");
         _map.content.addChild(this._pig2);
         _processor.hideMouseClickHint();
         MovieClipUtil.playMc(this._pig2,1,this._pig2.totalFrames,function():void
         {
            if(_pig2)
            {
               DisplayUtil.removeForParent(_pig2);
            }
            if(_ClickNum < 1)
            {
               initFirstMc();
               ++_ClickNum;
            }
            else
            {
               initPig3();
            }
         },true);
      }
      
      private function initPig3() : void
      {
         this._pig3 = _processor.resLib.getMovieClip("pig3");
         _map.content.addChild(this._pig3);
         MovieClipUtil.playMc(this._pig3,1,this._pig3.totalFrames,function():void
         {
            if(_pig3)
            {
               DisplayUtil.removeForParent(_pig3);
            }
            _pig = _processor.resLib.getMovieClip("pig");
            _map.content.addChild(_pig);
            _pig.buttonMode = true;
            _pig.addEventListener(MouseEvent.CLICK,onPigTalkHandler);
         },true);
      }
      
      private function onPigTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(89,"皮皮格",[[2,"是赛尔呀！救救我弟弟吧，刚才他被狼妖抓走了，就要被做成烧乳猪了…哼哼…哼…"]],["你看到芙拉了吗？！"],[function():void
         {
            NpcDialog.show(89,"皮皮格",[[2,"看到了…狼妖说，芙拉正好可以做汤喝…"]],["( ⊙ o ⊙ )啊！它往哪跑了吗？"],[function():void
            {
               NpcDialog.show(89,"皮皮格",[[2,"狼妖好像很热，要去冰沁氏族，我不敢跟去，它太恐怖了！"]],["我一定会帮你们把伙伴救回来的！"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2CompleteHandler);
                  QuestManager.completeStep(_quest.id,2);
               }]);
            }]);
         }]);
      }
      
      private function onStep2CompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2CompleteHandler);
         SceneManager.changeScene(SceneType.LOBBY,620);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this._pig1)
         {
            DisplayUtil.removeForParent(this._pig1);
         }
         if(this._pig2)
         {
            DisplayUtil.removeForParent(this._pig2);
         }
         if(this._pig3)
         {
            DisplayUtil.removeForParent(this._pig3);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2CompleteHandler);
      }
   }
}
