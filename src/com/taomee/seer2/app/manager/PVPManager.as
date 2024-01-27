package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.gameRule.behavior.SOMultiBehavior;
import com.taomee.seer2.app.gameRule.data.FighterSelectPanelVO;
import com.taomee.seer2.app.info.PVPInfo;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

public class PVPManager {

    private static var _pvpInfo:PVPInfo;

    private static var _fightPets:Vector.<uint>;

    private static var _mateFun:Function;


    public function PVPManager() {
        super();
    }

    public static function requestPVP(param1:PVPInfo, param2:Function = null):void {
        var _loc4_:Vector.<uint> = null;
        var _loc5_:PetInfo = null;
        _pvpInfo = param1;
        _mateFun = param2;
        if (PetInfoManager.getAllBagPetInfo().length < _pvpInfo.minPetNum) {
            AlertManager.showAlert("出战精灵数量不足");
            return;
        }
        var _loc3_:FighterSelectPanelVO = new FighterSelectPanelVO();
        _loc3_.minSelectedPetCount = _pvpInfo.minPetNum;
        _loc3_.maxSelectedPetCount = _pvpInfo.maxPetNum;
        _loc3_.pets = PetInfoManager.getAllBagPetInfo();
        _loc3_.onComplete = startMate;
        _loc3_.isShowSelected = _pvpInfo.isShowTag;
        _loc3_.defaultPets = getDefaultPets(_pvpInfo.mode, PetInfoManager.getAllBagPetInfo());
        if (_pvpInfo.minPetNum == 7 && _pvpInfo.maxPetNum == 7) {
            _loc4_ = new Vector.<uint>();
            for each(_loc5_ in _loc3_.defaultPets) {
                _loc4_.push(_loc5_.catchTime);
            }
            startMate(_loc4_);
        } else {
            ModuleManager.toggleModule(URLUtil.getAppModule("FighterSelectPanel"), "打开面板中...", _loc3_);
        }
    }

    private static function getDefaultPets(param1:uint, param2:Vector.<PetInfo>):Vector.<PetInfo> {
        var _loc6_:int = 0;
        var _loc7_:uint = 0;
        var _loc3_:String = "sky_sports_" + param1;
        var _loc4_:Array = SOMultiBehavior.readDefaultPets(_loc3_);
        var _loc5_:Vector.<PetInfo> = new Vector.<PetInfo>();
        if (!_loc4_) {
            _loc6_ = 0;
            while (_loc6_ < _pvpInfo.minPetNum) {
                _loc5_.push(param2[_loc6_]);
                _loc6_++;
            }
        } else {
            _loc7_ = param2.length;
            _loc6_ = 0;
            while (_loc6_ < _loc7_) {
                if (_loc5_.length >= _pvpInfo.minPetNum) {
                    break;
                }
                if (_loc4_.indexOf(param2[_loc6_].catchTime) != -1) {
                    _loc5_.push(param2[_loc6_]);
                }
                _loc6_++;
            }
            _loc6_ = 0;
            while (_loc6_ < _loc7_) {
                if (_loc5_.length >= _pvpInfo.minPetNum) {
                    break;
                }
                if (_loc4_.indexOf(param2[_loc6_].catchTime) == -1) {
                    _loc5_.push(param2[_loc6_]);
                }
                _loc6_++;
            }
        }
        return _loc5_;
    }

    private static function startMate(param1:Vector.<uint>):void {
        _pvpInfo.petList = param1;
        var _loc2_:String = "sky_sports_" + _pvpInfo.mode;
        var _loc3_:Array = [];
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc3_.push(param1[_loc4_]);
            _loc4_++;
        }
        SOMultiBehavior.writeDefaultPets(_loc2_, _loc3_);
        if (_mateFun == null) {
            ModuleManager.toggleModule(URLUtil.getAppModule("PVPMatePanel"), "打开面板中...", _pvpInfo);
        } else {
            _mateFun();
            _mateFun = null;
        }
    }
}
}
