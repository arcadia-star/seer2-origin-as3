package com.taomee.seer2.app.processor.quest.handler.story.quest21 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_21_470 extends QuestMapHandler {


    private var _firstInAnimation:MovieClip;

    private var _leaveAnimation:MovieClip;

    private var _jijiNpc:Mobile;

    public function QuestMapHandler_21_470(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (_quest.status == QuestStatus.IN_PROGRESS) {
            if (!_quest.isStepCompete(1)) {
                this.prcessStep1();
            }
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
    }

    private function prcessStep1():void {
        this._firstInAnimation = _processor.resLib.getMovieClip("mc_2");
        this._leaveAnimation = _processor.resLib.getMovieClip("mc_2_0");
        this._jijiNpc = MobileManager.getMobile(45, MobileType.NPC);
        this._jijiNpc.visible = false;
        _map.front.addChild(this._firstInAnimation);
        MovieClipUtil.playMc(this._firstInAnimation, 1, this._firstInAnimation.totalFrames, function ():void {
            NpcDialog.show(45, "吉吉导游", [[0, "喂，你们两个小鬼么又来了？快回去！回去！去！"]], ["……"], [function ():void {
                NpcDialog.show(51, "兰德", [[1, "吉吉！看我们“无敌探险小队”现在已经有3个人了！厉害吧！"]], ["（还真的把我算进去了……）"], [function ():void {
                    NpcDialog.show(45, "吉吉导游", [[0, "咳！要过我这一关，就要回答我的问题！只有聪明的孩子才能继续前进！继续前进！前进！进！"]], ["这简单，出题吧！"], [function ():void {
                        playNpcTalk();
                    }]);
                }]);
            }]);
        }, true);
    }

    private function playNpcTalk():void {
        MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("21_0"), 4, [[1, 0]], function ():void {
            NpcDialog.show(45, "吉吉导游", [[0, "那少了的1块究竟去哪里了呢？去哪里了呢？哪里呢？"]], ["再说一遍！", "我知道了！"], [playNpcTalk, function ():void {
                NpcDialog.show(51, "兰德", [[1, "哇新来的你好厉害！快说说为什么？我怎么算都少了1块！"]], ["哼哼……"], [function ():void {
                    NpcDialog.show(52, "蒂萨特", [[2, "是不是被怪物抢走了……？其实那个服务生是怪物……是吧，兰德德？"]], ["不是啦……"], [function ():void {
                        playNpcAnswer();
                    }]);
                }]);
            }]);
        });
    }

    private function playNpcAnswer():void {
        NpcDialog.show(45, "吉吉导游", [[4, "你有答案了？！来，说给我听听！！"]], ["1块在老板那里！", "1块在服务生那里！", "根本没有这1块！"], [function ():void {
            NpcDialog.show(51, "兰德", [[0, "不可能！老板损失最多，他摸出了5块呢！"]], ["呃，我再想想……"], [playNpcAnswer]);
        }, function ():void {
            NpcDialog.show(52, "蒂萨特", [[2, "服务生真的是怪物吧……？"]], ["呃，我再想想……"], [playNpcAnswer]);
        }, function ():void {
            NpcDialog.show(45, "吉吉导游", [[4, "原因是什么？！"]], ["哼哼，听好了！"], [function ():void {
                MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("21_1"), 1, [[1, 0]], function ():void {
                    NpcDialog.show(45, "吉吉导游", [[4, "兰德、蒂萨特，你们的新朋友很聪明！既然答对了问题，就去玩儿吧！但是要早点回家，别让爸爸妈妈担心，知道吗？"]], [" 知道了！"], [function ():void {
                        NpcDialog.show(51, "兰德", [[1, "下一站，地道之路！！"]], ["（去地道之路！）"], [function ():void {
                            DisplayObjectUtil.removeFromParent(_firstInAnimation);
                            _map.front.addChild(_leaveAnimation);
                            MovieClipUtil.playMc(_leaveAnimation, 1, _leaveAnimation.totalFrames, function ():void {
                                _jijiNpc.visible = true;
                                DisplayObjectUtil.removeFromParent(_leaveAnimation);
                                QuestManager.completeStep(_quest.id, 1);
                                _processor.showMouseHintAt(-30, 300);
                            }, true);
                        }]);
                    }]);
                });
            }]);
        }]);
    }
}
}
