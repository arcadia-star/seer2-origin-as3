package seer2.next.fight.ui.data {
public class PetExtData {
    public var monster:int;
    public var sex:int;
    public var featureTips:String;
    public var emblem1:int;
    public var emblem1Tips:String;
    public var emblem2:int;
    public var emblem2Tips:String;
    public var fetterTips:String;
    public var morphTips:String;
    public var showIcon:int;

    public function PetExtData() {

    }

    public static function from(obj:Object):PetExtData {
        if (!obj) {
            return null;
        }
        var target:PetExtData = new PetExtData;
        target.monster = obj.monster;
        target.sex = obj.sex;
        target.featureTips = obj.featureTips;
        target.emblem1 = obj.emblem1;
        target.emblem1Tips = obj.emblem1Tips;
        target.emblem2 = obj.emblem2;
        target.emblem2Tips = obj.emblem2Tips;
        target.fetterTips = obj.fetterTips;
        target.morphTips = obj.morphTips;
        target.showIcon = obj.showIcon;
        return target;
    }

    public static function clone(obj:PetExtData):PetExtData {
        if (!obj) {
            return null;
        }
        var target:PetExtData = new PetExtData;
        target.monster = obj.monster;
        target.sex = obj.sex;
        target.featureTips = obj.featureTips;
        target.emblem1 = obj.emblem1;
        target.emblem1Tips = obj.emblem1Tips;
        target.emblem2 = obj.emblem2;
        target.emblem2Tips = obj.emblem2Tips;
        target.fetterTips = obj.fetterTips;
        target.morphTips = obj.morphTips;
        target.showIcon = obj.showIcon;
        return target;
    }
}
}