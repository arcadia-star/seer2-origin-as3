package seer2.next.fight.ui.event {
public class OperateData {
    public var skill:uint;
    public var pet:uint;
    public var item:uint;
    public var capsule:uint;
    public var escape:uint;

    public function toObject():* {
        return {
            skill: this.skill,
            pet: this.pet,
            item: this.item,
            capsule: this.capsule,
            escape: this.escape
        }
    }
}
}
