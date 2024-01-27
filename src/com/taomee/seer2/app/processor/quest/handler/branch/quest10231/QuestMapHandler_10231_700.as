package com.taomee.seer2.app.processor.quest.handler.branch.quest10231 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10231_700 extends QuestMapHandler {

    public static var haveBattle:Boolean = true;


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    private var _mc4:MovieClip;

    private var _mack:AcceptableMark;

    public function QuestMapHandler_10231_700(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (!haveBattle) {
            return;
        }
        super.processMapComplete();
        if (QuestManager.isAccepted(10231) && QuestManager.isStepComplete(10231, 1) == false) {
            _map.content.visible = false;
            this.initStep1();
        }
    }

    private function initStep1():void {
        ActorManager.showRemoteActor = false;
        MobileManager.hideMoileVec(MobileType.NPC);
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc1 = _processor.resLib.getMovieClip("mc1");
        this._mc1["yuse"].visible = false;
        _map.front.addChild(this._mc1);
        MovieClipUtil.playMc(this._mc1, 2, this._mc1.totalFrames, function ():void {
            _mack = new AcceptableMark();
            _mc1["yuse"].visible = true;
            _mc1["yuse"].buttonMode = true;
            _mack.x = _mc1["yuse"].x + 40;
            _mack.y = _mc1["yuse"].y;
            _mc1.addChild(_mack);
            _mc1["yuse"].addEventListener(MouseEvent.CLICK, onClick);
        }, true);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc1["yuse"].removeEventListener(MouseEvent.CLICK, this.onClick);
        NpcDialog.show(400, ActorManager.actorInfo.nick + "", [[0, "约瑟王！"]], [" 怎么会突然降临？"], [function ():void {
            NpcDialog.show(591, "约瑟", [[0, "阿卡迪亚有大事要发生了，前所未有的入侵。"]], [" 前所未有的入侵？！"], [function ():void {
                NpcDialog.show(591, "约瑟", [[0, "没错，来自远古的邪恶力量已经侵入到了阿卡迪亚的根髓，我已经让最强的战士们前去应战，但依然需要你的帮助。"]], ["最强的战士？我的帮助？"], [function ():void {
                    NpcDialog.show(591, "约瑟", [[0, "没错，没时间解释了，快去吧。守护阿卡迪亚。"]], ["诶？到底要我做什么？"], [function ():void {
                        DisplayUtil.removeForParent(_mack);
                        DisplayUtil.removeForParent(_mc1);
                        initStep2();
                    }]);
                }]);
            }]);
        }]);
    }

    private function initStep2():void {
        ActorManager.showRemoteActor = false;
        MobileManager.hideMoileVec(MobileType.NPC);
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc2 = _processor.resLib.getMovieClip("mc2");
        _map.front.addChild(this._mc2);
        MovieClipUtil.playMc(this._mc2, 2, this._mc2.totalFrames, function ():void {
            _mc2.gotoAndStop(1);
            DisplayUtil.removeForParent(_mc2);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(10231, 1);
        }, true);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.LOBBY, 100);
    }

    override public function processMapDispose():void {
        MobileManager.showMoileVec(MobileType.NPC);
        ActorManager.showRemoteActor = true;
        ActorManager.getActor().isShow = true;
        ActorManager.getActor().blockNoNo = false;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._mc1);
        DisplayUtil.removeForParent(this._mc2);
        DisplayUtil.removeForParent(this._mack);
    }
}
}
