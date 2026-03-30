package seer2.next.fight.ui.data {

public class TeamData {
    public var _master:PetData;
    public var _slave:PetData;
    public var pets:Vector.<PetData>;
    public var items:Vector.<ItemData>;
    public var capsules:Vector.<ItemData>;

    public static function from(obj:Object):TeamData {
        var target:TeamData = new TeamData();
        target.pets = transPet(obj.pets);
        target.items = transItem(obj.items);
        target.capsules = transItem(obj.capsules);
        target.init();
        return target;
    }

    public static function clone(obj:TeamData):TeamData {
        var target:TeamData = new TeamData();
        target.pets = clonePet(obj.pets);
        target.items = cloneItem(obj.items);
        target.capsules = cloneItem(obj.capsules);
        target.init();
        return target;
    }

    private static function transPet(array:Array):Vector.<PetData> {
        var res:Vector.<PetData> = new Vector.<PetData>();
        if (!array) {
            return res;
        }
        for (var i:int = 0; i < array.length; i++) {
            res.push(PetData.from(array[i]));
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

    private static function clonePet(array:Vector.<PetData>):Vector.<PetData> {
        var res:Vector.<PetData> = new Vector.<PetData>();
        if (!array) {
            return res;
        }
        for (var i:int = 0; i < array.length; i++) {
            res.push(PetData.clone(array[i]));
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

    public function get master():PetData {
        return _master;
    }

    public function get slave():PetData {
        return _slave;
    }

    public function init():void {
        for (var i:int = 0; i < pets.length; i++) {
            var pet:PetData = pets[i];
            if (pet.position === 1) {
                _master = pet;
            } else if (pet.position === 2) {
                _slave = pet;
            }
        }
        if (!_master) {
            _master = pets[0];
        }
    }
}
}
