package com.taomee.seer2.app.gameRule.data {
import com.taomee.seer2.app.gameRule.behavior.InvitePetSelectBehavior;
import com.taomee.seer2.app.pet.data.PetInfo;

public class FighterSelectPanelVO {


    public var minSelectedPetCount:uint = 1;

    public var maxSelectedPetCount:uint = 1;

    public var actorName:String = "";

    public var selectable:Boolean = true;

    public var timeDown:uint = 0;

    public var pets:Vector.<PetInfo>;

    public var defaultPets:Vector.<PetInfo>;

    private var _onCancel:Function;

    public var onSelectCheck:Function;

    private var _onComplete:Function;

    public var isShowSelected:Boolean = true;

    private var _callBackBehavior:InvitePetSelectBehavior;

    public function FighterSelectPanelVO() {
        super();
    }

    public function set callBackBehavior(param1:InvitePetSelectBehavior):void {
        this._callBackBehavior = param1;
        this._onComplete = this._callBackBehavior.onInviteFighter;
        this._onCancel = this._callBackBehavior.onInviteCancel;
    }

    public function get onComplete():Function {
        return this._onComplete;
    }

    public function get onCancel():Function {
        return this._onCancel;
    }

    public function set onCancel(param1:Function):void {
        this._onCancel = param1;
    }

    public function set onComplete(param1:Function):void {
        this._onComplete = param1;
    }
}
}
