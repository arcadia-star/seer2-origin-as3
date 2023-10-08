package com.taomee.seer2.app.processor.quest.handler.branch.quest10090
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.record.FightRecordData;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10090_212 extends QuestMapHandler
   {
       
      
      private var _fightNum1:int;
      
      private var _fightNum2:int;
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _closeBtn:SimpleButton;
      
      private var _closeBtn1:SimpleButton;
      
      public function QuestMapHandler_10090_212(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         var _loc1_:int = 0;
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
            {
               if(FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.positionIndex) && Boolean(FightManager.currentFightRecord.initData.type) && FightManager.currentFightRecord.initData.type == FightRecordData.FIGHT_WILD)
               {
                  _loc1_ = int(FightManager.currentFightRecord.initData.positionIndex);
                  if(SceneManager.active.mapID == 212 && _loc1_ >= 0 && _loc1_ <= 9)
                  {
                     this.executeMiao();
                  }
               }
            }
         }
      }
      
      private function executeMiao() : void
      {
         if(DateUtil.inInDateScope(6,14,30,15,1))
         {
            this._fightNum1 = _quest.getStepData(_quest.getCurrentOrNextStep().id,0);
            if(this._fightNum1 < 5)
            {
               ++this._fightNum1;
               _quest.setStepData(_quest.getCurrentOrNextStep().id,0,this._fightNum1);
               QuestManager.addEventListener(QuestEvent.STEP_UPDATE_BUFFER,this.onStepUpdateBuffer);
               QuestManager.setStepBufferServer(_quest.id,_quest.getCurrentOrNextStep().id);
            }
         }
      }
      
      private function onStepUpdateBuffer(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            this._fightNum1 = _quest.getStepData(_quest.getCurrentOrNextStep().id,0);
            this._fightNum2 = _quest.getStepData(_quest.getCurrentOrNextStep().id,1);
            QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER,this.onStepUpdateBuffer);
            if(this._fightNum1 < 5)
            {
               ServerMessager.addMessage("已经得到了" + this._fightNum1 + "个坚硬外壳,还需要打" + (5 - this._fightNum1).toString() + "只蓝喵.");
            }
            else if(this._fightNum1 == 5)
            {
               ServerMessager.addMessage("已经得到了5个坚硬外壳.");
               if(this._fightNum2 == 5)
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
                  QuestManager.completeStep(_quest.id,1);
               }
               else
               {
                  this.updatePanel();
               }
            }
         }
      }
      
      private function updatePanel() : void
      {
         var $mc:MovieClip;
         var closeBtn:SimpleButton = null;
         var goBtn1:SimpleButton = null;
         var goBtn2:SimpleButton = null;
         var num1:TextField = null;
         var num2:TextField = null;
         var noMc1:MovieClip = null;
         var noMc2:MovieClip = null;
         var okMc1:MovieClip = null;
         var okMc2:MovieClip = null;
         this._mc_1 = _processor.resLib.getMovieClip("mc_0");
         _map.front.addChild(this._mc_1);
         $mc = this._mc_1 as MovieClip;
         goBtn1 = $mc["goBtn1"] as SimpleButton;
         goBtn1.visible = false;
         goBtn2 = $mc["goBtn2"] as SimpleButton;
         goBtn2.addEventListener(MouseEvent.CLICK,function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,191);
         });
         num1 = $mc["num1"] as TextField;
         num2 = $mc["num2"] as TextField;
         num1.text = this._fightNum1.toString();
         num2.text = this._fightNum2.toString();
         this._closeBtn1 = $mc["closeBtn"] as SimpleButton;
         this._closeBtn1.addEventListener(MouseEvent.CLICK,this.onClosePanel1Handler);
         noMc1 = $mc["no1"] as MovieClip;
         noMc2 = $mc["no2"] as MovieClip;
         okMc1 = $mc["ok1"] as MovieClip;
         okMc2 = $mc["ok2"] as MovieClip;
         okMc2.visible = false;
         if(DateUtil.inInDateScope(6,14,30,15,1))
         {
            okMc1.visible = true;
            goBtn2.visible = true;
            noMc1.visible = false;
            noMc2.visible = false;
         }
         else
         {
            okMc1.visible = true;
            goBtn2.visible = false;
            noMc1.visible = false;
            noMc2.visible = true;
         }
      }
      
      private function onClosePanel1Handler(param1:MouseEvent) : void
      {
         this._closeBtn1.removeEventListener(MouseEvent.CLICK,this.onClosePanel);
         DisplayUtil.removeForParent(this._mc_1);
      }
      
      private function onStep1Complete(param1:QuestEvent) : void
      {
         var $mc:MovieClip;
         var goBtn:SimpleButton = null;
         var noMc:MovieClip = null;
         var evt:QuestEvent = param1;
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
         this._mc_0 = _processor.resLib.getMovieClip("mc_7");
         _map.front.addChild(this._mc_0);
         $mc = this._mc_0 as MovieClip;
         goBtn = $mc["goBtn"] as SimpleButton;
         goBtn.addEventListener(MouseEvent.CLICK,function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Complete);
            QuestManager.completeStep(_quest.id,2);
         });
         this._closeBtn = $mc["closeBtn1"] as SimpleButton;
         this._closeBtn.addEventListener(MouseEvent.CLICK,this.onClosePanel);
         noMc = $mc["no_0"] as MovieClip;
         if(DateUtil.inInDateScope(6,14,30,15,1))
         {
            goBtn.visible = true;
            noMc.visible = false;
         }
         else
         {
            goBtn.visible = false;
            noMc.visible = true;
         }
      }
      
      private function onClosePanel(param1:MouseEvent) : void
      {
         this._closeBtn.removeEventListener(MouseEvent.CLICK,this.onClosePanel);
         DisplayUtil.removeForParent(this._mc_0);
      }
      
      private function onStep2Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         SceneManager.changeScene(SceneType.LOBBY,870);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
      }
   }
}
