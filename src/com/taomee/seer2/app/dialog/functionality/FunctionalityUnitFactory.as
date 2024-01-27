package com.taomee.seer2.app.dialog.functionality {
import com.taomee.seer2.app.dialog.constant.FunctionalityType;

public class FunctionalityUnitFactory {


    public function FunctionalityUnitFactory() {
        super();
    }

    public static function createUnit(param1:String, param2:String, param3:String):BaseUnit {
        var _loc4_:GameUnit = null;
        var _loc5_:ModuleUnit = null;
        var _loc6_:ShopUnit = null;
        var _loc7_:RewardUnit = null;
        var _loc8_:ActiveUnit = null;
        var _loc9_:URLUnit = null;
        var _loc10_:FishBookUnit = null;
        switch (param1) {
            case FunctionalityType.GAME:
                (_loc4_ = new GameUnit()).label = param2;
                _loc4_.params = param3;
                return _loc4_;
            case FunctionalityType.MODULE:
                (_loc5_ = new ModuleUnit()).label = param2;
                _loc5_.params = param3;
                return _loc5_;
            case FunctionalityType.SHOP:
                (_loc6_ = new ShopUnit()).label = param2;
                _loc6_.params = param3;
                return _loc6_;
            case FunctionalityType.REWARD:
                (_loc7_ = new RewardUnit()).label = param2;
                _loc7_.params = param3;
                return _loc7_;
            case FunctionalityType.ACTIVE:
                (_loc8_ = new ActiveUnit()).label = param2;
                _loc8_.params = param3;
                return _loc8_;
            case FunctionalityType.URL:
                (_loc9_ = new URLUnit()).label = param2;
                _loc9_.params = param3;
                return _loc9_;
            case FunctionalityType.FISHBOOK:
                (_loc10_ = new FishBookUnit()).label = param2;
                _loc10_.params = param3;
                return _loc10_;
            default:
                return new CustomUnit(param1, param2, param3);
        }
    }
}
}
