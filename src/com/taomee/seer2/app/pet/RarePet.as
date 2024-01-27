package com.taomee.seer2.app.pet {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.URLUtil;

public class RarePet extends SpawnedPet {


    public var time:int;

    public var type:int;

    public var resourceId:int;

    public var positionIndex:int;

    public function RarePet(param1:int, param2:int, param3:int, param4:int, param5:int) {
        if (param5 == 0) {
            param2 = 11001;
        }
        this.time = param4;
        this.type = param5;
        this.resourceId = param1;
        this.positionIndex = param2;
        super(param1, param2, param3);
    }

    override protected function setResource():void {
        this.buttonMode = true;
        this.mouseChildren = false;
        if (this.type == 1) {
            this.resourceUrl = URLUtil.getPetSwf(uint("10000" + _petInfo.resourceId));
        } else {
            this.resourceUrl = URLUtil.getPetSwf(_petInfo.resourceId);
        }
    }

    override protected function addShadow():void {
        if (this.type == 0) {
            _shadow = UIManager.getSprite("UI_RarePetShadow");
            addChildAt(_shadow, 0);
        } else if (this.type == 1) {
            _shadow = UIManager.getMovieClip("UI_MiniBossShadow");
            addChild(_shadow);
        }
    }

    override protected function showAnimation():void {
        super.showAnimation();
    }

    override protected function startFight():void {
        FightManager.startFightWithMiniBoss(this.positionIndex);
    }

    override protected function showLabel():void {
        setLabelStyle(16711782, 16777215);
        if (this.type == 0) {
            this.label = "【★】 " + "Lv" + _petInfo.level + " " + PetConfig.getPetDefinition(this.resourceId).name;
        } else if (this.type == 1) {
            this.label = "" + "Lv" + _petInfo.level + " " + PetConfig.getPetDefinition(this.resourceId).name;
        }
    }
}
}
