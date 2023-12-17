package com.taomee.seer2.app.processor.quest.handler.branch.quest10078
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.events.FunctionalityBoxEvent;
   import com.taomee.seer2.app.dialog.functionality.QuestNewUnit;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.net.parser.Parser_1065;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10078_800 extends QuestMapHandler
   {
       
      
      private var _userId:uint = 0;
      
      private var _fightStatusFirst:Boolean;
      
      private var _fightStatusEnd:Boolean;
      
      private var _fightStatus:Boolean;
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _mc_2:MovieClip;
      
      private var _btns:Array;
      
      public function QuestMapHandler_10078_800(param1:QuestProcessor)
      {
         this._btns = new Array();
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStart);
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepOne);
            QuestManager.completeStep(_quest.id,1);
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initNpcFirst();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStartFight);
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.initNpc();
            if(this._fightStatusFirst)
            {
               this._fightStatusFirst = false;
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  this.winFirst();
               }
               else
               {
                  this.noWinFirst();
               }
               return;
            }
            if(this._fightStatusEnd)
            {
               this._fightStatusEnd = false;
               if(FightManager.fightWinnerSide == FightSide.LEFT)
               {
                  this.winEnd();
               }
               else
               {
                  this.noWinEnd();
               }
            }
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.initNpcAgain();
         }
      }
      
      private function onStart(param1:DialogPanelEvent) : void
      {
         var myself:Actor = null;
         var evt:DialogPanelEvent = param1;
         if((evt.content as DialogPanelEventData).params == "10078_0")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStart);
            myself = ActorManager.getActor();
            myself.hide();
            MobileManager.getMobile(475,MobileType.NPC).visible = false;
            ActorManager.showRemoteActor = false;
            this._mc_0 = _processor.resLib.getMovieClip("mc_0");
            _map.front.addChild(this._mc_0);
            MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
            {
               QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
               QuestManager.accept(_quest.id);
            },true);
         }
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         this.load();
      }
      
      private function load() : void
      {
         DisplayUtil.removeForParent(this._mc_0);
         MobileManager.getMobile(475,MobileType.NPC).visible = true;
         var _loc1_:Actor = ActorManager.getActor();
         ActorManager.showRemoteActor = true;
         _loc1_.show();
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepOne);
         QuestManager.completeStep(_quest.id,1);
      }
      
      private function onStepOne(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOne);
         this.fedjackTalk();
      }
      
      private function fedjackTalk() : void
      {
         NpcDialog.show(475,"费德提克",[[1,"哟呵呵呵——多亏了你！主人说，能够和我同仇敌忾的就是伙伴！你先和我比试比试，如果能够战胜我十次，我就跟你走！"]],["没问题！开始吧！","我是打酱油的。"],[function():void
         {
            _fightStatusFirst = true;
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Complete);
            QuestManager.completeStep(_quest.id,2);
            FightManager.startFightWithWild(86);
         },function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Complete);
            QuestManager.completeStep(_quest.id,2);
         }]);
      }
      
      private function onStartFight(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "10078_1")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStartFight);
            this._fightStatusFirst = true;
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
            QuestManager.completeStep(_quest.id,2);
            FightManager.startFightWithWild(86);
         }
      }
      
      private function winFirst() : void
      {
         this.initQuest();
      }
      
      private function noWinFirst() : void
      {
         this.initQuest();
      }
      
      private function onStep2Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         this.initNpc();
      }
      
      private function initNpcFirst() : void
      {
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.onNpcFirst);
      }
      
      private function initNpc() : void
      {
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.onNpc);
      }
      
      private function initNpcAgain() : void
      {
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.onNpcAgain);
      }
      
      private function onNpcFirst(param1:DialogPanelEvent) : void
      {
         var _loc2_:QuestNewUnit = null;
         var _loc3_:QuestNewUnit = null;
         var _loc4_:QuestNewUnit = null;
         if(param1.content == 475)
         {
            _loc2_ = new QuestNewUnit();
            _loc2_.setData("草原狂想战",1,2);
            DialogPanel.functionalityBox.addUnit(_loc2_);
            _loc2_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK,this.onQuestNewClick);
            _loc3_ = new QuestNewUnit();
            _loc3_.setData("奖品兑换",2,2);
            DialogPanel.functionalityBox.addUnit(_loc3_);
            _loc3_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK,this.onQuestNewClick);
            (_loc4_ = new QuestNewUnit()).setData("帮助费德提克站岗",3,2);
            DialogPanel.functionalityBox.addUnit(_loc4_);
            _loc4_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK,this.onQuestNewClick);
         }
      }
      
      private function onNpc(param1:DialogPanelEvent) : void
      {
         var _loc2_:QuestNewUnit = null;
         var _loc3_:QuestNewUnit = null;
         var _loc4_:QuestNewUnit = null;
         if(param1.content == 475)
         {
            _loc2_ = new QuestNewUnit();
            _loc2_.setData("草原狂想战",1,3);
            DialogPanel.functionalityBox.addUnit(_loc2_);
            _loc2_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK,this.onQuestNewClick);
            _loc3_ = new QuestNewUnit();
            _loc3_.setData("奖品兑换",2,3);
            DialogPanel.functionalityBox.addUnit(_loc3_);
            _loc3_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK,this.onQuestNewClick);
            (_loc4_ = new QuestNewUnit()).setData("帮助费德提克站岗",3,3);
            DialogPanel.functionalityBox.addUnit(_loc4_);
            _loc4_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK,this.onQuestNewClick);
         }
      }
      
      private function onNpcAgain(param1:DialogPanelEvent) : void
      {
         var _loc2_:QuestNewUnit = null;
         var _loc3_:QuestNewUnit = null;
         var _loc4_:QuestNewUnit = null;
         if(param1.content == 475)
         {
            _loc2_ = new QuestNewUnit();
            _loc2_.setData("草原狂想战",1,4);
            DialogPanel.functionalityBox.addUnit(_loc2_);
            _loc2_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK,this.onQuestNewClick);
            _loc3_ = new QuestNewUnit();
            _loc3_.setData("奖品兑换",2,4);
            DialogPanel.functionalityBox.addUnit(_loc3_);
            _loc3_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK,this.onQuestNewClick);
            (_loc4_ = new QuestNewUnit()).setData("帮助费德提克站岗",3,4);
            DialogPanel.functionalityBox.addUnit(_loc4_);
            _loc4_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK,this.onQuestNewClick);
         }
      }
      
      private function onQuestNewClick(param1:FunctionalityBoxEvent) : void
      {
         switch(param1.content.questId)
         {
            case 1:
               this.initQuest();
               break;
            case 2:
               this.initExchangePanel();
               break;
            case 3:
               this.initStand();
         }
      }
      
      private function initQuest() : void
      {
         Connection.addCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetPanel);
         Connection.addErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
         Connection.send(CommandSet.ACTIVE_COUNT_1142,1,202029);
      }
      
      private function onGetActiveCountError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetPanel);
         Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
         AlertManager.showAlert("获取信息失败");
      }
      
      private function onGetPanel(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetPanel);
         Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
         var _loc2_:Parser_1142 = new Parser_1142(param1.message.getRawData());
         var _loc3_:uint = _loc2_.infoVec[0];
         this._mc_1 = _processor.resLib.getMovieClip("fight_panel");
         var _loc4_:TextField = new TextField();
         (_loc4_ = this._mc_1["count"]["num_text"] as TextField).text = _loc3_.toString();
         var _loc5_:SimpleButton = this._mc_1["fight_btn"] as SimpleButton;
         var _loc6_:SimpleButton;
         (_loc6_ = this._mc_1["close_btn"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onCloseHandler);
         if(_loc3_ < 9)
         {
            _map.front.addChild(this._mc_1);
            _loc5_.addEventListener(MouseEvent.CLICK,this.onContinueFight);
         }
         else if(_loc3_ == 9)
         {
            _map.front.addChild(this._mc_1);
            _loc5_.addEventListener(MouseEvent.CLICK,this.onFightEnd);
         }
         else if(_loc3_ >= 10)
         {
            this.onFight();
         }
      }
      
      private function onContinueFight(param1:MouseEvent) : void
      {
         DisplayUtil.removeForParent(this._mc_1);
         this._fightStatusFirst = true;
         FightManager.startFightWithWild(86);
      }
      
      private function onFightEnd(param1:MouseEvent) : void
      {
         DisplayUtil.removeForParent(this._mc_1);
         this._fightStatusEnd = true;
         FightManager.startFightWithWild(87);
      }
      
      private function onCloseHandler(param1:MouseEvent) : void
      {
         DisplayUtil.removeForParent(this._mc_1);
      }
      
      private function onFight() : void
      {
         this._fightStatus = true;
         FightManager.startFightWithWild(87);
      }
      
      private function winEnd() : void
      {
         NpcDialog.show(475,"费德提克",[[1,"哟呵呵呵——看来，你就是我一直在寻找的伙伴！我要加入你的队伍，不过你别忘记帮我对付乌鸦！"]],["行行行，别殃及无辜民众就行~~"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep3Complete);
            QuestManager.completeStep(_quest.id,3);
         }]);
      }
      
      private function noWinEnd() : void
      {
         this.initQuest();
      }
      
      private function onStep3Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
      }
      
      private function initStand() : void
      {
         Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065,this.onPlayStand);
         Connection.send(CommandSet.DAILY_LIMIT_1065,395);
      }
      
      private function onPlayStand(param1:MessageEvent) : void
      {
         var parser:Parser_1065;
         var count:uint;
         var myself:Actor = null;
         var evt:MessageEvent = param1;
         Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,this.onPlayStand);
         parser = new Parser_1065(evt.message.getRawDataCopy());
         count = parser.count;
         if(count < 10)
         {
            ActorManager.showRemoteActor = false;
            myself = ActorManager.getActor();
            myself.hide();
            this._mc_0 = _processor.resLib.getMovieClip("mc_1");
            _map.front.addChild(this._mc_0);
            _map.ground.addEventListener(MouseEvent.CLICK,this.onMovieHandler);
            _map.content.mouseChildren = false;
            _map.front.mouseChildren = false;
            MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
            {
               StandOK();
            });
         }
         else
         {
            NpcDialog.show(475,"费德提克",[[1,"哟呵呵呵——每天帮助我站十次岗就够了，剩下的我自己可以搞定！"]],["那我明天再来帮你！~~"],[function():void
            {
            }]);
         }
      }
      
      private function StandOK() : void
      {
         _map.ground.removeEventListener(MouseEvent.CLICK,this.onMovieHandler);
         _map.content.mouseChildren = true;
         _map.front.mouseChildren = true;
         ActorManager.showRemoteActor = true;
         DisplayUtil.removeForParent(this._mc_0);
         var _loc1_:Actor = ActorManager.getActor();
         _loc1_.show();
         Connection.addErrorHandler(CommandSet.DIGGER_MINE_1060,this.onGerRewardError);
         Connection.addCommandListener(CommandSet.DIGGER_MINE_1060,this.onGetRewardSuccess);
         Connection.send(CommandSet.DIGGER_MINE_1060,116);
      }
      
      private function onGerRewardError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060,this.onGerRewardError);
         Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060,this.onGetRewardSuccess);
         AlertManager.showAlert("很遗憾，本次抽奖失败!");
      }
      
      private function onGetRewardSuccess(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060,this.onGerRewardError);
         Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060,this.onGetRewardSuccess);
         var _loc2_:Parser_1060 = new Parser_1060(param1.message.getRawData());
         _loc2_.showResult(true);
      }
      
      private function onMovieHandler(param1:MouseEvent) : void
      {
         AlertManager.showConfirm("确定要放弃站岗吗？",this.giveUp);
      }
      
      private function giveUp() : void
      {
         _map.ground.removeEventListener(MouseEvent.CLICK,this.onMovieHandler);
         _map.content.mouseChildren = true;
         _map.front.mouseChildren = true;
         ActorManager.showRemoteActor = true;
         DisplayUtil.removeForParent(this._mc_0);
         var _loc1_:Actor = ActorManager.getActor();
         _loc1_.show();
      }
      
      private function initExchangePanel() : void
      {
         var close_btn:SimpleButton;
         var pre_btn:SimpleButton;
         var next_btn:SimpleButton;
         var i:int;
         var countText:TextField = null;
         var gameCoin:int = 0;
         var thing1Coin:int = 0;
         var thing2Coin:int = 0;
         var thing3Coin:int = 0;
         var thing4Coin:int = 0;
         var thing5Coin:int = 0;
         var mc:MovieClip = null;
         this._mc_2 = _processor.resLib.getMovieClip("exchange_panel");
         close_btn = this._mc_2["panel"]["closeBtn"] as SimpleButton;
         close_btn.addEventListener(MouseEvent.CLICK,this.onClosePanel);
         pre_btn = this._mc_2["panel"]["preBtn"] as SimpleButton;
         pre_btn.addEventListener(MouseEvent.CLICK,this.onPreFrame);
         next_btn = this._mc_2["panel"]["nextBtn"] as SimpleButton;
         next_btn.addEventListener(MouseEvent.CLICK,this.onNextFrame);
         countText = this._mc_2["panel"]["countTxt"] as TextField;
         ItemManager.requestItemList(function():void
         {
            var _loc1_:PetInfo = null;
            var _loc2_:PetInfo = null;
            var _loc3_:SimpleButton = null;
            var _loc4_:SimpleButton = null;
            gameCoin = ItemManager.getItemQuantityByReferenceId(400109);
            countText.text = gameCoin.toString();
            for each(_loc2_ in PetInfoManager.getAllBagPetInfo())
            {
               if(_loc2_.bunchId == 93)
               {
                  _loc1_ = _loc2_;
                  thing1Coin = _loc1_.emblemId;
               }
            }
            _loc3_ = _mc_2["panel0"]["btn0"] as SimpleButton;
            _loc4_ = _mc_2["panel0"]["btn00"] as SimpleButton;
            if(thing1Coin != 0)
            {
               _loc3_.visible = false;
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
               _loc3_.visible = true;
               if(gameCoin >= 30)
               {
                  _loc3_.addEventListener(MouseEvent.CLICK,onExchangeHandler1);
               }
               else
               {
                  _loc3_.mouseEnabled = false;
                  _loc3_.alpha = 0.5;
               }
            }
         });
         ItemManager.requestEquipList(function():void
         {
            var _loc1_:Vector.<EquipItem> = ItemManager.getEquipVec();
            var _loc2_:uint = 0;
            while(_loc2_ < _loc1_.length)
            {
               if(_loc1_[_loc2_].referenceId == 100353)
               {
                  thing2Coin = 1;
               }
               if(_loc1_[_loc2_].referenceId == 100354)
               {
                  thing3Coin = 1;
               }
               if(_loc1_[_loc2_].referenceId == 100355)
               {
                  thing4Coin = 1;
               }
               if(_loc1_[_loc2_].referenceId == 100356)
               {
                  thing5Coin = 1;
               }
               _loc2_++;
            }
            var _loc3_:SimpleButton = _mc_2["panel1"]["btn1"] as SimpleButton;
            var _loc4_:SimpleButton = _mc_2["panel1"]["btn11"] as SimpleButton;
            if(thing2Coin == 1)
            {
               _loc3_.visible = false;
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
               _loc3_.visible = true;
               if(gameCoin >= 20)
               {
                  _loc3_.addEventListener(MouseEvent.CLICK,onExchangeHandler2);
               }
               else
               {
                  _loc3_.mouseEnabled = false;
                  _loc3_.alpha = 0.5;
               }
            }
            var _loc5_:SimpleButton = _mc_2["panel2"]["btn2"] as SimpleButton;
            var _loc6_:SimpleButton = _mc_2["panel2"]["btn22"] as SimpleButton;
            if(thing3Coin == 1)
            {
               _loc5_.visible = false;
               _loc6_.visible = true;
            }
            else
            {
               _loc6_.visible = false;
               _loc5_.visible = true;
               if(gameCoin >= 15)
               {
                  _loc5_.addEventListener(MouseEvent.CLICK,onExchangeHandler3);
               }
               else
               {
                  _loc5_.mouseEnabled = false;
                  _loc5_.alpha = 0.5;
               }
            }
            var _loc7_:SimpleButton = _mc_2["panel3"]["btn3"] as SimpleButton;
            var _loc8_:SimpleButton = _mc_2["panel3"]["btn33"] as SimpleButton;
            if(thing4Coin == 1)
            {
               _loc7_.visible = false;
               _loc8_.visible = true;
            }
            else
            {
               _loc8_.visible = false;
               _loc7_.visible = true;
               if(gameCoin >= 10)
               {
                  _loc7_.addEventListener(MouseEvent.CLICK,onExchangeHandler4);
               }
               else
               {
                  _loc7_.mouseEnabled = false;
                  _loc7_.alpha = 0.5;
               }
            }
            var _loc9_:SimpleButton = _mc_2["panel4"]["btn4"] as SimpleButton;
            var _loc10_:SimpleButton = _mc_2["panel4"]["btn44"] as SimpleButton;
            if(thing5Coin == 1)
            {
               _loc9_.visible = false;
               _loc10_.visible = true;
            }
            else
            {
               _loc10_.visible = false;
               _loc9_.visible = true;
               if(gameCoin >= 15)
               {
                  _loc9_.addEventListener(MouseEvent.CLICK,onExchangeHandler5);
               }
               else
               {
                  _loc9_.mouseEnabled = false;
                  _loc9_.alpha = 0.5;
               }
            }
         });
         i = 0;
         while(i < 5)
         {
            mc = this._mc_2["panel" + i] as MovieClip;
            if(i < 3)
            {
               mc.visible = true;
            }
            else
            {
               mc.visible = false;
            }
            i++;
         }
         _map.front.addChild(this._mc_2);
      }
      
      private function onClosePanel(param1:MouseEvent) : void
      {
         var _loc2_:SimpleButton = this._mc_2["panel"]["closeBtn"] as SimpleButton;
         _loc2_.removeEventListener(MouseEvent.CLICK,this.onClosePanel);
         DisplayUtil.removeForParent(this._mc_2);
      }
      
      private function onPreFrame(param1:MouseEvent) : void
      {
         var _loc4_:MovieClip = null;
         var _loc2_:SimpleButton = this._mc_2["panel"]["closeBtn"] as SimpleButton;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClosePanel);
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = this._mc_2["panel" + _loc3_] as MovieClip;
            if(_loc3_ < 3)
            {
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc3_++;
         }
      }
      
      private function onNextFrame(param1:MouseEvent) : void
      {
         var _loc4_:MovieClip = null;
         var _loc2_:SimpleButton = this._mc_2["panel"]["closeBtn"] as SimpleButton;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClosePanel);
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = this._mc_2["panel" + _loc3_] as MovieClip;
            if(_loc3_ < 3)
            {
               _loc4_.visible = false;
            }
            else
            {
               _loc4_.visible = true;
            }
            _loc3_++;
         }
      }
      
      private function onExchangeHandler1(param1:MouseEvent) : void
      {
         var pet:PetInfo = null;
         var petInfo:PetInfo = null;
         var evt:MouseEvent = param1;
         for each(petInfo in PetInfoManager.getAllBagPetInfo())
         {
            if(petInfo.bunchId == 93)
            {
               pet = petInfo;
            }
         }
         if(pet == null)
         {
            AlertManager.showAlert("你的精灵背包中没有与此纹章产生共鸣的精灵");
            return;
         }
         SwapManager.swapItem(321,pet.catchTime,this.updateExchangePanel,function(param1:int):void
         {
            switch(param1)
            {
               case 33:
                  AlertManager.showAlert("精灵不在背包里");
                  break;
               case 126:
                  AlertManager.showAlert("此精灵已经有纹章啦");
                  break;
               case 52:
                  AlertManager.showAlert("没有权限使用纹章");
            }
         });
      }
      
      private function onExchangeHandler2(param1:MouseEvent) : void
      {
         SwapManager.swapItem(322,1,this.updateExchangePanel);
      }
      
      private function onExchangeHandler3(param1:MouseEvent) : void
      {
         SwapManager.swapItem(323,1,this.updateExchangePanel);
      }
      
      private function onExchangeHandler4(param1:MouseEvent) : void
      {
         SwapManager.swapItem(324,1,this.updateExchangePanelAgain);
      }
      
      private function onExchangeHandler5(param1:MouseEvent) : void
      {
         SwapManager.swapItem(325,1,this.updateExchangePanelAgain);
      }
      
      private function updateExchangePanel(param1:IDataInput) : void
      {
         new SwapInfo(param1);
         this.initPanel(1);
      }
      
      private function updateExchangePanelAgain(param1:IDataInput) : void
      {
         new SwapInfo(param1);
         this.initPanel(2);
      }
      
      private function initPanel(param1:int) : void
      {
         var countText:TextField = null;
         var gameCoin:int = 0;
         var thing1Coin:int = 0;
         var thing2Coin:int = 0;
         var thing3Coin:int = 0;
         var thing4Coin:int = 0;
         var thing5Coin:int = 0;
         var i:int = 0;
         var mc:MovieClip = null;
         var mc1:MovieClip = null;
         var page:int = param1;
         countText = this._mc_2["panel"]["countTxt"] as TextField;
         ItemManager.requestItemList(function():void
         {
            var _loc1_:PetInfo = null;
            var _loc2_:PetInfo = null;
            var _loc3_:SimpleButton = null;
            var _loc4_:SimpleButton = null;
            gameCoin = ItemManager.getItemQuantityByReferenceId(400109);
            countText.text = gameCoin.toString();
            for each(_loc2_ in PetInfoManager.getAllBagPetInfo())
            {
               if(_loc2_.bunchId == 93)
               {
                  _loc1_ = _loc2_;
                  thing1Coin = _loc1_.emblemId;
               }
            }
            _loc3_ = _mc_2["panel0"]["btn0"] as SimpleButton;
            _loc4_ = _mc_2["panel0"]["btn00"] as SimpleButton;
            if(thing1Coin != 0)
            {
               _loc3_.visible = false;
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
               _loc3_.visible = true;
               if(gameCoin >= 30)
               {
                  _loc3_.addEventListener(MouseEvent.CLICK,onExchangeHandler1);
               }
               else
               {
                  _loc3_.mouseEnabled = false;
                  _loc3_.alpha = 0.5;
               }
            }
         });
         ItemManager.requestEquipList(function():void
         {
            var _loc1_:Vector.<EquipItem> = ItemManager.getEquipVec();
            var _loc2_:uint = 0;
            while(_loc2_ < _loc1_.length)
            {
               if(_loc1_[_loc2_].referenceId == 100353)
               {
                  thing2Coin = 1;
               }
               if(_loc1_[_loc2_].referenceId == 100354)
               {
                  thing3Coin = 1;
               }
               if(_loc1_[_loc2_].referenceId == 100355)
               {
                  thing4Coin = 1;
               }
               if(_loc1_[_loc2_].referenceId == 100356)
               {
                  thing5Coin = 1;
               }
               _loc2_++;
            }
            var _loc3_:SimpleButton = _mc_2["panel1"]["btn1"] as SimpleButton;
            var _loc4_:SimpleButton = _mc_2["panel1"]["btn11"] as SimpleButton;
            if(thing2Coin == 1)
            {
               _loc3_.visible = false;
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
               _loc3_.visible = true;
               if(gameCoin >= 20)
               {
                  _loc3_.addEventListener(MouseEvent.CLICK,onExchangeHandler2);
               }
               else
               {
                  _loc3_.mouseEnabled = false;
                  _loc3_.alpha = 0.5;
               }
            }
            var _loc5_:SimpleButton = _mc_2["panel2"]["btn2"] as SimpleButton;
            var _loc6_:SimpleButton = _mc_2["panel2"]["btn22"] as SimpleButton;
            if(thing3Coin == 1)
            {
               _loc5_.visible = false;
               _loc6_.visible = true;
            }
            else
            {
               _loc6_.visible = false;
               _loc5_.visible = true;
               if(gameCoin >= 15)
               {
                  _loc5_.addEventListener(MouseEvent.CLICK,onExchangeHandler3);
               }
               else
               {
                  _loc5_.mouseEnabled = false;
                  _loc5_.alpha = 0.5;
               }
            }
            var _loc7_:SimpleButton = _mc_2["panel3"]["btn3"] as SimpleButton;
            var _loc8_:SimpleButton = _mc_2["panel3"]["btn33"] as SimpleButton;
            if(thing4Coin == 1)
            {
               _loc7_.visible = false;
               _loc8_.visible = true;
            }
            else
            {
               _loc8_.visible = false;
               _loc7_.visible = true;
               if(gameCoin >= 10)
               {
                  _loc7_.addEventListener(MouseEvent.CLICK,onExchangeHandler4);
               }
               else
               {
                  _loc7_.mouseEnabled = false;
                  _loc7_.alpha = 0.5;
               }
            }
            var _loc9_:SimpleButton = _mc_2["panel4"]["btn4"] as SimpleButton;
            var _loc10_:SimpleButton = _mc_2["panel4"]["btn44"] as SimpleButton;
            if(thing5Coin == 1)
            {
               _loc9_.visible = false;
               _loc10_.visible = true;
            }
            else
            {
               _loc10_.visible = false;
               _loc9_.visible = true;
               if(gameCoin >= 15)
               {
                  _loc9_.addEventListener(MouseEvent.CLICK,onExchangeHandler5);
               }
               else
               {
                  _loc9_.mouseEnabled = false;
                  _loc9_.alpha = 0.5;
               }
            }
         });
         if(page == 1)
         {
            i = 0;
            while(i < 5)
            {
               mc = this._mc_2["panel" + i] as MovieClip;
               if(i < 3)
               {
                  mc.visible = true;
               }
               else
               {
                  mc.visible = false;
               }
               i++;
            }
         }
         else
         {
            i = 0;
            while(i < 5)
            {
               mc1 = this._mc_2["panel" + i] as MovieClip;
               if(i < 3)
               {
                  mc1.visible = false;
               }
               else
               {
                  mc1.visible = true;
               }
               i++;
            }
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            this._mc_0 = null;
         }
         if(this._mc_1)
         {
            this._mc_1 = null;
         }
         if(this._mc_2)
         {
            this._mc_2 = null;
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepOne);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Complete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep3Complete);
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.onNpcFirst);
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.onNpc);
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.onNpcAgain);
      }
   }
}
