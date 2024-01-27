package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.utils.IDataInput;

import org.taomee.utils.BitUtil;

public class MapProcessor_80336 extends MapProcessor {

    private static const FOR_LIST:Array = [204978, 204982, 204997];

    private static const DAY_LIST:Array = [1427];

    private static const SWAP_LIST:Vector.<int> = Vector.<int>([3335]);

    private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1316]);

    private static const NPC_ID_LIST:Vector.<int> = Vector.<int>([824]);

    private static const FIGHT_NUM:Vector.<int> = Vector.<int>([2, 3]);

    private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([605095]);

    private static var _chacheDate:Vector.<int> = Vector.<int>([0]);

    private static const AWARD_NUM:Vector.<int> = Vector.<int>([50, 100, 200]);

    private static var _isInitItemNum:Boolean = false;

    private static var _oldItemNum:int;


    private var _par:Parser_1142;

    private var _info:DayLimitListInfo;

    private var _npc:Mobile;

    private var _mouseHint:MouseClickHintSprite;

    private var _swapUI:MovieClip;

    private var _bar:MovieClip;

    private var _getAwardList:Vector.<SimpleButton>;

    private var _getedMarkList:Vector.<MovieClip>;

    private var _exitBtn:SimpleButton;

    private var _itemNum:TextField;

    public function MapProcessor_80336(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.onActInit();
    }

    private function onActInit():void {
        this.swapUIInitSet();
        this.initEvent();
        this.update();
    }

    private function initEvent():void {
        var _loc1_:SimpleButton = null;
        this._exitBtn.addEventListener(MouseEvent.CLICK, this.onTwoBossExit);
        for each(_loc1_ in this._getAwardList) {
            _loc1_.addEventListener(MouseEvent.CLICK, this.onGetAward);
        }
    }

    private function onGetAward(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        var index:int = this._getAwardList.indexOf(evt.currentTarget as SimpleButton);
        SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            updateBar();
        }, null, new SpecialInfo(1, index + 1));
    }

    private function setFuncDisable():void {
        var _loc1_:SimpleButton = null;
        for each(_loc1_ in this._getAwardList) {
            _loc1_.mouseEnabled = false;
        }
    }

    private function updateData(param1:Function = null):void {
        var func:Function = param1;
        this.setFuncDisable();
        ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                var _loc2_:SimpleButton = null;
                _par = par;
                _info = param1;
                for each(_loc2_ in _getAwardList) {
                    _loc2_.mouseEnabled = true;
                }
                if (func != null) {
                    func();
                }
            });
        });
    }

    private function updateBar():void {
        this.updateData(this.getBarStateHandle);
    }

    private function onTwoBossExit(param1:MouseEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function update():void {
        this.updateData(function ():void {
            if (_chacheDate[0] == 0) {
                _chacheDate[0] = 1;
                MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("QingHolyPetProcessAct"), function ():void {
                    addNpc();
                    _npc.addEventListener(MouseEvent.CLICK, onNpcClick);
                }, true, true, 2, true);
            } else {
                addNpc();
                _npc.addEventListener(MouseEvent.CLICK, onNpcClick);
            }
            getBarStateHandle();
            itemNumHandle();
        });
    }

    private function addNpc():void {
        this._npc = new Mobile();
        this._npc.width = 82;
        this._npc.height = 115;
        this._npc.setPostion(new Point(440, 300));
        this._npc.resourceUrl = URLUtil.getNpcSwf(NPC_ID_LIST[0]);
        this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
        this._npc.label = "沁灵神";
        this._npc.labelImage.y = -this._npc.height - 10;
        this._npc.buttonMode = true;
        this.showMouseHintAtMonster(this._npc);
        MobileManager.addMobile(this._npc, MobileType.NPC);
    }

    private function onNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        var canFightNum:int = ActsHelperUtil.getCanNum(this._info.getCount(DAY_LIST[0]), this._par.infoVec[0], VipManager.vipInfo.isVip() ? FIGHT_NUM[1] : FIGHT_NUM[0]);
        if (canFightNum > 0) {
            NpcDialog.show(824, "沁灵神", [[0, "小赛尔，与我战斗吧！只有你的胜利才能拿走我魂魄中的【沁灵】！它会让你得到我的进化之力（每次胜利必得5-10个沁灵）!现在还有<font color=\'#ffcc00\'>" + canFightNum.toString() + " </font>次机会"]], ["嗯！", "准备一下"], [function ():void {
                FightManager.startFightWithWild(FIGHT_INDEX_LIST[0]);
            }]);
        } else {
            NpcDialog.show(824, "沁灵神", [[0, "你今天已经没有机会了!"]], ["购买挑战", "明天再来试试吧！"], [function ():void {
                ShopManager.buyItemForId(MI_ID_LIST[0], function ():void {
                    updateData(function ():void {
                        FightManager.startFightWithWild(FIGHT_INDEX_LIST[0]);
                    });
                });
            }]);
        }
    }

    private function removeNpc():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            this._npc = null;
        }
    }

    private function showMouseHintAtMonster(param1:Sprite):void {
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.y = -param1.height - 10;
        this._mouseHint.x = (param1.width - this._mouseHint.width) / 2;
        param1.addChild(this._mouseHint);
    }

    private function swapUIInitSet():void {
        this._swapUI = _map.front["swapUI"];
        this._bar = this._swapUI["bar"] as MovieClip;
        this._getAwardList = new Vector.<SimpleButton>();
        this._getedMarkList = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            this._getAwardList.push(this._swapUI["getAward" + _loc1_]);
            this._getedMarkList.push(this._swapUI["getedMark" + _loc1_]);
            _loc1_++;
        }
        this._exitBtn = this._swapUI["exitBtn"];
        this._itemNum = this._swapUI["itemNum"];
    }

    private function getBarStateHandle():void {
        this._bar.scaleY = this._par.infoVec[2] / AWARD_NUM[2] > 1 ? 1 : this._par.infoVec[2] / AWARD_NUM[2];
        var _loc1_:int = 0;
        while (_loc1_ < AWARD_NUM.length) {
            if (this._par.infoVec[2] >= AWARD_NUM[_loc1_]) {
                if (BitUtil.getBit(this._par.infoVec[1], _loc1_)) {
                    this._getedMarkList[_loc1_].visible = true;
                    DisplayObjectUtil.disableButton(this._getAwardList[_loc1_]);
                } else {
                    this._getedMarkList[_loc1_].visible = false;
                    DisplayObjectUtil.enableButton(this._getAwardList[_loc1_]);
                }
            } else {
                this._getedMarkList[_loc1_].visible = false;
                DisplayObjectUtil.disableButton(this._getAwardList[_loc1_]);
            }
            _loc1_++;
        }
    }

    private function itemNumHandle():void {
        if (!_isInitItemNum) {
            this._itemNum.text = this._par.infoVec[2].toString();
            _oldItemNum = this._par.infoVec[2];
            _isInitItemNum = true;
        } else {
            if (this._par.infoVec[2] > _oldItemNum) {
                ServerMessager.addMessage("恭喜你获得" + (this._par.infoVec[2] - _oldItemNum) + "个沁灵!");
            }
            this._itemNum.text = this._par.infoVec[2].toString();
            _oldItemNum = this._par.infoVec[2];
        }
    }

    private function onActDispose():void {
        this.removeNpc();
    }

    override public function dispose():void {
        this.onActDispose();
        super.dispose();
    }
}
}
