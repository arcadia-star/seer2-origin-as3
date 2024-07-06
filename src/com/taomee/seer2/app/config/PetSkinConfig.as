package com.taomee.seer2.app.config {
import org.taomee.ds.HashMap;
import seer2.next.entry.DynConfig;
public class PetSkinConfig {

    private static var _xmlClass:Class = PetSkinConfig__xmlClass;

    private static var skinMap:HashMap = new HashMap();

    {
        setup();
    }
    public function PetSkinConfig() {
        super();
    }

    private static function setup():void
    {
        var _xml:XML = null;
        var _skinXml:XML = DynConfig.petSkinConfigXML || XML(new _xmlClass());
        var _skinList:XMLList = _skinXml.descendants("pet");
        for each(_xml in _skinList)
        {
            skinMap.add(uint(_xml.@resourceId),uint(_xml.@skinId));
        }
    }

    public static function getSkinId(petId:uint):uint
    {
        if (skinMap.containsKey(petId)) {
            return skinMap.getValue(petId);
        }
        else
        {
            return 0;
        }
    }

    public static function setPetSkin(petId:uint,skinId:uint):void
    {
        if (skinMap.containsKey(petId)) {
            skinMap.remove(petId);
        }
        skinMap.add(petId,skinId);
    }
}
}
