package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.system.ApplicationDomain;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class MapProcessor_80193 extends MapProcessor {

    private static const FIGHT_NUM_DAY:int = 1105;

    private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([948]);

    private static const FIGHT_NUM_MI_BUY_FOR:int = 204126;

    private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([3, 5]);


    private var _resLib:ApplicationDomain;

    private var _npcList:Vector.<Mobile>;

    private var _mouseHint:MouseClickHintSprite;

    public function MapProcessor_80193(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.moGuProcessActInit();
    }

    private function moGuProcessActInit():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FIGHT_INDEX_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
            DayLimitManager.getDoCount(FIGHT_NUM_DAY, function (param1:int):void {
                var val:int = param1;
                ActiveCountManager.requestActiveCount(FIGHT_NUM_MI_BUY_FOR, function (param1:uint, param2:uint):void {
                    var canFightNum:int = 0;
                    var type:uint = param1;
                    var count:uint = param2;
                    if (type == FIGHT_NUM_MI_BUY_FOR) {
                        if (VipManager.vipInfo.isVip()) {
                            canFightNum = ActsHelperUtil.getCanNum(val, count, FIGHT_NUM_RULE[1]);
                        } else {
                            canFightNum = ActsHelperUtil.getCanNum(val, count, FIGHT_NUM_RULE[0]);
                        }
                        if (canFightNum > 0) {
                            createNpcList();
                        } else {
                            TweenNano.delayedCall(3, function ():void {
                                ServerMessager.addMessage("今日免费挑战次数已用完，可花费星钻继续战斗！");
                                SceneManager.changeScene(SceneType.LOBBY, 70);
                            });
                        }
                    }
                });
            });
        } else {
            this.createNpcList();
        }
    }

    private function getURL(param1:Function = null):void {
        var callBack:Function = param1;
        QueueLoader.load(URLUtil.getActivityAnimation("moGuProcessAct"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            if (callBack != null) {
                callBack();
            }
        });
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    private function createNpcList():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.MO_GU_PROCESS_FIRST, function (param1:ServerBuffer):void {
            var server:ServerBuffer = param1;
            var _isPlay:Boolean = Boolean(server.readDataAtPostion(2));
            if (!_isPlay) {
                ServerBufferManager.updateServerBuffer(ServerBufferType.MO_GU_PROCESS_FIRST, 2, 1);
                getURL(function ():void {
                    var sceneMC:MovieClip = null;
                    sceneMC = getMovie("SceneMC");
                    _map.front.addChild(sceneMC);
                    MovieClipUtil.playMc(sceneMC, 2, sceneMC.totalFrames, function ():void {
                        sceneMC.gotoAndStop(sceneMC.totalFrames);
                        (sceneMC["ok"] as SimpleButton).addEventListener(MouseEvent.CLICK, function onOK(param1:MouseEvent):void {
                            (sceneMC["ok"] as SimpleButton).removeEventListener(MouseEvent.CLICK, onOK);
                            DisplayUtil.removeForParent(sceneMC);
                            sceneMC = null;
                            _npcList = new Vector.<Mobile>();
                            _npcList.push(createNpc([75, 250], "BlackWind", [393, 394], "黑风口"));
                            showMouseHintAtMonster(_npcList[0]);
                        });
                    }, true);
                });
            } else {
                _npcList = new Vector.<Mobile>();
                _npcList.push(createNpc([75, 250], "BlackWind", [393, 394], "黑风口"));
                showMouseHintAtMonster(_npcList[0]);
            }
        });
    }

    private function createNpc(param1:Array, param2:String, param3:Array, param4:String):Mobile {
        var _loc5_:Mobile;
        (_loc5_ = new Mobile()).width = param1[0];
        _loc5_.height = param1[1];
        _loc5_.setPostion(new Point(param3[0], param3[1]));
        _loc5_.resourceUrl = URLUtil.getActivityMobile(param2);
        _loc5_.labelPosition = MobileLabelPosition.OVER_HEAD;
        _loc5_.label = param4;
        _loc5_.labelImage.y = -_loc5_.height - 10;
        _loc5_.buttonMode = true;
        MobileManager.addMobile(_loc5_, MobileType.NPC);
        _loc5_.addEventListener(MouseEvent.CLICK, this.onNpcClick);
        return _loc5_;
    }

    private function showMouseHintAtMonster(param1:Sprite):void {
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.y = -param1.height - 10;
        this._mouseHint.x = (param1.width - this._mouseHint.width) / 2;
        param1.addChild(this._mouseHint);
    }

    private function removeMouseHint():void {
        DisplayUtil.removeForParent(this._mouseHint);
        this._mouseHint = null;
    }

    private function onNpcClick(param1:MouseEvent):void {
        FightManager.startFightWithWild(FIGHT_INDEX_LIST[0]);
    }

    private function clearNpcList():void {
        var _loc1_:int = 0;
        if (this._npcList) {
            _loc1_ = 0;
            while (_loc1_ < this._npcList.length) {
                this._npcList[_loc1_].removeEventListener(MouseEvent.CLICK, this.onNpcClick);
                _loc1_++;
            }
            this._npcList = null;
        }
    }

    private function moGuProcessActDispose():void {
        this.clearNpcList();
        this.removeMouseHint();
    }

    override public function dispose():void {
        this.moGuProcessActDispose();
        super.dispose();
    }
}
}
