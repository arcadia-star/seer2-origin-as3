package com.taomee.seer2.app.yuelingshouevolution {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.scene.LobbyPanel;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.system.ApplicationDomain;
import flash.utils.IDataInput;

import org.taomee.utils.BitUtil;
import org.taomee.utils.DomainUtil;

public class YueLingShouEvolutionManager {

    private static var _map:MapModel;

    private static var _resLib:ApplicationDomain;

    private static var _mc1:MovieClip;

    private static var _npc581:Mobile;

    private static var _mouseObj:MouseClickHintSprite;

    private static var BarMc:MovieClip;

    private static var oneKeyPass:SimpleButton;

    private static var passList:Vector.<MovieClip>;

    private static var swapBtnList:Vector.<SimpleButton>;

    private static var markMc:MovieClip;

    private static var petMc:MovieClip;

    private static var exitBtn:SimpleButton;

    private static var pingBtn:SimpleButton;

    private static var _uiPanel:MovieClip;

    private static var itemMcList:Vector.<MovieClip>;

    private static var startMc:MovieClip;

    private static var fightIDArr:Array = [1582, 1583, 1584, 1585, 1586, 1587];

    private static var fight581ID:int = 1589;

    private static var fightBOSSID:int = 1588;

    private static var _npc307:Mobile;

    private static var FOR_LIST:Array = [250180, 250181, 250183];

    private static var DAY_LIST:int = 5075;

    private static var BUY_BOSS_COUNT:int = 605755;

    private static var tipArr:Array = ["8W赛尔豆", "精元晶石*10", "进化芯片"];

    private static var passBossNums:int;

    private static var numCont:int;

    private static var fightBossCount:int;

    private static var buyCount:int;


    public function YueLingShouEvolutionManager() {
        super();
    }

    public static function setup(param1:MapModel):void {
        _map = param1;
        LobbyPanel.instance.hide();
        getURL();
    }

    private static function getURL():void {
        QueueLoader.load(URLUtil.getActivityAnimation("yuelingshouAct/yuelingshouAct"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            initMc();
            start();
        });
    }

    private static function start():void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (fight581ID == FightManager.currentFightRecord.initData.positionIndex) {
                NpcDialog.show(113, "超级NONO", [[0, "啊啊啊~别打了，你去土地庙找土地爷吧，他会让地震停止的！"]], ["好的!"], [function ():void {
                    pingBtn.visible = true;
                    _mouseObj = new MouseClickHintSprite();
                    _mouseObj.x = pingBtn.x + 20;
                    _mouseObj.y = pingBtn.y - 15;
                    _map.content.addChild(_mouseObj);
                }]);
            }
            if (fightBOSSID == FightManager.currentFightRecord.initData.positionIndex) {
                if (FightManager.isWinWar()) {
                    ServerMessager.addMessage("获得【月灵】*5");
                }
                _uiPanel.visible = true;
                LobbyPanel.instance.hide();
            }
            if (fightIDArr.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
                _uiPanel.visible = true;
                pingBtn.visible = false;
            }
            updateDate();
        } else {
            pingBtn.visible = false;
            ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                var par:Parser_1142 = param1;
                passBossNums = par.infoVec[0];
                if (passBossNums == 0) {
                    _mc1 = getMovie("Mc1") as MovieClip;
                    _mc1.x = 588;
                    _mc1.y = 302;
                    _map.front.addChild(_mc1);
                    _mc1.gotoAndStop(1);
                    MovieClipUtil.playMc(_mc1, 2, _mc1.totalFrames, function ():void {
                        DisplayObjectUtil.removeFromParent(_mc1);
                        _mc1 = null;
                        creatNPC581();
                    }, true);
                } else {
                    _uiPanel.visible = true;
                    LobbyPanel.instance.hide();
                    updateDate();
                }
            });
        }
    }

    private static function updateDate():void {
        ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            var bitNum:int = 0;
            var i:int = 0;
            while (i < 6) {
                if (BitUtil.getBit(par.infoVec[0], i)) {
                    bitNum++;
                }
                i++;
            }
            passBossNums = bitNum;
            numCont = par.infoVec[1];
            buyCount = par.infoVec[2];
            DayLimitManager.getDoCount(DAY_LIST, function (param1:int):void {
                fightBossCount = ActsHelperUtil.getCanNum(param1, buyCount, 1);
                updateShow();
            });
        });
    }

    private static function updateShow():void {
        var _loc1_:int = 0;
        while (_loc1_ < passBossNums) {
            passList[_loc1_].gotoAndStop(2);
            _loc1_++;
        }
        if (numCont >= 50) {
            DisplayObjectUtil.enableButton(swapBtnList[0]);
        } else {
            DisplayObjectUtil.disableButton(swapBtnList[0]);
        }
        if (numCont >= 100) {
            DisplayObjectUtil.enableButton(swapBtnList[1]);
        } else {
            DisplayObjectUtil.disableButton(swapBtnList[1]);
        }
        if (numCont >= 200) {
            DisplayObjectUtil.enableButton(swapBtnList[2]);
        } else {
            DisplayObjectUtil.disableButton(swapBtnList[2]);
        }
        if (passBossNums == 6) {
            startMc.gotoAndStop(2);
            oneKeyPass.visible = false;
        } else {
            startMc.gotoAndStop(1);
        }
        _loc1_ = 0;
        while (_loc1_ < 3) {
            TooltipManager.addCommonTip(itemMcList[_loc1_], tipArr[_loc1_]);
            _loc1_++;
        }
        BarMc.gotoAndStop(int(numCont / 200 * 100) + 1);
        TooltipManager.addCommonTip(BarMc, numCont.toString());
        if (ItemManager.getItemQuantityByReferenceId(206687)) {
            markMc.visible = true;
            DisplayObjectUtil.disableButton(swapBtnList[2]);
        }
    }

    private static function initMc():void {
        pingBtn = _map.content["pingBtn"];
        pingBtn.addEventListener(MouseEvent.CLICK, onClickPing);
        _uiPanel = _map.front["uiPanel"];
        _uiPanel.visible = false;
        markMc = _uiPanel["markMc"];
        markMc.visible = false;
        startMc = _uiPanel["startMc"];
        startMc.buttonMode = true;
        BarMc = _uiPanel["barMc"];
        oneKeyPass = _uiPanel["oneKeyPass"];
        oneKeyPass.addEventListener(MouseEvent.CLICK, onOneKeyFire);
        startMc.addEventListener(MouseEvent.CLICK, onStart);
        exitBtn = _uiPanel["exitBtn"];
        exitBtn.addEventListener(MouseEvent.CLICK, onExit);
        petMc = _map.content["petMc"];
        passList = new Vector.<MovieClip>();
        swapBtnList = new Vector.<SimpleButton>();
        itemMcList = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 6) {
            passList.push(_map.content["passMcList" + _loc1_]);
            passList[_loc1_].gotoAndStop(1);
            if (_loc1_ < 3) {
                swapBtnList.push(_uiPanel["swapBtn" + _loc1_]);
                DisplayObjectUtil.disableButton(swapBtnList[_loc1_]);
                swapBtnList[_loc1_].addEventListener(MouseEvent.CLICK, onSwap);
                itemMcList.push(_uiPanel["itemMc" + _loc1_]);
            }
            _loc1_++;
        }
    }

    private static function onSwap(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        var idx:int = swapBtnList.indexOf(e.currentTarget as SimpleButton);
        SwapManager.swapItem(3928, 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            updateDate();
        }, null, new SpecialInfo(1, idx));
    }

    private static function onExit(param1:MouseEvent):void {
        _uiPanel.visible = false;
        LobbyPanel.instance.show();
        pingBtn.visible = true;
        if (_mouseObj) {
            _mouseObj.visible = true;
        }
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private static function onStart(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if ((e.currentTarget as MovieClip).currentFrame == 1) {
            ModuleManager.showAppModule("YueLingShouEvolutionFightPanel");
        } else if ((e.currentTarget as MovieClip).currentFrame == 2) {
            if (fightBossCount <= 0) {
                ShopManager.buyItemForId(BUY_BOSS_COUNT, function (param1:*):void {
                    updateDate();
                });
            } else {
                firstPlayFullScreen(function ():void {
                    pingBtn.visible = false;
                    _uiPanel.visible = false;
                    petMc.visible = false;
                    createNPC307();
                });
            }
        }
    }

    private static function createNPC307():void {
        _npc307 = new Mobile();
        _npc307.setPostion(new Point(400, 419));
        _npc307.resourceUrl = URLUtil.getNpcSwf(896);
        _npc307.buttonMode = true;
        _npc307.scaleX = _npc307.scaleY = 0.6;
        MobileManager.addMobile(_npc307, MobileType.NPC);
        _npc307.addEventListener(MouseEvent.CLICK, onNpc307Click);
        _mouseObj = new MouseClickHintSprite();
        _mouseObj.x = 400;
        _mouseObj.y = 275;
        _map.content.addChild(_mouseObj);
    }

    private static function onNpc307Click(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(896, "月灵神", [[0, "我将用这强大的力量击碎一切！"]], [" 让我来！", "不打了，被打倒一定很疼！"], [function ():void {
            FightManager.startFightWithWild(fightBOSSID);
        }]);
    }

    private static function firstPlayFullScreen(param1:Function = null):void {
        var callBack:Function = param1;
        ServerBufferManager.getServerBuffer(ServerBufferType.YUELingShouEvolution_FIRST, function (param1:ServerBuffer):void {
            var _loc2_:Boolean = Boolean(param1.readDataAtPostion(1));
            if (!_loc2_) {
                ServerBufferManager.updateServerBuffer(ServerBufferType.YUELingShouEvolution_FIRST, 1, 1);
                MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("YueLingShouEvolutionFull"), callBack, true, true, 2, true);
            } else if (callBack != null) {
                callBack();
            }
        });
    }

    private static function onOneKeyFire(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        ShopManager.buyItemForId(605753, function (param1:*):void {
            updateDate();
        });
    }

    private static function onClickPing(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        pingBtn.visible = false;
        ServerBufferManager.getServerBuffer(ServerBufferType.YUELingShouEvolution_FIRST_PLAY, function (param1:ServerBuffer):void {
            var server:ServerBuffer = param1;
            var _isPlay:Boolean = Boolean(server.readDataAtPostion(1));
            if (!_isPlay) {
                ServerBufferManager.updateServerBuffer(ServerBufferType.YUELingShouEvolution_FIRST_PLAY, 1, 1);
                _mc1 = getMovie("Mc2") as MovieClip;
                _mc1.x = 588;
                _mc1.y = 302;
                _map.front.addChild(_mc1);
                _mc1.gotoAndStop(1);
                MovieClipUtil.playMc(_mc1, 2, _mc1.totalFrames, function ():void {
                    _map.front.removeChild(_mc1);
                    _mc1 = null;
                    showUI();
                }, true);
            } else {
                showUI();
            }
        });
    }

    private static function showUI():void {
        _uiPanel.visible = true;
        LobbyPanel.instance.hide();
        if (_mouseObj) {
            _mouseObj.visible = false;
        }
        updateDate();
    }

    private static function creatNPC581():void {
        _npc581 = new Mobile();
        _npc581.setPostion(new Point(681, 425));
        _npc581.resourceUrl = URLUtil.getNpcSwf(897);
        _npc581.buttonMode = true;
        _npc581.scaleX = _npc581.scaleY = 0.6;
        MobileManager.addMobile(_npc581, MobileType.NPC);
        _npc581.addEventListener(MouseEvent.CLICK, onNpcClick);
        _mouseObj = new MouseClickHintSprite();
        _mouseObj.x = 681;
        _mouseObj.y = 255;
        _map.content.addChild(_mouseObj);
    }

    private static function onNpcClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(897, "路奇", [[0, "啊哈哈哈!借助魔王大人的力量，我已经把地灵兽控制住啦！"]], ["路奇？！"], [function ():void {
            NpcDialog.show(400, "小赛尔", [[0, "你又出来干坏事了？"]], ["（NONO，我们怎么办？）"], [function ():void {
                NpcDialog.show(897, "路奇", [[0, "哼哼~你管我？夺得月灵兽的力量后，我会变得更强！"]], ["想得美。 "], [function ():void {
                    FightManager.startFightWithWild(fight581ID);
                }]);
            }]);
        }]);
    }

    private static function getMovie(param1:String):DisplayObject {
        if (_resLib) {
            return DomainUtil.getDisplayObject(param1, _resLib);
        }
        return null;
    }

    private static function removeEvent():void {
        oneKeyPass.removeEventListener(MouseEvent.CLICK, onOneKeyFire);
        startMc.removeEventListener(MouseEvent.CLICK, onStart);
    }

    public static function dispose():void {
        if (_npc581) {
            _npc581.removeEventListener(MouseEvent.CLICK, onNpcClick);
            MobileManager.removeMobile(_npc581, MobileType.NPC);
            _npc581 = null;
        }
        if (_npc307) {
            _npc307.removeEventListener(MouseEvent.CLICK, onNpcClick);
            MobileManager.removeMobile(_npc307, MobileType.NPC);
            _npc307 = null;
        }
        if (_mouseObj) {
            DisplayObjectUtil.removeFromParent(_mouseObj);
            _mouseObj = null;
        }
        removeEvent();
    }
}
}
