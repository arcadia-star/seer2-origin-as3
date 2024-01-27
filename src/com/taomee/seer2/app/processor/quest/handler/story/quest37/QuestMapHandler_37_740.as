package com.taomee.seer2.app.processor.quest.handler.story.quest37 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_37_740 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    public function QuestMapHandler_37_740(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initNpc(1);
            this.showDialog();
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.initNpc(2);
            this.showDialog2();
        }
    }

    private function initNpc(param1:int):void {
        if (param1 == 1) {
            this._mc_0 = _processor.resLib.getMovieClip("mc_0_0");
        } else {
            this._mc_0 = _processor.resLib.getMovieClip("mc_0_1");
        }
        _map.front.addChild(this._mc_0);
    }

    private function showDialog():void {
        NpcDialog.show(95, "克莉斯蒂", [[1, "哇，两大兵团长的皮肤保养的那么好呀？！用的是什么牌子的化妆品？是从别的星球带来的吗？"]], ["……"], [function ():void {
            NpcDialog.show(80, "葛雷芬兵团长", [[0, "化妆品？那是什么？"]], ["……"], [function ():void {
                NpcDialog.show(83, "萨伯尔兵团长", [[0, "果然是个战斗机器啊，这种生活情趣的事情居然一窍不通！"]], ["……"], [function ():void {
                    NpcDialog.show(95, "克莉斯蒂", [[1, "呀哈哈哈……葛雷芬兵团长很天然呀……"]], ["……"], [function ():void {
                        _mc_1 = _processor.resLib.getMovieClip("mc_1");
                        _map.front.addChild(_mc_1);
                        MovieClipUtil.playMc(_mc_1, 1, _mc_1.totalFrames, function ():void {
                            DisplayUtil.removeForParent(_mc_1);
                            NpcDialog.show(97, "财务官", [[1, "呵——呵——呵——飞翼氏族的财力和才力您都大可放心！"]], ["（他边上那个人是谁啊？鬼鬼祟祟的感觉……）"], [function ():void {
                                NpcDialog.show(101, "神秘人", [[0, "哼。能不能放心，要看了才知道。确定没有人察觉么？（超小声，但是赛尔的听力是非常强大的，所以还是听见了）"]], ["（察觉什么东西？？）"], [function ():void {
                                    NpcDialog.show(97, "财务官", [[1, "阁下放心，对于变态的税收，大家也只有服从而已。毕竟我的身份放在那里……"]], ["……（我是不是听到了什么不该听的东西？）"], [function ():void {
                                        _mc_2 = _processor.resLib.getMovieClip("mc_2");
                                        _map.front.addChild(_mc_2);
                                        MovieClipUtil.playMc(_mc_2, 1, _mc_2.totalFrames, function ():void {
                                            DisplayUtil.removeForParent(_mc_2);
                                            NpcDialog.show(95, "克莉斯蒂", [[1, "真是愉快的茶会啊！使者大人，享受你的好时光了吗？"]], ["（基本都忙着偷听别人说话……）"], [function ():void {
                                                NpcDialog.show(97, "财务官", [[1, "那么阁下，今天就谈到这里，等我的好消息吧。"]], ["（总觉得他们有什么阴谋）"], [function ():void {
                                                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("37_1"), function ():void {
                                                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                                                        QuestManager.completeStep(_quest.id, 1);
                                                    }, true, false, 2);
                                                }]);
                                            }]);
                                        }, true);
                                    }]);
                                }]);
                            }]);
                        }, true);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        if (param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            DisplayUtil.removeForParent(this._mc_0);
            this._mc_0 = _processor.resLib.getMovieClip("mc_0_1");
            _map.front.addChild(this._mc_0);
            this.showDialog2();
        }
    }

    private function showDialog2():void {
        NpcDialog.show(83, "萨伯尔兵团长", [[0, "你什么都不用问，星际使者。事情和你想象得差不多。"]], ["我还什么都没说呢……"], [function ():void {
            NpcDialog.show(80, "葛雷芬兵团长", [[0, "背叛者……决不轻饶……！"]], ["你是说，他……他……背叛？？"], [function ():void {
                NpcDialog.show(83, "萨伯尔兵团长", [[0, "别那么快下定论！我们还在观测中。其实总督大人已经意识到不对劲了，所以才特批使者大人进入岛内。"]], ["原来是这样？……"], [function ():void {
                    NpcDialog.show(83, "萨伯尔兵团长", [[0, "是的。所以，我们希望使者大人能够暗中协助我们……倘若一日真相大白，定会重重感谢！！"]], ["我不用酬劳，我只需要真相！！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                        QuestManager.completeStep(_quest.id, 2);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (37 == param1.questId) {
            DisplayUtil.removeForParent(this._mc_0);
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._mc_0);
        DisplayUtil.removeForParent(this._mc_1);
        DisplayUtil.removeForParent(this._mc_2);
        this._mc_0 = null;
        this._mc_1 = null;
        this._mc_2 = null;
    }
}
}
