package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.actor.preview.ActorPreview;
import com.taomee.seer2.app.actor.util.ActorEquipAssembler;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.arena.resource.ArenaResourceLoader;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.info.PVPInfo;
import com.taomee.seer2.app.inventory.item.EquipItem;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.quest.animation.QuestCompleteAnimation;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.sound.SoundManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.IDataInput;

import org.taomee.manager.EventManager;
import org.taomee.utils.DisplayUtil;

public class PetMeleeManager {

    private static var _pvpInfo:PVPInfo;

    private static var _mc:MovieClip;

    private static var _remoteInfo:UserInfo;

    private static var _thisPetList:Vector.<PetInfo>;

    private static var _remotePetList:Vector.<PetInfo>;

    private static var _thisPreview:ActorPreview;

    private static var _remotePreview:ActorPreview;

    private static var _thisIconList:Vector.<IconDisplayer>;

    private static var _remoteIconList:Vector.<IconDisplayer>;


    public function PetMeleeManager() {
        super();
    }

    public static function startPetMeleeFight(param1:PVPInfo = null):void {
        var pvpInfo:PVPInfo = param1;
        _pvpInfo = pvpInfo;
        if (_pvpInfo == null) {
            _pvpInfo = new PVPInfo();
            _pvpInfo.minPetNum = 3;
            _pvpInfo.maxPetNum = 3;
            _pvpInfo.gate = 9;
            _pvpInfo.mode = 204;
            _pvpInfo.type = 9;
        }
        _pvpInfo.isStartFight = false;
        _pvpInfo.isShowTag = false;
        PVPManager.requestPVP(_pvpInfo, function ():void {
            var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
            _loc1_.writeUnsignedInt(204);
            _loc1_.writeUnsignedInt(_pvpInfo.petList.length);
            var _loc2_:int = 0;
            while (_loc2_ < _pvpInfo.petList.length) {
                _loc1_.writeUnsignedInt(_pvpInfo.petList[_loc2_]);
                _loc2_++;
            }
            Connection.addCommandListener(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, on1251);
            Connection.send(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, _loc1_);
        });
    }

    public static function startPvPFight(param1:PVPInfo):void {
        var pvpInfo:PVPInfo = param1;
        _pvpInfo = pvpInfo;
        _pvpInfo.isStartFight = false;
        _pvpInfo.isShowTag = false;
        PVPManager.requestPVP(_pvpInfo, function ():void {
            var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
            _loc1_.writeUnsignedInt(_pvpInfo.mode);
            _loc1_.writeUnsignedInt(_pvpInfo.petList.length);
            var _loc2_:int = 0;
            while (_loc2_ < _pvpInfo.petList.length) {
                _loc1_.writeUnsignedInt(_pvpInfo.petList[_loc2_]);
                _loc2_++;
            }
            Connection.addCommandListener(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, on1251);
            Connection.send(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, _loc1_);
        });
    }

    private static function on1251(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.CLI_FIGHT_MON_SELECT_MON_1251, on1251);
        Connection.addCommandListener(CommandSet.DOOR_FIGHT_MATCH_END_1082, matchSuccess);
        ModuleManager.toggleModule(URLUtil.getAppModule("PVPMatePanel"), "打开面板中...", _pvpInfo);
    }

    private static function matchSuccess(param1:MessageEvent):void {
        var _loc6_:uint = 0;
        var _loc10_:uint = 0;
        var _loc11_:uint = 0;
        var _loc12_:uint = 0;
        var _loc13_:int = 0;
        var _loc14_:PetInfo = null;
        var _loc15_:EquipItem = null;
        var _loc16_:uint = 0;
        var _loc17_:int = 0;
        var _loc18_:uint = 0;
        var _loc19_:uint = 0;
        var _loc20_:uint = 0;
        var _loc21_:uint = 0;
        var _loc22_:int = 0;
        var _loc23_:uint = 0;
        var _loc24_:int = 0;
        Connection.removeCommandListener(CommandSet.DOOR_FIGHT_MATCH_END_1082, matchSuccess);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:Vector.<PetInfo> = Vector.<PetInfo>([]);
        var _loc5_:Vector.<PetInfo> = Vector.<PetInfo>([]);
        var _loc7_:UserInfo = new UserInfo();
        var _loc8_:UserInfo = new UserInfo();
        var _loc9_:int = 0;
        while (_loc9_ < _loc3_) {
            _loc10_ = uint(_loc2_.readUnsignedInt());
            _loc11_ = uint(_loc2_.readUnsignedInt());
            _loc12_ = uint(_loc2_.readUnsignedInt());
            if (_loc10_ != ActorManager.actorInfo.id) {
                _loc6_ = _loc10_;
            }
            _loc13_ = 0;
            while (_loc13_ < _loc12_) {
                _loc18_ = uint(_loc2_.readUnsignedInt());
                _loc19_ = uint(_loc2_.readUnsignedInt());
                _loc20_ = uint(_loc2_.readUnsignedInt());
                _loc13_++;
            }
            if (_loc10_ == ActorManager.actorInfo.id) {
                _loc7_.id = _loc2_.readUnsignedInt();
                _loc7_.sex = _loc2_.readUnsignedByte();
                _loc7_.nick = _loc2_.readUTFBytes(UserInfo.NICK_DATA_LEN);
                _loc7_.color = _loc2_.readUnsignedInt();
                _loc7_.trainerScore = _loc2_.readUnsignedInt();
                _loc7_.equipVec = new Vector.<EquipItem>();
                _loc21_ = uint(_loc2_.readUnsignedInt());
                _loc22_ = 0;
                while (_loc22_ < _loc21_) {
                    _loc15_ = new EquipItem(_loc2_.readUnsignedInt());
                    _loc7_.equipVec.push(_loc15_);
                    _loc22_++;
                }
            } else {
                _loc8_.id = _loc2_.readUnsignedInt();
                _loc8_.sex = _loc2_.readUnsignedByte();
                _loc8_.nick = _loc2_.readUTFBytes(UserInfo.NICK_DATA_LEN);
                _loc8_.color = _loc2_.readUnsignedInt();
                _loc8_.trainerScore = _loc2_.readUnsignedInt();
                _loc8_.equipVec = new Vector.<EquipItem>();
                _loc23_ = uint(_loc2_.readUnsignedInt());
                _loc24_ = 0;
                while (_loc24_ < _loc23_) {
                    _loc15_ = new EquipItem(_loc2_.readUnsignedInt());
                    _loc8_.equipVec.push(_loc15_);
                    _loc24_++;
                }
                ActorEquipAssembler.mergeDefaultEquip(_loc8_.color, _loc8_.equipVec);
            }
            _loc16_ = uint(_loc2_.readUnsignedInt());
            _loc17_ = 0;
            while (_loc17_ < _loc16_) {
                (_loc14_ = new PetInfo()).resourceId = _loc2_.readUnsignedInt();
                if (_loc10_ == ActorManager.actorInfo.id) {
                    _loc4_.push(_loc14_);
                } else {
                    _loc5_.push(_loc14_);
                }
                _loc17_++;
            }
            _loc9_++;
        }
        _remoteInfo = _loc8_;
        _thisPetList = _loc4_;
        _remotePetList = _loc5_;
        if (_thisPetList.length > 1) {
            FightManager.addEventListener(FightStartEvent.FIGHT_LOADING_START, onFightLoadStart);
        }
        startFight();
    }

    private static function onFightLoadStart(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.FIGHT_LOADING_START, onFightLoadStart);
        ArenaResourceLoader.hideLoadingBar();
        entryFight();
    }

    private static function entryFight():void {
        var iconDisplayer:IconDisplayer = null;
        var petInfo:PetInfo = null;
        _thisIconList = Vector.<IconDisplayer>([]);
        _remoteIconList = Vector.<IconDisplayer>([]);
        for each(petInfo in _thisPetList) {
            iconDisplayer = new IconDisplayer();
            iconDisplayer.setIconUrl(URLUtil.getPetIcon(petInfo.resourceId));
            iconDisplayer.scaleX = iconDisplayer.scaleY = 2;
            _thisIconList.push(iconDisplayer);
        }
        for each(petInfo in _remotePetList) {
            iconDisplayer = new IconDisplayer();
            iconDisplayer.setIconUrl(URLUtil.getPetIcon(petInfo.resourceId));
            iconDisplayer.scaleX = iconDisplayer.scaleY = 2;
            _remoteIconList.push(iconDisplayer);
        }
        LayerManager.focusOnTopLayer();
        MovieClipUtil.getSwfContent(URLUtil.getActivityFullScreen("PetMelee"), function (param1:MovieClip):void {
            SoundManager.enabled = false;
            _mc = param1["mcc"];
            LayerManager.topLayer.addChild(_mc);
            _thisPreview = new ActorPreview();
            _thisPreview.scaleX = -1;
            _remotePreview = new ActorPreview();
            _thisPreview.setData(ActorManager.actorInfo);
            _remotePreview.setData(_remoteInfo);
            Connection.addCommandListener(CommandSet.FIGHT_GET_REVENUE_5, onFightGetRevenue);
            Connection.addCommandListener(CommandSet.FIGHT_TURN_START_2, onFightLoadEnd);
            _mc.gotoAndPlay(2);
            _mc.addEventListener(Event.ENTER_FRAME, onFullScreenEnter);
        });
    }

    private static function onFightGetRevenue(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.FIGHT_GET_REVENUE_5, onFightGetRevenue);
        Connection.removeCommandListener(CommandSet.FIGHT_TURN_START_2, onFightLoadEnd);
        clearMC();
    }

    private static function onFightLoadEnd(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.FIGHT_GET_REVENUE_5, onFightGetRevenue);
        Connection.removeCommandListener(CommandSet.FIGHT_TURN_START_2, onFightLoadEnd);
        clearMC();
    }

    private static function clearMC():void {
        var _loc1_:IconDisplayer = null;
        if (_mc) {
            _mc.stop();
            _mc.removeEventListener(Event.ENTER_FRAME, onFullScreenEnter);
            DisplayUtil.removeForParent(_thisPreview);
            DisplayUtil.removeForParent(_remotePreview);
            for each(_loc1_ in _thisIconList) {
                DisplayUtil.removeForParent(_loc1_);
            }
            for each(_loc1_ in _remoteIconList) {
                DisplayUtil.removeForParent(_loc1_);
            }
            DisplayUtil.removeForParent(_mc);
            LayerManager.resetOperation();
            LayerManager.showMap();
            SoundManager.enabled = true;
        }
    }

    private static function onFullScreenEnter(param1:Event):void {
        var _loc2_:int = 0;
        if (_mc.currentFrame == 13) {
            LayerManager.hideMap();
            _thisPreview.x = 160;
            _thisPreview.y = 320;
            LayerManager.topLayer.addChild(_thisPreview);
            _remotePreview.x = 1000;
            _remotePreview.y = 570;
            LayerManager.topLayer.addChild(_remotePreview);
        }
        if (_mc.currentFrame == 80) {
            DisplayUtil.removeForParent(_thisPreview);
            DisplayUtil.removeForParent(_remotePreview);
        }
        if (_mc.currentFrame == 154) {
            _loc2_ = 0;
            while (_loc2_ < _thisIconList.length) {
                _thisIconList[_loc2_].x = 17 + _loc2_ * 148;
                _thisIconList[_loc2_].y = 107;
                LayerManager.topLayer.addChild(_thisIconList[_loc2_]);
                _remoteIconList[_loc2_].x = 790 + _loc2_ * 148;
                _remoteIconList[_loc2_].y = 478;
                LayerManager.topLayer.addChild(_remoteIconList[_loc2_]);
                _loc2_++;
            }
        }
        if (_mc.currentFrame == _mc.totalFrames) {
            _mc.stop();
            _mc.removeEventListener(Event.ENTER_FRAME, onFullScreenEnter);
        }
    }

    private static function startFight():void {
        var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc1_.writeUnsignedInt(_pvpInfo.type);
        var _loc2_:Array = new Array();
        var _loc3_:uint = _pvpInfo.petList.length;
        _loc1_.writeUnsignedInt(_loc3_);
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            _loc2_.push(_pvpInfo.petList[_loc4_]);
            _loc1_.writeUnsignedInt(_pvpInfo.petList[_loc4_]);
            _loc4_++;
        }
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchComplete);
        FightManager.startFightPVP(_loc1_);
    }

    private static function onSwitchComplete(param1:SceneEvent):void {
        var event:SceneEvent = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchComplete);
            ServerBufferManager.getServerBuffer(100014, function (param1:ServerBuffer):void {
                var _loc4_:Object = null;
                var _loc5_:QuestCompleteAnimation = null;
                param1.printDataInfo();
                var _loc2_:int = 6;
                var _loc3_:int = 0;
                while (_loc3_ < 6) {
                    (_loc4_ = new Object())["task_id"] = param1.readDataAtPostion(_loc2_);
                    _loc4_["step_id"] = param1.readDataAtPostion(++_loc2_);
                    _loc4_["task_status"] = param1.readDataAtPostion(++_loc2_);
                    _loc2_++;
                    if (_loc4_["task_id"] == 12) {
                        if (_loc4_["task_status"] == 0) {
                            (_loc5_ = new QuestCompleteAnimation(1)).play();
                            ServerBufferManager.updataSvrExpandBuffer(100014, 12, 0);
                        }
                        EventManager.dispatchEvent(new Event("DiamondTaskEvent"));
                    }
                    _loc3_++;
                }
            }, false);
            if (_pvpInfo.mode == 205) {
                ModuleManager.showAppModule("HeroPkOnePkIntroducePanel");
                return;
            }
            if (FightManager.isWinWar()) {
                DayLimitManager.getDoCount(960, function (param1:uint):void {
                    if (param1 >= 1) {
                        ModuleManager.showModule(URLUtil.getAppModule("PetSelectFightPanel"), "正在打开pve选择精灵出战面板...", {
                            "mode": 21,
                            "posIndex": 794,
                            "min": 3,
                            "max": 3
                        });
                    }
                });
            }
        }
    }
}
}
