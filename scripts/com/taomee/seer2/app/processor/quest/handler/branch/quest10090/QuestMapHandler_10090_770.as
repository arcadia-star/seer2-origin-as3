package com.taomee.seer2.app.processor.quest.handler.branch.quest10090
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10090_770 extends QuestMapHandler
   {
       
      
      private var _fightNum1:int;
      
      private var _fightNum2:int;
      
      private var _fightStatusOne:Boolean;
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _shipMC:MovieClip;
      
      private var _closeBtn1:SimpleButton;
      
      private var _closeBtn2:SimpleButton;
      
      private var _num1:TextField;
      
      private var _num2:TextField;
      
      private var _teleport:Teleport;
      
      private var _endDate:uint;
      
      public function QuestMapHandler_10090_770(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._teleport = AnimateElementManager.getElement(2) as Teleport;
         this._endDate = new Date(2012,5,2,15,1).getTime() / 1000;
         if(DateUtil.inInDateScope(6,14,30,15,1))
         {
            this._teleport.visible = true;
         }
         else
         {
            this._teleport.visible = false;
         }
         if(QuestManager.isCanAccepted(_quest.id))
         {
            if(this._fightStatusOne)
            {
               this._fightStatusOne = false;
               this.blackManTalk();
            }
            else
            {
               this.initBlackMan();
            }
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initBlackManAgain();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            if(DateUtil.inInDateScope(6,14,30,15,1))
            {
               this.initBlackManLast();
            }
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            DisplayUtil.removeForParent(this._shipMC);
            this.playLastMC();
         }
      }
      
      private function initBlackMan() : void
      {
         if(TimeManager.getServerTime() < this._endDate)
         {
            this._mc_1 = _processor.resLib.getMovieClip("mc_1");
            _map.content.addChild(this._mc_1);
            this._mc_1.buttonMode = true;
            this._mc_1.addEventListener(MouseEvent.CLICK,this.blackTalkHandler);
         }
      }
      
      private function blackTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(121,"黑衣人",[[0,"要上去先过我这关！"]],["小米！等我！（进入对战）","我一会就来！"],[function():void
         {
            _fightStatusOne = true;
            FightManager.startFightWithWild(105);
         }]);
      }
      
      private function blackManTalk() : void
      {
         this._mc_1 = _processor.resLib.getMovieClip("mc_1");
         _map.content.addChild(this._mc_1);
         NpcDialog.show(121,"黑衣人",[[0,"软弱的赛尔！快滚！乘我没有改变主意之前！为什么……精灵不就是一个对战武器吗？有这么重要吗"]],["我不会扔下小米的！（继续）"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
            QuestManager.accept(_quest.id);
         }]);
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         this.blackManTalkAgain();
      }
      
      private function initBlackManAgain() : void
      {
         if(TimeManager.getServerTime() < this._endDate)
         {
            this._mc_1 = _processor.resLib.getMovieClip("mc_1");
            _map.content.addChild(this._mc_1);
            this._mc_1.buttonMode = true;
            this._mc_1.addEventListener(MouseEvent.CLICK,this.blackTalkAgainHandler);
         }
      }
      
      private function blackTalkAgainHandler(param1:MouseEvent) : void
      {
         this.blackManTalkAgain();
      }
      
      private function blackManTalkAgain() : void
      {
         NpcDialog.show(121,"黑衣人",[[0,"好！我帮你！飞船上有特殊的装置你无法靠近！需要蓝喵的坚硬外壳5个！安可的保护罩5个！该说的就这么多！拿到了再来找我！"]],["你到底是谁？","一会就来"],[function():void
         {
            var $mc:*;
            var mc:* = undefined;
            var noMc1:* = undefined;
            var noMc2:* = undefined;
            var okMc1:* = undefined;
            var okMc2:* = undefined;
            var goBtn1:* = undefined;
            var goBtn2:* = undefined;
            _fightNum1 = _quest.getStepData(_quest.getCurrentOrNextStep().id,0);
            _fightNum2 = _quest.getStepData(_quest.getCurrentOrNextStep().id,1);
            _mc_0 = _processor.resLib.getMovieClip("mc_0");
            _map.front.addChild(_mc_0);
            $mc = _mc_0 as MovieClip;
            goBtn1 = $mc["goBtn1"] as SimpleButton;
            goBtn1.addEventListener(MouseEvent.CLICK,function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,212);
            });
            goBtn2 = $mc["goBtn2"] as SimpleButton;
            goBtn2.addEventListener(MouseEvent.CLICK,function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,191);
            });
            okMc1 = $mc["ok1"] as MovieClip;
            okMc2 = $mc["ok2"] as MovieClip;
            _num1 = $mc["num1"] as TextField;
            _num2 = $mc["num2"] as TextField;
            _num1.text = _fightNum1.toString();
            _num2.text = _fightNum2.toString();
            _closeBtn1 = $mc["closeBtn"] as SimpleButton;
            _closeBtn1.addEventListener(MouseEvent.CLICK,onClosePanel);
            noMc1 = $mc["no1"] as MovieClip;
            noMc2 = $mc["no2"] as MovieClip;
            if(DateUtil.inInDateScope(6,14,30,15,1))
            {
               if(_fightNum2 == 5)
               {
                  goBtn2.visible = false;
                  okMc2.visible = true;
                  goBtn1.visible = true;
                  okMc1.visible = false;
               }
               else if(_fightNum1 == 5)
               {
                  goBtn1.visible = false;
                  okMc1.visible = true;
                  goBtn2.visible = true;
                  okMc2.visible = false;
               }
               else if(_fightNum2 != 5 && _fightNum1 != 5)
               {
                  goBtn1.visible = true;
                  goBtn2.visible = true;
                  okMc1.visible = false;
                  okMc2.visible = false;
               }
               noMc1.visible = false;
               noMc2.visible = false;
            }
            else
            {
               okMc1.visible = false;
               okMc2.visible = false;
               goBtn1.visible = false;
               goBtn2.visible = false;
               noMc1.visible = true;
               noMc2.visible = true;
            }
         },function():void
         {
            initBlackManAgain();
         }]);
      }
      
      private function onClosePanel(param1:MouseEvent) : void
      {
         this._closeBtn1.removeEventListener(MouseEvent.CLICK,this.onClosePanel);
         DisplayUtil.removeForParent(this._mc_0);
      }
      
      private function initBlackManLast() : void
      {
         if(TimeManager.getServerTime() < this._endDate)
         {
            this._mc_1 = _processor.resLib.getMovieClip("mc_1");
            _map.content.addChild(this._mc_1);
            this._mc_1.buttonMode = true;
            this._mc_1.addEventListener(MouseEvent.CLICK,this.blackTalkLastHandler);
         }
      }
      
      private function blackTalkLastHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(121,"黑衣人",[[0,"好自为之……去救你的伙伴吧！"]],["啊…………啊 …………"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Complete);
            QuestManager.completeStep(_quest.id,2);
         }]);
      }
      
      private function onStep2Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         SceneManager.changeScene(SceneType.LOBBY,870);
      }
      
      private function playLastMC() : void
      {
         if(this._mc_0)
         {
            this._mc_0 = null;
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_4");
         _map.front.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            _mc_0 = null;
            _mc_0 = _processor.resLib.getMovieClip("mc_5");
            _map.front.addChild(_mc_0);
            MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestCompleteHandler);
               QuestManager.completeStep(_quest.id,4);
            },true);
         },true);
      }
      
      private function onQuestCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestCompleteHandler);
         if(param1.questId == 10090)
         {
            DisplayUtil.removeForParent(this._mc_0);
            DisplayUtil.removeForParent(this._mc_1);
         }
      }
      
      override public function processMapDispose() : void
      {
         this._mc_0 = null;
         this._mc_1 = null;
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestCompleteHandler);
      }
   }
}
