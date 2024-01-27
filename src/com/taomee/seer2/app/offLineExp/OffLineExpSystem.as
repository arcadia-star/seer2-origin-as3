package com.taomee.seer2.app.offLineExp {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.data.FightResultInfo;
import com.taomee.seer2.app.arena.data.RevenueInfo;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.manager.FightResultPanelWrapper;
import com.taomee.seer2.app.manager.PetExperenceHelper;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;

import flash.utils.IDataInput;

public class OffLineExpSystem {

    private static const EXP_VALUE:uint = 203631;

    private static const SWAP_EXP:uint = 2294;

    private static var _currentExp:uint = 0;

    private static var _overTime:uint = 0;

    private static var _catchTime:uint = 0;


    public function OffLineExpSystem() {
        super();
    }

    public static function get overTime():uint {
        return _overTime;
    }

    public static function get currentExp():uint {
        return _currentExp;
    }

    public static function setup():void {
        ActiveCountManager.requestActiveCount(EXP_VALUE, getExpValue);
    }

    private static function getExpValue(param1:uint, param2:uint):void {
        _overTime = param2;
        var _loc3_:uint = uint(12 * 60 * 60);
        if (_overTime > _loc3_) {
            _overTime = _loc3_;
        }
        _currentExp = Math.floor(55 / 60 * _overTime);
    }

    public static function swapExp(param1:uint):void {
        var catchTime:uint = param1;
        _catchTime = catchTime;
        PetInfoManager.addEventListener(PetInfoEvent.PET_EXPERENCE_CHANGE, onPetExperenceChange);
        PetExperenceHelper.startListen();
        SwapManager.swapItem(SWAP_EXP, 1, function (param1:IDataInput):void {
            PetExperenceHelper.stopListen();
            new SwapInfo(param1);
            _currentExp = 0;
            _overTime = 0;
            PetAvatarPanel.hideExpIcon();
        }, null, new SpecialInfo(1, _catchTime));
    }

    private static function onPetExperenceChange(param1:PetInfoEvent):void {
        var _loc2_:RevenueInfo = null;
        var _loc3_:FightResultInfo = null;
        var _loc4_:PetInfo = null;
        _loc2_ = param1.content.revenueInfo;
        _loc3_ = param1.content.resultInfo;
        var _loc5_:int = 0;
        while (_loc5_ < PetInfoManager.getAllBagPetInfo().length) {
            if (PetInfoManager.getAllBagPetInfo()[_loc5_].catchTime == _catchTime) {
                _loc4_ = PetInfoManager.getAllBagPetInfo()[_loc5_];
                break;
            }
            _loc5_++;
        }
        PetInfoManager.removeEventListener(PetInfoEvent.PET_EXPERENCE_CHANGE, onPetExperenceChange);
        new FightResultPanelWrapper().show(Vector.<PetInfo>([_loc4_]), _loc2_, _loc3_);
    }
}
}
