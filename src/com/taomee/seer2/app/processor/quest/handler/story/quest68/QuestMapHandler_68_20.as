package com.taomee.seer2.app.processor.quest.handler.story.quest68 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.app.controls.widget.YueseNonoWidgetClick;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.guide.info.GudieDirectionType;
import com.taomee.seer2.app.guide.manager.GuideManager;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.QuestProcessor_68;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_68_20 extends QuestMapHandler {

    private static var isOpen:Boolean;


    private var _npc2:Mobile;

    private var _mc1:MovieClip;

    private var _mc_0:MovieClip;

    public function QuestMapHandler_68_20(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isOpen) {
            return;
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false && QuestProcessor_68.questStatus == _quest.id) {
            isOpen = true;
            this.init();
            this._mc1 = _processor.resLib.getMovieClip("mc1");
            LayerManager.topLayer.addChild(this._mc1);
            MovieClipUtil.playMc(this._mc1, 1, this._mc1.totalFrames, function ():void {
                QuestPlayMC.playMC(_mc1, function ():void {
                    buyItems();
                });
            }, true);
            ToolBar.enableBtn(YueseNonoWidgetClick.YUESE_NONO);
        } else if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 2) == false && QuestProcessor_68.questStatus == _quest.id) {
            this.init();
            this.fightPetGudie();
            ToolBar.enableBtn(YueseNonoWidgetClick.YUESE_NONO);
        } else if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 3) == false && QuestProcessor_68.questStatus == _quest.id) {
            this.init();
            this.recoverPetGudie();
            ToolBar.enableBtn(YueseNonoWidgetClick.YUESE_NONO);
        }
    }

    private function init():void {
        ActorManager.showRemoteActor = false;
        this._npc2 = MobileManager.getMobile(2, MobileType.NPC);
        ModuleManager.addEventListener("BusinessPanel", ModuleEvent.OPEN, this.hideGudie);
        ModuleManager.addEventListener("BusinessPanel", ModuleEvent.SET_UP, this.onShowBusiness);
        ModuleManager.addEventListener("BusinessPanel", ModuleEvent.DISPOSE, this.onDisposeBusiness);
        ActorManager.getActor().blockFollowingPet = true;
        ActorManager.getActor().blockNoNo = true;
    }

    private function hideGudie(param1:ModuleEvent):void {
        if (QuestManager.isAccepted(_quest.id)) {
            GuideManager.instance.pause();
        }
    }

    private function onComplete(param1:QuestEvent):void {
        GuideManager.instance.close();
        if (param1.questId == 68) {
            ActorManager.showRemoteActor = true;
            ModuleManager.toggleModule(URLUtil.getAppModule("QuestNewPanel"), "正在打开...");
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_80);
        }
    }

    private function onShowBusiness(param1:ModuleEvent):void {
        var _loc2_:Rectangle = null;
        if (QuestManager.isAccepted(68)) {
            _loc2_ = new Rectangle(0, 0, 65, 65);
            GuideManager.instance.addTarget(_loc2_, 12);
            GuideManager.instance.addGuide2Target(_loc2_, 0, 12, new Point(584, 243), false, false, GudieDirectionType.CONTENT, false, true);
            GuideManager.instance.startGuide(12);
        }
    }

    private function onDisposeBusiness(param1:ModuleEvent):void {
        GuideManager.instance.pause();
        if (QuestManager.isAccepted(_quest.id)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            QuestManager.completeStep(68, 1);
        }
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        if (param1.questId == _quest.id && param1.stepId == 1) {
            this.fightPetGudie();
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_78);
        } else if (param1.questId == _quest.id && param1.stepId == 2) {
            this.recoverPetGudie();
        }
    }

    private function recoverPetGudie():void {
        NpcDialog.show(2, "伊娃博士", [[0, "真厉害！不过刚刚的战斗消耗了精灵大量的<font color=\'#ff0000\'>" + "体力" + "</font>，当<font color=\'#ff0000\'>" + "体力为0" + "</font>时就不能继续战斗咯，赶紧使用精灵</font>，单击<font color=\'#ff0000\'>" + "恢复按钮" + "</font>帮助精灵恢复体力吧。"]], ["我知道了，这就去补充。"], [function ():void {
            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
            var _loc1_:* = new Rectangle(0, 0, 24, 23);
            GuideManager.instance.addTarget(_loc1_, 1);
            GuideManager.instance.addGuide2Target(_loc1_, 0, 1, new Point(203, 62), false, false, GudieDirectionType.CONTENT, true, false, true);
            GuideManager.instance.startGuide(1);
        }]);
    }

    private function fightPetGudie():void {
        NpcDialog.show(2, "伊娃博士", [[0, "你前面购买的<font color=\'#ff0000\'>" + "精灵胶囊" + "</font>是专门用来捕捉精灵的，接下来会有一种名叫<font color=\'#ff0000\'>" + "啾啾" + "</font>的精灵，如果你能成功<font color=\'#ff0000\'>" + "捕捉" + "</font>它，就会成为你的新伙伴哦！"]], ["真的吗？我一定会成功的！"], [function ():void {
            if (PetInfoManager.getFirstPetInfo().level >= 20) {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                QuestManager.completeStep(_quest.id, 2);
            } else {
                GuideManager.instance.close();
                FightManager.startFightWithGudiePet(0);
            }
        }]);
    }

    private function createPet():void {
        var scene:LobbyScene = null;
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.content.addChild(this._mc_0);
        this._npc2.visible = false;
        scene = SceneManager.active as LobbyScene;
        scene.hideToolbar();
        LayerManager.focusOnTopLayer();
        MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
            LayerManager.resetOperation();
            scene.showToolbar();
            _mc_0.gotoAndStop(_mc_0.totalFrames);
            _mc_0.addEventListener(Event.FRAME_CONSTRUCTED, onFrameConstructed);
            addGudie();
        });
    }

    private function onFrameConstructed(param1:Event):void {
        this._mc_0.removeEventListener(Event.FRAME_CONSTRUCTED, this.onFrameConstructed);
        (this._mc_0["pet"] as MovieClip).buttonMode = true;
        (this._mc_0["pet"] as MovieClip).mouseEnabled = true;
        (this._mc_0["pet"] as MovieClip).addEventListener(MouseEvent.CLICK, this.onNPC);
    }

    private function addGudie():void {
        _processor.showMouseHintAt(400, 235);
    }

    private function onNPC(param1:MouseEvent):void {
        this._npc2.visible = true;
        _processor.hideMouseClickHint();
        this._mc_0.removeEventListener(MouseEvent.CLICK, this.onNPC);
        DisplayObjectUtil.removeFromParent(this._mc_0);
        this._mc_0 = null;
        if (PetInfoManager.getFirstPetInfo().level >= 20) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            QuestManager.completeStep(_quest.id, 2);
        } else {
            FightManager.startFightWithGudiePet(0);
        }
    }

    private function buyItems():void {
        var _loc1_:Object = new Object();
        _loc1_.shopType = 1;
        ModuleManager.toggleModule(URLUtil.getAppModule("BusinessPanel"), "", _loc1_);
    }

    override public function processMapDispose():void {
        isOpen = false;
        DisplayUtil.removeForParent(this._mc1);
        this._mc1 = null;
        DisplayUtil.removeForParent(this._mc_0);
        this._mc_0 = null;
        ModuleManager.removeEventListener("BusinessPanel", ModuleEvent.OPEN, this.hideGudie);
        ModuleManager.removeEventListener("BusinessPanel", ModuleEvent.SET_UP, this.onShowBusiness);
        ModuleManager.removeEventListener("BusinessPanel", ModuleEvent.DISPOSE, this.onDisposeBusiness);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        ActorManager.showRemoteActor = true;
        ActorManager.getActor().blockNoNo = false;
        ActorManager.getActor().blockFollowingPet = false;
    }
}
}
