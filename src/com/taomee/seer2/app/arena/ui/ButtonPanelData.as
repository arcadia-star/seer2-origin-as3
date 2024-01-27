package com.taomee.seer2.app.arena.ui {
public class ButtonPanelData {


    public var fightEnabled:Boolean = true;

    public var catchEnabled:Boolean = true;

    public var itemEnabled:Boolean = true;

    public var petEnabled:Boolean = true;

    public var escapeEnabled:Boolean = true;

    public function ButtonPanelData() {
        super();
    }

    public function setDeadFightConfig():void {
        this.fightEnabled = false;
        this.petEnabled = false;
        this.catchEnabled = false;
        this.itemEnabled = false;
    }

    public function merge(param1:ButtonPanelData):void {
        this.fightEnabled = this.fightEnabled && param1.fightEnabled;
        this.catchEnabled = this.catchEnabled && param1.catchEnabled;
        this.itemEnabled = this.itemEnabled && param1.itemEnabled;
        this.petEnabled = this.petEnabled && param1.petEnabled;
        this.escapeEnabled = this.escapeEnabled && param1.escapeEnabled;
    }

    public function printData():void {
    }
}
}
