package com.taomee.seer2.app.processor.quest.handler.branch.quest10223 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.animationInteractive.Interactive_10222;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.miniGame.MiniGameEvent;
import com.taomee.seer2.app.miniGame.MiniGameManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10223_142 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    private var _mack:AcceptableMark;

    private var _makeStone:Interactive_10222;

    public function QuestMapHandler_10223_142(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10223) && QuestManager.isStepComplete(10223, 2) == false) {
            this.initStep1();
        }
    }

    private function updateNPC(param1:Event):void {
        MobileManager.getMobile(199, MobileType.NPC).visible = false;
        MobileManager.getMobile(201, MobileType.NPC).visible = false;
    }

    private function initStep1():void {
        MobileManager.getMobile(199, MobileType.NPC).visible = false;
        MobileManager.getMobile(201, MobileType.NPC).visible = false;
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc1 = _processor.resLib.getMovieClip("mc1");
        this._mc1["leiyi"].visible = false;
        this._mc1.addEventListener(Event.ENTER_FRAME, this.updateNPC);
        _map.front.addChild(this._mc1);
        MovieClipUtil.playMc(this._mc1, 2, this._mc1.totalFrames, function ():void {
            _mc1.removeEventListener(Event.ENTER_FRAME, updateNPC);
            _mack = new AcceptableMark();
            _mack.x = _mc1["leiyi"].x + 25;
            _mack.y = _mc1["leiyi"].y - 90;
            _map.front.addChild(_mack);
            _mc1["leiyi"].buttonMode = true;
            _mc1["leiyi"].visible = true;
            _mc1["leiyi"].addEventListener(MouseEvent.CLICK, onLeiyi);
        }, true);
    }

    private function initStep2():void {
        DisplayUtil.removeForParent(this._mack);
        DisplayUtil.removeForParent(this._mc1);
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc2 = _processor.resLib.getMovieClip("mc2");
        this._mc2["leiyi"].visible = false;
        this._mc2["yandi"].visible = false;
        _map.front.addChild(this._mc2);
        MovieClipUtil.playMc(this._mc2, 2, this._mc2.totalFrames, function ():void {
            _mack = new AcceptableMark();
            _mack.x = _mc2["leiyi"].x + 25;
            _mack.y = _mc2["leiyi"].y + 10;
            _map.front.addChild(_mack);
            _mc2["leiyi"].visible = true;
            _mc2["yandi"].visible = true;
            _mc2["leiyi"].buttonMode = true;
            _mc2["yandi"].buttonMode = true;
            _mc2["yandi"].addEventListener(MouseEvent.CLICK, onLeiyi2);
            _mc2["leiyi"].addEventListener(MouseEvent.CLICK, onLeiyi2);
        }, true);
    }

    private function initStep3():void {
        DisplayUtil.removeForParent(this._mc2);
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc3 = _processor.resLib.getMovieClip("mc3");
        _map.front.addChild(this._mc3);
        MovieClipUtil.playMc(this._mc3, 2, this._mc3.totalFrames, function ():void {
            ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameConsolePanel"), "正在打开" + "小游戏" + "...", {"gameId": 16});
            MiniGameManager.addEventListener(MiniGameEvent.END_PLAY_GAME, onPlayEnd);
            LayerManager.hideMap();
        }, true);
    }

    private function onLeiyi(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        MobileManager.getMobile(199, MobileType.NPC).visible = false;
        MobileManager.getMobile(201, MobileType.NPC).visible = false;
        _map.front.removeChild(this._mack);
        this._mack = null;
        this._mc1["leiyi"].removeEventListener(MouseEvent.CLICK, this.onLeiyi);
        NpcDialog.show(400, "小赛尔", [[0, "雷伊……他是……被暗化的……凯萨……炎煞……小心。"]], ["别轻敌啊！"], [function ():void {
            NpcDialog.show(477, "雷伊", [[0, "没想到炎帝凯萨，我最可敬的对手也被他们抓住了。"]], ["萨伦帝国太卑鄙了！"], [function ():void {
                NpcDialog.show(708, "炎煞", [[0, "不止炎帝，战神联盟的所有成员都已经成了斯坦因博士的试验品了，雷伊，你就投降了吧！"]], ["雷伊才不会投降呢！"], [function ():void {
                    NpcDialog.show(477, "雷伊", [[0, "谁胜谁负，现在还不知道呢！"]], ["加油雷伊！"], [function ():void {
                        initStep2();
                    }]);
                }]);
            }]);
        }]);
    }

    private function onLeiyi2(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DisplayUtil.removeForParent(this._mack);
        this._mc2["yandi"].removeEventListener(MouseEvent.CLICK, this.onLeiyi2);
        this._mc2["leiyi"].removeEventListener(MouseEvent.CLICK, this.onLeiyi2);
        NpcDialog.show(477, "雷伊", [[0, "如果没受伤的话……"]], [" 炎煞你欺负受伤的雷伊！"], [function ():void {
            NpcDialog.show(708, "炎煞", [[0, "哼，我现在就来给你最后一击。"]], ["雷伊小心！"], [function ():void {
                initStep3();
            }]);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.LOBBY, 770);
    }

    override public function processMapDispose():void {
        LayerManager.showMap();
        MobileManager.getMobile(199, MobileType.NPC).visible = true;
        MobileManager.getMobile(201, MobileType.NPC).visible = true;
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._mc1);
        DisplayUtil.removeForParent(this._mc2);
        DisplayUtil.removeForParent(this._mack);
        if (this._makeStone) {
            this._makeStone.dispose();
            this._makeStone = null;
        }
        ActorManager.getActor().isShow = true;
        ActorManager.getActor().blockNoNo = false;
    }

    private function onStartGame(param1:MiniGameEvent):void {
        MiniGameManager.removeEventListener(MiniGameEvent.START_PLAY_GAME, this.onStartGame);
        MiniGameManager.addEventListener(MiniGameEvent.END_PLAY_GAME, this.onPlayEnd);
    }

    private function onPlayEnd(param1:MiniGameEvent):void {
        MiniGameManager.removeEventListener(MiniGameEvent.END_PLAY_GAME, this.onPlayEnd);
        var _loc2_:SpecialInfo = new SpecialInfo(1, param1.gameInfo.score);
        if (param1.gameInfo.gameId == 16) {
            LayerManager.showMap();
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            QuestManager.completeStep(10223, 2);
        }
    }
}
}
