package com.taomee.seer2.app.processor.activity.sourceOfWater {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class SourceOfWaterManager {

    public static var fightIndex:int = 0;

    private static var fightWithWho:int;


    private var mobileVec:Vector.<Mobile>;

    private var mobileIDVec:Array;

    private var mobileIDsForBattle:Array;

    private var mobileIDsForSearch:Array;

    private var _mapmodel:MapModel;

    private var _hasWin:int = 0;

    private var _boss:MovieClip;

    private var _lightAndDragon:MovieClip;

    private var _bubbleLight:MovieClip;

    private var _countArray:Array;

    private var _lockedDragon:MovieClip;

    private var _hitArea:MovieClip;

    public function SourceOfWaterManager() {
        this.mobileVec = new Vector.<Mobile>();
        this.mobileIDVec = [550, 551, 552, 553];
        this.mobileIDsForBattle = [286, 287, 288, 289];
        this.mobileIDsForSearch = [606, 607, 608, 609];
        this._countArray = [];
        super();
    }

    private function init():void {
        var _loc2_:Mobile = null;
        this._mapmodel = SceneManager.active.mapModel;
        this._lightAndDragon = this._mapmodel.content["changedScene"];
        this._lightAndDragon.stop();
        this._lightAndDragon.visible = false;
        this._boss = this._lightAndDragon["dragon"];
        this._boss.buttonMode = true;
        this._bubbleLight = this._mapmodel.content["protectShelter"];
        this._bubbleLight.mouseChildren = this._bubbleLight.mouseEnabled = false;
        this._hitArea = this._mapmodel.content["hitarea"];
        this._hitArea.alpha = 0;
        this._hitArea.buttonMode = true;
        this._hitArea.addEventListener(MouseEvent.CLICK, this.onBubbleClick);
        this._lockedDragon = this._mapmodel.content["lockedDragon"];
        this._lockedDragon.mouseChildren = this._lockedDragon.mouseEnabled = false;
        var _loc1_:int = 0;
        while (_loc1_ < this.mobileIDVec.length) {
            _loc2_ = MobileManager.getMobile(this.mobileIDVec[_loc1_], MobileType.NPC);
            this.mobileVec.push(_loc2_);
            _loc2_.visible = false;
            _loc2_.buttonMode = true;
            _loc1_++;
        }
        this.getCount();
    }

    private function getCount():void {
        DayLimitManager.getDoCount(606, function (param1:uint):void {
            var a:uint = param1;
            _countArray[0] = a;
            DayLimitManager.getDoCount(607, function (param1:uint):void {
                var b:uint = param1;
                _countArray[1] = b;
                DayLimitManager.getDoCount(608, function (param1:uint):void {
                    var c:uint = param1;
                    _countArray[2] = c;
                    DayLimitManager.getDoCount(609, function (param1:uint):void {
                        _countArray[3] = param1;
                        checkCount();
                    });
                });
            });
        });
    }

    private function checkCount():void {
        var _loc1_:int = 0;
        while (_loc1_ < this._countArray.length) {
            if (this._countArray[_loc1_] >= 1) {
                this.mobileVec[_loc1_].visible = false;
                this._hasWin += 1;
            } else {
                this.mobileVec[_loc1_].visible = true;
                this.mobileVec[_loc1_].addEventListener(MouseEvent.CLICK, this.onMobileClick);
            }
            _loc1_++;
        }
        this.checkStatus();
    }

    private function onBubbleClick(param1:MouseEvent):void {
        NpcDialog.show(549, "脉灵兽", [[0, "唯有羁绊能让吾等重生，冲破铁索吾将与你同行。只有击败铁索上的4只精灵才能够解开封印与脉灵兽挑战，每天你将有3次挑战机会。"]], ["好吧"], [null]);
    }

    private function onMobileClick(param1:MouseEvent):void {
        FightManager.startFightWithWild((param1.currentTarget as Mobile).id - 264);
        fightWithWho = (param1.currentTarget as Mobile).id;
    }

    private function onBossClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if (this._hasWin >= 4) {
            DayLimitManager.getDoCount(610, function (param1:uint):void {
                var count:uint = param1;
                if (count > 2) {
                    NpcDialog.show(549, "脉灵兽", [[0, "今天就到这里，明天再来吧"]], ["好吧"], [null]);
                } else {
                    NpcDialog.show(549, "脉灵兽", [[0, "照亮明天的七色之光无法穿透深深的海底，泪水不曾停止流淌成了不息的脉流，铁索抑制疯狂的魂魄，羁绊让内心重掀巨浪……"]], ["挑战脉灵兽"], [function ():void {
                        FightManager.startFightWithWild(290);
                        fightWithWho = 549;
                    }]);
                }
            });
        } else {
            NpcDialog.show(549, "脉灵兽", [[0, "唯有羁绊能让吾等重生，冲破铁索吾将与你同行。只有击败铁索上的4只精灵才能够解开封印与脉灵兽挑战，每天你将有3次挑战机会。"]], ["好吧"], [null]);
        }
    }

    private function checkStatus():void {
        var isFightWIthSprite:Boolean = this.fightWithSprite();
        if (this._hasWin == 4) {
            if (SceneManager.prevSceneType == SceneType.ARENA && isFightWIthSprite) {
                MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("sourceOfWater/sourceOfWater"), function ():void {
                    changeScene();
                }, true, false, 2);
            } else {
                this.changeScene();
            }
        }
    }

    private function fightWithSprite():Boolean {
        return fightWithWho == 550 || fightWithWho == 551 || fightWithWho == 552 || fightWithWho == 553;
    }

    private function changeScene():void {
        this._bubbleLight.stop();
        DisplayObjectUtil.removeFromParent(this._bubbleLight);
        this._lockedDragon.visible = false;
        DisplayUtil.removeForParent(this._lockedDragon);
        this._lightAndDragon.visible = true;
        this._boss.addEventListener(MouseEvent.CLICK, this.onBossClick);
        this._hitArea.removeEventListener(MouseEvent.CLICK, this.onBubbleClick);
        DisplayUtil.removeForParent(this._hitArea);
    }

    public function setUp():void {
        this.init();
    }
}
}
