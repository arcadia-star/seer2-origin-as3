package com.taomee.seer2.app.processor.quest.handler.story.quest22 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_22_380 extends QuestMapHandler {

    private static var _flghtIndex:int;


    private var _mc_9:MovieClip;

    private var _mc_10:MovieClip;

    private var _mc_11:MovieClip;

    private var _mc_12:MovieClip;

    public function QuestMapHandler_22_380(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id, 5) == false && _flghtIndex == 1) {
            this._mc_12 = _processor.resLib.getMovieClip("mc_12");
            _map.front.addChild(this._mc_12);
            this._mc_12.gotoAndStop(1);
            NpcDialog.show(14, "S", [[1, "嘻嘻……我们来日方长！接下来，就等着看好戏吧……"]], ["站住！！"], [function ():void {
                MovieClipUtil.playMc(_mc_12, 2, _mc_12.totalFrames, function ():void {
                    QuestManager.completeStep(_quest.id, 5);
                    _flghtIndex = 0;
                }, true);
            }]);
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            this.initQuest5();
        }
    }

    private function initQuest5():void {
        this._mc_9 = _processor.resLib.getMovieClip("mc_9");
        _map.front.addChild(this._mc_9);
        this._mc_9.buttonMode = true;
        this._mc_9.gotoAndStop(1);
        this._mc_9.addEventListener(MouseEvent.CLICK, this.onMC9Click);
        this._mc_10 = _processor.resLib.getMovieClip("mc_10");
        _map.front.addChild(this._mc_10);
        this._mc_10.gotoAndStop(1);
    }

    private function onMC9Click(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc_9.removeEventListener(MouseEvent.CLICK, this.onMC9Click);
        NpcDialog.show(51, "兰德", [[1, "蒂萨特你来啦！我等了你好久哦！！"]], ["喂，大家都很担心你！"], [function ():void {
            NpcDialog.show(52, "蒂萨特", [[2, "兰德德……你妈妈很担心你……" + ActorManager.actorInfo.nick + "也是……你怎么到这里来了？"]], ["你妈妈以为蒂萨特把你藏起来了！"], [function ():void {
                NpcDialog.show(51, "兰德", [[1, "嘿嘿……不说这个了，我发现前面那个洞穴里，有很好玩的东西哦！蒂萨特要不要去看看？？"]], ["那里看起来很危险……"], [function ():void {
                    NpcDialog.show(52, "蒂萨特", [[4, "真的吗？是什么是什么？我看看……"]], ["等一下……！"], [function ():void {
                        MovieClipUtil.playMc(_mc_10, 2, _mc_10.totalFrames, function ():void {
                            NpcDialog.show(51, "兰德", [[1, "铁皮，你不去吗？里面很好玩哦！"]], ["不对劲"], [function ():void {
                                NpcDialog.show(51, "兰德", [[1, "什么不对劲？"]], ["你的鲁卜利娃娃呢？", "“无敌探险小队”是什么？"], [function ():void {
                                    NpcDialog.show(51, "兰德", [[1, "什么娃娃？鲁卜利？好难听的名字，哈哈哈。"]], ["……"], [function ():void {
                                        down10();
                                    }]);
                                }, function ():void {
                                    NpcDialog.show(51, "兰德", [[1, "什么乱七八糟的！这种名字，不符合我的审美！"]], ["……"], [function ():void {
                                        down10();
                                    }]);
                                }]);
                            }]);
                        }, true);
                    }]);
                }]);
            }]);
        }]);
    }

    private function down10():void {
        NpcDialog.show(51, "兰德", [[1, "你可能不清楚我这个人的性格，那种难看的东西，难听的名字什么的，我最讨厌了！"]], ["你不是兰德！冒牌货！！"], [function ():void {
            NpcDialog.show(51, "兰德", [[0, "别用这种口气对我说话，难看的铁皮罐头！不过……嘻嘻，目的已经达到了呢！"]], ["……"], [function ():void {
                DisplayUtil.removeForParent(_mc_9);
                _mc_11 = _processor.resLib.getMovieClip("mc_11");
                _map.front.addChild(_mc_11);
                MovieClipUtil.playMc(_mc_11, 2, _mc_11.totalFrames, function ():void {
                    onFight(null);
                }, true);
            }]);
        }]);
    }

    private function onFight(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc_11.removeEventListener(MouseEvent.CLICK, this.onFight);
        _flghtIndex = 1;
        FightManager.startFightWithWild(10, null, function ():void {
            _processor.showMouseHintAt(583, 359);
            _mc_11.buttonMode = true;
            _mc_11.addEventListener(MouseEvent.CLICK, onFight);
        });
    }

    override public function processMapDispose():void {
        _processor.hideMouseClickHint();
        DisplayUtil.removeForParent(this._mc_9);
        DisplayUtil.removeForParent(this._mc_10);
        DisplayUtil.removeForParent(this._mc_11);
        DisplayUtil.removeForParent(this._mc_12);
        this._mc_9 = null;
        this._mc_10 = null;
        this._mc_11 = null;
        this._mc_12 = null;
    }
}
}
