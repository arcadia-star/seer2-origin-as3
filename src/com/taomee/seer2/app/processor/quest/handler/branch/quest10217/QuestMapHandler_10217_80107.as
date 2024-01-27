package com.taomee.seer2.app.processor.quest.handler.branch.quest10217 {
import com.taomee.seer2.app.animationInteractive.Quest10217TurnTable;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10217_80107 extends QuestMapHandler {


    private var _turnTable:Quest10217TurnTable;

    private var _mc1:MovieClip;

    private var _count:uint = 0;

    public function QuestMapHandler_10217_80107(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10217) && QuestManager.isStepComplete(10217, 1) == false) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        this._mc1 = _processor.resLib.getMovieClip("mc1");
        _map.content.addChild(this._mc1);
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "我们还是慢了一步，看样子，萨伦帝国的人已经找到了库贝萨。"]], ["这下危险了……"], [function ():void {
            NpcDialog.show(684, "汤姆斯邦", [[0, "既然这样，我们必须做好充足的准备，来应对可怕的黑暗联盟。"]], ["是的，可以准备起来了！"], [function ():void {
                NpcDialog.show(684, "汤姆斯邦", [[0, "现在天马骑士团的成员们还在恢复中，暂时不能让他们出马。"]], ["那怎么办呢？"], [function ():void {
                    NpcDialog.show(684, "汤姆斯邦", [[0, "事到如今也许只能靠他了。"]], ["谁？"], [function ():void {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10217_1"), function ():void {
                            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "哇，好MAN啊~"]], ["那他现在在哪里呢？"], [function ():void {
                                NpcDialog.show(684, "汤姆斯邦", [[0, "他现在应该已经潜伏到萨伦帝国去了吧。"]], ["这么效率？"], [function ():void {
                                    NpcDialog.show(684, "汤姆斯邦", [[0, "那是，我告诉你现在的坐标，你快去找他吧。"]], ["好的，我现在就去。"], [function ():void {
                                        _turnTable = new Quest10217TurnTable();
                                        playGame();
                                    }]);
                                }]);
                            }]);
                        }, true, true);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        SceneManager.changeScene(SceneType.COPY, 80108);
    }

    private function playGame():void {
        this._turnTable.setup("quest10217Game", function (param1:Boolean):void {
            var isSuccess:Boolean = param1;
            ++_count;
            if (isSuccess || _count >= 3) {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                QuestManager.completeStep(10217, 1);
            } else {
                NpcDialog.show(684, "汤姆斯邦", [[0, "游戏失败了，要不要再试一次呢？"]], ["我再试一次。", "不玩了，下次再来！"], [function ():void {
                    playGame();
                }, function ():void {
                    _mc1.buttonMode = true;
                    _mc1.addEventListener(MouseEvent.CLICK, onClickMC);
                }]);
            }
        });
    }

    private function onClickMC(param1:MouseEvent):void {
        this._mc1.buttonMode = false;
        this._mc1.removeEventListener(MouseEvent.CLICK, this.onClickMC);
        this.playGame();
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        this._turnTable = null;
        if (this._mc1) {
            this._mc1.buttonMode = false;
            this._mc1.removeEventListener(MouseEvent.CLICK, this.onClickMC);
        }
        DisplayUtil.removeForParent(this._mc1);
        this._mc1 = null;
        super.processMapDispose();
    }
}
}
