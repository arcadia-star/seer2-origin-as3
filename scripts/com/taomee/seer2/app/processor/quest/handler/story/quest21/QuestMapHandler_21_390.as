package com.taomee.seer2.app.processor.quest.handler.story.quest21
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_21_390 extends QuestMapHandler
   {
       
      
      private var _acceptAnimation:MovieClip;
      
      private var _leaveAnimation:MovieClip;
      
      public function QuestMapHandler_21_390(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_quest.status == QuestStatus.ACCEPTABLE)
         {
            this.acceptQuest();
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this._acceptAnimation)
         {
            this._acceptAnimation.removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
         }
         super.processMapDispose();
      }
      
      private function acceptQuest() : void
      {
         this._acceptAnimation = _processor.resLib.getMovieClip("mc_0");
         this._leaveAnimation = _processor.resLib.getMovieClip("mc_1");
         _map.front.addChild(this._acceptAnimation);
         DisplayObjectUtil.enableButtonMode(this._acceptAnimation);
         this._acceptAnimation.addEventListener(MouseEvent.CLICK,this.onAcceptClick);
      }
      
      private function onAcceptClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         DisplayObjectUtil.disableButtonMode(this._acceptAnimation);
         this._acceptAnimation.removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
         NpcDialog.show(51,"兰德",[[1,"喂喂，和我去探险吧，我知道一个很好玩的地方哦！"]],["好孩子和坏孩子？"],[function():void
         {
            NpcDialog.show(51,"兰德",[[1,"喂！你，就是你！看起来你还不算笨，也有点实力，我特许你加入“无敌探险小队”！走，跟我们去探险吧！"]],["（这名字好傻！）"],[function():void
            {
               NpcDialog.show(52,"蒂萨特",[[1,"兰德德说了，要带我去看他的秘密基地和新朋友，你也一起来吧……"]],["秘密基地？有点兴趣！"],[function():void
               {
                  NpcDialog.show(51,"兰德",[[1,"哼哼好！“无敌探险小队”出发！第一站，地月主城！新来的要跟紧了，走丢了会很麻烦的！"]],["（要我保护你们就直说嘛……去地月主城！）"],[function():void
                  {
                     DisplayObjectUtil.removeFromParent(_acceptAnimation);
                     _map.front.addChild(_leaveAnimation);
                     MovieClipUtil.playMc(_leaveAnimation,1,_leaveAnimation.totalFrames,function():void
                     {
                        QuestManager.accept(_quest.id);
                        _processor.showMouseHintAt(650,270);
                     },true);
                  }]);
               }]);
            }]);
         }]);
      }
   }
}
