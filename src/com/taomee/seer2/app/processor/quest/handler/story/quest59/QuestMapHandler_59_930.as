package com.taomee.seer2.app.processor.quest.handler.story.quest59 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.map.MapProcessor_930;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_59_930 extends QuestMapHandler {


    private var duoluoDef:NpcDefinition;

    private var duoluoNpc:Mobile;

    private var mark:AcceptableMark;

    private var duoluo:MovieClip;

    private var toBtn:MovieClip;

    private var badi:MovieClip;

    private var phoneCall:MovieClip;

    public function QuestMapHandler_59_930(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        if (this.phoneCall) {
            this.phoneCall.removeEventListener(MouseEvent.CLICK, this.showNpcTalk);
        }
        if (this.toBtn) {
            this.toBtn.removeEventListener(MouseEvent.CLICK, this.showMonsterDia);
        }
        if (this.duoluo) {
            this.duoluo.removeEventListener(MouseEvent.CLICK, this.showDuoDia);
        }
        this.mark = null;
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id) && !QuestManager.isAccepted(_quest.id)) {
            this.initAccept();
        } else if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this.initQuestStep1();
        } else if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            if (SceneManager.prevSceneType == SceneType.ARENA) {
                this.showFightResultDia();
            } else {
                this.initStep2();
            }
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && !QuestManager.isComplete(_quest.id)) {
            this.initStep4();
        }
    }

    private function initStep4():void {
        ActorManager.getActor().show();
        NpcDialog.show(400, "我", [[0, "我怎么回到这里了！巴蒂哪去了？？？"]], [], [function ():void {
            NpcDialog.show(400, "我", [[0, "斯坦因怎么会在这里出现？刚才的机密档案和巴蒂的失踪…这里到底有多少不可告人的秘密…"]], [], [function ():void {
                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                QuestManager.completeStep(59, 4);
            }]);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 59) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        }
    }

    private function showFightResultDia():void {
        var process:MapProcessor_930 = SceneManager.active.mapModel.mapProcessor as MapProcessor_930;
        process.teleport.visible = true;
        NpcDialog.show(519, "奥罗吉尔", [[0, "不要进去呀！我会被主人骂死的……"]], ["一边玩去！别挡路！"], [function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
            QuestManager.completeStep(_quest.id, 2);
        }]);
    }

    private function initAccept():void {
        this.phoneCall = _processor.resLib.getMovieClip("PhoneCall");
        _map.content.addChild(this.phoneCall);
        this.phoneCall.buttonMode = true;
        this.phoneCall.addEventListener(MouseEvent.CLICK, this.showNpcTalk);
    }

    private function showNpcTalk(param1:MouseEvent):void {
        var talkMc:MovieClip = null;
        var event:MouseEvent = param1;
        talkMc = _processor.resLib.getMovieClip("SeerBadiTalk");
        _map.front.addChild(talkMc);
        DisplayObjectUtil.removeFromParent(this.mark);
        DisplayObjectUtil.removeFromParent(this.phoneCall);
        MovieClipUtil.playMc(talkMc, 1, talkMc.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(talkMc);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("59_0"), function ():void {
                QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                QuestManager.accept(_quest.id);
            });
        }, true);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this.initQuestStep1();
        }
    }

    private function initQuestStep1():void {
        this.duoluo = _processor.resLib.getMovieClip("Quest59_Npc_DuoLuo");
        this.badi = _processor.resLib.getMovieClip("Quest59_Npc_Badi");
        this.badi.x = 280;
        this.badi.y = 180;
        this.duoluo.buttonMode = true;
        this.duoluo.x = 120;
        this.duoluo.y = 100;
        this.duoluo.addEventListener(MouseEvent.CLICK, this.showDuoDia);
        this.mark = new AcceptableMark();
        this.mark.x = 200;
        this.mark.y = 160;
        _map.content.addChild(this.mark);
        _map.content.addChild(this.duoluo);
        _map.content.addChild(this.badi);
    }

    private function showDuoDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DisplayObjectUtil.removeFromParent(this.mark);
        NpcDialog.show(11, "多罗", [[0, "老大！大老远叫我们来着么恐怖的地方有什么事呀？"]], [], [function ():void {
            NpcDialog.show(400, "我", [[0, "我总感觉这个地方有些蹊跷，叫你们一起过来研究一下"]], [], [function ():void {
                NpcDialog.show(10, "巴蒂", [[0, "凭我这世界上最聪明的脑袋一定能想得出来，哈哈，你们就听我指挥吧！"]], [], [function ():void {
                    NpcDialog.show(11, "多罗", [[0, "这个地方好阴森呀，我先到处走走看……"]], [], [function ():void {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("59_1"), function ():void {
                            var duoluoLeave:* = undefined;
                            duoluoLeave = _processor.resLib.getMovieClip("Quest59_Npc_DuoLuoLeavel");
                            DisplayObjectUtil.removeFromParent(duoluo);
                            duoluoLeave.gotoAndStop(1);
                            _map.content.addChild(duoluoLeave);
                            NpcDialog.show(10, "巴蒂", [[0, "哈哈哈！胆小鬼！太滑稽了！被这么个小玩意儿就吓得站不起来了！哈哈哈！"]], [], [function ():void {
                                NpcDialog.show(400, "我", [[0, "哈哈哈！看把多罗吓得屁滚尿流的！哈哈！"]], [], [function ():void {
                                    NpcDialog.show(11, "多罗", [[0, "我不是胆小鬼！你们…你们…"]], [], [function ():void {
                                        NpcDialog.show(11, "多罗", [[0, "哼！我一定会证明我是勇士的！哼！你们走着瞧！"]], [], [function ():void {
                                            MovieClipUtil.playMc(duoluoLeave, 1, duoluoLeave.totalFrames, function ():void {
                                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                                                QuestManager.completeStep(_quest.id, 1);
                                            }, true);
                                        }]);
                                    }]);
                                }]);
                            }]);
                        });
                    }]);
                }]);
            }]);
        }]);
    }

    private function onCompleteStep(param1:QuestEvent):void {
        var _loc2_:MouseClickHintSprite = null;
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
            if (param1.stepId == 1) {
                this.initStep2();
            } else if (param1.stepId == 2) {
                _loc2_ = new MouseClickHintSprite();
                _loc2_.x = 503;
                _loc2_.y = 322;
                _map.content.addChild(_loc2_);
            }
        }
    }

    private function initStep2():void {
        if (!this.badi) {
            this.badi = _processor.resLib.getMovieClip("Quest59_Npc_Badi");
        }
        this.badi.x = 280;
        this.badi.y = 180;
        _map.content.addChild(this.badi);
        if (!this.mark) {
            this.mark = new AcceptableMark();
        }
        this.mark.x = 360;
        this.mark.y = 350;
        _map.content.addChild(this.mark);
        this.toBtn = _map.content["to950"];
        this.toBtn.buttonMode = true;
        this.toBtn.addEventListener(MouseEvent.CLICK, this.showMonsterDia, false, 1000);
    }

    private function showMonsterDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this.toBtn.removeEventListener(MouseEvent.CLICK, this.showMonsterDia);
        DisplayObjectUtil.removeFromParent(this.mark);
        NpcDialog.show(519, "奥罗吉尔", [[0, "是谁启动了这里的机关！！！"]], ["谁"], [function ():void {
            NpcDialog.show(519, "奥罗吉尔", [[0, "此山是我开！此树是我栽！要想过此路！留下买路财！"]], ["我们要从这里过去"], [function ():void {
                NpcDialog.show(519, "奥罗吉尔", [[0, "没门！有我在你们就别想过去！哈哈！"]], ["看来只能够武力解决咯！一起上！巴蒂！"], [function ():void {
                    if (PetInfoManager.getFirstPetInfo().hp < 1) {
                        toBtn.addEventListener(MouseEvent.CLICK, showMonsterDia, false, 1000);
                        AlertManager.showAlert("首发精灵体力耗尽");
                    } else {
                        FightManager.startFightWithWild(167);
                    }
                }]);
            }]);
        }]);
    }
}
}
