package com.taomee.seer2.app.processor.activity.giftMachine {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.activity.devilActivity.DevilLoad;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;

public class GiftMachine {


    private const pointList:Vector.<Point> = Vector.<Point>([new Point(548, 405), new Point(133, 359)]);

    private var _load:DevilLoad;

    private var _index:int;

    private var _mc:MovieClip;

    public function GiftMachine(param1:int) {
        super();
        this._index = param1;
        this.init();
    }

    private function init():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.GIFT_MACHINE, this.onGetSer);
    }

    private function onGetSer(param1:ServerBuffer):void {
        var ser:ServerBuffer = param1;
        if (ser.readDataAtPostion(this._index) != 1) {
            this._load = new DevilLoad();
            this._load.playLoad("giftMachine/giftMachine", function ():void {
                _mc = _load.getMC("itemMC");
                _mc.x = pointList[_index].x;
                _mc.y = pointList[_index].y;
                SceneManager.active.mapModel.content.addChild(_mc);
                _mc.buttonMode = true;
                _mc.addEventListener(MouseEvent.CLICK, onMC);
            });
        }
    }

    private function onMC(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        SwapManager.swapItem(582, 1, function (param1:IDataInput):void {
            new SwapInfo(param1, false);
            ServerMessager.addMessage("获得一张精灵扭蛋牌");
            DisplayUtil.removeForParent(_mc);
            ModuleManager.toggleModule(URLUtil.getAppModule("GiftMachineGotoPanel"), "……");
            ServerBufferManager.updateServerBuffer(ServerBufferType.GIFT_MACHINE, _index, 1);
        });
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_224);
    }

    public function dispose():void {
        DisplayUtil.removeForParent(this._mc);
        if (this._load) {
            this._load.dispose();
        }
        this._mc = null;
        this._load = null;
    }
}
}
