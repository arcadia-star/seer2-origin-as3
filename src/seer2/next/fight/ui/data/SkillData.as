package seer2.next.fight.ui.data {
public class SkillData {
    public var id:int;
    public var name:String;
    public var power:int;
    public var anger:int;
    public var category:String;
    public var typeIcon:String;
    public var tips:String;
    public var enable:Boolean;

    public static function from(obj:Object):SkillData {
        var target:SkillData = new SkillData();
        target.id = obj.id;
        target.name = obj.name;
        target.power = obj.power;
        target.anger = obj.anger;
        target.category = obj.category;
        target.typeIcon = obj.typeIcon;
        target.tips = obj.tips;
        target.enable = obj.enable;
        return target;
    }

    public static function clone(obj:SkillData):SkillData {
        var target:SkillData = new SkillData();
        target.id = obj.id;
        target.name = obj.name;
        target.power = obj.power;
        target.anger = obj.anger;
        target.category = obj.category;
        target.typeIcon = obj.typeIcon;
        target.tips = obj.tips;
        target.enable = obj.enable;
        return target;
    }
}
}
