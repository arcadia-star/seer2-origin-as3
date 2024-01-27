package com.taomee.seer2.app.processor.quest.handler.branch.quest10117 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.branch.quest10115.QuestMapHandlerDream;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.Tick;

public class QuestMapHandler_10117_1331 extends QuestMapHandlerDream {


    private var falaMc:MovieClip;

    private var yuluMc:MovieClip;

    private var findMc:FindDifferentPanel;

    private var mark:AcceptableMark;

    private var click:MouseClickHintSprite;

    public function QuestMapHandler_10117_1331(param1:QuestProcessor) {
        super(param1);
        _questID = 10117;
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isComplete(_quest.id)) {
            ActorManager.showRemoteActor = false;
            this.falaMc = _processor.resLib.getMovieClip("falaMc");
            this.falaMc.gotoAndStop(1);
            _map.content.addChild(this.falaMc);
            this.mark = new AcceptableMark();
            this.mark.x = 205;
            this.mark.y = 370;
            this.falaMc.addChild(this.mark);
            this.falaMc.buttonMode = true;
        }
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this.initStep1();
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.initStep2();
        }
    }

    private function initStep1():void {
        this.falaMc.addEventListener(MouseEvent.CLICK, this.clickFala);
    }

    private function clickFala(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this.falaMc.removeEventListener(MouseEvent.CLICK, this.clickFala);
        NpcDialog.show(510, "被吓呆的法拉", [[0, "梦话：我是路过这个梦的，我想我还可以被抢救一下，之后我会告诉你这里发生了什么….救救我吧…"]], ["点击法拉，用祝福雨露抢救它"], [function ():void {
            (SceneManager.active as LobbyScene).hideToolbar();
            falaMc.addEventListener(MouseEvent.CLICK, showYulu);
        }]);
    }

    private function showYulu(param1:MouseEvent):void {
        this.falaMc.removeEventListener(MouseEvent.CLICK, this.showYulu);
        if (!this.yuluMc) {
            this.yuluMc = _processor.resLib.getMovieClip("yuluMc");
            this.yuluMc.scaleX = this.yuluMc.scaleY = 1.5;
            this.yuluMc.buttonMode = true;
            this.yuluMc.gotoAndStop(1);
            this.yuluMc.addEventListener(MouseEvent.CLICK, this.clickYulu);
        }
        if (!this.click) {
            this.click = new MouseClickHintSprite();
        }
        this.yuluMc.x = this.mark.x - 10;
        this.yuluMc.y = this.mark.y - 30;
        this.click.x = this.yuluMc.x;
        this.click.y = this.yuluMc.y;
        this.mark.visible = false;
        _map.content.addChild(this.click);
        _map.content.addChild(this.yuluMc);
    }

    private function clickYulu(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this.yuluMc.removeEventListener(MouseEvent.CLICK, this.clickYulu);
        DisplayUtil.removeForParent(this.yuluMc);
        DisplayUtil.removeForParent(this.click);
        MovieClipUtil.playMc(this.falaMc, 1, 58, function ():void {
            falaMc.gotoAndPlay(58);
            mark.visible = true;
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, completeStep1);
            QuestManager.completeStep(10117, 1);
        });
    }

    private function completeStep1(param1:QuestEvent):void {
        if (param1.questId == 10117 && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep1);
            this.initStep2();
        }
    }

    private function initStep2():void {
        this.falaMc.gotoAndPlay(58);
        this.falaMc.addEventListener(MouseEvent.CLICK, this.showDia);
    }

    private function showDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this.falaMc.removeEventListener(MouseEvent.CLICK, this.showDia);
        NpcDialog.show(402, "恢复后的法拉", [[0, "这不是在做梦吧！我感觉好多了！很久很久没有尝过雨露的味道了，祝福雨露千年才会降临一次啊。太谢谢你了。"]], ["你就是在梦啊，不客气，快告诉我这里发生过什么？"], [function ():void {
            (SceneManager.active as LobbyScene).hideToolbar();
            NpcDialog.show(402, "恢复后的法拉", [[0, "好，那就让我带你重新做一遍我刚才路过的这个梦吧！"]], ["重新做梦？看来今天我是陷在梦里了，走吧！"], [function ():void {
                (SceneManager.active as LobbyScene).hideToolbar();
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10117_0"), function ():void {
                    (SceneManager.active as LobbyScene).hideToolbar();
                    showFindPanel();
                });
            }]);
        }]);
    }

    private function showFindPanel():void {
        if (!this.findMc) {
            this.findMc = new FindDifferentPanel(_processor.resLib.getMovieClip("findMc"), this.findComplete);
        }
        this.findMc.init();
        _map.front.addChild(this.findMc);
        Tick.instance.addTimeout(180000, this.NoFind);
    }

    private function NoFind():void {
        this.findMc.dispose();
        this.falaMc.addEventListener(MouseEvent.CLICK, this.againFind);
        Tick.instance.removeTimeout(this.NoFind);
    }

    private function againFind(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this.falaMc.removeEventListener(MouseEvent.CLICK, this.againFind);
        NpcDialog.show(402, "恢复后的法拉", [[0, "再试一次，趁我的梦还没有结束，加油啊！"]], ["嗯！再试一次！"], [function ():void {
            (SceneManager.active as LobbyScene).hideToolbar();
            showFindPanel();
        }]);
    }

    private function findComplete():void {
        Tick.instance.addTimeout(500, this.playfc);
        Tick.instance.removeTimeout(this.NoFind);
    }

    private function playfc():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10117_1"), function ():void {
            (SceneManager.active as LobbyScene).hideToolbar();
            NpcDialog.show(402, "恢复后的法拉", [[0, "你成功了！ “灾难将至，真正的勇者将抵御一切！”是什么意思？雨露，雷伊，梦境……看来要发生大事了，我还是躲到梦里比较好。"]], ["我也预感要出大事了，最近做了好多奇怪的梦呢。"], [function ():void {
                (SceneManager.active as LobbyScene).hideToolbar();
                NpcDialog.show(402, "恢复后的法拉", [[0, "不过还是要谢谢你救了我！现在你该回到你的梦里去了。"]], ["那个——我想说：也谢谢你！这是我第一次梦到雷伊！"], [function ():void {
                    (SceneManager.active as LobbyScene).hideToolbar();
                    NpcDialog.show(402, "恢复后的法拉", [[0, "嘿嘿，不客气，勇敢的小赛尔！后面还有梦在等着你呢。勇者无畏，记住雷伊的话哦。"]], [" 嗯！再见！"], [function ():void {
                        (SceneManager.active as LobbyScene).hideToolbar();
                        showStone();
                    }]);
                }]);
            }]);
        });
    }

    override protected function clickStone(param1:MouseEvent):void {
        stoneMc.removeEventListener(MouseEvent.CLICK, this.clickStone);
        ModuleManager.toggleModule(URLUtil.getAppModule("StonePanel"), "打开中...", {
            "toHome": true,
            "completeQuestId": 10117,
            "completeStep": 2
        });
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.completeStep1);
    }
}
}
