package com.taomee.seer2.app.processor.quest.handler.activity.quest30024 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.FightVerifyManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_30024_80 extends QuestMapHandler {

    private static var _fightIndex:int = 0;


    private var _npc30024:MovieClip;

    private var _palading_npc:MovieClip;

    private var _moumou_npc:MovieClip;

    private var _mobileYiwa:Mobile;

    private var _mobilePang:Mobile;

    public function QuestMapHandler_30024_80(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false && _fightIndex == 1) {
            _fightIndex = 0;
            this.afterFight();
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.initMc();
            this.initEvent();
            this._mobileYiwa = MobileManager.getMobile(1001, MobileType.NPC);
            this._mobileYiwa.visible = false;
            this._mobilePang = MobileManager.getMobile(468, MobileType.NPC);
            this._mobilePang.visible = false;
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isStepComplete(_quest.id, 3)) {
            this.initMc();
            this.initStep2Npc();
        }
    }

    private function initMc():void {
        this.createNewNpcs();
    }

    private function createNewNpcs():void {
        this._npc30024 = _processor.resLib.getMovieClip("Npc_30024");
        this._palading_npc = this._npc30024["npc0"] as MovieClip;
        (this._palading_npc["wenhao"] as MovieClip).visible = false;
        this._moumou_npc = this._npc30024["npc1"] as MovieClip;
        this._npc30024.x = 222;
        this._npc30024.y = 300;
        _map.front.addChild(this._npc30024);
    }

    private function initEvent():void {
        this._moumou_npc.buttonMode = true;
        this._moumou_npc.addEventListener(MouseEvent.CLICK, this.onClickNpc1);
    }

    private function onClickNpc1(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._moumou_npc.buttonMode = false;
        (this._moumou_npc["wenhao"] as MovieClip).visible = false;
        this._moumou_npc.removeEventListener(MouseEvent.CLICK, this.onClickNpc1);
        NpcDialog.show(503, "神秘的某某", [[0, "你们是斯坦因派来抓我的吗！我不会再跟你们走的！斯坦因……绝对是个既恐怖有邪恶的大坏人……"]], ["别怕！我们是来保护你的！"], [function ():void {
            NpcDialog.show(503, "神秘的某某", [[0, "真是吗？刚才我以为我又要被抓去进行那些可怕的实验了。"]], ["斯坦因究竟对你做了什么？"], [function ():void {
                NpcDialog.show(503, "神秘的某某", [[0, "那是一段最可怕的回忆……"]], ["我有一种不祥的预感。"], [function ():void {
                    MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30024_0"), 5, [[1, 0]], function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep2Complete);
                        QuestManager.completeStep(_quest.id, 2);
                    });
                }]);
            }]);
        }]);
    }

    private function onStep2Complete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Complete);
        if (param1.questId == _quest.id && param1.stepId == 2) {
            this.initStep2Npc();
        }
    }

    private function initStep2Npc():void {
        (this._moumou_npc["wenhao"] as MovieClip).visible = false;
        (this._palading_npc["wenhao"] as MovieClip).visible = true;
        this._palading_npc.buttonMode = true;
        this._palading_npc.addEventListener(MouseEvent.CLICK, this.onClickKalaer);
    }

    private function onClickKalaer(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        (this._palading_npc["wenhao"] as MovieClip).visible = false;
        NpcDialog.show(503, "卡拉尔", [[0, "我看到自己现在这副模样，再也没有勇气回归从前的光之守卫队了……呜呜呜……"]], ["可恶的斯坦因！"], [function ():void {
            NpcDialog.show(505, "帕拉丁", [[0, "原来你就是一个月前失踪的光之守卫卡拉尔！但你已经被斯坦因黑化，不可能再做回光之守卫者了。"]], [], [function ():void {
                NpcDialog.show(503, "卡拉尔", [[0, "呜呜呜…可怕的斯坦因…他毁了我的一切…"]], [], [function ():void {
                    NpcDialog.show(505, "帕拉丁", [[0, "但斯坦因并没有改变你的信仰！你的内心仍然坚持正义！向我们展现一下你被黑化的力量吧，我有预感，今后我们会遇到更多的黑暗。"]], [], [function ():void {
                        NpcDialog.show(503, "卡拉尔", [[0, "来吧，即使我变成了暗影系，我同样会站在正义的一边！"]], ["来吧！"], [function ():void {
                            fighting();
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function fighting():void {
        if (FightVerifyManager.validateFightStart()) {
            _fightIndex = 1;
            FightManager.startFightWithWild(130);
        }
    }

    private function afterFight():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30024_1"), function ():void {
            QuestManager.completeStep(_quest.id, 3);
        }, true);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Complete);
        if (this._palading_npc != null) {
            this._palading_npc.removeEventListener(MouseEvent.CLICK, this.onClickKalaer);
            this._palading_npc = null;
        }
        if (this._moumou_npc != null) {
            this._moumou_npc.removeEventListener(MouseEvent.CLICK, this.onClickNpc1);
            this._moumou_npc = null;
        }
        this._npc30024 = null;
        super.processMapDispose();
    }
}
}
