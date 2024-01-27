package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.PetIsHaveManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.IDataInput;

import org.taomee.utils.BitUtil;

public class TheSpriteOfDragonManager {

    private static var _instance:TheSpriteOfDragonManager;


    private const animationName:String = "dreamlandchest/DreamlandChestAnimation";

    private const PET_ID_ARR:Vector.<uint> = Vector.<uint>([426, 300, 603, 394, 529, 410, 384, 261, 163, 360]);

    private const BUY_LIGHT_PET_ARR:Array = [606531, 606532, 606533, 606534, 606535, 606536, 606537, 606538, 606539, 606540];

    private const GET_PET_NAME:Array = ["TheSpriteOfDragonRulePanel"];

    private const SWAP_LIGHT_DRAGON:int = 4195;

    private const SWAP_CALL_DRAGON:int = 4196;

    private const SWAP_NO_FIGHT_ID:int = 4244;

    private const FIGHT_ID_ARR:Array = [1651, 1652, 1653];

    private const TIPS_ARR:Array = ["阿斯顿马丁", "玛莎拉蒂", "布加迪威龙", "保时捷", "迈巴赫", "帕加尼", "法拉利", "英菲尼迪", "雷克萨斯", "兰博基尼"];

    private const BUY_PASS_ID:Array = [606542, 606543, 606544];

    private var dragonMcList:Vector.<MovieClip>;

    private var callMc:MovieClip;

    private var fightMc:MovieClip;

    private var longZhuBtn:SimpleButton;

    private var shopBtn:SimpleButton;

    private var winTxt:TextField;

    private var callSuccessMc:MovieClip;

    private var fightFailMc:MovieClip;

    private var movieMc:MovieClip;

    private const DAY_LIST:Array = [1754, 1755];

    private const FOR_LIST:Array = [206000, 205999, 206006, 206004, 206005];

    private const petNameStr:Array = ["伊特王", "超梦", "约瑟"];

    private var callNum:int;

    private var gameCount:int;

    private var buyCount:int;

    private var dayCount:int;

    private var dragonBit:int;

    private var winNum:int;

    private var isSwapPet:int;

    private var _mapContent:Sprite;

    private var _mapFront:Sprite;

    public function TheSpriteOfDragonManager() {
        super();
    }

    public static function get instance():TheSpriteOfDragonManager {
        if (_instance == null) {
            _instance = new TheSpriteOfDragonManager();
        }
        return _instance;
    }

    public function init():void {
        RightToolbarConter.instance.hide();
        CommonUseManager.hideLobbyMenu();
        ToolBar.show();
        this.onResLoaded(null);
    }

    private function onResLoaded(param1:ContentInfo):void {
        this._mapContent = SceneManager.active.mapModel.content;
        this._mapFront = SceneManager.active.mapModel.front;
        this.dragonMcList = new Vector.<MovieClip>();
        var _loc2_:int = 0;
        while (_loc2_ < 10) {
            this.dragonMcList.push(this._mapContent["dragonMc" + _loc2_]);
            this.dragonMcList[_loc2_].gotoAndStop(1);
            _loc2_++;
        }
        this.callMc = this._mapFront["callMc"];
        SimpleButton(this.callMc["callBtn"]).addEventListener(MouseEvent.CLICK, this.onCall);
        this.fightMc = this._mapFront["fightMc"];
        this.fightMc["modeBtn0"].addEventListener(MouseEvent.CLICK, this.onModeFight);
        this.fightMc["modeBtn1"].addEventListener(MouseEvent.CLICK, this.onModeFight);
        this.fightMc["swapBtn"].addEventListener(MouseEvent.CLICK, this.onSwapPet);
        this.winTxt = this.fightMc["winTxt"];
        this.callSuccessMc = this._mapFront["callSuccessMc"];
        SimpleButton(this.callSuccessMc["fightCallBtn"]).addEventListener(MouseEvent.CLICK, this.onFightCall);
        SimpleButton(this.callSuccessMc["fightCallNoBtn"]).addEventListener(MouseEvent.CLICK, this.onFightNoCall);
        this.fightFailMc = this._mapFront["fightFailMc"];
        this.fightFailMc["starBtn"].addEventListener(MouseEvent.CLICK, this.onBuyPass);
        this.fightFailMc["thanksBtn"].addEventListener(MouseEvent.CLICK, this.onBuyClose);
        this.longZhuBtn = this._mapFront["longZhuBtn"];
        this.longZhuBtn.addEventListener(MouseEvent.CLICK, this.onLongZhu);
        this.shopBtn = this._mapFront["shopBtn"];
        this.shopBtn.addEventListener(MouseEvent.CLICK, this.onShop);
        this.movieMc = this._mapFront["movieMc"];
        this.movieMc.visible = false;
        this.updateData();
    }

    private function onShop(param1:MouseEvent):void {
        ModuleManager.showAppModule("MedicineShopPanel");
    }

    private function onLongZhu(param1:MouseEvent):void {
        ModuleManager.showAppModule("TheSpriteOfDragonRulePanel");
    }

    private function onBuyPass(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        var idx:int = this.FIGHT_ID_ARR.indexOf(FightManager.currentFightRecord.initData.positionIndex);
        ShopManager.buyItemForId(this.BUY_PASS_ID[idx], function (param1:*):void {
            updateData();
        });
    }

    private function onBuyClose(param1:MouseEvent):void {
        this.fightFailMc.visible = false;
    }

    private function onFightNoCall(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        SwapManager.swapItem(this.SWAP_NO_FIGHT_ID, 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            updateData();
        });
    }

    private function onFightCall(param1:MouseEvent):void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onCompleteSwitch);
        if (this.callNum == 1) {
            FightManager.startFightWithWild(this.FIGHT_ID_ARR[0]);
        } else if (this.callNum == 2) {
            FightManager.startFightWithWild(this.FIGHT_ID_ARR[1]);
        } else if (this.callNum == 3) {
            FightManager.startFightWithWild(this.FIGHT_ID_ARR[2]);
        }
    }

    private function onCompleteSwitch(param1:SceneEvent):void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onCompleteSwitch);
            if (this.FIGHT_ID_ARR.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
                if (!FightManager.isWinWar()) {
                    this.fightFailMc.visible = true;
                }
            }
        }
    }

    private function onModeFight(param1:MouseEvent):void {
        switch (param1.currentTarget) {
            case this.fightMc["modeBtn0"]:
                ModuleManager.showAppModule("TheSpriteOfDragonModeOnePanel");
                break;
            case this.fightMc["modeBtn1"]:
                ModuleManager.showAppModule("TheSpriteOfDragonModeTwoPanel");
        }
    }

    private function onSwapPet(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        SwapManager.swapItem(4198, 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            updateData();
        });
    }

    public function updateData():void {
        this.callMc.visible = false;
        this.fightMc.visible = false;
        this.callSuccessMc.visible = false;
        this.fightFailMc.visible = false;
        ActiveCountManager.requestActiveCountList(this.FOR_LIST, function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            buyCount = par.infoVec[0];
            dragonBit = par.infoVec[1];
            callNum = par.infoVec[2];
            winNum = par.infoVec[3];
            isSwapPet = par.infoVec[4];
            DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                dayCount = param1.getCount(DAY_LIST[0]);
                if (VipManager.vipInfo.isVip()) {
                    gameCount = ActsHelperUtil.getCanNum(dayCount, buyCount, 4);
                } else {
                    gameCount = ActsHelperUtil.getCanNum(dayCount, buyCount, 2);
                }
                updateShow();
            });
        });
    }

    private function updateShow():void {
        var _loc3_:int = 0;
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this.PET_ID_ARR.length) {
            if (BitUtil.getBit(this.dragonBit, _loc2_)) {
                _loc1_++;
                this.dragonMcList[_loc2_].gotoAndStop(3);
            } else {
                this.dragonMcList[_loc2_].gotoAndStop(1);
                if (SimpleButton(this.dragonMcList[_loc2_]["reLifeBtn"]).hasEventListener(MouseEvent.CLICK) == false) {
                    SimpleButton(this.dragonMcList[_loc2_]["reLifeBtn"]).addEventListener(MouseEvent.CLICK, this.onReLife);
                }
                if (SimpleButton(this.dragonMcList[_loc2_]["buyLifeBtn"]).hasEventListener(MouseEvent.CLICK) == false) {
                    SimpleButton(this.dragonMcList[_loc2_]["buyLifeBtn"]).addEventListener(MouseEvent.CLICK, this.onBuyReLife);
                }
                TooltipManager.addCommonTip(this.dragonMcList[_loc2_]["zhuMc"], this.TIPS_ARR[_loc2_] + "之柱，\n拥有该龙就可点亮龙柱，也可用星钻一键点亮");
            }
            _loc2_++;
        }
        if (this.callNum < 4 && this.winNum < 10) {
            if (_loc1_ >= 10) {
                this.callMc.visible = true;
                this.callMc["numTxt"].text = String(5 - this.dayCount % 5 < 0 ? 0 : 5 - this.dayCount % 5);
                this.callMc["leftTxt"].text = String(this.gameCount);
                this.callMc["winTxt"].text = this.winNum + "/10";
                if (this.callNum > 0) {
                    this.callMc.visible = false;
                    this.callSuccessMc.visible = true;
                    this.callSuccessMc["petNameTxt"].text = this.petNameStr[this.callNum - 1];
                    MovieClip(this.callSuccessMc["petMc"]).gotoAndStop(this.callNum);
                }
            } else {
                this.playAndOpenRule();
            }
        } else {
            _loc3_ = 0;
            while (_loc3_ < this.dragonMcList.length) {
                this.dragonMcList[_loc3_].visible = false;
                _loc3_++;
            }
            this.fightMc.visible = true;
            this.fightMc["swapMark"].visible = false;
            this.winTxt.text = this.winNum + "/10";
            DisplayObjectUtil.disableButton(this.fightMc["swapBtn"]);
            if (this.isSwapPet) {
                this.fightMc["swapMark"].visible = true;
            } else if (this.winNum >= 10) {
                DisplayObjectUtil.enableButton(this.fightMc["swapBtn"]);
            }
        }
    }

    private function onCall(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if (this.gameCount <= 0) {
            ShopManager.buyItemForId(606541, function (param1:*):void {
                updateData();
            });
        } else {
            this.movieMc.visible = true;
            this.movieMc.gotoAndStop(1);
            MovieClipUtil.playMc(this.movieMc, 2, this.movieMc.totalFrames, function ():void {
                movieMc.visible = false;
                SwapManager.swapItem(SWAP_CALL_DRAGON, 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                    updateData();
                });
            });
        }
    }

    private function onBuyReLife(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        var idx:int = this.dragonMcList.indexOf(e.currentTarget.parent);
        ShopManager.buyItemForId(this.BUY_LIGHT_PET_ARR[idx], function (param1:*):void {
            updateData();
        });
    }

    private function onReLife(param1:MouseEvent):void {
        var idx:int = 0;
        var e:MouseEvent = param1;
        idx = this.dragonMcList.indexOf(e.currentTarget.parent);
        PetIsHaveManager.requestIsHavePet(this.PET_ID_ARR, function ():void {
            if (PetIsHaveManager.petIsHave(PET_ID_ARR[idx])) {
                SwapManager.swapItem(SWAP_LIGHT_DRAGON, 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                    ServerMessager.addMessage("点亮成功！");
                    updateData();
                }, null, new SpecialInfo(1, idx + 1));
            } else {
                ModuleManager.showAppModule(GET_PET_NAME[0]);
            }
        });
    }

    private function playAndOpenRule():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.TheSpriteOfDragonManager_FIRST, function (param1:ServerBuffer):void {
            var _loc2_:Boolean = Boolean(param1.readDataAtPostion(1));
            if (!_loc2_) {
                ServerBufferManager.updateServerBuffer(ServerBufferType.TheSpriteOfDragonManager_FIRST, 1, 1);
                ModuleManager.showAppModule("TheSpriteOfDragonRulePanel");
            }
        });
    }

    public function dispose():void {
    }
}
}
