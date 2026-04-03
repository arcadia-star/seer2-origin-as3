package seer2.next.fight.ui.data {
import seer2.next.fight.*;

public class PetData {
    public var pid:int;
    public var petIcon:String;
    public var petSwf:String;
    public var petSound:String;
    public var name:String;
    public var level:int;
    public var typeIcon:String;
    public var position:int;
    public var alive:int;
    public var anger:int;
    public var maxAnger:int;
    public var hp:int;
    public var maxHp:int;
    public var rate:int;
    public var atk:int;
    public var def:int;
    public var spa:int;
    public var spd:int;
    public var spe:int;
    public var skills:Vector.<SkillData>
    public var buffs:Vector.<BuffData>
    public var items:Vector.<ItemData>

    public static function from(obj:Object):PetData {
        var target:PetData = new PetData;
        target.pid = obj.pid;
        target.petIcon = obj.petIcon;
        target.petSwf = obj.petSwf;
        target.petSound = obj.petSound;
        target.name = obj.name;
        target.level = obj.level;
        target.typeIcon = obj.typeIcon;
        target.position = obj.position;
        target.alive = obj.alive;
        target.anger = obj.anger;
        target.maxAnger = obj.maxAnger;
        target.hp = obj.hp;
        target.maxHp = obj.maxHp;
        target.rate = obj.rate;
        target.atk = obj.atk;
        target.def = obj.def;
        target.spa = obj.spa;
        target.spd = obj.spd;
        target.spe = obj.spe;
        target.skills = transSkill(obj.skills);
        target.buffs = transBuff(obj.buffs);
        target.items = transItem(obj.items);
        return target;
    }

    public static function clone(obj:PetData):PetData {
        var target:PetData = new PetData;
        target.pid = obj.pid;
        target.petIcon = obj.petIcon;
        target.petSwf = obj.petSwf;
        target.petSound = obj.petSound;
        target.name = obj.name;
        target.level = obj.level;
        target.typeIcon = obj.typeIcon;
        target.position = obj.position;
        target.alive = obj.alive;
        target.anger = obj.anger;
        target.maxAnger = obj.maxAnger;
        target.hp = obj.hp;
        target.maxHp = obj.maxHp;
        target.rate = obj.rate;
        target.atk = obj.atk;
        target.def = obj.def;
        target.spa = obj.spa;
        target.spd = obj.spd;
        target.spe = obj.spe;
        target.skills = cloneSkill(obj.skills);
        target.buffs = cloneBuff(obj.buffs);
        target.items = cloneItem(obj.items);
        return target;
    }

    private static function transSkill(array:Array):Vector.<SkillData> {
        var res:Vector.<SkillData> = new Vector.<SkillData>();
        if (!array) {
            return res;
        }
        for (var i:int = 0; i < array.length; i++) {
            res.push(SkillData.from(array[i]));
        }
        return res;
    }

    private static function transBuff(array:Array):Vector.<BuffData> {
        var res:Vector.<BuffData> = new Vector.<BuffData>();
        if (!array) {
            return res;
        }
        for (var i:int = 0; i < array.length; i++) {
            res.push(BuffData.from(array[i]));
        }
        return res;
    }

    private static function transItem(array:Array):Vector.<ItemData> {
        var res:Vector.<ItemData> = new Vector.<ItemData>();
        if (!array) {
            return res;
        }
        for (var i:int = 0; i < array.length; i++) {
            res.push(ItemData.from(array[i]));
        }
        return res;
    }

    private static function cloneSkill(array:Vector.<SkillData>):Vector.<SkillData> {
        var res:Vector.<SkillData> = new Vector.<SkillData>();
        if (!array) {
            return res;
        }
        for (var i:int = 0; i < array.length; i++) {
            res.push(SkillData.clone(array[i]));
        }
        return res;
    }

    private static function cloneBuff(array:Vector.<BuffData>):Vector.<BuffData> {
        var res:Vector.<BuffData> = new Vector.<BuffData>();
        if (!array) {
            return res;
        }
        for (var i:int = 0; i < array.length; i++) {
            res.push(BuffData.clone(array[i]));
        }
        return res;
    }

    private static function cloneItem(array:Vector.<ItemData>):Vector.<ItemData> {
        var res:Vector.<ItemData> = new Vector.<ItemData>();
        if (!array) {
            return res;
        }
        for (var i:int = 0; i < array.length; i++) {
            res.push(ItemData.clone(array[i]));
        }
        return res;
    }
}
}
