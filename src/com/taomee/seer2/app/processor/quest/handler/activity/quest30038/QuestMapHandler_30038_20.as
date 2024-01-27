package com.taomee.seer2.app.processor.quest.handler.activity.quest30038 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_30038_20 extends QuestMapHandler {


    private var scholarNpc:Mobile;

    private var caonima:MovieClip;

    public function QuestMapHandler_30038_20(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
        if (this.scholarNpc) {
            this.scholarNpc.removeEventListener(MouseEvent.CLICK, this.showScholarDia);
        }
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(1)) {
            this.initStep1();
        } else if (isNeedCompleteStep(2)) {
            this.initStep2();
        }
    }

    private function initStep1():void {
        var diaMc:MovieClip = null;
        this.caonima = _processor.resLib.getMovieClip("CaonimaFind");
        this.caonima.x = 309;
        this.caonima.y = 271;
        this.caonima.gotoAndStop(1);
        _map.content.addChild(this.caonima);
        diaMc = _processor.resLib.getMovieClip("ScholarDiaMc_30038");
        _map.front.addChild(diaMc);
        MovieClipUtil.playMc(diaMc, 1, 152, function ():void {
            MovieClipUtil.playMc(caonima, 1, caonima.totalFrames, function ():void {
                MovieClipUtil.playMc(diaMc, 152, diaMc.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(diaMc);
                    NpcDialog.show(160, "多茨莫博士", [[3, "不听话！不是说好不再见面了吗！！"]], ["我看错你了！原来你那么无情！"], [function ():void {
                        NpcDialog.show(516, "卜古塔", [[2, "你误会多茨莫博士了……嘤嘤嘤……我知道博士都是为我好……"]], ["此话怎讲？"], [function ():void {
                            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30038_1"), 3, [[1, 0]], function ():void {
                                NpcDialog.show(160, "多茨莫博士", [[3, "我要倾力阻止这一切！所以，你不应该跟着我，那会相当危险……！"]], ["草泥马宝宝比你想象得要勇敢！"], [function ():void {
                                    NpcDialog.show(516, "卜古塔", [[3, "我是长颈鹿！！嘤嘤嘤……博士，如果普兰特山麓被破坏，我们就重建一个！如果有人要随意砍伐，我们就打败他们！！"]], ["说得好！"], [function ():void {
                                        NpcDialog.show(2, "伊娃", [[0, "呵呵……没错，多茨莫，我支持草泥马宝宝的说法。"]], ["我也是！"], [function ():void {
                                            NpcDialog.show(160, "多茨莫博士", [[1, "卜古塔，你真的愿意和我奋斗到最后……？"]], ["答案还用说吗"], [function ():void {
                                                NpcDialog.show(516, "卜古塔", [[2, "嗯，嗯……嘤嘤嘤……所以不要丢下我……！"]], ["可恶，我还是不会感动到哭的！呜呜…"], [function ():void {
                                                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, completeStep);
                                                    QuestManager.completeStep(questID, 1);
                                                }]);
                                            }]);
                                        }]);
                                    }]);
                                }]);
                            });
                        }]);
                    }]);
                }, true);
            }, true);
        }, true);
    }

    private function completeStep(param1:QuestEvent):void {
        if (param1.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
            if (param1.stepId == 1) {
                this.initStep2();
            } else if (param1.stepId == 2) {
                SceneManager.changeScene(SceneType.LOBBY, 990);
            }
        }
    }

    private function initStep2():void {
        if (this.caonima) {
            DisplayObjectUtil.removeFromParent(this.caonima);
        }
        var _loc1_:XML = <npc id="160" resId="160" name="多茨莫博士" dir="1" width="115" height="125" pos="309,280"
                              actorPos="340,250" path=""/>;
        var _loc2_:NpcDefinition = new NpcDefinition(_loc1_);
        this.scholarNpc = MobileManager.createNpc(_loc2_);
        this.scholarNpc.removeOverHeadMark();
        this.scholarNpc.addOverHeadMark(new AcceptableMark());
        this.scholarNpc.buttonMode = true;
        this.scholarNpc.addEventListener(MouseEvent.CLICK, this.showScholarDia);
    }

    private function showScholarDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(160, "多茨莫博士", [[1, "那么，我要开始拟定一份重建普兰特山麓的计划，小赛尔，愿意帮助我吗？"]], ["这件事情我帮定了！话说你和伊娃博士认识？"], [function ():void {
            NpcDialog.show(2, "伊娃", [[0, "咳……多茨莫博士是最早一批的探路者，负责生态系统研究。按照他们的分析报告我们才正式登陆阿卡迪亚星球的。"]], ["哇，那可真是充满挑战的工作！"], [function ():void {
                NpcDialog.show(160, "多茨莫博士", [[1, "我应该是第一个回到飞船的，斯坦因他们似乎都还没有回来。"]], ["斯斯斯斯斯斯……斯坦因博士？！？！"], [function ():void {
                    NpcDialog.show(2, "伊娃", [[0, "的确……不过嘛，这是我们之后的话题，该来的总会来的。当务之急，先解决普兰特山麓的问题吧。"]], ["又多了一个谜题！算了，先回普兰特山麓吧！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, completeStep);
                        QuestManager.completeStep(questID, 2);
                    }]);
                }]);
            }]);
        }]);
    }
}
}
