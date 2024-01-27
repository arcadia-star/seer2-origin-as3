package com.taomee.seer2.app.processor.quest.handler.branch.quest10139 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10139_124 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    public function QuestMapHandler_10139_124(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.addBird(0);
        }
        if (QuestManager.isStepComplete(_quest.id, 8) && QuestManager.isStepComplete(_quest.id, 9) == false) {
            this.addBird(1);
        }
    }

    private function addBird(param1:int):void {
        this._mc_0 = _processor.resLib.getMovieClip("bird");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        if (param1 == 0) {
            this._mc_0.addEventListener(MouseEvent.CLICK, this.onClickBirdHandler);
        } else {
            this._mc_0.addEventListener(MouseEvent.CLICK, this.onClickBirdAgainHandler);
        }
    }

    private function onClickBirdHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(526, "碧芙莱", [[0, "我是一只孔雀，但是我现在已经没有心情开屏了，族人们太让我失望了。"]], ["孔雀再开一次屏", " 孔雀，孔雀，我只是来看看你"], [function ():void {
            NpcDialog.show(526, "碧芙莱", [[0, "我一直在这里开屏，给氏族的人们带来吉祥，祈祷风调雨顺，可他们……"]], ["（听孔雀讲故事）"], [function ():void {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10139_0"), function ():void {
                    NpcDialog.show(526, "碧芙莱", [[0, "如果族人们改邪归正，他们肯停止战争，做一个象征和平的花环的话我还是愿意再次为族人们开屏祈福的。"]], ["那我先去问问神目酋长吧"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptHandler);
                        QuestManager.accept(_quest.id);
                    }]);
                }, true, false, 2);
            }]);
        }]);
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        SceneManager.changeScene(SceneType.LOBBY, 110);
    }

    private function onClickBirdAgainHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(526, "孔雀", [[0, "孔雀孔雀，我已经找到了象征氏族的花，你可以为他们再次开屏吗？"]], ["（把花给孔雀）"], [function ():void {
            NpcDialog.show(526, "孔雀", [[0, "一堆杂乱的花怎么能代表族人们的诚意呢？除非将它编为美丽的花环。记住，要美丽的花环哟。"]], [" 好的，那我现在就开始编花环了"], [function ():void {
                var _loc1_:* = new Object();
                _loc1_["callBack"] = gameOver;
                ModuleManager.toggleModule(URLUtil.getAppModule("BirdGamePanel"), "正在打开面板...", _loc1_);
            }]);
        }]);
    }

    private function gameOver():void {
        ModuleManager.closeForName("BirdGamePanel");
        NpcDialog.show(526, "孔雀", [[0, "真是美丽的花环啊，看来族人们是真心不再战争了，我愿意再次为他们祈福，送吉祥。"]], ["孔雀，你愿意开屏了吗？"], [function ():void {
            if (_mc_0) {
                DisplayUtil.removeForParent(_mc_0);
            }
            _mc_0 = _processor.resLib.getMovieClip("bird1");
            _map.content.addChild(_mc_0);
            MovieClipUtil.playMc(_mc_0, 1, _mc_0.totalFrames, function ():void {
                NpcDialog.show(526, "孔雀", [[0, "希望世界和平！如果你能弄来更好的花环的话我愿意多开几次屏。"]], ["我们一起去参加凤凰杯种植大赛吧"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onStep9Handler);
                    QuestManager.completeStep(_quest.id, 9);
                }]);
            }, true);
        }]);
    }

    private function onStep9Handler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStep9Handler);
        AlertManager.showAlert("恭喜你获得5个孔雀花种子");
        AlertManager.showAlert("恭喜你获得5个初级肥料");
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep9Handler);
    }
}
}
