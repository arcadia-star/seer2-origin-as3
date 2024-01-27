package com.taomee.seer2.app.gameRule.spt {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.gameRule.spt.support.BaseSptSupport;
import com.taomee.seer2.app.gameRule.spt.support.SPTBufferStatus;
import com.taomee.seer2.app.gameRule.spt.support.SptConfigInfoManager;
import com.taomee.seer2.app.gameRule.spt.support.SptDialogConfig;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.quest.data.DialogDefinition;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class SptKadoshSupport extends BaseSptSupport {

    private static var _instance:SptKadoshSupport;

    private static var _isWin:Boolean = false;

    private static const Weak_Point_Vec:Vector.<int> = Vector.<int>([4, 5, 6]);


    private const AFTER_WIN:String = "fight";

    private const BEFORE_WIN:String = "normal";

    private var _kadosh_mc:MovieClip;

    private var _timer:Timer;

    public function SptKadoshSupport(param1:Singleton) {
        super();
    }

    public static function getInstance():SptKadoshSupport {
        if (!_instance) {
            _instance = new SptKadoshSupport(new Singleton());
        }
        return _instance;
    }

    override public function init(param1:MapModel):void {
        _sptBossId = SPTBossID.Kadosh;
        _petMaxLevelLimit = SptConfigInfoManager.getSptBossLevel(_sptBossId);
        _sptBufferPosition = SPTBufferStatus.KADASH_POSITION;
        super.init(param1);
    }

    override protected function fightFailure(param1:LittleEndianByteArray):void {
        var _loc2_:uint = uint(Math.random() * 1000 % Weak_Point_Vec.length);
        var _loc3_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, Weak_Point_Vec[_loc2_]));
        var _loc4_:DialogDefinition = new DialogDefinition(_loc3_);
        DialogPanel.showForCommon(_loc4_);
    }

    private function startTimer():void {
        this._timer = new Timer(10000, 1);
        this._timer.addEventListener(TimerEvent.TIMER, this.stopMcHandler);
        this._timer.start();
    }

    private function stopMcHandler(param1:TimerEvent):void {
        this.showSPT(this.BEFORE_WIN);
        this._timer.reset();
        this._timer.removeEventListener(TimerEvent.TIMER, this.stopMcHandler);
        this._timer = null;
    }

    override protected function fightWin():void {
        if (!_winHistory) {
            ServerBufferManager.updateServerBuffer(ServerBufferType.SPT, _sptBufferPosition, SPTBufferStatus.FIGHT_WIN);
            MovieClipUtil.playFullScreen("res/active/fullScreen/910_212.swf", function ():void {
                firstWinTalk();
            });
        } else {
            this.showSPT(this.AFTER_WIN);
        }
    }

    public function firstWinTalk():void {
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "其实，菲亚斯一直都在遗忘之岛上等着你！他一直因为没法履行约定而苦恼！"]], ["（将自己遇见菲亚斯的事告诉卡多斯）"], [function ():void {
            var twoStyle:Function = null;
            twoStyle = function (param1:String = ""):void {
                var _loc2_:* = undefined;
                var _loc3_:* = undefined;
                if (param1 == "nextTwoStyle") {
                    _loc2_ = new XML(SptDialogConfig.getSptDialog(_sptBossId, 8));
                    _loc3_ = new DialogDefinition(_loc2_);
                    DialogPanel.showForCommon(_loc3_);
                }
            };
            var data:* = new XML(SptDialogConfig.getSptDialog(_sptBossId, 3));
            var dialogDefinition:* = new DialogDefinition(data);
            DialogPanel.showForCommon(dialogDefinition, twoStyle);
        }]);
    }

    override protected function initSPTNPC():void {
        _sptNPC = _map.content["kadoshMc"];
        _sptNPC.buttonMode = true;
        super.initSPTNPC();
        this.showSPT();
    }

    override protected function showSPT(param1:String = null):void {
        if (_sptNPC) {
            _sptNPC.visible = true;
            if (param1 != null) {
                (_sptNPC as MovieClip).gotoAndStop(param1);
            }
        }
    }

    override protected function onSPTClickHandler(param1:MouseEvent):void {
        var _loc2_:UserInfo = ActorManager.actorInfo;
        var _loc3_:uint = _loc2_.highestPetLevel;
        if (_loc3_ < _petMaxLevelLimit) {
            this.userLevelLowHandler();
        } else {
            ServerBufferManager.getServerBuffer(ServerBufferType.SPT, this.checkServerBufferHandler);
        }
    }

    private function userLevelLowHandler():void {
        var _loc1_:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, 1));
        var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
        DialogPanel.showForCommon(_loc2_);
    }

    private function checkServerBufferHandler(param1:ServerBuffer):void {
        _winHistory = param1.readDataAtPostion(_sptBufferPosition) == SPTBufferStatus.FIGHT_WIN;
        if (_winHistory) {
            _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
        } else {
            this.doWhenNeverWinBefore();
        }
    }

    private function doWhenNeverWinBefore():void {
        var prepareFight:Function = null;
        prepareFight = function (param1:String = ""):void {
            var startFighter:Function = null;
            var data:XML = null;
            var dialogDefinition:DialogDefinition = null;
            var params:String = param1;
            startFighter = function (param1:String = ""):void {
                var _loc2_:int = 0;
                if (AFTER_WIN == param1) {
                    _fighterID = FightManager.startFightWithSPTBoss(_sptBossId);
                    _loc2_ = 0;
                }
            };
            if (params == "prepareFight") {
                data = new XML(SptDialogConfig.getSptDialog(_sptBossId, 7));
                dialogDefinition = new DialogDefinition(data);
                DialogPanel.showForCommon(dialogDefinition, startFighter);
            }
        };
        var data:XML = new XML(SptDialogConfig.getSptDialog(_sptBossId, 2));
        var dialogDefinition:DialogDefinition = new DialogDefinition(data);
        DialogPanel.showForCommon(dialogDefinition, prepareFight);
    }
}
}

class Singleton {


    public function Singleton() {
        super();
    }
}
