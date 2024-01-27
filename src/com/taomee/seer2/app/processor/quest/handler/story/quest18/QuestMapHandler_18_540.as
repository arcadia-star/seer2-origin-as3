package com.taomee.seer2.app.processor.quest.handler.story.quest18 {
import com.taomee.seer2.app.animationInteractive.Interactive_18;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_18_540 extends QuestMapHandler {

    private static var _flghtIndex:int = 0;


    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    private var _mc_3:MovieClip;

    private var _mc_4:MovieClip;

    private var _count:int;

    private var _interactive_18:Interactive_18;

    public function QuestMapHandler_18_540(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id, 5) == false && _flghtIndex == 1) {
            this._count = 0;
            this.initQuest4(102);
            if (FightManager.fightWinnerSide == FightSide.LEFT && _flghtIndex == 1) {
                _flghtIndex = 0;
                this.win();
            } else {
                _flghtIndex = 0;
                this.noWin();
            }
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.playAnimation();
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this.initNpc();
        }
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            this._count = 0;
            this.initQuest4(19);
            ShootController.addEventListener(ShootEvent.PLAY_END, this.onShootOver);
        }
    }

    private function playAnimation():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("18_0"), function ():void {
            _mc_1 = _processor.resLib.getMovieClip("mc_1");
            _map.front.addChild(_mc_1);
            _mc_1.gotoAndStop(1);
            _mc_2 = _processor.resLib.getMovieClip("mc_2");
            _map.content.addChild(_mc_2);
            _mc_2.x = 461;
            _mc_2.y = 170;
            _mc_2.gotoAndStop(1);
            NpcDialog.show(11, "多罗", [[2, "好冷啊~~~队长！虽然我是一个机器人，看到这样的景象还是会觉得……好冷！！"]], ["……这就是冰沁氏族？"], [function ():void {
                NpcDialog.show(11, "多罗", [[2, "这里一个人……一个精灵……一个赛尔都没有！我们该怎么办？？"]], ["四处检查一下！！"], [function ():void {
                    MovieClipUtil.playMc(_mc_1, 2, 168, function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onQuestStep);
                        QuestManager.completeStep(_quest.id, 3);
                    }, true);
                }]);
            }]);
        });
    }

    private function onQuestStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStep);
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            if (this._mc_1) {
                this._mc_1.gotoAndStop(169);
                this._mc_1.buttonMode = true;
                this._mc_1.addEventListener(MouseEvent.CLICK, this.onClick);
            } else {
                this.initNpc();
            }
            if (this._mc_2 == null) {
                this._mc_2 = _processor.resLib.getMovieClip("mc_2");
                _map.content.addChild(this._mc_2);
                this._mc_2.gotoAndStop(1);
            }
        }
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            this._count = 0;
            ShootController.addEventListener(ShootEvent.PLAY_END, this.onShootOver);
        }
    }

    private function onShootOver(param1:ShootEvent):void {
        var event:ShootEvent = param1;
        var info:ShootInfo = event.info;
        if (this._mc_2["mc"].hitTestPoint(info.endPos.x, info.endPos.y)) {
            if (info.id == 3) {
                if (this._count == 0) {
                    ++this._count;
                    MovieClipUtil.playMc(this._mc_2, 22, 47);
                    return;
                }
                if (this._count == 1) {
                    ++this._count;
                    MovieClipUtil.playMc(this._mc_2, 49, 74);
                    return;
                }
                if (this._count == 2) {
                    MovieClipUtil.playMc(this._mc_2, 76, this._mc_2.totalFrames, function ():void {
                        _mc_2.buttonMode = true;
                        _processor.showMouseHintAt(492, 221);
                        _mc_2.addEventListener(MouseEvent.CLICK, onMC2Click);
                    }, true);
                }
            }
        }
    }

    private function startFight():void {
        if (PetInfoManager.getFirstPetInfo().hp <= 1) {
            AlertManager.showAlert("您的首发精灵体力不够");
            this._mc_2.buttonMode = true;
            _processor.showMouseHintAt(492, 221);
            this._mc_2.addEventListener(MouseEvent.CLICK, this.onMC2Click);
            return;
        }
        _flghtIndex = 1;
        FightManager.startFightWithWild(37);
    }

    private function onMC2Click(param1:MouseEvent):void {
        this._mc_2.removeEventListener(MouseEvent.CLICK, this.onMC2Click);
        this.startFight();
    }

    private function initNpc():void {
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.front.addChild(this._mc_1);
        this._mc_1.gotoAndStop(169);
        this._mc_1.buttonMode = true;
        this._mc_1.addEventListener(MouseEvent.CLICK, this.onClick);
        if (this._mc_2 == null) {
            this._mc_2 = _processor.resLib.getMovieClip("mc_2");
            this._mc_2.x = 461;
            this._mc_2.y = 170;
            _map.content.addChild(this._mc_2);
            this._mc_2.gotoAndStop(1);
        }
    }

    private function initQuest4(param1:int):void {
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.front.addChild(this._mc_1);
        this._mc_1.gotoAndStop(168);
        this._mc_2 = _processor.resLib.getMovieClip("mc_2");
        this._mc_2.x = 461;
        this._mc_2.y = 170;
        _map.content.addChild(this._mc_2);
        this._mc_2.gotoAndStop(param1);
        this._mc_3 = _processor.resLib.getMovieClip("mc_3");
        _map.front.addChild(this._mc_3);
        this._mc_3.gotoAndStop(39);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(10, "巴蒂", [[0, "嗯……我什么都没有找到……不过！伊娃博士不是给了我们一个生命勘测仪吗？这个时候应该可以派上用处了。"]], ["（使用生命勘测仪）"], [function ():void {
            _mc_1.gotoAndStop(168);
            _mc_1.removeEventListener(MouseEvent.CLICK, onClick);
            _interactive_18 = new Interactive_18();
            _interactive_18.setup("interactive_18", function (param1:Boolean):void {
                var isSuccess:Boolean = param1;
                NpcDialog.show(10, "巴蒂", [[4, "快看！那里有微弱的生命迹象！"]], ["但是，要怎么把它救出来？"], [function ():void {
                    _mc_3 = _processor.resLib.getMovieClip("mc_3");
                    _map.front.addChild(_mc_3);
                    MovieClipUtil.playMc(_mc_3, 3, 39, function ():void {
                        NpcDialog.show(444, "目之魂", [[0, "你们终于来到这里了…… "]], ["好熟悉的声音……难道？"], [function ():void {
                            NpcDialog.show(444, "目之魂", [[0, "我是……目之魂……"]], ["给我看了那段影像的就是你！"], [function ():void {
                                NpcDialog.show(444, "目之魂", [[0, "用……火焰……就可以解除冰封……"]], ["火焰？！对了，用火系头部射击打冰块！"], [function ():void {
                                    MovieClipUtil.playMc(_mc_2, 2, 19, function ():void {
                                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onQuestStep);
                                        QuestManager.completeStep(_quest.id, 4);
                                    }, true);
                                }]);
                            }]);
                        }]);
                    }, true);
                }]);
            });
        }]);
    }

    private function win():void {
        NpcDialog.show(11, "多罗", [[4, "哼哼！人质！！快说，这里变成这样子是不是你们萨伦帝国干的好事？！"]], ["为什么你会被冰冻？"], [function ():void {
            NpcDialog.show(32, "小兵", [[2, "我，我不知道……我原本以为，我只要在这里看守当地的居民就可以了……我完全没有得到撤退通知……呜哇！！"]], ["（萨伦帝国不惜连看守居民的士兵也冰封？！）"], [function ():void {
                NpcDialog.show(10, "巴蒂", [[0, "队长，我们放他走吧。虽然他是敌人……但是他也有亲人在等他回家。何况，我们已经知道，这一切都是萨伦帝国做的了。"]], ["嗯，我同意。"], [function ():void {
                    NpcDialog.show(32, "小兵", [[2, "你们说的是真的……？"]], ["当然！不过，这里的冰封有没有办法破解？"], [function ():void {
                        NpcDialog.show(32, "小兵", [[2, "（沉思）"]], ["……"], [function ():void {
                            NpcDialog.show(32, "小兵", [[2, "你们看见天上那个悬浮的魔法冰晶了吗？我只知道……是它让这里冰封起来的……！其它的我就……我就……"]], ["（魔法冰晶，看来是解开冰封的关键了。）"], [function ():void {
                                _mc_2.visible = false;
                                _mc_4 = _processor.resLib.getMovieClip("mc_4");
                                _map.front.addChild(_mc_4);
                                MovieClipUtil.playMc(_mc_4, 2, _mc_4.totalFrames, function ():void {
                                    NpcDialog.show(444, "目之魂", [[0, "你们……果然不愧为被选中的人……无论是，实力，气量……阿卡迪亚星球……有希望了……"]], ["嘿嘿嘿，我没有那么好啦！"], [function ():void {
                                        NpcDialog.show(444, "目之魂", [[0, "现在……我已经没有力气再维持这个形态了……只能……暂时离开你们了……在你们遇到危难的时候，我一定会……一定会……"]], ["等……等一下！目之魂？！"], [function ():void {
                                            MovieClipUtil.playMc(_mc_3, 41, _mc_3.totalFrames, function ():void {
                                                QuestManager.completeStep(_quest.id, 5);
                                                DisplayUtil.removeForParent(_mc_1);
                                                _mc_1 = null;
                                            }, true);
                                        }]);
                                    }]);
                                }, true);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function noWin():void {
        this._mc_2.buttonMode = true;
        _processor.showMouseHintAt(492, 221);
        this._mc_2.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
            var event:MouseEvent = param1;
            _mc_2.removeEventListener(MouseEvent.CLICK, arguments.callee);
            NpcDialog.show(11, "多罗", [[2, "居……居然是萨伦帝国的士兵！真倒霉！"]], ["怕什么！再来一次！"], [function ():void {
                startFight();
            }]);
        });
    }

    override public function processMapDispose():void {
        _processor.hideMouseClickHint();
        this._count = 0;
        ShootController.removeEventListener(ShootEvent.PLAY_END, this.onShootOver);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStep);
        if (this._mc_1) {
            this._mc_1.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        DisplayUtil.removeForParent(this._mc_1);
        this._mc_1 = null;
        if (this._mc_2) {
            this._mc_2.removeEventListener(MouseEvent.CLICK, this.onMC2Click);
        }
        DisplayUtil.removeForParent(this._mc_2);
        this._mc_2 = null;
        DisplayUtil.removeForParent(this._mc_3);
        this._mc_3 = null;
        DisplayUtil.removeForParent(this._mc_4);
        this._mc_4 = null;
    }
}
}
