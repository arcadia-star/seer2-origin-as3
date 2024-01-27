package com.taomee.seer2.app.processor.quest.handler.story.quest21 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_21_5107 extends QuestMapHandler {

    private static var _isFightQuest:Boolean = false;


    private var _landeAnimation:MovieClip;

    private var _leaveAnimation:MovieClip;

    public function QuestMapHandler_21_5107(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (_quest.status == QuestStatus.IN_PROGRESS) {
            if (Boolean(_quest.isStepCompete(1)) && !_quest.isStepCompete(2)) {
                this.processStep2();
            }
        }
    }

    override public function processMapDispose():void {
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartSuccess);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartError);
        if (this._landeAnimation) {
            this._landeAnimation.removeEventListener(MouseEvent.CLICK, this.onLandeClick);
        }
        super.processMapDispose();
    }

    private function processStep2():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && _isFightQuest) {
            _isFightQuest = false;
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                NpcDialog.show(51, "兰德", [[1, "太好啦！太好啦！我的珍贵的鲁卜利娃娃！！好，我们去乌黑矿坑玩儿吧，那里有很好玩的东西哦！"]], ["臭……（去乌黑矿坑！）"], [function ():void {
                    _leaveAnimation = _processor.resLib.getMovieClip("mc_3");
                    _map.front.addChild(_leaveAnimation);
                    MovieClipUtil.playMc(_leaveAnimation, 1, _leaveAnimation.totalFrames, function ():void {
                        DisplayObjectUtil.removeFromParent(_leaveAnimation);
                        _processor.showMouseHintAt(550, 250);
                        QuestManager.completeStep(_quest.id, 2);
                    }, true);
                }]);
            } else {
                NpcDialog.show(51, "兰德", [[2, "兰德德，还是算了吧……"]], ["不行！（怎么能在孩子面前丢脸？）"]);
            }
        } else {
            this._landeAnimation = _processor.resLib.getMovieClip("mc_4");
            DisplayObjectUtil.enableButtonMode(this._landeAnimation);
            _map.front.addChild(this._landeAnimation);
            this._landeAnimation.addEventListener(MouseEvent.CLICK, this.onLandeClick);
        }
    }

    private function onLandeClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        DisplayObjectUtil.disableButtonMode(this._landeAnimation);
        this._landeAnimation.removeEventListener(MouseEvent.CLICK, this.onLandeClick);
        NpcDialog.show(51, "兰德", [[2, "真气人！那是蒂萨特给我的礼物，居然被那个贪吃鬼吞了下去！"]], ["好好的怎么了呢？"], [function ():void {
            NpcDialog.show(51, "兰德", [[2, "就在刚才，蒂萨特送给我一个鲁卜利娃娃！我没拿稳掉在了地上，结果……被贪吃鬼格尔西克吞了下去！！"]], ["这是什么肠胃啊……"], [function ():void {
                NpcDialog.show(51, "兰德", [[0, "格尔西克是出名的贪吃鬼……不过，它才吃下去没多久，如果用力打它的肚子，应该还能吐出来……"]], [" ……"], [function ():void {
                    NpcDialog.show(52, "蒂萨特", [[2, "帮帮我们吧……好不好？好不好？"]], ["唉，拿你们没办法。"], [function ():void {
                        FightManager.addEventListener(FightStartEvent.START_ERROR, onStartError);
                        FightManager.addEventListener(FightStartEvent.START_SUCCESS, onStartSuccess);
                        FightManager.startFightWithWild(10);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStartSuccess(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartSuccess);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartError);
        _isFightQuest = true;
    }

    private function onStartError(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartSuccess);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartError);
    }
}
}
