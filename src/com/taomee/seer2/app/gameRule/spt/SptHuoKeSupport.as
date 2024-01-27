package com.taomee.seer2.app.gameRule.spt {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.ProgressiveAnimationPlayer;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.gameRule.spt.support.BaseSptSupport;
import com.taomee.seer2.app.gameRule.spt.support.SPTBufferStatus;
import com.taomee.seer2.app.gameRule.spt.support.SptBossInfoManager;
import com.taomee.seer2.app.gameRule.spt.support.SptConfigInfoManager;
import com.taomee.seer2.app.gameRule.spt.support.SptDialogConfig;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.entity.events.MoveEvent;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

public class SptHuoKeSupport extends BaseSptSupport {

    private static var _instance:SptHuoKeSupport;


    private const LABEL_UNLEVEL:String = "unLevelTag";

    private const LABEL_WINBEFORE:String = "afterWin";

    private const LABEL_NEVERWIN:String = "beforeWin";

    private var _huoke_MC:MovieClip;

    public function SptHuoKeSupport(param1:Block) {
        super();
        if (param1 == null) {
            throw new Error("get By getInstance()");
        }
    }

    public static function getInstance():SptHuoKeSupport {
        if (!_instance) {
            _instance = new SptHuoKeSupport(new Block());
        }
        return _instance;
    }

    override public function init(param1:MapModel):void {
        _sptBossId = SPTBossID.HuoKe;
        _petMaxLevelLimit = SptConfigInfoManager.getSptBossLevel(_sptBossId);
        _sptBufferPosition = SPTBufferStatus.HUOKE_POSITION;
        super.init(param1);
    }

    override protected function initSPTNPC():void {
        this._huoke_MC = _map.front["huokeMC"];
        _sptNPC = this._huoke_MC["huoke"];
        _sptNPC.buttonMode = true;
        _sptNPC.useHandCursor = true;
        super.initSPTNPC();
    }

    override public function dispose():void {
        this._huoke_MC.gotoAndStop(this._huoke_MC.totalFrames);
        super.dispose();
    }

    override protected function showSPT(param1:String = null):void {
        if (this._huoke_MC) {
            this._huoke_MC.visible = true;
            if (param1 != null) {
                (this._huoke_MC as MovieClip).gotoAndPlay(param1);
            }
        }
    }

    override protected function hideSPT():void {
        if (this._huoke_MC) {
            this._huoke_MC.visible = false;
        }
    }

    override protected function dealWithMapInit():void {
        var _loc1_:UserInfo = ActorManager.actorInfo;
        var _loc2_:uint = _loc1_.highestPetLevel;
        if (_loc2_ >= _petMaxLevelLimit) {
            if (_winHistory) {
                this.showSPT(this.LABEL_WINBEFORE);
            } else {
                this.showSPT(this.LABEL_NEVERWIN);
            }
        } else {
            this.showSPT(this.LABEL_UNLEVEL);
        }
    }

    override protected function fightFailure(param1:LittleEndianByteArray):void {
        var _loc3_:XML = null;
        var _loc4_:DialogDefinition = null;
        var _loc2_:uint = SptBossInfoManager.resolveSpt(_sptBossId, param1);
        if (_loc2_ < SptBossInfoManager.CATCH) {
            this.showSPT(this.LABEL_NEVERWIN);
            _loc3_ = new XML(SptDialogConfig.getSptDialog(_sptBossId, 1, [SptDialogConfig.getTalkContent(_sptBossId)]));
            _loc4_ = new DialogDefinition(_loc3_);
            DialogPanel.showForCommon(_loc4_);
        } else {
            this.showSPT(this.LABEL_WINBEFORE);
        }
    }

    override protected function fightWin():void {
        if (!_winHistory) {
            ServerBufferManager.updateServerBuffer(ServerBufferType.SPT, _sptBufferPosition, SPTBufferStatus.FIGHT_WIN);
            _animationPlayer = new ProgressiveAnimationPlayer(URLUtil.getQuestAnimation("spt/Win_HuoKe_Movie"));
            _animationPlayer.addEventListener(ProgressiveAnimationPlayer.EVT_END, this.onWinAnimationEnd);
            LayerManager.topLayer.addChild(_animationPlayer);
        } else {
            this.showSPT(this.LABEL_WINBEFORE);
        }
    }

    override protected function fightError():void {
        this.showSPT(this.LABEL_WINBEFORE);
    }

    private function onWinAnimationEnd(param1:Event):void {
        _animationPlayer.removeEventListener(ProgressiveAnimationPlayer.EVT_END, this.onWinAnimationEnd);
        DisplayObjectUtil.removeFromParent(_animationPlayer);
        _animationPlayer = null;
        this.showSPT(this.LABEL_WINBEFORE);
        var _loc2_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, 2));
        var _loc3_:DialogDefinition = new DialogDefinition(_loc2_);
        DialogPanel.showForCommon(_loc3_);
    }

    override protected function onSPTClickHandler(param1:MouseEvent):void {
        var _loc2_:Actor = ActorManager.getActor();
        var _loc3_:Boolean = Boolean(_loc2_.isArrivedPosition(new Point(350, 320)));
        if (_loc3_) {
            this.doAction();
        } else {
            _loc2_.addEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
            _loc2_.runToLocation(350, 320);
        }
        param1.stopImmediatePropagation();
    }

    private function onActorMoveFinished(param1:MoveEvent):void {
        var _loc2_:Actor = ActorManager.getActor();
        _loc2_.removeEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
        var _loc3_:Boolean = Boolean(_loc2_.isArrivedPosition(new Point(_loc2_.x, _loc2_.y)));
        if (_loc3_) {
            this.doAction();
        }
    }

    private function doAction():void {
        var _loc1_:UserInfo = ActorManager.actorInfo;
        var _loc2_:uint = _loc1_.highestPetLevel;
        if (_loc2_ >= _petMaxLevelLimit) {
            ServerBufferManager.getServerBuffer(ServerBufferType.SPT, this.checkServerBufferHandler);
        } else {
            this.unConfigDialoge();
        }
    }

    private function checkServerBufferHandler(param1:ServerBuffer):void {
        var beforeSPTWin:Boolean;
        var checkSptBossInfoHandler:Function = null;
        var branchDialog_1:Function = null;
        var branchDialog_2:Function = null;
        var startFighter:Function = null;
        var xmlData:XML = null;
        var dialogDefinition:DialogDefinition = null;
        var serverBuffer:ServerBuffer = param1;
        checkSptBossInfoHandler = function (param1:LittleEndianByteArray):void {
            var _loc2_:uint = SptBossInfoManager.resolveSpt(SPTBossID.AKanasi, param1);
            if (_loc2_ < SptBossInfoManager.WIN) {
                unConfigDialoge();
            } else {
                _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
            }
        };
        branchDialog_1 = function (param1:DialogCloseEvent):void {
            var _loc2_:XML = null;
            var _loc3_:DialogDefinition = null;
            DialogPanel.removeCloseEventListener(branchDialog_1);
            if ("joniDialog" == param1.params) {
                _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId, 4));
                _loc3_ = new DialogDefinition(_loc2_);
                DialogPanel.addCloseEventListener(branchDialog_2);
                DialogPanel.showForCommon(_loc3_);
            }
        };
        branchDialog_2 = function (param1:DialogCloseEvent):void {
            var _loc2_:XML = null;
            var _loc3_:DialogDefinition = null;
            DialogPanel.removeCloseEventListener(branchDialog_2);
            if ("badiDialog" == param1.params) {
                _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId, 5, [_petMaxLevelLimit]));
                _loc3_ = new DialogDefinition(_loc2_);
                DialogPanel.showForCommon(_loc3_, startFighter);
            }
        };
        startFighter = function (param1:String = ""):void {
            if ("fight" == param1) {
                _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
            }
        };
        serverBuffer.printDataInfo();
        beforeSPTWin = serverBuffer.readDataAtPostion(_sptBufferPosition - 1) == SPTBufferStatus.FIGHT_WIN;
        if (beforeSPTWin) {
            _winHistory = serverBuffer.readDataAtPostion(_sptBufferPosition) == SPTBufferStatus.FIGHT_WIN;
            if (_winHistory) {
                _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
            } else {
                xmlData = new XML(SptDialogConfig.getSptDialog(_sptBossId, 3));
                dialogDefinition = new DialogDefinition(xmlData);
                DialogPanel.addCloseEventListener(branchDialog_1);
                DialogPanel.showForCommon(dialogDefinition);
            }
        } else {
            checkSptBossInfo(checkSptBossInfoHandler);
        }
    }

    private function unConfigDialoge():void {
        var _loc1_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, 6, [_petMaxLevelLimit]));
        var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
        DialogPanel.showForCommon(_loc2_);
    }
}
}

class Block {


    public function Block() {
        super();
    }
}
