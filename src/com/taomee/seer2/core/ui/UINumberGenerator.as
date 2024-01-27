package com.taomee.seer2.core.ui {
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.NumberUtil;

import flash.display.Sprite;

import org.taomee.ds.HashMap;

public class UINumberGenerator {

    private static var _poolMap:HashMap;

    {
        initialize();
    }

    public function UINumberGenerator() {
        super();
    }

    private static function initialize():void {
        _poolMap = new HashMap();
    }

    public static function generateItemNumber(param1:int):Sprite {
        return generateNumberSprite(param1, "UI_NumberItem", 7);
    }

    public static function generateLoaderNumber(param1:int):Sprite {
        return generateNumberSprite(param1, "UI_NumberLoader", 13);
    }

    public static function generateFighterLevelNumber(param1:int, param2:uint = 11):Sprite {
        var _loc3_:String = "UI_NumberPetLevel";
        return generateNumberSprite(param1, _loc3_, param2);
    }

    public static function generateAngerIncreaseNumber(param1:int):Sprite {
        var _loc2_:String = "UI_NumberAngerIncrease";
        return generateNumberSprite(param1, _loc2_, 36);
    }

    public static function generateHpNumber(param1:int, param2:int):Sprite {
        var _loc3_:String = "UI_NumberHp";
        recyleDigitSprite(_loc3_);
        var _loc4_:Sprite = createDisableSprite();
        var _loc5_:Sprite = generateNumberSprite(param1, _loc3_, 11);
        _loc4_.addChild(_loc5_);
        var _loc6_:Sprite;
        (_loc6_ = UIManager.getSprite(_loc3_ + "Slash")).x = _loc5_.width;
        _loc4_.addChild(_loc6_);
        var _loc7_:Sprite;
        (_loc7_ = generateNumberSprite(param2, _loc3_, 11)).x = _loc6_.x + _loc6_.width;
        _loc4_.addChild(_loc7_);
        return _loc4_;
    }

    public static function generateAngerNumber(param1:int, param2:int):Sprite {
        var _loc3_:String = "UI_NumberAnger";
        recyleDigitSprite(_loc3_);
        var _loc4_:Sprite = createDisableSprite();
        var _loc5_:Sprite = generateNumberSprite(param1, _loc3_, 11);
        _loc4_.addChild(_loc5_);
        var _loc6_:Sprite;
        (_loc6_ = UIManager.getSprite(_loc3_ + "Slash")).x = _loc5_.width;
        _loc4_.addChild(_loc6_);
        var _loc7_:Sprite;
        (_loc7_ = generateNumberSprite(param2, _loc3_, 11)).x = _loc6_.x + _loc6_.width;
        _loc4_.addChild(_loc7_);
        return _loc4_;
    }

    private static function recyleDigitSprite(param1:String):void {
        var _loc2_:DigitSpritePool = getDigitSpritePool(param1);
        _loc2_.recycle();
    }

    private static function generateNumberSprite(param1:int, param2:String, param3:int):Sprite {
        var _loc7_:Sprite = null;
        var _loc10_:int = 0;
        var _loc4_:DigitSpritePool = getDigitSpritePool(param2);
        var _loc5_:Sprite = createDisableSprite();
        var _loc6_:Vector.<int>;
        var _loc8_:int = int((_loc6_ = NumberUtil.parseNumberToDigitVec(param1)).length);
        var _loc9_:int = 0;
        while (_loc9_ < _loc8_) {
            _loc10_ = _loc6_[_loc9_];
            (_loc7_ = _loc4_.checkOut(_loc10_)).x = _loc9_ * param3;
            _loc5_.addChild(_loc7_);
            _loc9_++;
        }
        return _loc5_;
    }

    private static function getDigitSpritePool(param1:String):DigitSpritePool {
        if (_poolMap.containsKey(param1) == false) {
            _poolMap.add(param1, new DigitSpritePool(param1));
        }
        return _poolMap.getValue(param1) as DigitSpritePool;
    }

    private static function createDisableSprite():Sprite {
        var _loc1_:Sprite = new Sprite();
        DisplayObjectUtil.disableSprite(_loc1_);
        return _loc1_;
    }
}
}
