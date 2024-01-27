package com.taomee.seer2.app.processor.quest.handler.branch.quest10079 {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightEndReason;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.dialog.events.FunctionalityBoxEvent;
import com.taomee.seer2.app.dialog.functionality.QuestNewUnit;
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.item.EquipItem;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.net.parser.Parser_1065;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.ActivePet;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.HitTest;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.Tick;

public class QuestMapHandler_10079_810 extends QuestMapHandler {


    private var _myself:Actor;

    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    private var _isGame:Boolean;

    private var _fightCount:int;

    private var _hitCount:int = 1;

    private var _fightStatus:Boolean;

    private var _teleport:Teleport;

    private var _pets:Vector.<ActivePet>;

    private var _mapPointList:Array;

    private var _petPoint:Point;

    private var _petCount:int;

    public function QuestMapHandler_10079_810(param1:QuestProcessor) {
        this._mapPointList = [[522, 114], [860, 321], [555, 472], [661, 248], [804, 432]];
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this._myself = ActorManager.getActor();
        this._teleport = AnimateElementManager.getElement(1) as Teleport;
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStartHandler);
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onTestFightHandler);
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onFirstFightHandler);
            if (this._fightStatus) {
                this._fightStatus = false;
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    this.win();
                }
            }
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.initNpc();
        }
    }

    private function onStartHandler(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "10079_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStartHandler);
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
            QuestManager.accept(_quest.id);
        }
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        var evt:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        NpcDialog.show(481, "耐普图隆", [[1, "现在我会张开一张结界，那些被污染的孩子们会试图靠近这里。请保证在他们接触到结界之前用鼠标点击净化他们！"]], ["行！包在我身上！", "我是打酱油的。"], [function ():void {
            _myself.hide();
            ActorManager.showRemoteActor = false;
            _mc_0 = _processor.resLib.getMovieClip("mc_0");
            _map.front.addChild(_mc_0);
            MovieClipUtil.playMc(_mc_0, 1, _mc_0.totalFrames, function ():void {
                loadnpc();
            }, true);
        }, function ():void {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, onTestFightHandler);
        }]);
    }

    private function onTestFightHandler(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if ((evt.content as DialogPanelEventData).params == "10079_1") {
            this._myself = ActorManager.getActor();
            this._myself.hide();
            ActorManager.showRemoteActor = false;
            this._mc_0 = _processor.resLib.getMovieClip("mc_0");
            _map.front.addChild(this._mc_0);
            MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
                loadnpc();
            }, true);
        }
    }

    private function loadnpc():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_1");
        this._mc_1 = _processor.resLib.getMovieClip("mc_2");
        _map.front.addChild(this._mc_1);
        _map.front.addChild(this._mc_0);
        this._mc_1.gotoAndStop(1);
        this.createPets();
    }

    private function createPets():void {
        var _loc2_:ActivePet = null;
        this._teleport.visible = false;
        this._pets = new Vector.<ActivePet>();
        var _loc1_:uint = 0;
        while (_loc1_ < 5) {
            _loc2_ = new ActivePet(new Point(this._mapPointList[_loc1_][0], this._mapPointList[_loc1_][1]), 1045);
            _loc2_.addEventListener(MouseEvent.CLICK, this.onPetHandler);
            _loc2_.targetPoint = new Point(380, 400);
            MobileManager.addMobile(_loc2_, MobileType.MODEL_PET);
            this._pets.push(_loc2_);
            _loc1_++;
        }
        Tick.instance.addRender(this.hasHitOn, 100);
    }

    private function onPetHandler(param1:MouseEvent):void {
        var _loc2_:ActivePet = param1.currentTarget as ActivePet;
        this._petPoint = new Point(_loc2_.x, _loc2_.y);
        this.loadPetEffect(1);
        MobileManager.removeMobile(_loc2_, MobileType.MODEL_PET);
        var _loc3_:int = this._pets.indexOf(_loc2_);
        if (_loc3_ != -1) {
            this._pets.splice(_loc3_, 1);
        }
        var _loc4_:int;
        if ((_loc4_ = int(this._pets.length)) == 0) {
            if (this._petCount >= 5 && this._hitCount <= 10) {
                this._petCount = 0;
                this._hitCount = 1;
                if (!this._isGame) {
                    this._teleport.visible = true;
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepOne);
                    QuestManager.completeStep(_quest.id, 1);
                } else {
                    this._teleport.visible = true;
                    if (this._mc_0) {
                        DisplayUtil.removeForParent(this._mc_0);
                    }
                    if (this._mc_1) {
                        DisplayUtil.removeForParent(this._mc_1);
                    }
                    this._myself.show();
                    ActorManager.showRemoteActor = true;
                    Connection.addErrorHandler(CommandSet.DIGGER_MINE_1060, this.onGerRewardError);
                    Connection.addCommandListener(CommandSet.DIGGER_MINE_1060, this.onGetRewardSuccess);
                    Connection.send(CommandSet.DIGGER_MINE_1060, 117);
                }
                return;
            }
            if (this._hitCount <= 10) {
                ++this._petCount;
                this.createPets();
            } else {
                this._hitCount = 1;
                this.NpcNiteTalk();
            }
        }
    }

    private function loadPetEffect(param1:uint):void {
        if (param1 == 1) {
            this.onLoadComplete();
        } else if (param1 == 0) {
            this.onHitComplete();
        }
    }

    private function onLoadComplete():void {
        var mc:MovieClip = null;
        mc = UIManager.getMovieClip("PetEffect_UI");
        mc.x = this._petPoint.x;
        mc.y = this._petPoint.y;
        SceneManager.active.mapModel.content.addChild(mc);
        MovieClipUtil.getChild(mc, 2, 0, function (param1:DisplayObject):void {
            var _loc2_:MovieClip = param1 as MovieClip;
            MovieClipUtil.playMc(_loc2_, 1, _loc2_.totalFrames);
        });
    }

    private function onHitComplete():void {
        var mc:MovieClip = null;
        mc = UIManager.getMovieClip("PetEffect_UI");
        mc.x = this._petPoint.x;
        mc.y = this._petPoint.y;
        SceneManager.active.mapModel.content.addChild(mc);
        MovieClipUtil.getChild(mc, 1, 0, function (param1:DisplayObject):void {
            var _loc2_:MovieClip = param1 as MovieClip;
            MovieClipUtil.playMc(_loc2_, 1, _loc2_.totalFrames);
        });
    }

    private function hasHitOn(param1:int):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:Rectangle = null;
        var _loc6_:ActivePet = null;
        var _loc7_:uint = 0;
        var _loc5_:int = 0;
        while (_loc5_ < this._pets.length) {
            if ((Boolean(_loc6_ = this._pets[_loc5_])) && Boolean(HitTest.complexHitTestObject(_loc6_, this._mc_0))) {
                _loc4_ = HitTest.intersectionRectangle(_loc6_, this._mc_0);
                ++this._hitCount;
                if (this._hitCount > 10) {
                    this._petCount = 0;
                    this._hitCount = 1;
                    this.NpcNiteTalk();
                    Tick.instance.removeRender(this.hasHitOn);
                    _loc7_ = 0;
                    while (_loc7_ < this._pets.length) {
                        MobileManager.removeMobile(this._pets[_loc7_], MobileType.MODEL_PET);
                        _loc7_++;
                    }
                    this._pets.length = 0;
                } else {
                    this._mc_1.gotoAndStop(this._hitCount);
                    this._petPoint = new Point(_loc4_.x, _loc4_.y + _loc4_.height);
                    this.loadPetEffect(0);
                    MobileManager.removeMobile(_loc6_, MobileType.MODEL_PET);
                    _loc3_ = this._pets.indexOf(_loc6_);
                    if (_loc3_ != -1) {
                        this._pets.splice(_loc3_, 1);
                    }
                    _loc2_ = int(this._pets.length);
                    if (_loc2_ == 0) {
                        if (this._petCount >= 5 && this._hitCount <= 10) {
                            this._teleport.visible = true;
                            this._petCount = 0;
                            this._hitCount = 1;
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepOne);
                            QuestManager.completeStep(_quest.id, 1);
                            return;
                        }
                        ++this._petCount;
                        this.createPets();
                    }
                }
            }
            _loc5_++;
        }
    }

    private function NpcNiteTalk():void {
        this._teleport.visible = true;
        LayerManager.resetOperation();
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        this._myself.show();
        ActorManager.showRemoteActor = true;
        NpcDialog.show(481, "耐普图隆", [[2, "不行，我的结界被打破了，水源被污染了……"]], ["再来一次！", "我是打酱油的。"], [function ():void {
            _myself = ActorManager.getActor();
            _myself.hide();
            ActorManager.showRemoteActor = false;
            if (_isGame) {
                _mc_0 = _processor.resLib.getMovieClip("mc_3");
            } else {
                _mc_0 = _processor.resLib.getMovieClip("mc_0");
            }
            _map.front.addChild(_mc_0);
            MovieClipUtil.playMc(_mc_0, 1, _mc_0.totalFrames, function ():void {
                loadnpc();
            }, true);
        }]);
    }

    private function onStepOne(param1:QuestEvent):void {
        var evt:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepOne);
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        this._myself.show();
        ActorManager.showRemoteActor = true;
        NpcDialog.show(481, "耐普图隆", [[1, "感谢你……拯救了那些可怜的孩子，拯救了星球的脉流。如果你可以完成我的最后试炼，我就跟你走。"]], ["没问题！开始吧！", "我是打酱油的。"], [function ():void {
            initQuest();
        }, function ():void {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, onFirstFightHandler);
        }]);
    }

    private function initQuest():void {
        Connection.addCommandListener(CommandSet.ACTIVE_COUNT_1142, this.onGetPanel);
        Connection.addErrorHandler(CommandSet.ACTIVE_COUNT_1142, this.onGetActiveCountError);
        Connection.send(CommandSet.ACTIVE_COUNT_1142, 1, 202031);
    }

    private function onGetActiveCountError(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142, this.onGetPanel);
        Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142, this.onGetActiveCountError);
        AlertManager.showAlert("获取信息失败");
    }

    private function onGetPanel(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142, this.onGetPanel);
        Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142, this.onGetActiveCountError);
        var _loc2_:Parser_1142 = new Parser_1142(param1.message.getRawData());
        this._fightCount = _loc2_.infoVec[0];
        if (this._fightCount <= 5) {
            this.switchNpcTalk(this._fightCount);
        } else {
            FightManager.startFightWithWild(98);
        }
    }

    private function onFirstFightHandler(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "10079_2") {
            this.initQuest();
        }
    }

    private function switchNpcTalk(param1:uint):void {
        var count:uint = param1;
        switch (count) {
            case 0:
                NpcDialog.show(481, "耐普图隆", [[0, "第一次试炼，你需要在15回合内击败我。"]], ["没问题！开始吧！", "我是打酱油的。"], [function ():void {
                    _fightStatus = true;
                    FightManager.startFightWithWild(93);
                }, function ():void {
                    DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, onFirstFightHandler);
                }]);
                break;
            case 1:
                NpcDialog.show(481, "耐普图隆", [[0, "第二次试炼，你需要在13回合内击败我。"]], ["没问题！开始吧！", "我是打酱油的。"], [function ():void {
                    _fightStatus = true;
                    FightManager.startFightWithWild(94);
                }]);
                break;
            case 2:
                NpcDialog.show(481, "耐普图隆", [[0, "第三次试炼，你需要在11回合内击败我。"]], ["没问题！开始吧！", "我是打酱油的。"], [function ():void {
                    _fightStatus = true;
                    FightManager.startFightWithWild(95);
                }]);
                break;
            case 3:
                NpcDialog.show(481, "耐普图隆", [[0, "第四次试炼，你需要在9回合内击败我。"]], ["没问题！开始吧！", "我是打酱油的。"], [function ():void {
                    _fightStatus = true;
                    FightManager.startFightWithWild(96);
                }]);
                break;
            case 4:
                NpcDialog.show(481, "耐普图隆", [[0, "第五次试炼，你需要在7回合内击败我。"]], ["没问题！开始吧！", "我是打酱油的。"], [function ():void {
                    _fightStatus = true;
                    FightManager.startFightWithWild(97);
                }]);
                break;
            case 5:
                NpcDialog.show(481, "耐普图隆", [[0, "我想，你就是我一直寻找的伙伴，你可以与我一起守护这颗星球的脉流。爱丽丝，你会同意我的做法吧……？"]], ["她一定会为你感到高兴的！"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep2Complete);
                    QuestManager.completeStep(_quest.id, 2);
                }]);
        }
    }

    private function onStep2Complete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Complete);
        this.initNpc();
    }

    private function initNpc():void {
        DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW, this.onNpcHandler);
    }

    private function win():void {
        if (FightManager.endReason != FightEndReason.ESCAPE_END) {
            this.initQuest();
        }
    }

    private function onNpcHandler(param1:DialogPanelEvent):void {
        var _loc2_:QuestNewUnit = null;
        var _loc3_:QuestNewUnit = null;
        var _loc4_:QuestNewUnit = null;
        if (param1.content == 481) {
            _loc2_ = new QuestNewUnit();
            _loc2_.setData("水脉守卫战", 1, 2);
            DialogPanel.functionalityBox.addUnit(_loc2_);
            _loc2_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK, this.onQuestNewClick);
            _loc3_ = new QuestNewUnit();
            _loc3_.setData("奖品兑换", 2, 2);
            DialogPanel.functionalityBox.addUnit(_loc3_);
            _loc3_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK, this.onQuestNewClick);
            (_loc4_ = new QuestNewUnit()).setData("帮助净化水源", 3, 2);
            DialogPanel.functionalityBox.addUnit(_loc4_);
            _loc4_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK, this.onQuestNewClick);
        }
    }

    private function onQuestNewClick(param1:FunctionalityBoxEvent):void {
        switch (param1.content.questId) {
            case 1:
                FightManager.startFightWithWild(98);
                break;
            case 2:
                this.initExchangePanel();
                break;
            case 3:
                this.initHit();
        }
    }

    private function initHit():void {
        Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065, this.onPlayHint);
        Connection.send(CommandSet.DAILY_LIMIT_1065, 397);
    }

    private function onPlayHint(param1:MessageEvent):void {
        var parser:Parser_1065;
        var count:uint;
        var evt:MessageEvent = param1;
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onPlayHint);
        parser = new Parser_1065(evt.message.getRawDataCopy());
        count = parser.count;
        if (count < 10) {
            this._isGame = true;
            this._myself.hide();
            ActorManager.showRemoteActor = false;
            this._mc_0 = _processor.resLib.getMovieClip("mc_3");
            _map.front.addChild(this._mc_0);
            MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
                loadnpc();
            }, true);
        } else {
            NpcDialog.show(481, "耐普图隆", [[1, "今天，水源已经得到净化了……感谢你……！"]], ["那我明天再来帮你!"]);
        }
    }

    private function onGerRewardError(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060, this.onGerRewardError);
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.onGetRewardSuccess);
        AlertManager.showAlert("很遗憾，本次抽奖失败!");
    }

    private function onGetRewardSuccess(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060, this.onGerRewardError);
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.onGetRewardSuccess);
        var _loc2_:Parser_1060 = new Parser_1060(param1.message.getRawData());
        _loc2_.showResult(true);
    }

    private function initExchangePanel():void {
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
        close_btn.addEventListener(MouseEvent.CLICK, this.onClosePanel);
        pre_btn = this._mc_2["panel"]["preBtn"] as SimpleButton;
        pre_btn.addEventListener(MouseEvent.CLICK, this.onPreFrame);
        next_btn = this._mc_2["panel"]["nextBtn"] as SimpleButton;
        next_btn.addEventListener(MouseEvent.CLICK, this.onNextFrame);
        countText = this._mc_2["panel"]["countTxt"] as TextField;
        ItemManager.requestItemList(function ():void {
            var _loc1_:PetInfo = null;
            var _loc2_:PetInfo = null;
            var _loc3_:SimpleButton = null;
            var _loc4_:SimpleButton = null;
            gameCoin = ItemManager.getItemQuantityByReferenceId(400110);
            countText.text = gameCoin.toString();
            for each(_loc2_ in PetInfoManager.getAllBagPetInfo()) {
                if (_loc2_.bunchId == 108) {
                    _loc1_ = _loc2_;
                    thing1Coin = _loc1_.emblemId;
                }
            }
            _loc3_ = _mc_2["panel0"]["btn0"] as SimpleButton;
            _loc4_ = _mc_2["panel0"]["btn00"] as SimpleButton;
            if (thing1Coin != 0) {
                _loc3_.visible = false;
                _loc4_.visible = true;
            } else {
                _loc4_.visible = false;
                _loc3_.visible = true;
                if (gameCoin >= 30) {
                    _loc3_.addEventListener(MouseEvent.CLICK, onExchangeHandler1);
                } else {
                    _loc3_.mouseEnabled = false;
                    _loc3_.alpha = 0.5;
                }
            }
        });
        ItemManager.requestEquipList(function ():void {
            var _loc1_:Vector.<EquipItem> = ItemManager.getEquipVec();
            var _loc2_:uint = 0;
            while (_loc2_ < _loc1_.length) {
                if (_loc1_[_loc2_].referenceId == 100358) {
                    thing2Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100359) {
                    thing3Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100360) {
                    thing4Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100361) {
                    thing5Coin = 1;
                }
                _loc2_++;
            }
            var _loc3_:SimpleButton = _mc_2["panel1"]["btn1"] as SimpleButton;
            var _loc4_:SimpleButton = _mc_2["panel1"]["btn11"] as SimpleButton;
            if (thing2Coin == 1) {
                _loc3_.visible = false;
                _loc4_.visible = true;
            } else {
                _loc4_.visible = false;
                _loc3_.visible = true;
                if (gameCoin >= 20) {
                    _loc3_.addEventListener(MouseEvent.CLICK, onExchangeHandler2);
                } else {
                    _loc3_.mouseEnabled = false;
                    _loc3_.alpha = 0.5;
                }
            }
            var _loc5_:SimpleButton = _mc_2["panel2"]["btn2"] as SimpleButton;
            var _loc6_:SimpleButton = _mc_2["panel2"]["btn22"] as SimpleButton;
            if (thing3Coin == 1) {
                _loc5_.visible = false;
                _loc6_.visible = true;
            } else {
                _loc6_.visible = false;
                _loc5_.visible = true;
                if (gameCoin >= 15) {
                    _loc5_.addEventListener(MouseEvent.CLICK, onExchangeHandler3);
                } else {
                    _loc5_.mouseEnabled = false;
                    _loc5_.alpha = 0.5;
                }
            }
            var _loc7_:SimpleButton = _mc_2["panel3"]["btn3"] as SimpleButton;
            var _loc8_:SimpleButton = _mc_2["panel3"]["btn33"] as SimpleButton;
            if (thing4Coin == 1) {
                _loc7_.visible = false;
                _loc8_.visible = true;
            } else {
                _loc8_.visible = false;
                _loc7_.visible = true;
                if (gameCoin >= 10) {
                    _loc7_.addEventListener(MouseEvent.CLICK, onExchangeHandler4);
                } else {
                    _loc7_.mouseEnabled = false;
                    _loc7_.alpha = 0.5;
                }
            }
            var _loc9_:SimpleButton = _mc_2["panel4"]["btn4"] as SimpleButton;
            var _loc10_:SimpleButton = _mc_2["panel4"]["btn44"] as SimpleButton;
            if (thing5Coin == 1) {
                _loc9_.visible = false;
                _loc10_.visible = true;
            } else {
                _loc10_.visible = false;
                _loc9_.visible = true;
                if (gameCoin >= 15) {
                    _loc9_.addEventListener(MouseEvent.CLICK, onExchangeHandler5);
                } else {
                    _loc9_.mouseEnabled = false;
                    _loc9_.alpha = 0.5;
                }
            }
        });
        i = 0;
        while (i < 5) {
            mc = this._mc_2["panel" + i] as MovieClip;
            if (i < 3) {
                mc.visible = true;
            } else {
                mc.visible = false;
            }
            i++;
        }
        _map.front.addChild(this._mc_2);
    }

    private function onClosePanel(param1:MouseEvent):void {
        var _loc2_:SimpleButton = this._mc_2["panel"]["closeBtn"] as SimpleButton;
        _loc2_.removeEventListener(MouseEvent.CLICK, this.onClosePanel);
        DisplayUtil.removeForParent(this._mc_2);
    }

    private function onPreFrame(param1:MouseEvent):void {
        var _loc4_:MovieClip = null;
        var _loc2_:SimpleButton = this._mc_2["panel"]["closeBtn"] as SimpleButton;
        _loc2_.addEventListener(MouseEvent.CLICK, this.onClosePanel);
        var _loc3_:int = 0;
        while (_loc3_ < 5) {
            _loc4_ = this._mc_2["panel" + _loc3_] as MovieClip;
            if (_loc3_ < 3) {
                _loc4_.visible = true;
            } else {
                _loc4_.visible = false;
            }
            _loc3_++;
        }
    }

    private function onNextFrame(param1:MouseEvent):void {
        var _loc4_:MovieClip = null;
        var _loc2_:SimpleButton = this._mc_2["panel"]["closeBtn"] as SimpleButton;
        _loc2_.addEventListener(MouseEvent.CLICK, this.onClosePanel);
        var _loc3_:int = 0;
        while (_loc3_ < 5) {
            _loc4_ = this._mc_2["panel" + _loc3_] as MovieClip;
            if (_loc3_ < 3) {
                _loc4_.visible = false;
            } else {
                _loc4_.visible = true;
            }
            _loc3_++;
        }
    }

    private function onExchangeHandler1(param1:MouseEvent):void {
        var pet:PetInfo = null;
        var petInfo:PetInfo = null;
        var evt:MouseEvent = param1;
        for each(petInfo in PetInfoManager.getAllBagPetInfo()) {
            if (petInfo.bunchId == 108) {
                pet = petInfo;
            }
        }
        if (pet == null) {
            AlertManager.showAlert("你的精灵背包中没有与此纹章产生共鸣的精灵");
            return;
        }
        SwapManager.swapItem(330, pet.catchTime, this.updateExchangePanel, function (param1:int):void {
            switch (param1) {
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

    private function onExchangeHandler2(param1:MouseEvent):void {
        SwapManager.swapItem(331, 1, this.updateExchangePanel);
    }

    private function onExchangeHandler3(param1:MouseEvent):void {
        SwapManager.swapItem(332, 1, this.updateExchangePanel);
    }

    private function onExchangeHandler4(param1:MouseEvent):void {
        SwapManager.swapItem(333, 1, this.updateExchangePanelAgain);
    }

    private function onExchangeHandler5(param1:MouseEvent):void {
        SwapManager.swapItem(334, 1, this.updateExchangePanelAgain);
    }

    private function updateExchangePanel(param1:IDataInput):void {
        new SwapInfo(param1);
        this.initPanel(1);
    }

    private function updateExchangePanelAgain(param1:IDataInput):void {
        new SwapInfo(param1);
        this.initPanel(2);
    }

    private function initPanel(param1:int):void {
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
        ItemManager.requestItemList(function ():void {
            var _loc1_:PetInfo = null;
            var _loc2_:PetInfo = null;
            var _loc3_:SimpleButton = null;
            var _loc4_:SimpleButton = null;
            gameCoin = ItemManager.getItemQuantityByReferenceId(400110);
            countText.text = gameCoin.toString();
            for each(_loc2_ in PetInfoManager.getAllBagPetInfo()) {
                if (_loc2_.bunchId == 108) {
                    _loc1_ = _loc2_;
                    thing1Coin = _loc1_.emblemId;
                }
            }
            _loc3_ = _mc_2["panel0"]["btn0"] as SimpleButton;
            _loc4_ = _mc_2["panel0"]["btn00"] as SimpleButton;
            if (thing1Coin != 0) {
                _loc3_.visible = false;
                _loc4_.visible = true;
            } else {
                _loc4_.visible = false;
                _loc3_.visible = true;
                if (gameCoin >= 30) {
                    _loc3_.addEventListener(MouseEvent.CLICK, onExchangeHandler1);
                } else {
                    _loc3_.mouseEnabled = false;
                    _loc3_.alpha = 0.5;
                }
            }
        });
        ItemManager.requestEquipList(function ():void {
            var _loc1_:Vector.<EquipItem> = ItemManager.getEquipVec();
            var _loc2_:uint = 0;
            while (_loc2_ < _loc1_.length) {
                if (_loc1_[_loc2_].referenceId == 100358) {
                    thing2Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100359) {
                    thing3Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100360) {
                    thing4Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100361) {
                    thing5Coin = 1;
                }
                _loc2_++;
            }
            var _loc3_:SimpleButton = _mc_2["panel1"]["btn1"] as SimpleButton;
            var _loc4_:SimpleButton = _mc_2["panel1"]["btn11"] as SimpleButton;
            if (thing2Coin == 1) {
                _loc3_.visible = false;
                _loc4_.visible = true;
            } else {
                _loc4_.visible = false;
                _loc3_.visible = true;
                if (gameCoin >= 20) {
                    _loc3_.addEventListener(MouseEvent.CLICK, onExchangeHandler2);
                } else {
                    _loc3_.mouseEnabled = false;
                    _loc3_.alpha = 0.5;
                }
            }
            var _loc5_:SimpleButton = _mc_2["panel2"]["btn2"] as SimpleButton;
            var _loc6_:SimpleButton = _mc_2["panel2"]["btn22"] as SimpleButton;
            if (thing3Coin == 1) {
                _loc5_.visible = false;
                _loc6_.visible = true;
            } else {
                _loc6_.visible = false;
                _loc5_.visible = true;
                if (gameCoin >= 15) {
                    _loc5_.addEventListener(MouseEvent.CLICK, onExchangeHandler3);
                } else {
                    _loc5_.mouseEnabled = false;
                    _loc5_.alpha = 0.5;
                }
            }
            var _loc7_:SimpleButton = _mc_2["panel3"]["btn3"] as SimpleButton;
            var _loc8_:SimpleButton = _mc_2["panel3"]["btn33"] as SimpleButton;
            if (thing4Coin == 1) {
                _loc7_.visible = false;
                _loc8_.visible = true;
            } else {
                _loc8_.visible = false;
                _loc7_.visible = true;
                if (gameCoin >= 10) {
                    _loc7_.addEventListener(MouseEvent.CLICK, onExchangeHandler4);
                } else {
                    _loc7_.mouseEnabled = false;
                    _loc7_.alpha = 0.5;
                }
            }
            var _loc9_:SimpleButton = _mc_2["panel4"]["btn4"] as SimpleButton;
            var _loc10_:SimpleButton = _mc_2["panel4"]["btn44"] as SimpleButton;
            if (thing5Coin == 1) {
                _loc9_.visible = false;
                _loc10_.visible = true;
            } else {
                _loc10_.visible = false;
                _loc9_.visible = true;
                if (gameCoin >= 15) {
                    _loc9_.addEventListener(MouseEvent.CLICK, onExchangeHandler5);
                } else {
                    _loc9_.mouseEnabled = false;
                    _loc9_.alpha = 0.5;
                }
            }
        });
        if (page == 1) {
            i = 0;
            while (i < 5) {
                mc = this._mc_2["panel" + i] as MovieClip;
                if (i < 3) {
                    mc.visible = true;
                } else {
                    mc.visible = false;
                }
                i++;
            }
        } else {
            i = 0;
            while (i < 5) {
                mc1 = this._mc_2["panel" + i] as MovieClip;
                if (i < 3) {
                    mc1.visible = false;
                } else {
                    mc1.visible = true;
                }
                i++;
            }
        }
    }

    override public function processMapDispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStartHandler);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onTestFightHandler);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onFirstFightHandler);
    }
}
}
