package com.taomee.seer2.app.processor.activity.moonWakeUpAct {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;
import flash.text.TextField;
import flash.utils.IDataInput;

import org.taomee.filter.ColorFilter;
import org.taomee.utils.BitUtil;
import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class MoonWakeUpAct {

    private static var _self:MoonWakeUpAct;

    private static const LAST_EVENT_FOR:uint = 206038;

    private static const SEARCH_NUM_FOR:uint = 206036;

    private static const RANDOM_PET_FOR:uint = 206039;

    private static const SEARCH_NUM_DAY:int = 1758;

    private static const FIGHT_INDEX:int = 1662;

    private static const SWAP_LIST:Vector.<int> = Vector.<int>([4238, 4239, 4240, 4241]);

    private static const MI_NUM_BUY_ID:uint = 606636;

    private static const TIP_PANEL_ITEM_TIPS:Vector.<String> = Vector.<String>(["2K经验芯片", "资质灵石", "性格重置秘药（价值2元）", "神秘果实（使精灵获得经验，等级越高效果越大）", "中秋礼券"]);

    private static const SERCH_NUM:Vector.<int> = Vector.<int>([5, 8]);

    private static var _isLeave:Boolean;

    private static var _resMapId:int;


    private var _map:MapModel;

    private var _resLib:ApplicationDomain;

    private var _menu:MovieClip;

    private var _leave:SimpleButton;

    private var _tipLink:SimpleButton;

    private var _tip:MovieClip;

    private var _tipCloseBtn:SimpleButton;

    private var _tipItemList:Vector.<MovieClip>;

    private var _forward:SimpleButton;

    private var _searchNum:TextField;

    private var _miNumBuy:SimpleButton;

    private var _forwardMC:MovieClip;

    private var _searchNumVal:int;

    private var _par:Parser_1142;

    public function MoonWakeUpAct() {
        super();
    }

    public static function getInstance():MoonWakeUpAct {
        if (_self == null) {
            _self = new MoonWakeUpAct();
        }
        return _self;
    }

    public function setup(param1:MapModel):void {
        this._map = param1;
        _isLeave = false;
        this.hideLobbyMenu();
        this.getURL();
        this.getResMapIdHandle();
    }

    private function getResMapIdHandle():void {
        if (SceneManager.prevSceneType == SceneType.LOBBY) {
            _resMapId = SceneManager.prevMapID;
        }
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX) {
            ModuleManager.showAppModule("MoonWakeGetAwardPanel");
        }
    }

    private function getURL():void {
        QueueLoader.load(URLUtil.getActivityAnimation("moonWakeUpAct/MoonWakeUpAct"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            init();
        });
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function showLobbyMenu():void {
        (SceneManager.active as LobbyScene).showToolbar();
    }

    private function init():void {
        this.initSet();
        this.initEvent();
        this.update();
        this.show();
    }

    private function initSet():void {
        this._menu = this.getMovie("Menu");
        this._leave = this._menu["leave"];
        this._tipLink = this._menu["tipLink"];
        this._tip = this._menu["tip"];
        this._tip.visible = false;
        this._tip.mouseEnabled = this._tip.mouseChildren = false;
        this._tipCloseBtn = this._tip["closeBtn"];
        this._tipItemList = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 5) {
            this._tipItemList.push(this._tip["tip" + _loc1_]);
            (this._tipItemList[_loc1_] as MovieClip).buttonMode = true;
            _loc1_++;
        }
        this._forward = this._menu["forward"];
        this._searchNum = this._menu["searchNum"];
        this._miNumBuy = this._menu["miNumBuy"];
        this._forwardMC = this.getMovie("ForwardMC");
    }

    private function initEvent():void {
        this._tipLink.addEventListener(MouseEvent.CLICK, this.onTipShow);
        this._tipCloseBtn.addEventListener(MouseEvent.CLICK, this.onTipHide);
        var _loc1_:int = 0;
        while (_loc1_ < this._tipItemList.length) {
            TooltipManager.addCommonTip(this._tipItemList[_loc1_], TIP_PANEL_ITEM_TIPS[_loc1_]);
            _loc1_++;
        }
        this._miNumBuy.addEventListener(MouseEvent.CLICK, this.onMiNumBuy);
        this._forward.addEventListener(MouseEvent.CLICK, this.onForward);
        this._leave.addEventListener(MouseEvent.CLICK, this.onLeave);
    }

    private function onLeave(param1:MouseEvent):void {
        _isLeave = true;
        if (_resMapId != 0) {
            SceneManager.changeScene(SceneType.LOBBY, _resMapId);
        } else {
            SceneManager.changeScene(SceneType.LOBBY, 70);
        }
    }

    private function onForward(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this.forwardFilter()) {
            this._leave.mouseEnabled = this._forward.mouseEnabled = false;
            ActiveCountManager.requestActiveCount(LAST_EVENT_FOR, function (param1:uint, param2:uint):void {
                var type:uint = param1;
                var val:uint = param2;
                _forwardMC.x = 40;
                _forwardMC.y = 6;
                _map.front.addChild(_forwardMC);
                MovieClipUtil.playMc(_forwardMC, 2, _forwardMC.totalFrames, function ():void {
                    _forwardMC.parent.removeChild(_forwardMC);
                    if (val != 0) {
                        onEventHandleById(val);
                    } else {
                        SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
                            var data:IDataInput = param1;
                            new SwapInfo(data);
                            ActiveCountManager.requestActiveCountList([SEARCH_NUM_FOR, LAST_EVENT_FOR, RANDOM_PET_FOR], function (param1:Parser_1142):void {
                                _par = param1;
                                onEventHandleById(_par.infoVec[1]);
                            });
                        });
                    }
                });
            });
        }
    }

    private function forwardFilter():Boolean {
        if (TimeManager.getAvailableTime() <= 0) {
            AlertManager.showAlert("电池已耗完,暂时不可前进,以防遇到对战不可进入战斗哦!");
            return false;
        }
        var _loc1_:PetInfo = PetInfoManager.getFirstPetInfo();
        if (_loc1_ != null) {
            if (_loc1_.hp == 0) {
                AlertManager.showAlert("首发精灵体力耗尽,暂时不可前进,以防遇到对战不可进入战斗哦!");
                return false;
            }
            return true;
        }
        AlertManager.showAlert("没有设置首发精灵,暂时不可前进,以防遇到对战不可进入战斗哦!");
        return false;
    }

    private function onEventHandleById(param1:int):void {
        var id:int = param1;
        if (id == 1) {
            ModuleManager.showModule(URLUtil.getAppModule("MoonWakeEventOneActPanel"), "正在打开遇到敌人面板...", {"type": this.getCurFightIndex()});
        } else if (id == 2) {
            ModuleManager.addEventListener("MoonWakeEventTwoActPanel", ModuleEvent.DISPOSE, function onEventTwoHide(param1:ModuleEvent):void {
                ModuleManager.removeEventListener("MoonWakeEventTwoActPanel", ModuleEvent.DISPOSE, onEventTwoHide);
                update();
            });
            ModuleManager.showAppModule("MoonWakeEventTwoActPanel");
        } else if (id == 3) {
            ModuleManager.addEventListener("MoonWakeEventThreeActPanel", ModuleEvent.DISPOSE, function onEventThreeHide(param1:ModuleEvent):void {
                ModuleManager.removeEventListener("MoonWakeEventThreeActPanel", ModuleEvent.DISPOSE, onEventThreeHide);
                update();
            });
            ModuleManager.showAppModule("MoonWakeEventThreeActPanel");
        } else if (id == 4) {
            ModuleManager.addEventListener("MoonWakeEventFourActPanel", ModuleEvent.DISPOSE, this.onEventFourHide);
            ModuleManager.showAppModule("MoonWakeEventFourActPanel");
        } else if (id == 5) {
            ModuleManager.showAppModule("MoonWakeEventFiveActPanel");
        }
        this._leave.mouseEnabled = this._forward.mouseEnabled = true;
    }

    private function getCurFightIndex():int {
        var _loc1_:int = -1;
        var _loc2_:int = 0;
        while (_loc2_ < 4) {
            if (BitUtil.getBit(this._par.infoVec[2], _loc2_)) {
                _loc1_ = _loc2_;
                break;
            }
            _loc2_++;
        }
        return _loc1_;
    }

    private function onEventFourHide(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("MoonWakeEventFourActPanel", ModuleEvent.DISPOSE, this.onEventFourHide);
        this.update();
    }

    private function onMiNumBuy(param1:MouseEvent):void {
        this._forward.mouseEnabled = false;
        ModuleManager.addEventListener("BuyPropPanel", ModuleEvent.DISPOSE, this.onBuyPanelHide);
        ModuleManager.toggleModule(URLUtil.getAppModule("BuyPropPanel"), "正在打开米币小面板...", {
            "itemId": MI_NUM_BUY_ID,
            "canBatch": true,
            "isLimitNum": false,
            "buyType": "mi",
            "itemType": "hideShop"
        });
    }

    private function onBuyPanelHide(param1:ModuleEvent):void {
        this._forward.mouseEnabled = true;
        ModuleManager.removeEventListener("BuyPropPanel", ModuleEvent.DISPOSE, this.onBuyPanelHide);
        this.update();
    }

    private function onTipShow(param1:MouseEvent):void {
        this._tip.visible = true;
        this._tip.mouseEnabled = this._tip.mouseChildren = true;
        this._miNumBuy.mouseEnabled = this._forward.mouseEnabled = this._tipLink.mouseEnabled = false;
    }

    private function onTipHide(param1:MouseEvent):void {
        this._tip.visible = false;
        this._tip.mouseEnabled = this._tip.mouseChildren = false;
        this._miNumBuy.mouseEnabled = this._tipLink.mouseEnabled = true;
        if (int(this._searchNum.text) > 0) {
            this._forward.mouseEnabled = true;
        } else {
            this._forward.mouseEnabled = false;
        }
    }

    private function update(param1:Function = null):void {
        var callBack:Function = param1;
        this._forward.mouseEnabled = false;
        ActiveCountManager.requestActiveCountList([SEARCH_NUM_FOR, LAST_EVENT_FOR, RANDOM_PET_FOR], function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            DayLimitManager.getDoCount(SEARCH_NUM_DAY, function (param1:int):void {
                _par = par;
                _searchNumVal = ActsHelperUtil.getCanNum(param1, par.infoVec[0], VipManager.vipInfo.isVip() ? SERCH_NUM[1] : SERCH_NUM[0]);
                if (_searchNumVal > 0) {
                    setBtnState(_forward, true);
                } else {
                    setBtnState(_forward, false);
                }
                _searchNum.text = _searchNumVal.toString();
                if (callBack != null) {
                    callBack();
                }
                if (par.infoVec[1] != 0) {
                    onEventHandleById(par.infoVec[1]);
                }
            });
        });
    }

    private function setBtnState(param1:SimpleButton, param2:Boolean):void {
        if (param2) {
            param1.filters = [];
            param1.mouseEnabled = true;
        } else {
            ColorFilter.setGrayscale(param1);
            param1.mouseEnabled = false;
        }
    }

    private function show():void {
        this._map.content.addChild(this._menu);
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    public function dispose():void {
        if (_isLeave) {
            _self = null;
        }
        if (this._tipLink) {
            this._tipLink.removeEventListener(MouseEvent.ROLL_OVER, this.onTipShow);
            this._tipLink.removeEventListener(MouseEvent.ROLL_OUT, this.onTipHide);
            DisplayUtil.removeForParent(this._tipLink);
            this._tipLink = null;
        }
        if (this._miNumBuy) {
            this._miNumBuy.removeEventListener(MouseEvent.CLICK, this.onMiNumBuy);
            DisplayUtil.removeForParent(this._miNumBuy);
            this._miNumBuy = null;
        }
        if (this._forward) {
            this._forward.removeEventListener(MouseEvent.CLICK, this.onForward);
            DisplayUtil.removeForParent(this._forward);
            this._forward = null;
        }
        if (this._leave) {
            this._leave.removeEventListener(MouseEvent.CLICK, this.onLeave);
            DisplayUtil.removeForParent(this._leave);
            this._leave = null;
        }
        if (this._menu) {
            DisplayUtil.removeForParent(this._menu);
            this._menu = null;
        }
        this._map = null;
        this._resLib = null;
        this._leave = null;
        this._tipLink = null;
        this._tip = null;
        this._forward = null;
        this._searchNum = null;
        this._miNumBuy = null;
    }
}
}
