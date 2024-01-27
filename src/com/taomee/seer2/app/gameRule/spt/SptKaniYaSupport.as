package com.taomee.seer2.app.gameRule.spt {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.component.ProgressiveAnimationPlayer;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.gameRule.spt.support.PillarInfo;
import com.taomee.seer2.app.gameRule.spt.support.SPTBufferStatus;
import com.taomee.seer2.app.gameRule.spt.support.SptBossInfoManager;
import com.taomee.seer2.app.gameRule.spt.support.SptConfigInfoManager;
import com.taomee.seer2.app.gameRule.spt.support.SptDialogConfig;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.sound.SoundManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class SptKaniYaSupport {

    public static const WUGONG:uint = 0;

    public static const WUFANG:uint = 1;

    public static const TEGONG:uint = 2;

    public static const TEFANG:uint = 3;

    public static const SHUDU:uint = 4;

    private static var _fighterID:Number = -1;


    private var _properties:Array;

    private var _map:MapModel;

    private var _winHistory:Boolean;

    private var _sptBufferPosition:int;

    private var _sptBossId:uint = 0;

    private var _petMaxLevelLimit:uint = 0;

    private var _kaniya_MC:MovieClip;

    private var _pillarInfos:Vector.<PillarInfo>;

    private var _animationPlayer:ProgressiveAnimationPlayer;

    public function SptKaniYaSupport() {
        this._properties = new Array();
        super();
    }

    public function init(param1:MapModel):void {
        this._map = param1;
        this._sptBufferPosition = SPTBufferStatus.KANIYA_POSITION;
        this._sptBossId = SPTBossID.KaniYa;
        this._petMaxLevelLimit = SptConfigInfoManager.getSptBossLevel(this._sptBossId);
        ServerBufferManager.getServerBuffer(ServerBufferType.SPT, this.onServerBufferDataHandler);
    }

    public function dispose():void {
        this._map = null;
        ShootController.removeEventListener(ShootEvent.PLAY_END, this.onShoot);
        if (this._pillarInfos != null) {
            this._pillarInfos.splice(0, this._pillarInfos.length);
        }
        if (this._properties != null) {
            this._properties.splice(0, this._properties.length);
        }
        this._properties = null;
        this._pillarInfos = null;
        this.removeSptClickListener();
        this._kaniya_MC = null;
    }

    private function initUI():void {
        this._kaniya_MC = this._map.content["kaniyaya"]["kaniyaMC"];
        this._kaniya_MC.buttonMode = true;
        this._kaniya_MC.useHandCursor = true;
        this._pillarInfos = new Vector.<PillarInfo>();
        var _loc1_:MovieClip = this._map.content["kaniyaya"];
        this._pillarInfos.push(new PillarInfo(WUGONG, _loc1_["pillar_mc1"], _loc1_["pillar_eff_mc1"]));
        this._pillarInfos.push(new PillarInfo(WUFANG, _loc1_["pillar_mc2"], _loc1_["pillar_eff_mc2"]));
        this._pillarInfos.push(new PillarInfo(TEGONG, _loc1_["pillar_mc3"], _loc1_["pillar_eff_mc3"]));
        this._pillarInfos.push(new PillarInfo(TEFANG, _loc1_["pillar_mc4"], _loc1_["pillar_eff_mc4"]));
        this._pillarInfos.push(new PillarInfo(SHUDU, _loc1_["pillar_mc5"], _loc1_["pillar_eff_mc5"]));
        ShootController.addEventListener(ShootEvent.PLAY_END, this.onShoot);
        this.addSptClickListener();
    }

    private function onShoot(param1:ShootEvent):void {
        var onCloseDialog:Function = null;
        var shoot:Boolean = false;
        var pillarInfo:PillarInfo = null;
        var info:PillarInfo = null;
        var data:XML = null;
        var dialogDefinition:DialogDefinition = null;
        var evt:ShootEvent = param1;
        onCloseDialog = function (param1:String = ""):void {
            if (param1 == "next") {
                onSPTClick(null);
            }
        };
        var shootInfo:ShootInfo = evt.info;
        var actorInfo:UserInfo = ActorManager.actorInfo;
        if (shootInfo.id == 3 && shootInfo.userID == actorInfo.id) {
            shoot = false;
            for each(info in this._pillarInfos) {
                shoot = info.pillarMC.hitTestPoint(evt.info.endPos.x, evt.info.endPos.y, true);
                if (shoot) {
                    pillarInfo = info;
                    break;
                }
            }
            if (pillarInfo != null) {
                if (this._properties.length >= 3) {
                    data = new XML(SptDialogConfig.getSptDialog(this._sptBossId, 1));
                    dialogDefinition = new DialogDefinition(data);
                    DialogPanel.showForCommon(dialogDefinition, onCloseDialog);
                } else {
                    ++pillarInfo.count;
                    if (pillarInfo.count >= 1) {
                        this._properties.push(pillarInfo.type);
                        pillarInfo.effectMC.gotoAndPlay("status2");
                    } else {
                        pillarInfo.effectMC.gotoAndPlay("status1");
                    }
                }
            }
        }
    }

    private function playSceneAnimiation():void {
        var mc:MovieClip = null;
        var onEndSceneAnimiation:Function = null;
        var onEnterFrame:Function = null;
        onEndSceneAnimiation = function (param1:Event):void {
            mc.removeEventListener("end", onEndSceneAnimiation);
            mc.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            mc.gotoAndStop("mcContent");
        };
        onEnterFrame = function (param1:Event):void {
            mc.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            initUI();
        };
        if (!this._map) {
            return;
        }
        mc = this._map.content["kaniyaya"];
        mc.addEventListener("end", onEndSceneAnimiation);
        mc.gotoAndPlay(1);
    }

    private function playFullSceneAnimiation():void {
        this._animationPlayer = new ProgressiveAnimationPlayer(URLUtil.getQuestAnimation("spt/win_kaniya_movie"));
        this._animationPlayer.addEventListener(ProgressiveAnimationPlayer.EVT_END, this.onAnimationEnd);
        SoundManager.enabled = false;
        LayerManager.topLayer.addChild(this._animationPlayer);
    }

    private function onAnimationEnd(param1:Event):void {
        var data:XML;
        var dialogDefinition:DialogDefinition;
        var onCloseDialog:Function = null;
        var evt:Event = param1;
        onCloseDialog = function (param1:String = ""):void {
            var _loc2_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, 3));
            var _loc3_:DialogDefinition = new DialogDefinition(_loc2_);
            DialogPanel.showForCommon(_loc3_);
        };
        SoundManager.enabled = true;
        this._animationPlayer.removeEventListener(ProgressiveAnimationPlayer.EVT_END, this.onAnimationEnd);
        DisplayObjectUtil.removeFromParent(this._animationPlayer);
        this._animationPlayer = null;
        data = new XML(SptDialogConfig.getSptDialog(this._sptBossId, 2));
        dialogDefinition = new DialogDefinition(data);
        DialogPanel.showForCommon(dialogDefinition, onCloseDialog);
        this.playSceneAnimiation();
    }

    private function addSptClickListener():void {
        this._kaniya_MC.addEventListener(MouseEvent.CLICK, this.onSPTClick);
    }

    private function removeSptClickListener():void {
        if (Boolean(this._kaniya_MC) && this._kaniya_MC.hasEventListener(MouseEvent.CLICK)) {
            this._kaniya_MC.removeEventListener(MouseEvent.CLICK, this.onSPTClick);
        }
    }

    private function onServerBufferDataHandler(param1:ServerBuffer):void {
        var _loc2_:uint = 0;
        param1.printDataInfo();
        this._winHistory = param1.readDataAtPostion(this._sptBufferPosition) == SPTBufferStatus.FIGHT_WIN;
        if (SceneManager.prevSceneType != SceneType.ARENA) {
            this.dealWithMapInit();
        } else if (_fighterID == FightManager.currentFightRecord.fightUniqueID) {
            _loc2_ = FightManager.fightWinnerSide;
            if (_loc2_ == FightSide.RIGHT) {
                SptBossInfoManager.getSptBossInfo(this.fightFailure);
            } else if (_loc2_ == FightSide.LEFT) {
                this.fightWin();
            }
        } else {
            this.dealWithMapInit();
        }
    }

    private function fightWin():void {
        if (!this._winHistory) {
            ServerBufferManager.updateServerBuffer(ServerBufferType.SPT, this._sptBufferPosition, SPTBufferStatus.FIGHT_WIN);
            this.playFullSceneAnimiation();
        } else {
            this.playSceneAnimiation();
        }
    }

    private function fightFailure(param1:LittleEndianByteArray):void {
        var _loc3_:XML = null;
        var _loc4_:DialogDefinition = null;
        var _loc2_:uint = SptBossInfoManager.resolveSpt(this._sptBossId, param1);
        if (_loc2_ < SptBossInfoManager.CATCH) {
            _loc3_ = new XML(SptDialogConfig.getSptDialog(this._sptBossId, 4, [SptDialogConfig.getTalkContent(this._sptBossId)]));
            _loc4_ = new DialogDefinition(_loc3_);
            DialogPanel.showForCommon(_loc4_);
        }
        this.playSceneAnimiation();
    }

    private function dealWithMapInit():void {
        this.playSceneAnimiation();
    }

    private function onSPTClick(param1:MouseEvent):void {
        var checkServerBufferHandler:Function = null;
        var onSptBossInfo:Function = null;
        var onClose1:Function = null;
        var onClose2:Function = null;
        var onClose3:Function = null;
        var onClose4:Function = null;
        var onClose5:Function = null;
        var event:MouseEvent = param1;
        checkServerBufferHandler = function (param1:ServerBuffer):void {
            var _loc2_:* = param1.readDataAtPostion(_sptBufferPosition - 1) == SPTBufferStatus.FIGHT_WIN;
            if (_loc2_) {
                if (_winHistory) {
                    startFight();
                } else {
                    winNeverTalk();
                }
            } else {
                SptBossInfoManager.getSptBossInfo(onSptBossInfo);
            }
        };
        onSptBossInfo = function (param1:LittleEndianByteArray):void {
            var _loc2_:uint = SptBossInfoManager.resolveSpt(82, param1);
            if (_loc2_ < SptBossInfoManager.WIN) {
                unConditionTalk();
            } else if (_winHistory) {
                startFight();
            } else {
                winNeverTalk();
            }
        };
        var unConditionTalk:Function = function ():void {
            var _loc1_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, 5, [_petMaxLevelLimit]));
            var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
            DialogPanel.showForCommon(_loc2_);
        };
        var winNeverTalk:Function = function ():void {
            var _loc1_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, 6));
            var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
            DialogPanel.showForCommon(_loc2_, onClose1);
        };
        onClose1 = function (param1:String = ""):void {
            var _loc2_:XML = null;
            var _loc3_:DialogDefinition = null;
            if (param1 == "next") {
                _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId, 7));
                _loc3_ = new DialogDefinition(_loc2_);
                DialogPanel.showForCommon(_loc3_, onClose2);
            }
        };
        onClose2 = function (param1:String = ""):void {
            var _loc2_:XML = null;
            var _loc3_:DialogDefinition = null;
            if (param1 == "next") {
                _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId, 8));
                _loc3_ = new DialogDefinition(_loc2_);
                DialogPanel.showForCommon(_loc3_, onClose3);
            }
        };
        onClose3 = function (param1:String = ""):void {
            var _loc2_:XML = null;
            var _loc3_:DialogDefinition = null;
            if (param1 == "next") {
                _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId, 9));
                _loc3_ = new DialogDefinition(_loc2_);
                DialogPanel.showForCommon(_loc3_, onClose4);
            } else if (param1 == "fight") {
                beforStartFight();
            }
        };
        onClose4 = function (param1:String = ""):void {
            if (param1 != "shoot") {
                if (param1 == "fight") {
                    beforStartFight();
                }
            }
        };
        var beforStartFight:Function = function ():void {
            var _loc1_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, 10));
            var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
            DialogPanel.showForCommon(_loc2_, onClose5);
        };
        onClose5 = function (param1:String = ""):void {
            if (param1 == "fight") {
                startFight();
            }
        };
        var actorInfo:UserInfo = ActorManager.actorInfo;
        var maxPetLevel:uint = actorInfo.highestPetLevel;
        if (maxPetLevel >= this._petMaxLevelLimit) {
            ServerBufferManager.getServerBuffer(ServerBufferType.SPT, checkServerBufferHandler);
        } else {
            unConditionTalk();
        }
    }

    private function startFight():void {
        var _loc1_:Array = new Array();
        var _loc2_:uint = 0;
        while (_loc2_ < 5) {
            if (this._properties.indexOf(_loc2_) == -1) {
                _loc1_.push(_loc2_);
            }
            _loc2_++;
        }
        _fighterID = FightManager.startFightWithSPTBoss(this._sptBossId, _loc1_);
    }
}
}
