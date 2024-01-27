package com.taomee.seer2.app.processor.quest.handler.story.quest51 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_51_640 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    private var _mc_3:MovieClip;

    private var _fightStatus:Boolean;

    public function QuestMapHandler_51_640(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.initNpc();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            if (this._fightStatus) {
                this.initMC();
            } else {
                this.initNpcAgain();
            }
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this.initAllNpc();
        }
    }

    private function initNpc():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_5");
        _map.front.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
            var _loc1_:MovieClip = _mc_0["tiff"];
            _loc1_.buttonMode = true;
            _loc1_.addEventListener(MouseEvent.CLICK, TifflunTalkHandler);
        }, true);
    }

    private function TifflunTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(114, "蒂芙伦", [[0, "看我没说错吧，酋长大人真的在这里。"]], ["你们不是有冰后么，怎么又多出来个酋长？"], [function ():void {
            NpcDialog.show(123, "文森特", [[0, "内外的琐事，她并不擅长打理，所以特别委托了一个优秀的族人来代理酋长的职务。"]], ["我大概懂了，要不先把酋长救出来吧！"], [function ():void {
                NpcDialog.show(122, "派瑞", [[0, "没有詹姆斯不行……这本来就是族人和精灵的合唱曲目，只有在内心深处将友爱之情融会贯通才会产生意想不到的力量……！"]], ["你们就先试试看，救人要紧！"], [function ():void {
                    if (_mc_0) {
                        DisplayUtil.removeForParent(_mc_0);
                    }
                    _mc_1 = _processor.resLib.getMovieClip("mc_6");
                    _map.front.addChild(_mc_1);
                    MovieClipUtil.playMc(_mc_1, 1, _mc_1.totalFrames, function ():void {
                        NpcDialog.show(49, "冰沁酋长", [[0, "没想到真的会有一天被这熟悉的歌声唤醒。"]], ["太好了酋长！这样，冰沁氏族可以再次发展起来了！"], [function ():void {
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepTwoHandler);
                            QuestManager.completeStep(_quest.id, 2);
                        }]);
                    }, true);
                }]);
            }]);
        }]);
    }

    private function onStepTwoHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepTwoHandler);
        this.BossTalk();
    }

    private function initNpcAgain():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_7");
        _map.front.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.onBossTalkHandler);
        this._mc_1 = _processor.resLib.getMovieClip("mc_8");
        _map.content.addChild(this._mc_1);
    }

    private function onBossTalkHandler(param1:MouseEvent):void {
        this.BossTalk();
    }

    private function BossTalk():void {
        NpcDialog.show(49, "冰沁酋长", [[0, "不论如何还是要感谢你们，派瑞，詹姆斯，还有……这位女士，你是谁？谢谢你的帮助。"]], ["不会吧，酋长也不认识蒂芙伦？"], [function ():void {
            NpcDialog.show(122, "派瑞", [[3, "詹姆斯被你藏起来了对吧！那个走音的音调我是不会听错的！"]], ["的确，刚才在营救酋长的时候……"], [function ():void {
                NpcDialog.show(114, "蒂芙伦", [[1, "冰系的宠物拥有极其坚强的心灵，就如同你们那位精灵王的心脏一般，这点我早有耳闻，也难怪如此难以控制……"]], ["……？！"], [function ():void {
                    NpcDialog.show(114, "蒂芙伦", [[1, "不过，博士的黑化研究也已经登峰造极……如果你们想见詹姆斯，我就成全你们吧！"]], ["！！！"], [function ():void {
                        if (_mc_0) {
                            DisplayUtil.removeForParent(_mc_0);
                        }
                        if (_mc_1) {
                            DisplayUtil.removeForParent(_mc_1);
                        }
                        _mc_2 = _processor.resLib.getMovieClip("mc_9");
                        _map.front.addChild(_mc_2);
                        MovieClipUtil.playMc(_mc_2, 1, _mc_2.totalFrames, function ():void {
                            var _loc1_:* = _mc_2["tiff"];
                            _loc1_.buttonMode = true;
                            _loc1_.addEventListener(MouseEvent.CLICK, FightTifflunHandler);
                            _fightStatus = true;
                            FightManager.startFightWithWild(112);
                        }, true);
                    }]);
                }]);
            }]);
        }]);
    }

    private function FightTifflunHandler(param1:MouseEvent):void {
        this._fightStatus = true;
        FightManager.startFightWithWild(112);
    }

    private function initMC():void {
        if (this._mc_2) {
            DisplayUtil.removeForParent(this._mc_2);
            this._mc_2 = null;
        }
        this._mc_2 = _processor.resLib.getMovieClip("mc_10");
        _map.front.addChild(this._mc_2);
        MovieClipUtil.playMc(this._mc_2, 1, this._mc_2.totalFrames, function ():void {
            NpcDialog.show(122, "派瑞", [[1, "太好啦詹姆斯！你安然无恙！！"]], ["原来詹姆斯被S抓走了！蒂芙伦是S变的！"], [function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "大家听我说，S是萨伦帝国的人，擅长变身！她变成冰沁族人一直潜伏在你们周围！"]], ["但是她帮助你们一一解封的原因是什么咧……"], [function ():void {
                    NpcDialog.show(14, "S", [[1, "哦——呵呵呵，告诉你们也无妨。我们在寻找冰系的守护兽，然后用博士特别研发的胶囊去收服它！不管它是不是愿意都必须服从！"]], ["就像波利和詹姆斯一样？！"], [function ():void {
                        NpcDialog.show(14, "S", [[1, "铁皮，我一直都喜欢聪明人。我们一直以为守护兽会在那个被诅咒的神殿里，甚至牺牲了很多杂兵去侦查，不过，看来它就在这里！"]], ["就在这里？难道是……"], [function ():void {
                            NpcDialog.show(14, "S", [[1, "那不就是吗？？呵呵，当年那个妖怪精灵的暴风雪冰冻了所有生灵，包括守护兽在内。不过，已经有破解方法了，就是你们的愚蠢的歌声！"]], ["我们不会配合你的！"], [function ():void {
                                _mc_3 = _processor.resLib.getMovieClip("mc_11");
                                _map.front.addChild(_mc_3);
                                MovieClipUtil.playMc(_mc_3, 1, _mc_3.totalFrames, function ():void {
                                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepThreeHandler);
                                    QuestManager.completeStep(_quest.id, 3);
                                }, true);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }, true);
    }

    private function onStepThreeHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepThreeHandler);
        this.XiuNpcTalk();
    }

    private function initAllNpc():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_12");
        _map.front.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.onBadManTalkHandler);
        this._mc_1 = _processor.resLib.getMovieClip("mc_13");
        _map.front.addChild(this._mc_1);
    }

    private function onBadManTalkHandler(param1:MouseEvent):void {
        this.XiuNpcTalk();
    }

    private function XiuNpcTalk():void {
        NpcDialog.show(13, "阿修", [[1, "我从来都不担心你们不配合。我只怕你们太快妥协反而减少了我的乐趣。"]], ["阿修！"], [function ():void {
            NpcDialog.show(122, "派瑞", [[3, "你真以为我们会配合你吗？就算动用武力，就算付出生命！我们都会守护最重要的东西！"]], ["对！你们永远都不会得逞！"], [function ():void {
                NpcDialog.show(486, "詹姆斯", [[3, "嗷呜呜呜呜呜呜呜！！！！=。=#"]], ["詹姆斯也会奋战到底的！（我怎么突然能听懂了）"], [function ():void {
                    NpcDialog.show(49, "冰沁酋长", [[0, "冰沁氏族的族人从来都不惧怕为了守卫家园而牺牲。就像卡尼娅唤来暴风雪时一样……背负痛苦，却无比自豪"]], ["（嗯？有隐情！！）"], [function ():void {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("51_0"), function ():void {
                            if (_mc_0) {
                                DisplayUtil.removeForParent(_mc_0);
                            }
                            if (_mc_1) {
                                DisplayUtil.removeForParent(_mc_1);
                            }
                            if (_mc_2) {
                                DisplayUtil.removeForParent(_mc_2);
                            }
                            if (_mc_3) {
                                DisplayUtil.removeForParent(_mc_3);
                            }
                            _mc_0 = _processor.resLib.getMovieClip("mc_14");
                            _map.front.addChild(_mc_0);
                            NpcDialog.show(122, "派瑞", [[0, "沁灵兽没有被冰冻束缚？？当年卡尼娅的暴风雪不是冻住了我们所有人吗？连冰后也……"]], ["而且，卡尼娅为什么要背叛大家呢？"], [function ():void {
                                NpcDialog.show(49, "冰沁酋长", [[0, "不，卡尼娅并没有背叛我们。事已至此，我想我应该告诉你们了。"]], ["到底是怎么回事呢？"], [function ():void {
                                    NpcDialog.show(49, "冰沁酋长", [[0, "（陷入了深深的回忆之中……）"]], ["静静地聆听吧。"], [function ():void {
                                        QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                                        QuestManager.completeStep(_quest.id, 4);
                                    }]);
                                }]);
                            }]);
                        }, true, false, 2);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        if (param1.questId == 51) {
            DisplayUtil.removeForParent(this._mc_0);
            DisplayUtil.removeForParent(this._mc_1);
            DisplayUtil.removeForParent(this._mc_2);
            DisplayUtil.removeForParent(this._mc_3);
        }
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
        if (this._mc_3) {
            DisplayUtil.removeForParent(this._mc_3);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepTwoHandler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepThreeHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }
}
}
