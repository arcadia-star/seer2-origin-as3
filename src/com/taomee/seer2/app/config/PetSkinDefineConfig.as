package com.taomee.seer2.app.config {
import org.taomee.ds.HashMap;

import seer2.next.entry.DynConfig;

public class PetSkinDefineConfig {
    private static var _xmlClass:Class = PetSkinDefineConfig__xmlClass;

    private static var _skinDefineMap:HashMap;

    private static var _skinNameMap:HashMap;

    {
        setup();
    }

    public function PetSkinDefineConfig() {
        super();
    }

    private static function setup():void {
        var _xml:XML = null;
        var _skinXml:XML = DynConfig.petSkinDefineConfigXML || XML(new _xmlClass());
        var _skinList:XMLList = _skinXml.descendants("pet");
        _skinDefineMap = new HashMap();
        _skinNameMap = new HashMap();

        for each(_xml in _skinList) {
            var tempArr:Array = null;//如果map中已经有resourceId, 先取出skinId数组并添加, 再塞回去; 如果没有就直接添加
            var resId:uint = uint(_xml.@resourceId);
            var skinId:uint = uint(_xml.@skinId);
            var tempMap:HashMap = null;
            if (_skinDefineMap.containsKey(resId)) {
                tempArr = _skinDefineMap.remove(resId) as Array;//hashmap取出来的东西用as转换, 不能用强转
            } else {
                tempArr = [resId];
            }
            tempArr.push(skinId);
            _skinDefineMap.add(uint(_xml.@resourceId), tempArr);

            if (_skinNameMap.containsKey(resId)) {
                tempMap = _skinNameMap.remove(resId) as HashMap;
            } else {
                tempMap = new HashMap();
            }
            tempMap.add(skinId, _xml.@skinname);
            _skinNameMap.add(resId, tempMap);
        }
    }

    public static function getPetSkinDefine(petId:uint):Array {
        if (_skinDefineMap.containsKey(petId)) {
            return _skinDefineMap.getValue(petId) as Array;
        }
        return [petId];
    }

    public static function getSkinName(petId:uint,skinId:uint):String {
        var nameMap:HashMap = null;
        if (_skinNameMap.containsKey(petId))
        {
            nameMap = _skinNameMap.getValue(petId) as HashMap;
            if(nameMap && nameMap.containsKey(skinId))
            {
                return nameMap.getValue(skinId);
            }
            else
            {
                return "未定义该皮肤";
            }
        }
        return "未知";
    }
}
}