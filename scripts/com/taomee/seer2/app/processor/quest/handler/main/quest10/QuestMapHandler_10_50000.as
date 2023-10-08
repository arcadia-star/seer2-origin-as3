package com.taomee.seer2.app.processor.quest.handler.main.quest10
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_10;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10_50000 extends QuestMapHandler
   {
       
      
      private var _stepAnimation1:MovieClip;
      
      private var _stepAnimation2:MovieClip;
      
      private var _stepAnimation3:MovieClip;
      
      private var _goTransmitCabinClick:MovieClip;
      
      public function QuestMapHandler_10_50000(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_map.id == ActorManager.actorInfo.id)
         {
            this.extractAssets();
            if(_quest.status == QuestStatus.ACCEPTABLE)
            {
               this.processAccept();
            }
            else if(_quest.isStepCompletable(1))
            {
               this.processStep1();
            }
            else if(_quest.isStepCompletable(2))
            {
               _processor.showMouseHintAt(-90,300);
            }
         }
      }
      
      private function extractAssets() : void
      {
         this._stepAnimation1 = _processor.getMcFromLib("mc_50000_1");
         this._stepAnimation2 = _processor.getMcFromLib("mc_50000_2");
         this._stepAnimation3 = _processor.getMcFromLib("mc_50000_3");
         this._goTransmitCabinClick = _map.content["goTransmitCabin"];
      }
      
      private function processAccept() : void
      {
         _map.content.addChild(this._stepAnimation1);
         _processor.showMouseHintOver(this._stepAnimation1);
         this._stepAnimation1.addEventListener(MouseEvent.CLICK,this.onClickStepAnimation1_0);
         DisplayObjectUtil.enableButtonMode(this._stepAnimation1);
      }
      
      private function onClickStepAnimation1_0(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._stepAnimation1.removeEventListener(MouseEvent.CLICK,this.onClickStepAnimation1_0);
         _processor.hideMouseClickHint();
         DisplayObjectUtil.disableButtonMode(this._stepAnimation1);
         NpcDialog.show(11,"多罗",[[1,"吼吼……老大……第七分队……我们最强大！ (～ o ～)~zZ"]],["（这家伙竟然睡着了……）"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptQuest);
            QuestManager.accept(_quest.id);
         }]);
      }
      
      private function onAcceptQuest(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptQuest);
            this.processStep1();
         }
      }
      
      private function processStep1() : void
      {
         if(!QuestProcessor_10(_processor).hasEnterDream)
         {
            _map.content.addChild(this._stepAnimation1);
            _processor.showMouseHintOver(this._stepAnimation1);
            this._stepAnimation1.addEventListener(MouseEvent.CLICK,this.onClickStepAnimation1_1);
            DisplayObjectUtil.enableButtonMode(this._stepAnimation1);
         }
         else
         {
            _map.content.addChild(this._stepAnimation2);
            _processor.showMouseHintOver(this._stepAnimation2);
            this._stepAnimation2.addEventListener(MouseEvent.CLICK,this.onClickStepAnimation2_0);
            DisplayObjectUtil.enableButtonMode(this._stepAnimation2);
         }
      }
      
      private function onClickStepAnimation1_1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._stepAnimation1.removeEventListener(MouseEvent.CLICK,this.onClickStepAnimation1_1);
         _processor.hideMouseClickHint();
         DisplayObjectUtil.disableButtonMode(this._stepAnimation1);
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"额……我的头怎么也晕晕的……眼皮不听使唤了……Zzzz……"]],["（一个多罗……两个巴蒂……我睡着了吗？）"],[function():void
         {
            DisplayObjectUtil.removeFromParent(_stepAnimation1);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10_0"),function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,172);
            });
         }]);
      }
      
      private function onClickStepAnimation2_0(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._stepAnimation2.removeEventListener(MouseEvent.CLICK,this.onClickStepAnimation2_0);
         _processor.hideMouseClickHint();
         DisplayObjectUtil.disableButtonMode(this._stepAnimation2);
         NpcDialog.show(11,"多罗",[[0,"老大……你终于回来啦……我前面还在你家睡着了呢……你别说那个怪梦好吓人……"]],["不是这么巧合吧！"],[function():void
         {
            NpcDialog.show(10,"巴蒂",[[4,"队长！难道又和上次目灵兽出现的梦境一样？我也做了同样的梦！！！！这……这一定有问题！"]],[" 走！快去水脉氏族！"],[function():void
            {
               DisplayObjectUtil.removeFromParent(_stepAnimation2);
               _goTransmitCabinClick.visible = false;
               _map.content.addChild(_stepAnimation3);
               MovieClipUtil.playMc(_stepAnimation3,1,_stepAnimation3.totalFrames,function():void
               {
                  DisplayObjectUtil.removeFromParent(_stepAnimation3);
                  _goTransmitCabinClick.visible = true;
                  _processor.showMouseHintAt(-90,300);
                  QuestManager.completeStep(_quest.id,1);
               });
            }]);
         }]);
      }
      
      override public function processMapDispose() : void
      {
         this._stepAnimation1.removeEventListener(MouseEvent.CLICK,this.onClickStepAnimation1_0);
         this._stepAnimation1.removeEventListener(MouseEvent.CLICK,this.onClickStepAnimation1_1);
         this._stepAnimation2.removeEventListener(MouseEvent.CLICK,this.onClickStepAnimation2_0);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptQuest);
         super.processMapDispose();
      }
   }
}
