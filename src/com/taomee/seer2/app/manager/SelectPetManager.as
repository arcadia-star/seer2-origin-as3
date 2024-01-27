package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.gameRule.behavior.SOMultiBehavior;
import com.taomee.seer2.app.gameRule.data.FighterSelectPanelVO;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

public class SelectPetManager {

    private static var _callBack:Function;


    public function SelectPetManager() {
        super();
    }

    public static function selectFixedPet(param1:int, param2:Function):void {
        var _loc3_:FighterSelectPanelVO = null;
        if (PetInfoManager.getAllBagPetInfo().length < param1) {
            AlertManager.showAlert("出战精灵数量不足");
            return;
        }
        _callBack = param2;
        _loc3_ = new FighterSelectPanelVO();
        _loc3_.minSelectedPetCount = param1;
        _loc3_.maxSelectedPetCount = param1;
        _loc3_.pets = PetInfoManager.getAllBagPetInfo();
        _loc3_.onComplete = onComplete;
        _loc3_.isShowSelected = true;
        _loc3_.defaultPets = getDefaultPets(param1);
        ModuleManager.toggleModule(URLUtil.getAppModule("FighterSelectPanel"), "打开面板中...", _loc3_);
    }

    private static function onComplete(param1:Vector.<uint>):void {
        var _loc2_:String = "default_selected_list";
        var _loc3_:Array = [];
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc3_.push(param1[_loc4_]);
            _loc4_++;
        }
        SOMultiBehavior.writeDefaultPets(_loc2_, _loc3_);
        _callBack(param1);
    }

    private static function getDefaultPets(param1:int):Vector.<PetInfo> {
        var _loc5_:int = 0;
        var _loc7_:uint = 0;
        var _loc2_:String = "default_selected_list";
        var _loc3_:Array = SOMultiBehavior.readDefaultPets(_loc2_);
        var _loc4_:Vector.<PetInfo> = new Vector.<PetInfo>();
        var _loc6_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
        if (!_loc3_) {
            _loc5_ = 0;
            while (_loc5_ < param1) {
                _loc4_.push(_loc6_[_loc5_]);
                _loc5_++;
            }
        } else {
            _loc7_ = _loc6_.length;
            _loc5_ = 0;
            while (_loc5_ < _loc7_) {
                if (_loc4_.length >= param1) {
                    break;
                }
                if (_loc3_.indexOf(_loc6_[_loc5_].catchTime) != -1) {
                    _loc4_.push(_loc6_[_loc5_]);
                }
                _loc5_++;
            }
            _loc5_ = 0;
            while (_loc5_ < _loc7_) {
                if (_loc4_.length >= param1) {
                    break;
                }
                if (_loc3_.indexOf(_loc6_[_loc5_].catchTime) == -1) {
                    _loc4_.push(_loc6_[_loc5_]);
                }
                _loc5_++;
            }
        }
        return _loc4_;
    }
}
}
