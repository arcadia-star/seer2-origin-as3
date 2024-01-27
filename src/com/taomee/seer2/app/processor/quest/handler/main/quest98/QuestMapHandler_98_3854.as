package com.taomee.seer2.app.processor.quest.handler.main.quest98 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_98_3854 extends QuestMapHandler {


    private var _npc40:Mobile;

    private var _fightID:Array;

    private var _oldNpc:Mobile;

    private var _newNpc:Mobile;

    private var _animation:MovieClip;

    public function QuestMapHandler_98_3854(param1:QuestProcessor) {
        this._fightID = [1670];
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 3) == false) {
            this.changeNpc3020();
        }
    }

    private function changeNpc3020():void {
        this._oldNpc = MobileManager.getMobile(3020, MobileType.NPC);
        this._oldNpc.visible = false;
        this._newNpc = new Mobile();
        this._newNpc.width = this._oldNpc.width;
        this._newNpc.height = this._oldNpc.height;
        this._newNpc.label = this._oldNpc.label;
        this._newNpc.setPostion(new Point(this._oldNpc.x, this._oldNpc.y));
        this._newNpc.resourceUrl = this._oldNpc.resourceUrl;
        this._newNpc.buttonMode = true;
        this.showMouseHintAtMonster(this._newNpc);
        MobileManager.addMobile(this._newNpc, MobileType.NPC);
        this._newNpc.addEventListener(MouseEvent.CLICK, this.onNpc3020Click);
    }

    private function afterFinish():void {
        if (this._newNpc) {
            DisplayUtil.removeForParent(this._newNpc);
            this._newNpc = null;
        }
        if (this._oldNpc) {
            this._oldNpc.visible = true;
        }
    }

    private function showDialog():void {
        NpcDialog.show(3020, "费雷德", [[0, "好了~现在我们需要施法召唤暗影守护者！在这期间我需要你们帮我个忙……"]], ["要我们做什么尽管说吧！？"], [function ():void {
            NpcDialog.show(3020, "费雷德", [[0, "我们会在祭坛中使用法典的力量开始召唤仪式？这强大的法力涌动肯定会引起精灵的躁动甚至惊动萨伦帝国……"]], ["YE！放心，我会帮你赶跑他们"], [function ():void {
                NpcDialog.show(3020, "费雷德", [[0, "你办事~我放心！这事就交给你了可别让他们中断我们的召唤！"]], ["当然当然？"], [function ():void {
                    MovieClipUtil.getSwfContent(URLUtil.getActivityAnimation("DarkDefender"), function callBack(param1:MovieClip):void {
                        var tempNpc:* = undefined;
                        var mc:MovieClip = param1;
                        ActorManager.getActor().hide();
                        ActorManager.getActor().blockFollowingPet = false;
                        ActorManager.getActor().blockNoNo = false;
                        _animation = mc.content as MovieClip;
                        _map.front.addChild(_animation);
                        tempNpc = MobileManager.getMobile(3020, MobileType.NPC);
                        if (tempNpc) {
                            tempNpc.visible = false;
                        }
                        MovieClipUtil.playMc(_animation, 1, _animation.totalFrames, function callBack():void {
                            _animation.gotoAndStop(1);
                            _animation.visible = false;
                            _animation = null;
                            ActorManager.getActor().show();
                            ActorManager.getActor().blockFollowingPet = false;
                            ActorManager.getActor().blockNoNo = false;
                            RightToolbarConter.instance.show();
                            if (tempNpc) {
                                tempNpc.visible = true;
                                tempNpc = null;
                            }
                            showNpc40();
                        });
                    });
                }]);
            }]);
        }]);
    }

    private function showNpc40():void {
        this._npc40 = new Mobile();
        this._npc40.setPostion(new Point(960, 420));
        this._npc40.label = "萨伦小兵";
        this._npc40.id = 40;
        this._npc40.resourceUrl = URLUtil.getNpcSwf(40);
        this._npc40.buttonMode = true;
        this._npc40.addEventListener(MouseEvent.CLICK, this.onNpc40Click);
        this.showMouseHintAtMonster(this._npc40);
        MobileManager.addMobile(this._npc40, MobileType.NPC);
    }

    private function showMouseHintAtMonster(param1:Mobile):void {
        var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
        _loc2_.y = -_loc2_.height - 50;
        _loc2_.x = (param1.width - param1.width) / 2;
        param1.addChild(_loc2_);
    }

    private function onNpc40Click(param1:MouseEvent):void {
        this._npc40.removeEventListener(MouseEvent.CLICK, this.onNpc40Click);
        this.fightWithWild();
    }

    private function onNpc3020Click(param1:MouseEvent):void {
        this._newNpc.removeEventListener(MouseEvent.CLICK, this.onNpc3020Click);
        this.afterFinish();
        this.showDialog();
    }

    private function fightWithWild():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onCompleteSwitch);
        FightManager.startFightWithWild(this._fightID[0]);
    }

    private function onCompleteSwitch(param1:SceneEvent):void {
        var e:SceneEvent = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onCompleteSwitch);
            if (this._fightID[0] == FightManager.currentFightRecord.initData.positionIndex) {
                if (FightManager.isWinWar()) {
                    MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("DarkDefender1"), function callBack():void {
                        afterFinish();
                        QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                        QuestManager.completeStep(questID, 3);
                    }, true, true, 2, true);
                } else {
                    MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("DarkDefender2"), function callBack():void {
                        changeNpc3020();
                    }, true, true, 2, true);
                }
            }
        }
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        this.afterFinish();
        RightToolbarConter.instance.show();
    }
}
}
