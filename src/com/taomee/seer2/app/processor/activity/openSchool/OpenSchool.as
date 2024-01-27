package com.taomee.seer2.app.processor.activity.openSchool {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.activity.devilActivity.DevilLoad;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.Tick;

public class OpenSchool {


    private const pointList:Vector.<Point> = Vector.<Point>([new Point(551, 120), new Point(575, 420), new Point(575, 420), new Point(575, 420)]);

    private const limitList:Vector.<uint> = Vector.<uint>([202136, 202137, 202138]);

    private const timeList:Vector.<uint> = Vector.<uint>([18000, 18000, 18000]);

    private const questList:Vector.<uint> = Vector.<uint>([30041, 30042, 30043, 30044]);

    private var _npc:Mobile;

    private var _cheer:MovieClip;

    private var _load:DevilLoad;

    private var _playNpc:MovieClip;

    private var _timeMC:MovieClip;

    private var _index:uint;

    private var _completeCount:uint;

    private var _threePet:MovieClip;

    public function OpenSchool() {
        super();
        this.init();
    }

    private function init():void {
        this._npc = MobileManager.getMobile(65, MobileType.NPC);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc);
        this._npc.visible = false;
        this.initLoad();
    }

    private function initLoad():void {
        this._load = new DevilLoad();
        this._load.playLoad("openSchool/openSchool", function ():void {
            checkNpc();
        });
    }

    private function checkNpc():void {
        if (QuestManager.isAccepted(30041) && QuestManager.isStepComplete(30041, 2) && QuestManager.isStepComplete(30041, 3) == false) {
            this.addPlayNpc("playMC30041", 0);
        } else if (QuestManager.isAccepted(30042) && QuestManager.isStepComplete(30042, 2) && QuestManager.isStepComplete(30042, 3) == false) {
            this.addPlayNpc("playMC30042", 1);
        } else if (QuestManager.isAccepted(30043) && QuestManager.isStepComplete(30043, 2) && QuestManager.isStepComplete(30043, 3) == false) {
            this.addPlayNpc("playMC30043", 2);
        } else if (QuestManager.isAccepted(30044) && QuestManager.isStepComplete(30044, 1) && QuestManager.isStepComplete(30044, 2) == false) {
            this.addPlayNpc("playMC30044", 3);
        } else if (QuestManager.isComplete(30044)) {
            this._npc.visible = false;
        } else {
            this._npc.visible = true;
        }
    }

    private function addPlayNpc(param1:String, param2:uint):void {
        this._index = param2;
        this._playNpc = this._load.getMC(param1);
        this._playNpc.x = this.pointList[param2].x;
        this._playNpc.y = this.pointList[param2].y;
        if (this._index != 3) {
            this._cheer = this._playNpc["cheer"];
            this._cheer.visible = false;
            this._cheer.addEventListener(MouseEvent.CLICK, this.onCheer, false, 1);
            TooltipManager.addCommonTip(this._cheer, "加速1小时要消耗1000赛尔豆");
            this._playNpc.addEventListener(MouseEvent.CLICK, this.onPanel);
            this._playNpc.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
            this._playNpc.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
            this.addTimeMC();
        } else {
            this._playNpc.buttonMode = true;
            this._playNpc.addEventListener(MouseEvent.CLICK, this.onNpc);
        }
        SceneManager.active.mapModel.content.addChild(this._playNpc);
    }

    private function onPanel(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("OpenSchoolPanel"), "正在打开面板...");
    }

    private function onOver(param1:MouseEvent):void {
        if (this._cheer) {
            this._cheer.visible = true;
        }
    }

    private function onOut(param1:MouseEvent):void {
        this._cheer.visible = false;
    }

    private function onCheer(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        event.stopImmediatePropagation();
        this._cheer.visible = false;
        if (ActorManager.actorInfo.coins < 1000) {
            AlertManager.showAlert("赛尔豆不够");
        }
        SwapManager.swapItem(975 + this._index, 1, function (param1:IDataInput):void {
            var data:IDataInput = param1;
            new SwapInfo(data);
            ServerMessager.addMessage("使用了1000赛尔豆");
            _threePet = _load.getMC("threePet");
            if (_index == 0) {
                _threePet.x = _playNpc.x - 100;
                _threePet.y = _playNpc.y + 50;
            } else {
                _threePet.x = _playNpc.x - 120;
                _threePet.y = _playNpc.y;
            }
            SceneManager.active.mapModel.content.addChild(_threePet);
            MovieClipUtil.playMc(_threePet, 1, _threePet.totalFrames, function ():void {
                DisplayUtil.removeForParent(_threePet);
                _completeCount -= 3600;
            }, true);
        }, function (param1:uint):void {
            AlertManager.showAlert("赛尔豆不够");
        });
    }

    private function addTimeMC():void {
        ActiveCountManager.requestActiveCount(this.limitList[this._index], function (param1:uint, param2:uint):void {
            if (TimeManager.getServerTime() >= param2) {
                playComplete();
            } else {
                _completeCount = param2;
                _timeMC = _load.getMC("time");
                _timeMC.x = _playNpc.x - 5;
                _timeMC.y = _playNpc.y - 50;
                SceneManager.active.mapModel.content.addChild(_timeMC);
                if (Tick.instance.hasRender(updateTime) == false) {
                    Tick.instance.addRender(updateTime, 1000);
                }
                updateTime(0);
            }
        });
    }

    private function updateTime(param1:uint):void {
        if (TimeManager.getServerTime() > this._completeCount) {
            Tick.instance.removeRender(this.updateTime);
            this.playComplete();
            return;
        }
        var _loc2_:uint = this.timeList[this._index] - (TimeManager.getServerTime() - (this._completeCount - this.timeList[this._index]));
        this._timeMC["mc"].scaleX = _loc2_ / this.timeList[this._index];
        var _loc3_:uint = uint((this._completeCount - TimeManager.getServerTime()) / 60);
        this._timeMC["txt"].text = "还剩" + _loc3_ + "分钟";
    }

    private function playComplete():void {
        MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("openSchool/openSchool" + this._index), function ():void {
            QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
            QuestManager.completeStep(questList[_index], 3);
        });
    }

    private function onQuestComplete(param1:QuestEvent):void {
        var event:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        DisplayUtil.removeForParent(this._timeMC);
        DisplayUtil.removeForParent(this._playNpc);
        if (event.questId != 30044) {
            this._npc.visible = true;
        } else {
            MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("openSchool/openSchool3"), function ():void {
                _npc.visible = false;
            });
        }
    }

    private function onNpc(param1:MouseEvent):void {
        ServerBufferManager.getServerBuffer(ServerBufferType.OPEN_SCHOOL, this.onOpenSchool);
    }

    private function onOpenSchool(param1:ServerBuffer):void {
        var server:ServerBuffer = param1;
        if (server.readDataAtPostion(0) != 1) {
            NpcDialog.show(65, "包工头", [[0, "全新的一年开始啦！传送室也该换个新面貌了吧！我包工头百忙之中抽出空来专门帮你布置，还傻站着干什么？还不快过来看一下我的最新设计图？ "]], ["哦？快给我看看！", "装修好累啊！不管！"], [function ():void {
                ServerBufferManager.updateServerBuffer(ServerBufferType.OPEN_SCHOOL, 0, 1);
                nextNpc();
            }]);
        } else {
            this.nextNpc();
        }
    }

    private function nextNpc():void {
        if (QuestManager.isAccepted(30041) && QuestManager.isStepComplete(30041, 1) && QuestManager.isStepComplete(30041, 2) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStepComplete);
            QuestManager.completeStep(30041, 2);
        } else if (QuestManager.isAccepted(30042) && QuestManager.isStepComplete(30042, 1) && QuestManager.isStepComplete(30042, 2) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStepComplete);
            QuestManager.completeStep(30042, 2);
        } else if (QuestManager.isAccepted(30043) && QuestManager.isStepComplete(30043, 1) && QuestManager.isStepComplete(30043, 2) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStepComplete);
            QuestManager.completeStep(30043, 2);
        } else if (QuestManager.isAccepted(30044) && QuestManager.isStepComplete(30044, 1) && QuestManager.isStepComplete(30044, 2) == false) {
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
            QuestManager.completeStep(30044, 2);
        } else {
            ModuleManager.toggleModule(URLUtil.getAppModule("OpenSchoolPanel"), "正在打开面板...");
        }
    }

    private function onQuestStepComplete(param1:QuestEvent):void {
        this._npc.visible = false;
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStepComplete);
        this.addPlayNpc("playMC" + param1.questId, param1.questId - 30041);
    }

    public function dispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStepComplete);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        DisplayUtil.removeForParent(this._timeMC);
        DisplayUtil.removeForParent(this._playNpc);
        DisplayUtil.removeForParent(this._threePet);
        if (this._playNpc) {
            this._playNpc.removeEventListener(MouseEvent.MOUSE_OVER, this.onOver);
            this._playNpc.removeEventListener(MouseEvent.MOUSE_OUT, this.onOut);
        }
        Tick.instance.removeRender(this.updateTime);
        this._index = 0;
        this._timeMC = null;
        this._playNpc = null;
        this._cheer = null;
        this._npc = null;
        this._threePet = null;
    }
}
}
