package com.taomee.seer2.app.processor.activity.LightTorch {
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class LightTorchManager {


    private var _mapModel:MapModel;

    private var _torchMC:MovieClip;

    private var _clickMc:MovieClip;

    private const DAY_LIST:Array = [5550, 5551];

    private const SWAP_ID:int = 4350;

    private var mapID:Array;

    private var torchPos:Array;

    public function LightTorchManager(param1:MapModel) {
        var mapModel:MapModel = param1;
        this.mapID = [90, 230, 330, 320, 470, 160, 720];
        this.torchPos = [[340, 500], [320, 550], [490, 550], [670, 440], [260, 550], [760, 550], [810, 490]];
        super();
        this._mapModel = mapModel;
        MovieClipUtil.getSwfContent(URLUtil.getActivityAnimation("lightTorchActivity"), function callBack(param1:MovieClip):void {
            var _loc2_:int = 0;
            _loc2_ = mapID.indexOf(_mapModel.id);
            _torchMC = param1["contentMc"];
            _torchMC.x = torchPos[_loc2_][0];
            _torchMC.y = torchPos[_loc2_][1];
            _torchMC.mouseEnabled = false;
            _mapModel.content.addChild(_torchMC);
            _clickMc = _torchMC["clickMc"];
            _clickMc.buttonMode = true;
            _clickMc.addEventListener(MouseEvent.CLICK, onTorchClick);
        });
        ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, function requestSuccess(param1:ItemEvent):void {
            ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, requestSuccess);
        });
        ItemManager.requestSpecialItemList();
    }

    public function onTorchClick(param1:MouseEvent):void {
        var itemID:uint;
        var evt:MouseEvent = param1;
        this._clickMc.mouseEnabled = false;
        itemID = 606689;
        DayLimitListManager.getDaylimitList(this.DAY_LIST, function callBack(param1:DayLimitListInfo):void {
            var info:DayLimitListInfo = param1;
            var num:int = int(info.getCount(DAY_LIST[0]));
            var cdTime:int = info.getCount(DAY_LIST[1]) - TimeManager.getServerTime();
            if (cdTime <= 0 && num < 5) {
                SwapManager.swapItem(SWAP_ID, 1, function success(param1:IDataInput):void {
                    new SwapInfo(param1);
                    _torchMC.gotoAndStop(2);
                    _torchMC.mouseEnabled = _torchMC.mouseChildren = false;
                    _clickMc.mouseEnabled = true;
                    StatisticsManager.newSendNovice("2015活动", "备战孤独之战", "点亮火柱");
                }, function failed(param1:uint):void {
                    _clickMc.mouseEnabled = true;
                });
            } else if (num >= 5) {
                _clickMc.mouseEnabled = true;
                AlertManager.showAlert("今天已成功点燃 5 次，明天再来吧...");
            } else if (cdTime > 0) {
                _clickMc.mouseEnabled = true;
                AlertManager.showAlert("还要等待 " + DateUtil.getMS(cdTime) + " 才能点燃。");
            }
        });
    }

    public function dispose():void {
        if (this._torchMC.hasEventListener(MouseEvent.CLICK)) {
            this._torchMC.removeEventListener(MouseEvent.CLICK, this.onTorchClick);
        }
    }
}
}
