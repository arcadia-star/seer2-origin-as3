package com.taomee.seer2.app.processor.activity.frozen {
import com.taomee.seer2.app.manager.InteractiveRewardManager;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class StoneAward {

    private static var _stone:MovieClip;

    private static var _soArray:Array;

    private static var _stoneList:Vector.<MovieClip>;

    private static var _index:int;


    public function StoneAward() {
        super();
    }

    public static function setupStone(param1:MapModel):void {
        var map:MapModel = param1;
        FrozenStatus.getSwfContent(function ():void {
            _stone = FrozenStatus.getStone();
            map.content.addChild(_stone);
            initEvent();
            initSoArray();
        });
    }

    private static function initSoArray():void {
        var _loc1_:uint = 0;
        _soArray = FrozenSo.getRewardNum();
        for each(_loc1_ in _soArray) {
            _stone["stone" + _loc1_].buttonMode = false;
            _stone["stone" + _loc1_].removeEventListener(MouseEvent.CLICK, onStoneClick);
            DisplayUtil.removeForParent(_stone["stone" + _loc1_]);
        }
    }

    private static function initEvent():void {
        var _loc1_:int = 0;
        _stoneList = Vector.<MovieClip>([]);
        _loc1_ = 0;
        while (_loc1_ < 14) {
            _stoneList.push(_stone["stone" + _loc1_]);
            _stoneList[_loc1_].buttonMode = true;
            _stoneList[_loc1_].addEventListener(MouseEvent.CLICK, onStoneClick);
            _loc1_++;
        }
    }

    private static function onStoneClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        _index = _stoneList.indexOf(_loc2_);
        InteractiveRewardManager.requestReward(49, onGetRewardSuccess, error);
    }

    private static function onGetRewardSuccess(param1:Parser_1060):void {
        var parser:Parser_1060 = param1;
        FrozenSo.setRewardNum(_index);
        if (parser.petId != 0) {
            FrozenStatus.playAnimation7(function ():void {
                parser.showResult(true);
                DisplayUtil.removeForParent(_stoneList[_index]);
            });
            return;
        }
        parser.showResult(true);
        DisplayUtil.removeForParent(_stoneList[_index]);
    }

    private static function error():void {
        AlertManager.showAlert("冰轴已经没有碎片了……（明天再试试）");
    }

    public static function remove():void {
        var _loc1_:MovieClip = null;
        for each(_loc1_ in _stoneList) {
            _loc1_.removeEventListener(MouseEvent.CLICK, onStoneClick);
        }
        DisplayUtil.removeForParent(_stone);
    }
}
}
