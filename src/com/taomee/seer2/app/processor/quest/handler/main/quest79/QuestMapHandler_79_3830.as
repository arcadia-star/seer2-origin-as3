package com.taomee.seer2.app.processor.quest.handler.main.quest79 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.InProgressMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

public class QuestMapHandler_79_3830 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    private var _mc4:MovieClip;

    private var fightFirstID:Array;

    private var _npc:Mobile;

    private var _npc1:Mobile;

    private var _npc2:Mobile;

    private var _npc1032:Mobile;

    public function QuestMapHandler_79_3830(param1:QuestProcessor) {
        this.fightFirstID = [1334];
        super(param1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this._npc1032 = MobileManager.getMobile(1032, MobileType.NPC);
        this._npc1032.visible = false;
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            if (SceneManager.prevSceneType == SceneType.ARENA) {
                this.onSwitchComplete();
            } else {
                this.createNpc();
                this._npc.addEventListener(MouseEvent.CLICK, this.initDialogNpc);
            }
        }
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
        }
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 2) && !QuestManager.isStepComplete(questID, 3)) {
            this.createNpc2();
        }
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        if (DialogPanelEventData(param1.content).params == "79_2") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            this.initStep4(null);
        }
    }

    private function initDialogNpc(param1:MouseEvent):void {
        this.initStep1();
    }

    private function onComplete(param1:QuestEvent):void {
        this._mc1 = null;
        this._mc2 = null;
        this._mc3 = null;
        this._mc4 = null;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function initStep1():void {
        MobileManager.hideMoileVec(MobileType.NPC);
        this._mc1 = _processor.resLib.getMovieClip("Mc79_0");
        _map.front.addChild(this._mc1);
        this._mc1.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc1, 1, this._mc1.totalFrames, function ():void {
            NpcDialog.show(32, "杂兵", [[0, "少废话，你到底交不交钱！"]], [" ！！"], [function ():void {
                NpcDialog.show(1017, "瓦利大叔", [[2, "大爷，我……我真的没有多余的钱了……"]], ["发生了什么事？"], [function ():void {
                    NpcDialog.show(32, "杂兵", [[2, "哼，那就别怪我不客气了！这些首饰看上去不错啊，归我了哈哈哈！"]], ["住手！"], [function ():void {
                        initContinue();
                    }]);
                }]);
            }]);
        }, true);
    }

    private function initContinue(param1:MouseEvent = null):void {
        var event:MouseEvent = param1;
        NpcDialog.show(32, "杂兵", [[0, "哟，这又是哪里来的家伙？长得怪模怪样的，怎么，你们也敢多管闲事？活得不耐烦了吗！"]], ["欺负弱小，太可恶了！"], [function ():void {
            initStep2();
        }]);
    }

    private function initStep2():void {
        FightManager.startFightWithWild(this.fightFirstID[0]);
    }

    private function onSwitchComplete():void {
        var result:uint = 0;
        if (this.fightFirstID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
            result = FightManager.fightWinnerSide;
            if (result == FightSide.RIGHT) {
                NpcDialog.show(32, "杂兵", [[0, "哼，实力这么弱也敢来多管闲事？大爷我今天心情好，快滚吧！"]], ["……"], [function ():void {
                    createNpc();
                    _npc.addEventListener(MouseEvent.CLICK, initContinue);
                }]);
            } else if (result == FightSide.LEFT) {
                NpcDialog.show(11, "多罗", [[3, "你败了！还不快向这位大叔道歉！"]], ["快道歉！"], [function ():void {
                    NpcDialog.show(32, "杂兵", [[0, "你们……你们大胆！我是萨伦帝国派驻在这里的士兵，你们……你们竟敢打我！"]], ["打的就是你！"], [function ():void {
                        NpcDialog.show(10, "巴蒂", [[3, "哼，对付你这种抢劫者，我们见一次打一次！再让我们知道你欺负这位大叔，我们不会放过你的！"]], ["就是！"], [function ():void {
                            NpcDialog.show(1017, "瓦利大叔", [[0, "唉……算啦……大爷，我是真的没有多余的钱了，这些首饰……这些首饰也是一些贵人订的啊，实在是不能给你啊……"]], [" ……"], [function ():void {
                                NpcDialog.show(32, "杂兵", [[0, "那，那就算了！至于你们几个，走…走着瞧！"]], [" ……"], [function ():void {
                                    initStep3();
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }
        }
    }

    private function initStep3():void {
        this._npc1 = MobileManager.getMobile(1017, MobileType.NPC);
        this._npc1.visible = false;
        this._mc2 = _processor.resLib.getMovieClip("Mc79_1");
        _map.front.addChild(this._mc2);
        this._mc2.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc2, 1, this._mc2.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_mc2);
            _npc1.visible = true;
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(questID, 1);
        }, true);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        if (param1.stepId == 1) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
        } else if (param1.stepId == 2) {
            this.createNpc2();
        }
    }

    private function initStep4(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(10, "巴蒂", [[0, "大叔不用客气啦。我们来自一颗遥远的星球，来阿卡迪亚是为了进行探索。但是，在这里我们也遇到了一些朋友，他们需要我们的帮助，所以我们会在这里待上一阵子。"]], ["…"], [function ():void {
            NpcDialog.show(400, "小赛尔", [[0, "大叔，刚才又是怎么回事呢？那个萨伦小兵为什么要欺负你？你又为什么这么轻易就让它走了？"]], ["…"], [function ():void {
                NpcDialog.show(1017, "瓦利大叔", [[0, "唉，我叫瓦利，是个普通的首饰匠。大概是因为手艺还不错吧，经常会有王公贵族来找我订做首饰。但是，萨伦大军占领这里之后，隔三差五就有这样的小兵来收取费用。"]], [" ……"], [function ():void {
                    NpcDialog.show(1017, "瓦利大叔", [[0, "唉，这样一次次的压榨，本来日子就过得紧巴巴，现在更是……刚才多亏你们哪，要不然，我这些做完的首饰被他们夺走，我可怎么办哪……"]], [" 大叔，你真的太可怜了……"], [function ():void {
                        NpcDialog.show(11, "多罗", [[0, "大叔，那既然他们这么可恶，你为什么不反抗呢？超能氏族的人不是具有超能力吗？"]], [" 是啊"], [function ():void {
                            NpcDialog.show(1017, "瓦利大叔", [[0, "唉，哪有那么容易啊……并不是每个超能氏族的人都具有强大的战斗能力，我们这样的普通人又怎么能抗衡实力强大的萨伦军队……何况现在能量水晶在慢慢衰弱，恐怕我们也只能被萨伦帝国控制了。"]], ["这……"], [function ():void {
                                NpcDialog.show(400, "小赛尔", [[0, "瓦利大叔，你也知道能量水晶衰弱的事情？"]], [" ……"], [function ():void {
                                    NpcDialog.show(1017, "瓦利大叔", [[0, "唉，能量水晶是整个氏族的本源，我们又怎么会不知道它的变化呢……"]], [" ……"], [function ():void {
                                        NpcDialog.show(400, "小赛尔", [[0, "萨伦派人切割了能量水晶，破坏了水晶的结构！这才是能量水晶慢慢衰弱的真正原因！我们来这里，也正是受到超能氏族朋友的委托，帮助他们寻找从水晶上脱落下来的能量碎片，以弥补水晶的缺口。"]], [" …"], [function ():void {
                                            NpcDialog.show(1017, "瓦利大叔", [[0, "原来是这样……能量碎片……我这里有样东西，或许可以帮到你们。"]], ["真的吗！"], [function ():void {
                                                initStep5();
                                            }]);
                                        }]);
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function initStep5():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("79_1"), function ():void {
            NpcDialog.show(1017, "瓦利大叔", [[0, "我看它不像是一般的首饰材料，给我一种…一种说不上来的奇特感觉，就一直留着，也没敢把它做成首饰。听你们这么一说，我想，这或许就是你们在寻找的东西吧？"]], ["（隐隐感觉到奇异的力量……）"], [function ():void {
                NpcDialog.show(400, "小赛尔", [[1, "这种奇异的力量……这应该就是我们要寻找的能量碎片！"]], ["…"], [function ():void {
                    NpcDialog.show(1017, "瓦利大叔", [[1, "那太好了！这碎片我拿着我没有多大用处，既然正是你们在找的东西，就给你们吧，希望可以真正解决问题。唉，如果不是迫不得已，谁愿意受到萨伦的压迫和奴役呢……"]], [" 嗯，多谢大叔"], [function ():void {
                        NpcDialog.show(10, "巴蒂", [[0, "剩下的碎片应该就在军工厂了。瓦利大叔，我们先走啦！"]], ["大叔再见！"], [function ():void {
                            initStep6();
                        }]);
                    }]);
                }]);
            }]);
        });
    }

    private function initStep6():void {
        this._npc1 = MobileManager.getMobile(1017, MobileType.NPC);
        this._npc1.visible = false;
        MobileManager.removeMobile(this._npc, MobileType.NPC);
        this._npc = null;
        this._mc3 = _processor.resLib.getMovieClip("Mc79_2");
        _map.front.addChild(this._mc3);
        this._mc3.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc3, 1, this._mc3.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_mc3);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(questID, 2);
        }, true);
    }

    private function initStep7(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(766, "小梦", [[0, "小赛尔，我们又见面啦！"]], ["小梦，你怎么在这儿？"], [function ():void {
            NpcDialog.show(766, "小梦", [[0, "我到这里来，是为了寻找永恒能源。"]], [" 永恒能源在超能氏族？"], [function ():void {
                NpcDialog.show(400, "小赛尔", [[0, "这到底是怎么回事呀？"]], [" …"], [function ():void {
                    NpcDialog.show(766, "小梦", [[0, "小赛尔，你们还不知道吗？地球已经到了危急存亡的关头！如果依然得不到能源的补充，我们的地球恐怕……"]], [" 怎么会这样！"], [function ():void {
                        NpcDialog.show(766, "小梦", [[0, "我不知道这里有没有永恒能源，但既然这里叫作“超能氏族”，或许、或许真的有可以帮到地球的东西也说不定！哪怕只有一线希望，我也不能放弃！"]], ["对！"], [function ():void {
                            NpcDialog.show(766, "小梦", [[0, "对了小赛尔，你们又怎么会在这里呢？"]], ["我们受人之托，来这里寻找能量碎片"], [function ():void {
                                NpcDialog.show(400, "小赛尔", [[0, "……（将前因后果告诉小梦）……"]], ["  …"], [function ():void {
                                    NpcDialog.show(766, "小梦", [[0, "原来是这样，但是据我的观察，军工厂门前有萨伦士兵把守，可能没办法通过正常方式进入。"]], ["那可怎么办呢？"], [function ():void {
                                        NpcDialog.show(766, "小梦", [[0, "哈，这可难不倒我！我帮你们去找就行了！能量碎片是什么样的？"]], [" 那太好了！看，这就是碎片……"], [function ():void {
                                            initStep8();
                                        }]);
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function initStep8():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("79_2"), function ():void {
            NpcDialog.show(766, "小梦", [[0, "我感觉到……我感觉到了永恒能源的存在！这…这碎片蕴含着永恒能源的力量！"]], ["能量碎片和永恒能源有关系？！"], [function ():void {
                NpcDialog.show(766, "小梦", [[0, "我不知道这是为什么……但这种感觉不会有错！或许、或许它就能解决地球的危机！"]], ["那真的太好了！"], [function ():void {
                    NpcDialog.show(766, "小梦", [[0, "当务之急还是先潜入军工厂找到碎片……小赛尔，你们在这儿等着，我很快就出来。"]], ["好，小梦，加油！"], [function ():void {
                        initStep9();
                    }]);
                }]);
            }]);
        });
    }

    private function initStep9():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("79_3"), function ():void {
            initStep10();
        });
    }

    private function initStep10():void {
        MobileManager.removeMobile(this._npc2, MobileType.NPC);
        this._mc4 = _processor.resLib.getMovieClip("Mc79_3");
        _map.front.addChild(this._mc4);
        this._mc4.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc4, 1, this._mc4.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_mc4);
            NpcDialog.show(766, "小梦", [[0, "碎片顺利找到！"]], ["好样的，小梦！"], [function ():void {
                NpcDialog.show(766, "小梦", [[0, "但是，小赛尔，我……我想把碎片带回地球！我们的地球、我们的小伙伴们都在等着“永恒能源”的拯救！"]], ["但这碎片属于超能氏族啊"], [function ():void {
                    NpcDialog.show(766, "小梦", [[0, "好吧，我把能量碎片交给你，是交还给你的朋友还是带回地球解决危机，这应该由你来决定。我相信你。"]], ["我会仔细考虑的。"], [function ():void {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("79_4"), function ():void {
                            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                            QuestManager.completeStep(questID, 3);
                        });
                    }]);
                }]);
            }]);
        }, true);
    }

    private function createNpc():void {
        var _loc1_:InProgressMark = null;
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(552, 490));
            this._npc.resourceUrl = URLUtil.getNpcSwf(1019);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -130;
        }
    }

    private function createNpc1():void {
        var _loc1_:InProgressMark = null;
        var _loc2_:InProgressMark = null;
        MobileManager.removeMobile(this._npc, MobileType.NPC);
        if (!this._npc) {
            this._npc = MobileManager.getMobile(1017, MobileType.NPC);
            if (this._npc != null) {
                _loc1_ = new InProgressMark();
                this._npc.addChild(_loc1_);
                _loc1_.y = -130;
                this._npc.addEventListener(MouseEvent.CLICK, this.initStep4);
            } else {
                this._npc = new Mobile();
                this._npc.setPostion(new Point(400, 400));
                this._npc.resourceUrl = URLUtil.getNpcSwf(1017);
                this._npc.buttonMode = true;
                MobileManager.addMobile(this._npc, MobileType.NPC);
                _loc2_ = new InProgressMark();
                this._npc.addChild(_loc2_);
                _loc2_.y = -130;
                this._npc.addEventListener(MouseEvent.CLICK, this.initStep4);
            }
        }
    }

    private function createNpc2():void {
        var _loc1_:InProgressMark = null;
        if (!this._npc2) {
            this._npc2 = new Mobile();
            this._npc2.setPostion(new Point(924, 470));
            this._npc2.resourceUrl = URLUtil.getNpcSwf(766);
            this._npc2.buttonMode = true;
            MobileManager.addMobile(this._npc2, MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc2.addChild(_loc1_);
            _loc1_.y = -100;
            this._npc2.addEventListener(MouseEvent.CLICK, this.initStep7);
        }
    }

    override public function processMapDispose():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.initStep4);
        }
        this._npc = null;
        super.processMapDispose();
    }
}
}
