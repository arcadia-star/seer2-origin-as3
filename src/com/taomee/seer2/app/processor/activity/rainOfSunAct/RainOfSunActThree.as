package com.taomee.seer2.app.processor.activity.rainOfSunAct {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class RainOfSunActThree {

    private static const BLUE_GET_FOR:uint = 1;

    private static const BLUE_GET_SWAP:int = 1;

    private static const FIGHT_INDEX:int = 572;

    private static const NPC_RES_ID:int = 487;


    private var _map:MapModel;

    private var _resLib:ApplicationDomain;

    private var _npc:Mobile;

    private var _blueRain:MovieClip;

    private const TIME_REGION:Array = [[20, 0], [29, 59]];

    private var _isGet:Boolean;

    public function RainOfSunActThree(param1:MapModel) {
        super();
        this._map = param1;
        this.init();
    }

    private function getURL():void {
        QueueLoader.load(URLUtil.getActivityAnimation("rainOfSunAct/RainOfSunActThree"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            init();
        });
    }

    private function init():void {
        this._npc = MobileManager.getMobile(NPC_RES_ID, MobileType.NPC);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
    }

    private function isInHourScope(param1:Array, param2:Array):Boolean {
        var _loc3_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc4_:Date = new Date(2013, 7, 24, 14, param1[0], param1[1]);
        var _loc5_:Date = new Date(2013, 7, 24, 14, param2[0], param2[1]);
        if (_loc4_ <= _loc3_ && _loc5_ >= _loc3_) {
            return true;
        }
        return false;
    }

    private function onNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(NPC_RES_ID, "米咔", [[2, "最近听说太阳神出动，天空下着神奇的太阳雨。我这里也恰好捡到一些，和我对战就可以给你一点哟。"]], ["开始对战", "准备一下"], [function ():void {
            FightManager.startFightWithWild(FIGHT_INDEX);
        }]);
    }

    private function blueRainHandleInit():void {
        this._blueRain = this.getMovie("BlueRain");
        this._blueRain.buttonMode = true;
        ActiveCountManager.requestActiveCount(BLUE_GET_FOR, function (param1:int, param2:int):void {
            _isGet = Boolean(param2);
            _blueRain.addEventListener(MouseEvent.CLICK, onSwap);
        });
    }

    private function clearBlueRain():void {
        if (this._blueRain) {
            this._blueRain.removeEventListener(MouseEvent.CLICK, this.onSwap);
            DisplayUtil.removeForParent(this._blueRain);
            this._blueRain = null;
        }
    }

    private function onSwap(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (!this._isGet) {
            SwapManager.swapItem(BLUE_GET_SWAP, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                _isGet = true;
            });
        } else {
            AlertManager.showAlert("你已经领取过了！");
        }
    }

    private function removeNpc():void {
        if (this._npc) {
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
        }
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    public function dispose():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
        }
        this.removeNpc();
    }
}
}
