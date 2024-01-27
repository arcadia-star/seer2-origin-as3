package com.taomee.seer2.app.processor.quest.handler.activity.quest30024 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30024_50 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _mcDuoluo:MovieClip;

    private var _mc_1:MovieClip;

    private var _duoluo_npc:Mobile;

    private var _paLaDing_npc:MovieClip;

    public function QuestMapHandler_30024_50(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this.initMc();
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.initNpc(2);
        }
    }

    private function initMc():void {
        this._duoluo_npc = MobileManager.getMobile(1003, MobileType.NPC);
        this._duoluo_npc.visible = false;
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        LayerManager.topLayer.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 2, this._mc_0.totalFrames, function ():void {
            initNpc(1);
        }, true);
    }

    private function onStep1Complete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Complete);
        if (param1.questId == _quest.id && param1.stepId == 1) {
            this.initNpc(2);
        }
    }

    private function onStep2():void {
        SceneManager.changeScene(SceneType.LOBBY, 80);
    }

    private function initNpc(param1:int):void {
        if (param1 == 1) {
            this._mc_0.gotoAndStop(1);
            if (this._mc_0["duoluo"] != null) {
                this._mcDuoluo = this._mc_0["duoluo"];
                this._mcDuoluo.buttonMode = true;
                this._mcDuoluo.addEventListener(MouseEvent.CLICK, this.onDuoluoClick);
            } else {
                this._mc_0.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            }
        } else if (param1 == 2) {
            this._paLaDing_npc = _processor.resLib.getMovieClip("npc_palading");
            _map.front.addChild(this._paLaDing_npc);
            this._paLaDing_npc.buttonMode = true;
            this._paLaDing_npc.addEventListener(MouseEvent.CLICK, this.onClickPalading);
        }
    }

    private function onClickPalading(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._paLaDing_npc.buttonMode = false;
        NpcDialog.show(505, "帕拉丁", [[0, "我是飞船的光之守卫，神秘的某某难道就是失踪的光之守卫队员卡拉尔？！看来斯坦因早已将邪恶的触角伸向了光之守卫队了！"]], ["光之守卫？我怎么从来没有见过？"], [function ():void {
            NpcDialog.show(505, "帕拉丁", [[0, "没时间了！你的问题以后再解答！现在千万不能让神秘的精灵再次落入斯坦因之手！刚刚它应该是向游戏室逃跑了！"]], ["好吧！我绝不允许斯坦因邪恶计划的实施！"], [function ():void {
                onStep2();
            }]);
        }]);
    }

    private function onEnterFrame(param1:Event):void {
        if (this._mc_0["duoluo"] != null) {
            this._mc_0.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this._mcDuoluo = this._mc_0["duoluo"];
            this._mcDuoluo.buttonMode = true;
            this._mcDuoluo.addEventListener(MouseEvent.CLICK, this.onDuoluoClick);
        }
    }

    private function onDuoluoClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mcDuoluo.buttonMode = false;
        this._mcDuoluo.removeEventListener(MouseEvent.CLICK, this.onDuoluoClick);
        this._mc_0.gotoAndStop(2);
        NpcDialog.show(11, "多罗", [[4, "老大你终于来了……这队长还是你来当吧，斯坦因和萨伦要抢走神秘精灵！"]], ["斯坦因又是你从中作梗！"], [function ():void {
            NpcDialog.show(106, "斯坦因", [[1, "桀桀桀！谁也别想阻止我的研究！这个小家伙本来就是属于我的！"]], ["休想！"], [function ():void {
                NpcDialog.show(106, "斯坦因", [[1, "可惜你晚了一步，小家伙已经被我们抓住啦，我的黑化实验就要成功啦！桀桀桀！"]], ["站住！我是不会让你得逞的！"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30024_0"), function ():void {
                        DisplayUtil.removeForParent(_mc_0);
                        _mc_1 = _processor.resLib.getMovieClip("mc_1");
                        _map.front.addChild(_mc_1);
                        MovieClipUtil.playMc(_mc_1, 1, _mc_1.totalFrames, function ():void {
                            DisplayUtil.removeForParent(_mc_1);
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1Complete);
                            QuestManager.completeStep(_quest.id, 1);
                        }, true);
                    });
                }]);
            }]);
        }]);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Complete);
        DisplayUtil.removeForParent(this._mc_0);
        if (this._mcDuoluo != null) {
            this._mcDuoluo.removeEventListener(MouseEvent.CLICK, this.onDuoluoClick);
            this._mcDuoluo = null;
        }
        this._mc_0 = null;
        DisplayUtil.removeForParent(this._mc_1);
        this._mc_1 = null;
        if (this._duoluo_npc != null) {
            this._duoluo_npc.visible = true;
        }
        super.processMapDispose();
    }
}
}
