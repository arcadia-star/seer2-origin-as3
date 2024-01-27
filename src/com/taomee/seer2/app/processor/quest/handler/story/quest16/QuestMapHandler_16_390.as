package com.taomee.seer2.app.processor.quest.handler.story.quest16 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_16_390 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    public function QuestMapHandler_16_390(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) == false && QuestManager.isCanAccepted(_quest.id)) {
            this._mc_0 = _processor.resLib.getMovieClip("mc_0");
            _map.front.addChild(this._mc_0);
            MovieClipUtil.playMc(this._mc_0, 1, 56, function ():void {
                _mc_0.buttonMode = true;
                _mc_0.addEventListener(MouseEvent.CLICK, onShowAnimation);
            }, true);
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isComplete(_quest.id) == false) {
            _processor.showMouseHintAt(146, 447);
        }
    }

    private function onShowAnimation(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc_0.removeEventListener(MouseEvent.CLICK, this.onShowAnimation);
        NpcDialog.show(46, "居民", [[0, "我要搬家！这里已经不安全了！对了，我要赶紧回去和孩子他妈说，我藏了几袋子珠宝在沙发下，别忘了带走……！"]], ["发生什么事情了……"], [function ():void {
            NpcDialog.show(46, "居民", [[2, "布条！布条居然自己在走路！太可怕了啊啊啊！怪物啊！"]], ["冷静点……"], [function ():void {
                MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("16_0"), 3, [[1, 0]], function ():void {
                    NpcDialog.show(11, "多罗", [[2, "队长，我们赶快逃走吧……糟糕！我那袋赛尔豆藏哪儿了？这种时候我居然忘记了！！"]], ["你就别添乱了！"], [function ():void {
                        NpcDialog.show(46, "居民", [[0, "不过，我当时本能地揍了它一顿，它往沙爪氏族的方向去了……"]], ["呃……先去三八跑道线（沙）看看吧"], [function ():void {
                            DisplayUtil.removeForParent(_mc_0);
                            _mc_0 = null;
                            _mc_1 = _processor.resLib.getMovieClip("mc_1");
                            _map.front.addChild(_mc_1);
                            MovieClipUtil.playMc(_mc_1, 1, _mc_1.totalFrames, function ():void {
                                QuestManager.addEventListener(QuestEvent.ACCEPT, onQuestAccept);
                                QuestManager.accept(_quest.id);
                            }, true);
                        }]);
                    }]);
                });
            }]);
        }]);
    }

    private function onQuestAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
            _processor.showMouseHintAt(146, 447);
        }
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._mc_0);
        this._mc_0 = null;
        DisplayUtil.removeForParent(this._mc_1);
        this._mc_1 = null;
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
        _processor.hideMouseClickHint();
    }
}
}
