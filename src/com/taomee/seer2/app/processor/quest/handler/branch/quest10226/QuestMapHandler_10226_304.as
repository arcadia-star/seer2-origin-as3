package com.taomee.seer2.app.processor.quest.handler.branch.quest10226 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10226_304 extends QuestMapHandler {

    public static var haveBattle:Boolean = true;


    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    private var _mc4:MovieClip;

    private var _mack:AcceptableMark;

    public function QuestMapHandler_10226_304(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (!haveBattle) {
            return;
        }
        super.processMapComplete();
        if (QuestManager.isAccepted(10226) && QuestManager.isStepComplete(10226, 2) == false) {
            _map.content.visible = false;
            this.initStep1();
        }
    }

    private function initStep1():void {
        ActorManager.showRemoteActor = false;
        MobileManager.hideMoileVec(MobileType.NPC);
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc2 = _processor.resLib.getMovieClip("mc2");
        this._mc2["xierq"].visible = false;
        _map.front.addChild(this._mc2);
        MovieClipUtil.playMc(this._mc2, 2, this._mc2.totalFrames, function ():void {
            _mack = new AcceptableMark();
            _mack.x = _mc2["xierq"].x + 25;
            _mack.y = _mc2["xierq"].y;
            _mc2.addChild(_mack);
            _mc2["xierq"].visible = true;
            _mc2["xierq"].buttonMode = true;
            _mc2["xierq"].addEventListener(MouseEvent.CLICK, onClick);
        }, true);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc2["xierq"].removeEventListener(MouseEvent.CLICK, this.onClick);
        NpcDialog.show(741, "切希尔", [[0, "NO.48——爱德华，连抓一个王子都用了那么久，真是没用。 "]], [" 不准你们带走赫！"], [function ():void {
            NpcDialog.show(737, "爱德华", [[0, "哥……我还行的……再给我一次机会……"]], [" 哥？!"], [function ():void {
                NpcDialog.show(741, "切希尔", [[0, "爱德华，我来时老大给我的任务有两个：1，抓回赫；2，除掉废物！"]], ["除掉废物！？"], [function ():void {
                    NpcDialog.show(741, "切希尔", [[0, "不过，既然你是我亲弟弟，就当没看见你被打的那么惨吧。可别忘了这份恩情那，哈哈哈哈。"]], ["亲弟弟？"], [function ():void {
                        NpcDialog.show(741, "切希尔", [[0, "好了，该办正事了，来吧炎星的王子，乖乖跟我走。"]], [" 不准抓走赫！"], [function ():void {
                            DisplayUtil.removeForParent(_mack);
                            DisplayUtil.removeForParent(_mc2);
                            initStep2();
                        }]);
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
        this._mc3 = _processor.resLib.getMovieClip("mc3");
        _map.front.addChild(this._mc3);
        MovieClipUtil.playMc(this._mc3, 2, this._mc3.totalFrames, function ():void {
            _mc3.gotoAndStop(1);
            DisplayUtil.removeForParent(_mc3);
            ModuleManager.showModule(URLUtil.getAppModule("HunterQiXierGamePanel"), "正在打开拔保护熊游戏面板...", {"func": gameOver});
        }, true);
    }

    private function gameOver(param1:int):void {
        this.initStep3();
    }

    private function initStep3():void {
        ModuleManager.closeForName("HunterQiXierGamePanel");
        ActorManager.showRemoteActor = false;
        MobileManager.hideMoileVec(MobileType.NPC);
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc4 = _processor.resLib.getMovieClip("mc4");
        this._mc4["star"].visible = false;
        _map.front.addChild(this._mc4);
        MovieClipUtil.playMc(this._mc4, 2, this._mc4.totalFrames, function ():void {
            _mack = new AcceptableMark();
            _mack.x = _mc4["star"].x;
            _mack.y = _mc4["star"].y;
            _mc4.addChild(_mack);
            _mc4["star"].visible = true;
            _mc4["star"].buttonMode = true;
            _mc4["star"].addEventListener(MouseEvent.CLICK, onClick2);
        }, true);
    }

    private function onClick2(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc4["star"].removeEventListener(MouseEvent.CLICK, this.onClick2);
        NpcDialog.show(616, "观星者", [[0, "我是辛迪请来的救兵。噬神界的各位，好久不见了。 "]], ["  观星者！"], [function ():void {
            NpcDialog.show(741, "切希尔", [[0, "观星！没想到连你都来了！看来这次任务变麻烦了呢。"]], [" 你们认识？"], [function ():void {
                NpcDialog.show(616, "观星者", [[0, "NO.47切希尔，你老大和我的交情你也知道。炎星王子现在还不能交给你，回去报告你老大吧。"]], ["是的！赫不能给你！"], [function ():void {
                    NpcDialog.show(741, "切希尔", [[0, "要说你自己和老大说！我只负责完成任务！即使对手是你……"]], ["观星者小心！"], [function ():void {
                        DisplayUtil.removeForParent(_mack);
                        DisplayUtil.removeForParent(_mc4);
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10226_0"), function ():void {
                            QuestManager.addEventListener(QuestEvent.COMPLETE, onStepComplete);
                            QuestManager.completeStep(10226, 2);
                        }, true, true);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    override public function processMapDispose():void {
        MobileManager.showMoileVec(MobileType.NPC);
        ActorManager.showRemoteActor = true;
        ActorManager.getActor().isShow = true;
        ActorManager.getActor().blockNoNo = false;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._mc3);
        DisplayUtil.removeForParent(this._mc2);
        DisplayUtil.removeForParent(this._mc4);
        DisplayUtil.removeForParent(this._mack);
    }
}
}
