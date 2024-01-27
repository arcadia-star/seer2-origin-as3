package com.taomee.seer2.app.processor.quest.handler.story.quest21 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_21_500 extends QuestMapHandler {


    private var _angryAnimation:MovieClip;

    private var _leaveAnimation:MovieClip;

    public function QuestMapHandler_21_500(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (_quest.status == QuestStatus.IN_PROGRESS) {
            if (Boolean(_quest.isStepCompete(3)) && !_quest.isStepCompete(4)) {
                this.processStep4();
            }
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
    }

    private function processStep4():void {
        this._angryAnimation = _processor.resLib.getMovieClip("mc_7");
        this._leaveAnimation = _processor.resLib.getMovieClip("mc_8");
        NpcDialog.show(51, "兰德", [[1, "小不点！我来找你玩儿了，介绍一下，这是我的好朋友，蒂萨特！"]], ["（他口中的新朋友原来是伊特？）"], [function ():void {
            NpcDialog.show(52, "蒂萨特", [[0, "你……你好！我叫蒂萨特，你叫什么名字？希望能够和你成为朋友！"]], ["（真希望他们能成为朋友！）"], [function ():void {
                NpcDialog.show(429, "伊特", [[0, "……你难道不知道我是谁？我可是大家最头痛的捣蛋鬼！！"]], ["（这个我最清楚了！）"], [function ():void {
                    MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("21_2"), 2, [[1, 0]], function ():void {
                        NpcDialog.show(429, "伊特", [[0, "就算这样，你还想和我做朋友？？？"]], ["（这都是很久以前的事了嘛！）"], [function ():void {
                            NpcDialog.show(52, "蒂萨特", [[4, "……！"]], ["（喂……）"], [function ():void {
                                NpcDialog.show(51, "兰德", [[4, "……！"]], ["（喂喂……！！）"], [function ():void {
                                    NpcDialog.show(52, "蒂萨特", [[4, "兰德德……！小不点好厉害！"]], ["（喂喂！！你们两个……！）"], [function ():void {
                                        NpcDialog.show(429, "伊特", [[0, "我觉得你们两个比我还像怪胎……好……！我就勉为其难做你的朋友了！"]], ["真是的，你坦率一点嘛！"], [function ():void {
                                            _map.front.addChild(_angryAnimation);
                                            MovieClipUtil.playMc(_angryAnimation, 1, _angryAnimation.totalFrames, function ():void {
                                                NpcDialog.show(53, "兰德妈妈", [[3, "大板牙说的没错，你果然在这里！！"]], ["（好可怕的家长！）"], [function ():void {
                                                    NpcDialog.show(51, "兰德", [[2, "妈妈……我就是想带蒂萨特来见见我的新朋友……"]], ["我保证，他们没有做坏事！"], [function ():void {
                                                        NpcDialog.show(53, "兰德妈妈", [[3, "说什么呢！！兰德，我和你说了多少次，别再和那个沙爪的寒酸小鬼混在一起！！我们地月氏族，怎么能和他们扯上关系？？"]], ["啊……？"], [function ():void {
                                                            NpcDialog.show(53, "兰德妈妈", [[3, "还有！你居然还和这么个捣蛋鬼交上朋友！你的屁股在发痒吗？？跟我回去！！"]], ["……"], [function ():void {
                                                                DisplayObjectUtil.removeFromParent(_angryAnimation);
                                                                _map.front.addChild(_leaveAnimation);
                                                                MovieClipUtil.playMc(_leaveAnimation, 1, _leaveAnimation.totalFrames, function ():void {
                                                                    DisplayObjectUtil.removeFromParent(_leaveAnimation);
                                                                    NpcDialog.show(52, "蒂萨特", [[2, "……呜呜……呜呜呜！！"]], ["兰德妈妈以前也这样吗？"], [function ():void {
                                                                        NpcDialog.show(52, "蒂萨特", [[2, "其实我妈妈也不允许我和兰德一起玩……因为，他们说，沙爪氏族和地月氏族生来就是死对头……只有，吉吉导游对我们好……呜呜……"]], ["怎么会这样……"], [function ():void {
                                                                            NpcDialog.show(429, "伊特", [[0, "别哭了！你就这点胆子？哼，兰德比你勇敢，因为就算屁股被打肿，他还是去找你了！"]], ["的确是！男子汉不哭！"], [function ():void {
                                                                                NpcDialog.show(52, "蒂萨特", [[2, "嗯……嗯！我，我知道了……呜呜……我不哭，我没有哭！"]], ["（地月……沙爪……究竟是什么深仇大恨？）"], [function ():void {
                                                                                    QuestManager.completeStep(_quest.id, 4);
                                                                                }]);
                                                                            }]);
                                                                        }]);
                                                                    }]);
                                                                }, true);
                                                            }]);
                                                        }]);
                                                    }]);
                                                }]);
                                            }, true);
                                        }]);
                                    }]);
                                }]);
                            }]);
                        }]);
                    });
                }]);
            }]);
        }]);
    }
}
}
