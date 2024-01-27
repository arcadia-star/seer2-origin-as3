package com.taomee.seer2.app.processor.quest.handler.branch.quest10135 {
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
import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10135_891 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    public function QuestMapHandler_10135_891(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.addFeetMC();
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.addAllMC();
            this.addTalk();
        }
    }

    private function addFeetMC():void {
        this._mc_0 = _processor.resLib.getMovieClip("feet");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.onClickFeetHandler);
    }

    private function onClickFeetHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10135_0"), function ():void {
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "这……这是哪？"]], ["我得好好想想这是哪里……", "我一会再来"], [function ():void {
                _mc_1 = _processor.resLib.getMovieClip("QA");
                _map.front.addChild(_mc_1);
                QAPanel();
            }]);
        }, false, false, 2);
    }

    private function QAPanel():void {
        var ansA:MovieClip = null;
        var ansB:MovieClip = null;
        var ansC:MovieClip = null;
        var close_Btn:SimpleButton = null;
        ansA = this._mc_1["radioA"];
        ansB = this._mc_1["radioB"];
        ansC = this._mc_1["radioC"];
        close_Btn = this._mc_1["closeBtn"];
        ansA.buttonMode = true;
        ansB.buttonMode = true;
        ansC.buttonMode = true;
        ansA.gotoAndStop(1);
        ansB.gotoAndStop(1);
        ansC.gotoAndStop(1);
        ansA.addEventListener(MouseEvent.CLICK, function ():void {
            ansA.gotoAndStop(2);
            QAWrong();
        });
        ansB.addEventListener(MouseEvent.CLICK, function ():void {
            ansB.gotoAndStop(2);
            QAWrong();
        });
        ansC.addEventListener(MouseEvent.CLICK, function ():void {
            ansC.gotoAndStop(2);
            QARight();
        });
        close_Btn.addEventListener(MouseEvent.CLICK, function ():void {
            if (_mc_1) {
                DisplayUtil.removeForParent(_mc_1);
            }
        });
    }

    private function QAWrong():void {
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        NpcDialog.show(14, "S", [[0, "总算遇到一个比我还路盲的家伙了……得了得了！你再好好想想吧！"]], ["想想就想想……", "我一会再来"], [function ():void {
            _mc_1 = _processor.resLib.getMovieClip("QA");
            _map.front.addChild(_mc_1);
            QAPanel();
        }]);
    }

    private function QARight():void {
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        QuestManager.accept(_quest.id);
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        SceneManager.changeScene(SceneType.LOBBY, 770);
    }

    private function addAllMC():void {
        this._mc_0 = _processor.resLib.getMovieClip("all");
        _map.content.addChild(this._mc_0);
    }

    private function addTalk():void {
        this._mc_1 = _processor.resLib.getMovieClip("talk1");
        _map.front.addChild(this._mc_1);
        MovieClipUtil.playMc(this._mc_1, 1, this._mc_1.totalFrames, function ():void {
            if (_mc_0) {
                DisplayUtil.removeForParent(_mc_0);
            }
            _mc_0 = _processor.resLib.getMovieClip("fight");
            _map.content.addChild(_mc_0);
            MovieClipUtil.playMc(_mc_0, 1, _mc_0.totalFrames, function ():void {
                if (_mc_0) {
                    DisplayUtil.removeForParent(_mc_0);
                }
                if (_mc_1) {
                    DisplayUtil.removeForParent(_mc_1);
                }
                _mc_1 = _processor.resLib.getMovieClip("xiang");
                _map.content.addChild(_mc_1);
                NpcDialog.show(521, "神笔马良", [[0, "橡皮神君……是哦！我的世界里似乎是少了什么……不知道这家伙……"]], ["（思考ING）"], [function ():void {
                    NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "晚了！他们都坐南瓜飞艇前往萨伦帝国的飞船了！根本没入口前往！ "]], ["磨磨蹭蹭什么！"], [function ():void {
                        NpcDialog.show(521, "神笔马良", [[0, "这这这……是你求我去救那家伙的哦！可不是我自己想的哦！不就个飞艇嘛！看我的！！"]], ["（嗖嗖嗖……）"], [function ():void {
                            if (_mc_0) {
                                DisplayUtil.removeForParent(_mc_0);
                            }
                            if (_mc_1) {
                                DisplayUtil.removeForParent(_mc_1);
                            }
                            _mc_2 = _processor.resLib.getMovieClip("nangua");
                            _map.content.addChild(_mc_2);
                            MovieClipUtil.playMc(_mc_2, 1, _mc_2.totalFrames, function ():void {
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep2Complete);
                                QuestManager.completeStep(_quest.id, 2);
                            }, true);
                        }]);
                    }]);
                }]);
            }, true);
        }, true);
    }

    private function onStep2Complete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Complete);
        SceneManager.changeScene(SceneType.LOBBY, 870);
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        if (this._mc_2) {
            DisplayUtil.removeForParent(this._mc_2);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Complete);
    }
}
}
