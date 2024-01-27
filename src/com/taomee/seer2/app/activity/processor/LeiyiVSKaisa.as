package com.taomee.seer2.app.activity.processor {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.Tick;

public class LeiyiVSKaisa {

    private static const MAP_ID:uint = 880;


    private var _flag1:int;

    private var _flag2:int;

    private var _flag3:int;

    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    private var _mc_3:MovieClip;

    private var _mc_4:MovieClip;

    private var _btn:MovieClip;

    private var _kaiyi:MovieClip;

    private var _split:MovieClip;

    private var _sickLeiyi:MovieClip;

    private var _sickKaisa:MovieClip;

    private var _kaisaOK:MovieClip;

    private var _leiyi:MovieClip;

    private var _kaisa:MovieClip;

    private var _ispaly:Boolean;

    private var _isPaly_1:Boolean;

    private var _curStep:uint;

    private const month:int = 10;

    private const dayListVec:Vector.<uint> = Vector.<uint>([6, 0]);

    private const dateListVec:Vector.<uint> = Vector.<uint>([5, 6, 12, 13, 19, 20, 26, 27]);

    public function LeiyiVSKaisa() {
        super();
        this.init();
    }

    private function init():void {
        var data:LittleEndianByteArray = new LittleEndianByteArray();
        data.writeUnsignedInt(3);
        data.writeUnsignedInt(680);
        data.writeUnsignedInt(681);
        data.writeUnsignedInt(682);
        DayLimitListManager.getDoCount(data, function (param1:DayLimitListInfo):void {
            _flag1 = param1.getCount(680);
            _flag2 = param1.getCount(682);
            _flag3 = param1.getCount(681);
            loadActiveResource();
        });
    }

    private function loadActiveResource():void {
        var _loc1_:String = String(URLUtil.getActivityAnimation("FitKaiyi"));
        QueueLoader.load(_loc1_, LoadType.SWF, this.onLoadActiveResource);
    }

    private function onLoadActiveResource(param1:ContentInfo):void {
        var _loc2_:MovieClip = param1.content as MovieClip;
        this._mc_0 = _loc2_["mc_0"] as MovieClip;
        this._mc_1 = _loc2_["mc_1"] as MovieClip;
        this._mc_2 = _loc2_["mc_2"] as MovieClip;
        this._mc_3 = _loc2_["mc_3"] as MovieClip;
        this._mc_4 = _loc2_["mc_4"] as MovieClip;
        this._btn = _loc2_["button"] as MovieClip;
        this._kaiyi = _loc2_["kaiyi"] as MovieClip;
        this._split = _loc2_["splitkaiyi"] as MovieClip;
        this._kaisaOK = _loc2_["right"] as MovieClip;
        this._sickLeiyi = _loc2_["leiyi"] as MovieClip;
        this._sickKaisa = _loc2_["kaisa"] as MovieClip;
        this._leiyi = _loc2_["leiyi1"] as MovieClip;
        this._kaisa = _loc2_["kaisa1"] as MovieClip;
        this.initMC();
    }

    private function onTimeLoad(param1:int):void {
        var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc2_.day != 6 && _loc2_.day != 0) {
            this.hideAll();
            return;
        }
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        if (DateUtil.inInDateScope(_loc2_.day, 13, 0, 13, 25)) {
            _loc3_ = 1;
            _loc4_ = 1;
        } else if (DateUtil.inInDateScope(_loc2_.day, 19, 0, 19, 25)) {
            _loc3_ = 1;
            _loc4_ = 2;
        } else if (DateUtil.inInDateScope(_loc2_.day, 13, 26, 13, 30)) {
            _loc3_ = 2;
            _loc4_ = 1;
        } else if (DateUtil.inInDateScope(_loc2_.day, 19, 26, 19, 30)) {
            _loc3_ = 2;
            _loc4_ = 2;
        } else if (DateUtil.inInDateScope(_loc2_.day, 13, 31, 14, 0)) {
            _loc3_ = 3;
            _loc4_ = 1;
        } else if (DateUtil.inInDateScope(_loc2_.day, 19, 31, 20, 0)) {
            _loc3_ = 3;
            _loc4_ = 2;
        }
        if (_loc3_ == 1) {
            if (_loc4_ == 1) {
                if (this._flag1 == 0 && this._isPaly_1 == false) {
                    this.playFullMC();
                }
            } else if (this._flag1 <= 1 && this._isPaly_1 == false) {
                this.playFullMC();
            }
        } else if (_loc3_ != 2) {
            if (_loc3_ == 3) {
                if (this._flag2 < _loc4_ && this._ispaly == false) {
                    DisplayUtil.removeForParent(this._sickLeiyi);
                    DisplayUtil.removeForParent(this._sickKaisa);
                    this.playFullMCAgain();
                }
            }
        }
    }

    private function hideAll():void {
        this.dispose();
    }

    private function initMC():void {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc1_.day != 6 && _loc1_.day != 0) {
            this.hideAll();
            return;
        }
        Tick.instance.addRender(this.onTimeLoad, 1000 * 30);
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (DateUtil.inInDateScope(_loc1_.day, 13, 1, 13, 24)) {
            _loc2_ = 1;
            _loc3_ = 1;
        } else if (DateUtil.inInDateScope(_loc1_.day, 19, 1, 19, 24)) {
            _loc2_ = 1;
            _loc3_ = 2;
        } else if (DateUtil.inInDateScope(_loc1_.day, 13, 25, 13, 30)) {
            _loc2_ = 2;
            _loc3_ = 1;
        } else if (DateUtil.inInDateScope(_loc1_.day, 19, 25, 19, 30)) {
            _loc2_ = 2;
            _loc3_ = 2;
        } else if (DateUtil.inInDateScope(_loc1_.day, 13, 31, 14, 0)) {
            _loc2_ = 3;
            _loc3_ = 1;
        } else if (DateUtil.inInDateScope(_loc1_.day, 19, 31, 20, 0)) {
            _loc2_ = 3;
            _loc3_ = 2;
        }
        if (_loc2_ == 1) {
            if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 40) {
                if (FightManager.fightWinnerSide != FightSide.LEFT) {
                    this.noWin();
                } else {
                    this.Win();
                }
            } else if (_loc3_ == 1) {
                if (this._flag1 == 0 && this._isPaly_1 == false) {
                    this.playFullMC();
                } else if (this._flag1 == 1 && this._flag3 == 0) {
                    this.addNpc();
                } else if (this._flag3 == 1) {
                    this.playLeiyiSplitKaisa();
                }
            } else if (this._flag1 <= 1 && this._isPaly_1 == false) {
                this.playFullMC();
            } else if (this._flag1 == 2 && this._flag3 < 2) {
                this.addNpc();
            } else if (this._flag3 == 2) {
                this.playLeiyiSplitKaisa();
            }
        } else if (_loc2_ == 2) {
            this.playLeiyiSplitKaisa();
        } else if (_loc2_ == 3) {
            if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 155) {
                this.initFightNpc();
                if (FightManager.fightWinnerSide != FightSide.LEFT) {
                    this.noWinLeiyi();
                } else {
                    this.winLeiyi();
                }
            } else if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 156) {
                this.initFightNpc();
                if (FightManager.fightWinnerSide != FightSide.LEFT) {
                    this.noWinKaisa();
                } else {
                    this.winKaisa();
                }
            } else if (this._flag2 < _loc3_ && this._ispaly == false) {
                this.playFullMCAgain();
            } else {
                this.initFightNpc();
            }
        }
    }

    private function playFullMC():void {
        this._isPaly_1 = true;
        MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("LeiyiFitKaisa/leiyiFitKaisa_0"), function ():void {
            SceneManager.active.mapModel.front.addChild(_mc_0);
            MovieClipUtil.playMc(_mc_0, 1, _mc_0.totalFrames, function ():void {
                NpcDialog.show(511, "影灵兽", [[0, "你忘了，你已经做出了很多伤害他们的事？背负着罪恶，连回归光明的资格都没有了！"]], ["......"], [function ():void {
                    NpcDialog.show(511, "影灵兽", [[0, "所以……乖孩子……继续……落入黑暗的怀抱……你依然能够享用力量……来吧……"]], ["......"], [function ():void {
                        DisplayUtil.removeForParent(_mc_0);
                        SceneManager.active.mapModel.content.addChild(_mc_1);
                        MovieClipUtil.playMc(_mc_1, 1, _mc_1.totalFrames, function ():void {
                            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "凯萨……！凯萨！！振作起来啊！！不要向黑暗妥协！！我们相信你！！"]], ["犯错并不可怕，可怕的是一直错下去！"], [function ():void {
                                DisplayUtil.removeForParent(_mc_1);
                                SceneManager.active.mapModel.content.addChild(_mc_2);
                                MovieClipUtil.playMc(_mc_2, 1, _mc_2.totalFrames, function ():void {
                                    SceneManager.active.mapModel.front.addChild(_btn);
                                    var _loc1_:* = _btn["btn"] as SimpleButton;
                                    _loc1_.addEventListener(MouseEvent.CLICK, onClickButtonHandler);
                                }, true);
                            }]);
                        }, true);
                    }]);
                }]);
            }, true);
        }, true, false, 2);
    }

    private function onClickButtonHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        DisplayUtil.removeForParent(this._btn);
        MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("LeiyiFitKaisa/kaisaOK"), function ():void {
            DisplayUtil.removeForParent(_mc_2);
            SceneManager.active.mapModel.content.addChild(_kaisaOK);
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "太好了……凯萨好像又恢复原来的样子了……！"]], ["......"], [function ():void {
                DisplayUtil.removeForParent(_kaisaOK);
                SceneManager.active.mapModel.content.addChild(_mc_3);
                MovieClipUtil.playMc(_mc_3, 1, _mc_3.totalFrames, function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("LeiyiFitKaisa/leiyiFitKaisa_1"), function ():void {
                        SwapManager.swapItem(1256, 1, function (param1:IDataInput):void {
                            ++_flag1;
                            DisplayUtil.removeForParent(_mc_3);
                            FightManager.startFightWithNPC(40, 0);
                        });
                    }, true, false, 2);
                }, true);
            }]);
        }, true, false, 2);
    }

    private function addNpc():void {
        SceneManager.active.mapModel.content.addChild(this._split);
        this._split.buttonMode = true;
        this._split.addEventListener(MouseEvent.CLICK, this.onFightKaiyiHandler);
    }

    private function onFightKaiyiHandler(param1:MouseEvent):void {
        FightManager.startFightWithNPC(40, 0);
    }

    private function Win():void {
        LayerManager.moduleLayer.addChild(this._split);
        NpcDialog.show(511, "影灵兽", [[0, "很好……很好……你们的体力已经完全透支，不久以后，我们会在死亡的黑暗深渊重聚……！"]], ["不会的！他们不会倒下！！"], [function ():void {
            NpcDialog.show(512, "凯伊", [[0, "我……已经……"]], ["雷伊……不，凯萨……你们怎么了！！"], [function ():void {
                DisplayUtil.removeForParent(_split);
                LayerManager.moduleLayer.addChild(_mc_4);
                MovieClipUtil.playMc(_mc_4, 1, _mc_4.totalFrames, function ():void {
                    DisplayUtil.removeForParent(_mc_4);
                    SceneManager.active.mapModel.content.addChild(_sickLeiyi);
                    SceneManager.active.mapModel.content.addChild(_sickKaisa);
                    _sickLeiyi.buttonMode = true;
                    _sickKaisa.buttonMode = true;
                    _sickLeiyi.addEventListener(MouseEvent.CLICK, onLeiyiSayHandler);
                    _sickKaisa.addEventListener(MouseEvent.CLICK, onKaisaSayHandler);
                }, true);
            }]);
        }]);
    }

    private function noWin():void {
        this.addNpc();
        NpcDialog.show(512, "凯伊", [[0, "不行，不能倒下去，一定要战胜它！！"]], ["一定要战胜它！！", "休息一下，体力透支了。"], [function ():void {
            FightManager.startFightWithNPC(40, 0);
        }]);
    }

    private function playLeiyiSplitKaisa():void {
        LayerManager.moduleLayer.addChild(this._mc_4);
        MovieClipUtil.playMc(this._mc_4, 1, this._mc_4.totalFrames, function ():void {
            DisplayUtil.removeForParent(_mc_4);
            SceneManager.active.mapModel.content.addChild(_sickLeiyi);
            SceneManager.active.mapModel.content.addChild(_sickKaisa);
            _sickLeiyi.buttonMode = true;
            _sickKaisa.buttonMode = true;
            _sickLeiyi.addEventListener(MouseEvent.CLICK, onLeiyiSayHandler);
            _sickKaisa.addEventListener(MouseEvent.CLICK, onKaisaSayHandler);
        }, true);
    }

    private function onLeiyiSayHandler(param1:MouseEvent):void {
        var _loc2_:String = "13:30……会出现奇迹吗？救救他们！";
        var _loc3_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc3_.hours > 18) {
            _loc2_ = "19:30……会出现奇迹吗？救救他们！";
        }
        NpcDialog.show(477, "雷伊", [[0, "如果因为守护这星球而献出生命……我毫无怨言……之后，就交给凯萨吧……"]], [_loc2_], []);
    }

    private function onKaisaSayHandler(param1:MouseEvent):void {
        var _loc2_:String = "13:30……会出现奇迹吗？救救他们！";
        var _loc3_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc3_.hours > 18) {
            _loc2_ = "19:30……会出现奇迹吗？救救他们！";
        }
        NpcDialog.show(499, "凯萨", [[0, "现在我才知道，曾经那么多次战斗我都没有真正赢过……如果为了保护这星球，就算死也是无上的荣耀！之后，就交给雷伊吧……"]], [_loc2_], []);
    }

    private function playFullMCAgain():void {
        this._ispaly = true;
        MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("LeiyiFitKaisa/leiyiFitKaisa_2"), function ():void {
            SwapManager.swapItem(1257, 1, function (param1:IDataInput):void {
                ++_flag2;
                initFightNpc();
            });
        }, true, false, 2);
    }

    private function initFightNpc():void {
        LayerManager.mapLayer.addChild(this._leiyi);
        LayerManager.mapLayer.addChild(this._kaisa);
        this._leiyi.buttonMode = true;
        this._kaisa.buttonMode = true;
        this._leiyi.addEventListener(MouseEvent.CLICK, this.onFightLeiyiHandler);
        this._kaisa.addEventListener(MouseEvent.CLICK, this.onFightKaisaHandler);
    }

    private function onFightLeiyiHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(477, "雷伊", [[0, "要和我一起保护星球？看你够不够强力！！"]], ["打一场就知道了！", "一会儿再说。"], [function ():void {
            FightManager.startFightWithWild(155);
        }]);
    }

    private function onFightKaisaHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(499, "凯萨", [[0, "无论是什么目的，高品质的战斗总是让人兴奋！你准备好了吗？"]], ["我准备好了！", "一会儿再说。"], [function ():void {
            FightManager.startFightWithWild(156);
        }]);
    }

    private function noWinLeiyi():void {
        NpcDialog.show(477, "雷伊", [[0, "你的实力应该不只是这样吧？"]], ["再来一次", "一会儿再说。"], [function ():void {
            FightManager.startFightWithWild(155);
        }]);
    }

    private function winLeiyi():void {
        var _loc1_:PetInfo = null;
        var _loc2_:PetInfo = null;
        for each(_loc2_ in PetInfoManager.getAllBagPetInfo()) {
            if (_loc2_.bunchId == 38) {
                _loc1_ = _loc2_;
            }
        }
        if (_loc1_ == null) {
            NpcDialog.show(477, "雷伊", [[0, "很好，就让我们并肩作战！！"]], ["太好了！"], []);
        }
    }

    private function noWinKaisa():void {
        NpcDialog.show(499, "凯萨", [[0, "你的实力应该不只是这样吧？"]], ["再来一次", "一会儿再说。"], [function ():void {
            FightManager.startFightWithWild(156);
        }]);
    }

    private function winKaisa():void {
        var _loc1_:PetInfo = null;
        var _loc2_:PetInfo = null;
        for each(_loc2_ in PetInfoManager.getAllBagPetInfo()) {
            if (_loc2_.bunchId == 115) {
                _loc1_ = _loc2_;
            }
        }
        if (_loc1_ == null) {
            NpcDialog.show(499, "凯萨", [[0, "很好，就让我们并肩作战！！"]], ["太好了！"], []);
        }
    }

    public function dispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        if (this._mc_2) {
            DisplayUtil.removeForParent(this._mc_2);
        }
        if (this._mc_3) {
            DisplayUtil.removeForParent(this._mc_3);
        }
        if (this._mc_4) {
            DisplayUtil.removeForParent(this._mc_4);
        }
        if (this._btn) {
            DisplayUtil.removeForParent(this._btn);
        }
        if (this._kaiyi) {
            DisplayUtil.removeForParent(this._kaiyi);
        }
        if (this._split) {
            DisplayUtil.removeForParent(this._split);
        }
        if (this._sickLeiyi) {
            DisplayUtil.removeForParent(this._sickLeiyi);
        }
        if (this._sickKaisa) {
            DisplayUtil.removeForParent(this._sickKaisa);
        }
        if (this._leiyi) {
            DisplayUtil.removeForParent(this._leiyi);
        }
        if (this._kaisa) {
            DisplayUtil.removeForParent(this._kaisa);
        }
        if (this._kaisaOK) {
            DisplayUtil.removeForParent(this._kaisaOK);
        }
        Tick.instance.removeRender(this.onTimeLoad);
    }
}
}
