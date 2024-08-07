package com.taomee.seer2.app.config {
import seer2.next.entry.DynConfig;
public class PetSkinDefineConfig {
    private static var _xmlClass:Class = PetSkinDefineConfig__xmlClass;

    private static var _skinDefineVec:Array;

    {
        setup();
    }
    public function PetSkinDefineConfig() {
        super();
    }
    private static function setup():void
    {
        var _xml:XML = null;
        var _skinXml:XML = DynConfig.petSkinDefineConfigXML || XML(new _xmlClass());
        var _skinList:XMLList = _skinXml.descendants("pet");
        _skinDefineVec = [];
        for(var i:int = 0;i<3000;i++)
        {
            _skinDefineVec[i]=[i];
        }
        for each(_xml in _skinList)
        {
            if(_skinDefineVec[uint(_xml.@resourceId)].indexOf(uint(_xml.@skinId)) == -1)
            {
                _skinDefineVec[uint(_xml.@resourceId)].push(uint(_xml.@skinId));
            }
        }
    }

    public static function getPetSkinDefine(petId:uint):Array
    {
        return _skinDefineVec[petId];
    }
}
}
