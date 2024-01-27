package com.taomee.seer2.app.popup.alert {
import com.greensock.TweenNano;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.arena.util.FightMode;
import com.taomee.seer2.app.common.ResourceLibraryLoader;
import com.taomee.seer2.app.event.LogicEvent;
import com.taomee.seer2.app.gameRule.behavior.InvitePetSelectBehavior;
import com.taomee.seer2.app.gameRule.behavior.SOMultiBehavior;
import com.taomee.seer2.app.gameRule.data.FighterSelectPanelVO;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.helper.UserInfoParseHelper;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.ModelLocator;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.ByteArray;
import flash.utils.IDataInput;

import org.taomee.filter.ColorFilter;

public class InviteFightAlert extends Sprite implements IAlert {


    private var _ui:MovieClip;

    private var _closeButton:SimpleButton;

    private var _fightButtons:Vector.<ButtonInfo>;

    private var _inviteUserId:uint;

    private var _inviteUser:UserInfo;

    private var _requestFlag:Boolean = false;

    private var _alertInfo:AlertInfo;

    private var _resLoader:ResourceLibraryLoader;

    public function InviteFightAlert() {
        super();
        ModelLocator.getInstance().addEventListener(LogicEvent.GOD_FIRE_PK_SELECT, this.onSelectEvent);
        ModelLocator.getInstance().addEventListener(LogicEvent.BEST_CATCH_PK_SELECT, this.onSelectEvent1);
        this._resLoader = new ResourceLibraryLoader(URLUtil.getRes("publicRes/inviteFight" + URLUtil.POSTFIX_SWF));
        this._resLoader.getLib(this.onGetLib);
    }

    private function onGetLib(param1:ResourceLibrary):void {
        var _loc4_:SimpleButton = null;
        var _loc5_:int = 0;
        var _loc6_:SimpleButton = null;
        var _loc7_:int = 0;
        this._ui = param1.getMovieClip("UI_InviteSkin");
        addChild(this._ui);
        this._ui.x -= this._ui.width / 2;
        this._ui.y -= this._ui.height / 2;
        this._closeButton = this._ui["closeBtn"];
        this._closeButton.addEventListener(MouseEvent.CLICK, this.onCloseHandler);
        this._fightButtons = new Vector.<ButtonInfo>();
        this._fightButtons.push(new ButtonInfo(this._ui["fBtn_0"], FightMode.FIGHT_PVP_INVITE_1V1, 1));
        this._fightButtons.push(new ButtonInfo(this._ui["fBtn_1"], FightMode.FIGHT_PVP_INVITE_NVN, 1));
        this._fightButtons.push(new ButtonInfo(this._ui["fBtn_2"], FightMode.FIGHT_PVP_INVITE_2V2, 2));
        if (SceneManager.active.mapID == 1111) {
            _loc5_ = 1;
            while (_loc5_ < 3) {
                if (_loc4_ = this._fightButtons[_loc5_].button) {
                    ColorFilter.setGrayscale(_loc4_);
                    _loc4_.mouseEnabled = false;
                }
                _loc5_++;
            }
        } else {
            _loc7_ = 0;
            while (_loc7_ < 3) {
                if (_loc6_ = this._fightButtons[_loc7_].button) {
                    _loc6_.filters = [];
                    _loc6_.mouseEnabled = true;
                }
                _loc7_++;
            }
        }
        var _loc2_:uint = this._fightButtons.length;
        if (SceneManager.active.mapID == 15001) {
            this._requestFlag = true;
            this.requestFightInvite(1, FightMode.FIGHT_PVP_INVITE_NVN);
            return;
        }
        var _loc3_:uint = 0;
        while (_loc3_ < _loc2_) {
            this._fightButtons[_loc3_].button.addEventListener(MouseEvent.CLICK, this.onInviteHandler);
            _loc3_++;
        }
    }

    private function onSelectEvent(param1:LogicEvent):void {
        var evt:LogicEvent = param1;
        ModelLocator.getInstance().removeEventListener(LogicEvent.GOD_FIRE_PK_SELECT, this.onSelectEvent);
        this.visible = false;
        if (this._fightButtons == null) {
            TweenNano.delayedCall(2, function ():void {
                requestFightInvite(_fightButtons[int(evt.obj)].fightType, _fightButtons[int(evt.obj)].fightMode);
            });
        } else {
            this.requestFightInvite(this._fightButtons[int(evt.obj)].fightType, this._fightButtons[int(evt.obj)].fightMode);
        }
    }

    private function onSelectEvent1(param1:LogicEvent):void {
        var evt:LogicEvent = param1;
        ModelLocator.getInstance().removeEventListener(LogicEvent.BEST_CATCH_PK_SELECT, this.onSelectEvent1);
        this.visible = false;
        if (this._fightButtons == null) {
            TweenNano.delayedCall(2, function ():void {
                if (Boolean(_fightButtons) && Boolean(_fightButtons[int(evt.obj)])) {
                    requestFightInvite(_fightButtons[int(evt.obj)].fightType, _fightButtons[int(evt.obj)].fightMode);
                }
            });
        } else {
            this.requestFightInvite(this._fightButtons[int(evt.obj)].fightType, this._fightButtons[int(evt.obj)].fightMode);
        }
    }

    private function onInviteHandler(param1:MouseEvent):void {
        var _loc2_:SimpleButton = null;
        var _loc3_:uint = 0;
        var _loc4_:uint = 0;
        if (this._requestFlag == false) {
            this._requestFlag = true;
            _loc2_ = param1.currentTarget as SimpleButton;
            _loc3_ = this._fightButtons.length;
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                if (this._fightButtons[_loc4_].button == _loc2_) {
                    this.requestFightInvite(this._fightButtons[_loc4_].fightType, this._fightButtons[_loc4_].fightMode);
                    break;
                }
                _loc4_++;
            }
        }
    }

    private function requestFightInvite(param1:uint, param2:uint):void {
        var _loc3_:uint = this._inviteUser.id;
        var _loc4_:FighterSelectPanelVO;
        (_loc4_ = new FighterSelectPanelVO()).defaultPets = this.getDefaultPets(param2, PetInfoManager.getAllBagPetInfo());
        _loc4_.pets = PetInfoManager.getAllBagPetInfo();
        if (param2 == FightMode.FIGHT_PVP_INVITE_1V1) {
            _loc4_.minSelectedPetCount = 1;
            _loc4_.maxSelectedPetCount = 1;
        } else if (param2 == FightMode.FIGHT_PVP_INVITE_NVN) {
            _loc4_.minSelectedPetCount = 1;
            _loc4_.maxSelectedPetCount = 6;
            _loc4_.selectable = false;
        } else if (param2 == FightMode.FIGHT_PVP_INVITE_2V2) {
            _loc4_.minSelectedPetCount = 2;
            _loc4_.maxSelectedPetCount = 2;
            if (_loc4_.pets.length < 2) {
                AlertManager.showAlert("您背包中的精灵少于2只！");
                return;
            }
        }
        _loc4_.actorName = ActorManager.actorInfo.nick;
        _loc4_.callBackBehavior = new InvitePetSelectBehavior(this._inviteUser, param2, param1);
        ModuleManager.showModule(URLUtil.getAppModule("FighterSelectPanel"), "正在打开选择对战精灵面板...", _loc4_);
        this.dispose();
    }

    private function getDefaultPets(param1:uint, param2:Vector.<PetInfo>):Vector.<PetInfo> {
        var _loc6_:uint = 0;
        var _loc7_:Array = null;
        var _loc8_:uint = 0;
        var _loc9_:uint = 0;
        var _loc10_:uint = 0;
        var _loc3_:Vector.<PetInfo> = new Vector.<PetInfo>();
        var _loc4_:String = SOMultiBehavior.getKey(param1);
        var _loc5_:Array = SOMultiBehavior.readDefaultPets(_loc4_);
        if (param1 == FightMode.FIGHT_PVP_INVITE_NVN) {
            _loc3_ = PetInfoManager.getAllBagPetInfo();
        } else {
            if (_loc5_ != null) {
                _loc9_ = param2.length;
                while (_loc10_ < _loc9_) {
                    if (_loc5_.indexOf(param2[_loc10_].catchTime) != -1) {
                        _loc3_.push(param2[_loc10_]);
                    }
                    _loc10_++;
                }
            }
            if (_loc3_.length == 0) {
                if (param1 == FightMode.FIGHT_PVP_INVITE_1V1) {
                    _loc3_ = Vector.<PetInfo>([PetInfoManager.getFirstPetInfo()]);
                } else if (param1 == FightMode.FIGHT_PVP_INVITE_2V2) {
                    _loc3_ = PetInfoManager.getRandomFightPetInfo(2);
                }
            }
            _loc6_ = _loc3_.length;
            _loc7_ = new Array();
            _loc8_ = 0;
            while (_loc8_ < _loc6_) {
                _loc7_.push(_loc3_[_loc8_].catchTime);
                _loc8_++;
            }
            SOMultiBehavior.writeDefaultPets(_loc4_, _loc7_);
        }
        return _loc3_;
    }

    private function onCloseHandler(param1:MouseEvent):void {
        this.dispose();
        param1.stopImmediatePropagation();
    }

    public function show(param1:AlertInfo):void {
        this._alertInfo = param1;
        this._inviteUserId = param1.initInfo.userId;
        this.requestUserInfo(this._inviteUserId);
    }

    private function requestUserInfo(param1:uint):void {
        Connection.addCommandListener(CommandSet.USER_GET_DETAIL_INFO_1010, this.onGetDetailInfo);
        Connection.send(CommandSet.USER_GET_DETAIL_INFO_1010, param1);
    }

    private function onGetDetailInfo(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        if (_loc3_ == this._inviteUserId) {
            Connection.removeCommandListener(CommandSet.USER_GET_DETAIL_INFO_1010, this.onGetDetailInfo);
            ByteArray(_loc2_).position = 0;
            this._inviteUser = new UserInfo();
            UserInfoParseHelper.parseUserDetailInfo(this._inviteUser, _loc2_);
            AlertManager.addPopUp(this._alertInfo, this);
        }
    }

    public function dispose():void {
        this._resLoader.dispose();
        this._inviteUser = null;
        this._closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseHandler);
        this._closeButton = null;
        var _loc1_:uint = this._fightButtons.length;
        var _loc2_:uint = 0;
        while (_loc2_ < _loc1_) {
            this._fightButtons[_loc2_].button.removeEventListener(MouseEvent.CLICK, this.onInviteHandler);
            _loc2_++;
        }
        this._fightButtons = null;
        this._ui = null;
        AlertManager.removePopUp(this);
        LayerManager.resetOperation();
        this.dispatchEvent(new Event(Event.CLOSE));
    }
}
}

import flash.display.SimpleButton;

class ButtonInfo {


    public var button:SimpleButton;

    public var fightMode:uint;

    public var fightType:uint;

    public function ButtonInfo(param1:SimpleButton, param2:uint, param3:uint) {
        this.button = param1;
        this.fightMode = param2;
        this.fightType = param3;
        super();
    }
}
