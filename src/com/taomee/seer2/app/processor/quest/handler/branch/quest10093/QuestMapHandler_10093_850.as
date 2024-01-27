package com.taomee.seer2.app.processor.quest.handler.branch.quest10093 {
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
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.net.parser.Parser_1065;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10093_850 extends QuestMapHandler {


    private var _hasFight:Boolean;

    private var _hasFightAgain:Boolean;

    private var _hasHide:Boolean;

    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    private var _gang_mc:MovieClip;

    private var _seer_mc:MovieClip;

    private var _tips_mc:MovieClip;

    private var _upBtn_mc:MovieClip;

    private var _downBtn_mc:MovieClip;

    private var _middleBtn_mc:MovieClip;

    private var _upBtn1:MovieClip;

    private var _downBtn1:MovieClip;

    private var _middleBtn1:MovieClip;

    private var _upBtn2:MovieClip;

    private var _downBtn2:MovieClip;

    private var _middleBtn2:MovieClip;

    private var _help_mc:MovieClip;

    private var _time_mc:MovieClip;

    private var _blood_mc:MovieClip;

    private var _arr:Array;

    private var _blood_num:int = 2;

    private var _fight_num:int;

    private var _scene:LobbyScene;

    public function QuestMapHandler_10093_850(param1:QuestProcessor) {
        this._arr = ["1", "2", "3", "1", "2", "3", "1", "2", "3"];
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStepHandler);
            if (SceneManager.prevSceneType == SceneType.ARENA && this._hasFight) {
                this._hasFight = false;
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    this.win();
                } else {
                    this.noWin();
                }
            }
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStepOneHandler);
            if (SceneManager.prevSceneType == SceneType.ARENA && this._hasFightAgain) {
                this._hasFightAgain = false;
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    this.winAgain();
                } else {
                    this.noWinAgain();
                }
            } else {
                this.CreatNpc();
            }
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.initNpc();
        }
    }

    private function onStepHandler(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "10093_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStepHandler);
            this._hasFight = true;
            FightManager.startFightWithWild(116);
        }
    }

    private function onStepOneHandler(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "10093_1") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStepOneHandler);
            this._hasFightAgain = true;
            FightManager.startFightWithWild(117);
        }
    }

    private function win():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
            QuestManager.addEventListener(QuestEvent.ACCEPT, AcceptHandler);
            QuestManager.accept(_quest.id);
        }, true);
    }

    private function noWin():void {
        NpcDialog.show(494, "萨兰古尔", [[0, "如果和刚铎相比，你应该还差得远。"]], ["我不会输，再来！", "还是算了。"], [function ():void {
            _hasFight = true;
            FightManager.startFightWithWild(116);
        }]);
    }

    private function AcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.AcceptHandler);
        this.CreatNpc();
    }

    private function CreatNpc():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_1");
        _map.front.addChild(this._mc_0);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStepOneHandler);
        NpcDialog.show(494, "萨兰古尔", [[0, "我的训练师已经回来了，在这个情况之下，你还能战胜我吗？"]], ["不试试看怎么知道？", "还是算了。"], [function ():void {
            _hasFightAgain = true;
            FightManager.startFightWithWild(117);
        }]);
    }

    private function winAgain():void {
        NpcDialog.show(494, "萨兰古尔", [[1, "不愧是星球的希望，实力不同凡响。我想将我的小伙伴交给你，你会和它一起成长吧？"]], ["嗯，一定的！"], [function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1Complete);
            QuestManager.completeStep(_quest.id, 1);
        }]);
    }

    private function noWinAgain():void {
        NpcDialog.show(494, "萨兰古尔", [[0, "怎么样，作为训练师我比你强太多了！"]], ["我不会输，再来！", "还是算了。"], [function ():void {
            _hasFight = true;
            FightManager.startFightWithWild(116);
        }]);
    }

    private function onStep1Complete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Complete);
        this.initNpc();
    }

    private function initNpc():void {
        if (this._mc_0 == null) {
            this._mc_0 = _processor.resLib.getMovieClip("mc_1");
            _map.front.addChild(this._mc_0);
        }
        DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW, this.onNpcHandler);
    }

    private function onNpcHandler(param1:DialogPanelEvent):void {
        var _loc2_:QuestNewUnit = null;
        var _loc3_:QuestNewUnit = null;
        var _loc4_:QuestNewUnit = null;
        if (param1.content == 494) {
            _loc2_ = new QuestNewUnit();
            _loc2_.setData("最强训练师之战", 1, 2);
            DialogPanel.functionalityBox.addUnit(_loc2_);
            _loc2_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK, this.onQuestNewClick);
            _loc3_ = new QuestNewUnit();
            _loc3_.setData("奖品兑换", 2, 2);
            DialogPanel.functionalityBox.addUnit(_loc3_);
            _loc3_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK, this.onQuestNewClick);
            (_loc4_ = new QuestNewUnit()).setData("刚铎的强化训练", 3, 2);
            DialogPanel.functionalityBox.addUnit(_loc4_);
            _loc4_.addEventListener(FunctionalityBoxEvent.QUEST_NEW_CLICK, this.onQuestNewClick);
        }
    }

    private function onQuestNewClick(param1:FunctionalityBoxEvent):void {
        switch (param1.content.questId) {
            case 1:
                FightManager.startFightWithWild(118);
                break;
            case 2:
                this.initExchangePanel();
                break;
            case 3:
                this.initHit();
        }
    }

    private function initHit():void {
        var mc1:MovieClip = null;
        NpcDialog.show(93, "刚铎", [[1, "少年！现在我就要开始锻炼你身为训练师的能力了！做好准备了没有！！"]], ["悉听尊便，什么风雨我都招架得住！", "还是算了。"], [function ():void {
            Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065, onPlayHint);
            Connection.send(CommandSet.DAILY_LIMIT_1065, 420);
        }]);
    }

    private function onPlayHint(param1:MessageEvent):void {
        var parser:Parser_1065;
        var count:uint;
        var start_Btn:SimpleButton = null;
        var close_Btn:SimpleButton = null;
        var evt:MessageEvent = param1;
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onPlayHint);
        parser = new Parser_1065(evt.message.getRawDataCopy());
        count = parser.count;
        if (count < 10) {
            if (count < 1) {
                this._scene = SceneManager.active as LobbyScene;
                this._scene.hideToolbar();
                this._mc_1 = _processor.resLib.getMovieClip("mc_2");
                _map.front.addChild(this._mc_1);
                start_Btn = this._mc_1["startBtn"] as SimpleButton;
                close_Btn = this._mc_1["closeBtn"] as SimpleButton;
                close_Btn.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
                    if (_mc_1) {
                        DisplayUtil.removeForParent(_mc_1);
                    }
                });
                start_Btn.addEventListener(MouseEvent.CLICK, this.gotoNextPageHandler);
            } else {
                this._scene = SceneManager.active as LobbyScene;
                this._scene.hideToolbar();
                this.startFight();
            }
        } else {
            NpcDialog.show(93, "刚铎", [[1, "体力透支对第二天的训练不利，少年！今天就到此为止了"]], ["那我明天再来训练！"]);
        }
    }

    private function gotoNextPageHandler(param1:MouseEvent):void {
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        this._mc_1 = _processor.resLib.getMovieClip("mc_3");
        _map.front.addChild(this._mc_1);
        this._tips_mc = this._mc_1["tipss"] as MovieClip;
        this._gang_mc = this._mc_1["gang"] as MovieClip;
        this._seer_mc = this._mc_1["me"] as MovieClip;
        this._upBtn_mc = this._mc_1["upMC"] as MovieClip;
        this._downBtn_mc = this._mc_1["downMC"] as MovieClip;
        this._middleBtn_mc = this._mc_1["middleMC"] as MovieClip;
        this._time_mc = this._mc_1["jishi"] as MovieClip;
        this._blood_mc = this._mc_1["blood"] as MovieClip;
        this._help_mc = this._mc_1["help"] as MovieClip;
        this._upBtn1 = this._upBtn_mc["btn1"] as MovieClip;
        this._downBtn1 = this._downBtn_mc["btn2"] as MovieClip;
        this._middleBtn1 = this._middleBtn_mc["btn3"] as MovieClip;
        this.teacherMode();
    }

    private function startFight():void {
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        this._mc_1 = _processor.resLib.getMovieClip("mc_3");
        _map.front.addChild(this._mc_1);
        this._tips_mc = this._mc_1["tipss"] as MovieClip;
        DisplayUtil.removeForParent(this._tips_mc);
        this._gang_mc = this._mc_1["gang"] as MovieClip;
        this._seer_mc = this._mc_1["me"] as MovieClip;
        this._upBtn_mc = this._mc_1["upMC"] as MovieClip;
        this._downBtn_mc = this._mc_1["downMC"] as MovieClip;
        this._middleBtn_mc = this._mc_1["middleMC"] as MovieClip;
        this._time_mc = this._mc_1["jishi"] as MovieClip;
        this._blood_mc = this._mc_1["blood"] as MovieClip;
        this._help_mc = this._mc_1["help"] as MovieClip;
        this._upBtn1 = this._upBtn_mc["btn1"] as MovieClip;
        this._downBtn1 = this._downBtn_mc["btn2"] as MovieClip;
        this._middleBtn1 = this._middleBtn_mc["btn3"] as MovieClip;
        this.ChooseFight();
    }

    private function teacherMode():void {
        this._gang_mc.gotoAndPlay(26);
        this._upBtn_mc.gotoAndStop(2);
        this._upBtn2 = this._upBtn_mc.getChildAt(0) as MovieClip;
        this._upBtn2.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
            var evt:MouseEvent = param1;
            _upBtn_mc.gotoAndStop(1);
            _seer_mc.gotoAndPlay(26);
            _gang_mc.gotoAndPlay(26);
            _seer_mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
                var evt:Event = param1;
                if (_seer_mc.currentFrame == 50) {
                    _seer_mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                    _gang_mc.gotoAndPlay(51);
                    _downBtn_mc.gotoAndStop(2);
                    _tips_mc.gotoAndStop(2);
                    _downBtn2 = _downBtn_mc.getChildAt(0) as MovieClip;
                    _downBtn2.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
                        var evt:MouseEvent = param1;
                        _downBtn_mc.gotoAndStop(1);
                        _seer_mc.gotoAndPlay(51);
                        _gang_mc.gotoAndPlay(51);
                        _seer_mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
                            var evt:Event = param1;
                            if (_seer_mc.currentFrame == 75) {
                                _seer_mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                                _gang_mc.gotoAndPlay(76);
                                _middleBtn_mc.gotoAndStop(2);
                                _tips_mc.gotoAndStop(3);
                                _middleBtn2 = _middleBtn_mc.getChildAt(0) as MovieClip;
                                _middleBtn2.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
                                    var evt:MouseEvent = param1;
                                    _middleBtn_mc.gotoAndStop(1);
                                    _seer_mc.gotoAndPlay(76);
                                    _gang_mc.gotoAndPlay(76);
                                    _seer_mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
                                        var evt:Event = param1;
                                        if (_seer_mc.currentFrame == 100) {
                                            _seer_mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                                            _time_mc.gotoAndPlay(2);
                                            _gang_mc.gotoAndPlay(1);
                                            _tips_mc.visible = false;
                                            _time_mc.addEventListener(Event.ENTER_FRAME, function (param1:Event):void {
                                                if (_time_mc.currentFrame == 62) {
                                                    _time_mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                                                    ChooseFight();
                                                }
                                            });
                                        }
                                    });
                                });
                            }
                        });
                    });
                }
            });
        });
    }

    private function ChooseFight():void {
        var _loc1_:int = Math.random() * 9;
        var _loc2_:int = int(this._arr[_loc1_]);
        ++this._fight_num;
        if (this._fight_num < 16) {
            if (_loc2_ == 1) {
                this.StartFightOne(1);
            }
            if (_loc2_ == 2) {
                this.StartFightTwo(2);
            }
            if (_loc2_ == 3) {
                this.StartFightThree(3);
            }
        } else {
            this._fight_num = 0;
            this._blood_num = 2;
            this._scene.showToolbar();
            if (this._mc_1) {
                DisplayUtil.removeForParent(this._mc_1);
            }
            Connection.addCommandListener(CommandSet.DIGGER_MINE_1060, this.onGetRewardSuccess);
            Connection.send(CommandSet.DIGGER_MINE_1060, 147);
        }
    }

    private function onGetRewardSuccess(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.onGetRewardSuccess);
        var _loc2_:Parser_1060 = new Parser_1060(param1.message.getRawData());
        _loc2_.showResult(true);
    }

    private function StartFightOne(param1:int):void {
        this._upBtn_mc.gotoAndStop(2);
        this._upBtn2 = this._upBtn_mc.getChildAt(0) as MovieClip;
        this._help_mc.gotoAndPlay(1);
        this._help_mc.addEventListener(Event.ENTER_FRAME, this.helpThingOne);
    }

    private function StartFightTwo(param1:int):void {
        this._downBtn_mc.gotoAndStop(2);
        this._downBtn2 = this._downBtn_mc.getChildAt(0) as MovieClip;
        this._help_mc.gotoAndPlay(1);
        this._help_mc.addEventListener(Event.ENTER_FRAME, this.helpThingTwo);
    }

    private function StartFightThree(param1:int):void {
        this._help_mc.gotoAndPlay(1);
        this._help_mc.addEventListener(Event.ENTER_FRAME, this.helpThingThree);
    }

    private function onFrame(param1:Event):void {
        if (this._seer_mc.currentFrame == 75 || this._seer_mc.currentFrame == 50 || this._seer_mc.currentFrame == 100) {
            this._seer_mc.removeEventListener(Event.ENTER_FRAME, this.onFrame);
            this.ChooseFight();
        }
    }

    private function loseFrame(param1:Event):void {
        var evt:Event = param1;
        if (this._gang_mc.currentFrame == 51 || this._gang_mc.currentFrame == 76 || this._gang_mc.currentFrame == 101) {
            this._gang_mc.removeEventListener(Event.ENTER_FRAME, this.loseFrame);
            if (this._blood_num == 11) {
                this._blood_mc.gotoAndStop(11);
                this._scene.showToolbar();
                AlertManager.showAlert("你已经战斗失败！", function ():void {
                    if (_mc_1) {
                        _fight_num = 0;
                        _blood_num = 2;
                        DisplayUtil.removeForParent(_mc_1);
                    }
                    Connection.send(CommandSet.ITEM_EXCHANGE_1055, 434, 1, 0);
                });
            } else {
                this.ChooseFight();
            }
        }
    }

    private function helpThingOne(param1:Event):void {
        var evt:Event = param1;
        if (this._help_mc.currentFrame == this._help_mc.totalFrames) {
            this._upBtn_mc.gotoAndStop(1);
            this._help_mc.removeEventListener(Event.ENTER_FRAME, this.helpThingOne);
            this._gang_mc.gotoAndPlay(26);
            this._blood_mc.gotoAndStop(this._blood_num++);
            this._gang_mc.addEventListener(Event.ENTER_FRAME, this.loseFrame);
        } else {
            this._upBtn2.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
                _help_mc.removeEventListener(Event.ENTER_FRAME, helpThingOne);
                _upBtn_mc.gotoAndStop(1);
                _seer_mc.gotoAndPlay(26);
                _gang_mc.gotoAndPlay(26);
                _seer_mc.addEventListener(Event.ENTER_FRAME, onFrame);
            });
        }
    }

    private function helpThingTwo(param1:Event):void {
        var evt:Event = param1;
        if (this._help_mc.currentFrame == this._help_mc.totalFrames) {
            this._downBtn_mc.gotoAndStop(1);
            this._help_mc.removeEventListener(Event.ENTER_FRAME, this.helpThingTwo);
            this._gang_mc.gotoAndPlay(52);
            this._blood_mc.gotoAndStop(this._blood_num++);
            this._gang_mc.addEventListener(Event.ENTER_FRAME, this.loseFrame);
        } else {
            this._downBtn2.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
                _help_mc.removeEventListener(Event.ENTER_FRAME, helpThingTwo);
                _downBtn_mc.gotoAndStop(1);
                _seer_mc.gotoAndPlay(51);
                _gang_mc.gotoAndPlay(52);
                _seer_mc.addEventListener(Event.ENTER_FRAME, onFrame);
            });
        }
    }

    private function helpThingThree(param1:Event):void {
        var evt:Event = param1;
        if (this._help_mc.currentFrame == this._help_mc.totalFrames) {
            this._middleBtn_mc.gotoAndStop(1);
            this._help_mc.removeEventListener(Event.ENTER_FRAME, this.helpThingThree);
            this._gang_mc.gotoAndPlay(77);
            this._blood_mc.gotoAndStop(this._blood_num++);
            this._gang_mc.addEventListener(Event.ENTER_FRAME, this.loseFrame);
        } else {
            this._middleBtn_mc.gotoAndStop(2);
            this._middleBtn2 = this._middleBtn_mc.getChildAt(0) as MovieClip;
            this._middleBtn2.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
                _help_mc.removeEventListener(Event.ENTER_FRAME, helpThingThree);
                _middleBtn_mc.gotoAndStop(1);
                _seer_mc.gotoAndPlay(76);
                _gang_mc.gotoAndPlay(77);
                _seer_mc.addEventListener(Event.ENTER_FRAME, onFrame);
            });
        }
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
            gameCoin = ItemManager.getItemQuantityByReferenceId(400130);
            countText.text = gameCoin.toString();
            for each(_loc2_ in PetInfoManager.getAllBagPetInfo()) {
                if (_loc2_.bunchId == 116) {
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
                if (_loc1_[_loc2_].referenceId == 100401) {
                    thing2Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100402) {
                    thing3Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100403) {
                    thing4Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100404) {
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
            if (petInfo.bunchId == 116) {
                pet = petInfo;
            }
        }
        if (pet == null) {
            AlertManager.showAlert("你的精灵背包中没有与此纹章产生共鸣的精灵");
            return;
        }
        SwapManager.swapItem(429, pet.catchTime, this.updateExchangePanel, function (param1:int):void {
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
        SwapManager.swapItem(430, 1, this.updateExchangePanel);
    }

    private function onExchangeHandler3(param1:MouseEvent):void {
        SwapManager.swapItem(431, 1, this.updateExchangePanel);
    }

    private function onExchangeHandler4(param1:MouseEvent):void {
        SwapManager.swapItem(432, 1, this.updateExchangePanelAgain);
    }

    private function onExchangeHandler5(param1:MouseEvent):void {
        SwapManager.swapItem(433, 1, this.updateExchangePanelAgain);
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
            gameCoin = ItemManager.getItemQuantityByReferenceId(400130);
            countText.text = gameCoin.toString();
            for each(_loc2_ in PetInfoManager.getAllBagPetInfo()) {
                if (_loc2_.bunchId == 116) {
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
                if (_loc1_[_loc2_].referenceId == 100401) {
                    thing2Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100402) {
                    thing3Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100403) {
                    thing4Coin = 1;
                }
                if (_loc1_[_loc2_].referenceId == 100404) {
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
        DisplayUtil.removeForParent(this._mc_0);
        DisplayUtil.removeForParent(this._mc_1);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.AcceptHandler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Complete);
    }
}
}
