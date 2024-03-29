package com.taomee.seer2.app.gameRule.spt {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.ProgressiveAnimationPlayer;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.gameRule.spt.support.BaseSptSupport;
import com.taomee.seer2.app.gameRule.spt.support.SPTBufferStatus;
import com.taomee.seer2.app.gameRule.spt.support.SptBossInfoManager;
import com.taomee.seer2.app.gameRule.spt.support.SptConfigInfoManager;
import com.taomee.seer2.app.gameRule.spt.support.SptDialogConfig;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.sound.SoundManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class SptFeiYaSiSupport extends BaseSptSupport {

    private static var _instance:SptFeiYaSiSupport;


    private var _feiyasi_MC:MovieClip;

    private var _sptNPC_1:MovieClip;

    private var _sptNPC_2:MovieClip;

    public function SptFeiYaSiSupport() {
        super();
    }

    public static function getInstance():SptFeiYaSiSupport {
        if (!_instance) {
            _instance = new SptFeiYaSiSupport();
        }
        return _instance;
    }

    override public function init(param1:MapModel):void {
        _sptBossId = SPTBossID.FeiYaSi;
        _petMaxLevelLimit = SptConfigInfoManager.getSptBossLevel(_sptBossId);
        _sptBufferPosition = SPTBufferStatus.FEIYASI_POSITION;
        super.init(param1);
    }

    override protected function initSPTNPC():void {
        this._feiyasi_MC = _map.content["sptFYS"];
    }

    override public function dispose():void {
        super.dispose();
        this.removeSptNpc();
        this._feiyasi_MC = null;
    }

    private function removeSptNpc():void {
        if (Boolean(this._sptNPC_1) && this._sptNPC_1.hasEventListener(MouseEvent.CLICK)) {
            this._sptNPC_1.removeEventListener(MouseEvent.CLICK, this.onSPTClickHandler);
        }
        this._sptNPC_1 = null;
        if (Boolean(this._sptNPC_2) && this._sptNPC_2.hasEventListener(MouseEvent.CLICK)) {
            this._sptNPC_2.removeEventListener(MouseEvent.CLICK, this.onSPTDoubleHandler);
        }
        this._sptNPC_2 = null;
    }

    private function showNPCUnCondition():void {
        var onActionEnd:Function = null;
        onActionEnd = function (param1:Event):void {
            _feiyasi_MC.removeEventListener("actionEnd", onActionEnd);
            _sptNPC_1 = _feiyasi_MC["hotZone"];
            _sptNPC_1.buttonMode = true;
            _sptNPC_1.useHandCursor = true;
            _sptNPC_1.addEventListener(MouseEvent.CLICK, onSPTClickHandler);
        };
        this.removeSptNpc();
        this._feiyasi_MC.addEventListener("actionEnd", onActionEnd);
        this._feiyasi_MC.gotoAndPlay("action_1");
    }

    private function showNPCNeverWin():void {
        var onActionEnd:Function = null;
        onActionEnd = function (param1:Event):void {
            _feiyasi_MC.removeEventListener("actionEnd", onActionEnd);
            _sptNPC_1 = _feiyasi_MC["hotZone"];
            _sptNPC_1.buttonMode = true;
            _sptNPC_1.useHandCursor = true;
            _sptNPC_1.addEventListener(MouseEvent.CLICK, onSPTClickHandler);
        };
        this.removeSptNpc();
        this._feiyasi_MC.addEventListener("actionEnd", onActionEnd);
        this._feiyasi_MC.gotoAndPlay("action_2");
    }

    private function showNPCWin():void {
        var onActionEnd:Function = null;
        onActionEnd = function (param1:Event):void {
            _feiyasi_MC.removeEventListener("actionEnd", onActionEnd);
            _sptNPC_1 = _feiyasi_MC["hotZone_1"];
            _sptNPC_1.buttonMode = true;
            _sptNPC_1.useHandCursor = true;
            _sptNPC_1.addEventListener(MouseEvent.CLICK, onSPTClickHandler);
            _sptNPC_2 = _feiyasi_MC["hotZone_2"];
            _sptNPC_2.buttonMode = true;
            _sptNPC_2.useHandCursor = true;
            _sptNPC_2.addEventListener(MouseEvent.CLICK, onSPTDoubleHandler);
        };
        this.removeSptNpc();
        this._feiyasi_MC.addEventListener("actionEnd", onActionEnd);
        this._feiyasi_MC.gotoAndPlay("action_3");
    }

    override protected function dealWithMapInit():void {
        var mapInitCallBack:Function = null;
        mapInitCallBack = function (param1:LittleEndianByteArray):void {
            var _loc4_:uint = 0;
            var _loc2_:UserInfo = ActorManager.actorInfo;
            var _loc3_:uint = _loc2_.highestPetLevel;
            if (_loc3_ >= _petMaxLevelLimit) {
                _loc4_ = SptBossInfoManager.resolveSpt(_sptBossId, param1);
                if (_winHistory) {
                    if (_loc4_ >= SptBossInfoManager.CHALLENGE_RULE_1) {
                        showNPCWin();
                    } else {
                        showNPCNeverWin();
                    }
                } else {
                    showNPCNeverWin();
                }
            } else {
                showNPCUnCondition();
            }
        };
        checkSptBossInfo(mapInitCallBack);
    }

    override protected function fightFailure(param1:LittleEndianByteArray):void {
        var _loc3_:XML = null;
        var _loc4_:DialogDefinition = null;
        var _loc2_:uint = SptBossInfoManager.resolveSpt(_sptBossId, param1);
        if (_loc2_ < SptBossInfoManager.CATCH) {
            this.showNPCNeverWin();
            _loc3_ = new XML(SptDialogConfig.getSptDialog(_sptBossId, 3, [SptDialogConfig.getTalkContent(_sptBossId)]));
            _loc4_ = new DialogDefinition(_loc3_);
            DialogPanel.showForCommon(_loc4_);
        } else if (_loc2_ == SptBossInfoManager.CATCH) {
            this.showNPCNeverWin();
        } else if (_loc2_ >= SptBossInfoManager.CHALLENGE_RULE_1) {
            this.showNPCWin();
        }
    }

    override protected function fightWin():void {
        var onSwitchComplete:Function = null;
        var fullScreenAnimaitonEnd:Function = null;
        var fightWinCallBack:Function = null;
        onSwitchComplete = function (param1:Event):void {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchComplete);
            ServerBufferManager.updateServerBuffer(ServerBufferType.SPT, _sptBufferPosition, SPTBufferStatus.FIGHT_WIN);
            _animationPlayer = new ProgressiveAnimationPlayer(URLUtil.getQuestAnimation("spt/spt_feiyasi_fs"));
            _animationPlayer.addEventListener(ProgressiveAnimationPlayer.EVT_END, fullScreenAnimaitonEnd);
            LayerManager.topLayer.addChild(_animationPlayer);
            SoundManager.backgroundSoundEnabled = false;
        };
        fullScreenAnimaitonEnd = function (param1:Event):void {
            SoundManager.backgroundSoundEnabled = true;
            _animationPlayer.removeEventListener(ProgressiveAnimationPlayer.EVT_END, fullScreenAnimaitonEnd);
            DisplayObjectUtil.removeFromParent(_animationPlayer);
            _animationPlayer = null;
            showNPCNeverWin();
            var _loc2_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, 2));
            var _loc3_:DialogDefinition = new DialogDefinition(_loc2_);
            DialogPanel.showForCommon(_loc3_);
        };
        fightWinCallBack = function (param1:LittleEndianByteArray):void {
            var _loc2_:uint = SptBossInfoManager.resolveSpt(_sptBossId, param1);
            if (_loc2_ >= SptBossInfoManager.CHALLENGE_RULE_1) {
                showNPCWin();
            } else {
                showNPCNeverWin();
            }
        };
        if (!_winHistory) {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchComplete);
        } else {
            checkSptBossInfo(fightWinCallBack);
        }
    }

    override protected function onSPTClickHandler(param1:MouseEvent):void {
        var checkServerBufferHandler:Function = null;
        var checkSptBossInfoHandler:Function = null;
        var onClose_1:Function = null;
        var onClose_2:Function = null;
        var startFighter:Function = null;
        var event:MouseEvent = param1;
        checkServerBufferHandler = function (param1:ServerBuffer):void {
            var _loc2_:* = param1.readDataAtPostion(_sptBufferPosition - 1) == SPTBufferStatus.FIGHT_WIN;
            if (_loc2_) {
                _winHistory = param1.readDataAtPostion(_sptBufferPosition) == SPTBufferStatus.FIGHT_WIN;
                if (_winHistory) {
                    _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
                } else {
                    doWhenNeverWinBefore();
                }
            } else {
                checkSptBossInfo(checkSptBossInfoHandler);
            }
        };
        checkSptBossInfoHandler = function (param1:LittleEndianByteArray):void {
            var _loc2_:uint = SptBossInfoManager.resolveSpt(SPTBossID.KaniYa, param1);
            if (_loc2_ < SptBossInfoManager.WIN) {
                unConfigDialoge();
            } else {
                _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
            }
        };
        var doWhenNeverWinBefore:Function = function ():void {
            var _loc1_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, 4));
            var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
            DialogPanel.showForCommon(_loc2_, onClose_1);
        };
        onClose_1 = function (param1:String = ""):void {
            var _loc2_:XML = null;
            var _loc3_:DialogDefinition = null;
            if (param1 == "next") {
                _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId, 5));
                _loc3_ = new DialogDefinition(_loc2_);
                DialogPanel.showForCommon(_loc3_, onClose_2);
            }
        };
        onClose_2 = function (param1:String = ""):void {
            var _loc2_:XML = null;
            var _loc3_:DialogDefinition = null;
            if (param1 == "next") {
                _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId, 6));
                _loc3_ = new DialogDefinition(_loc2_);
                DialogPanel.showForCommon(_loc3_, startFighter);
            }
        };
        startFighter = function (param1:String = ""):void {
            if ("fight" == param1) {
                _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
            }
        };
        var actorInfo:UserInfo = ActorManager.actorInfo;
        var maxPetLevel:uint = actorInfo.highestPetLevel;
        if (maxPetLevel >= _petMaxLevelLimit) {
            ServerBufferManager.getServerBuffer(ServerBufferType.SPT, checkServerBufferHandler);
        } else {
            this.unConfigDialoge();
        }
    }

    private function unConfigDialoge():void {
        var _loc1_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, 1, [_petMaxLevelLimit]));
        var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
        DialogPanel.showForCommon(_loc2_);
    }

    private function onSPTDoubleHandler(param1:MouseEvent):void {
        _fighterID = FightManager.startFightBinarySPTBoss(_sptBossId);
    }
}
}
