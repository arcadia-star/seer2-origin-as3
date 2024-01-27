package com.taomee.seer2.app.processor.quest.handler.main.quest107 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_107_80537 extends QuestMapHandler {


    private var npc:MovieClip;

    public function QuestMapHandler_107_80537(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        if (!QuestManager.isAccepted(_quest.id)) {
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        var _loc1_:MovieClip = null;
        _loc1_ = _processor.resLib.getMovieClip("duoLuo");
        _loc1_.x += 450;
        _loc1_.y += 100;
        SceneManager.active.mapModel.front.addChild(_loc1_);
        _loc1_.buttonMode = true;
        _loc1_.mouseChildren = false;
        _loc1_.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    protected function onClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        var dialog:Array = [[10, "巴蒂", [[0, "队长，事情严重了不是么？没有希望之光而召唤出的约瑟王……连翼灵兽都没有发现其中的问题！"]], ["......"]], [400, "小赛尔", [[0, "是这样的……我要再找找那本书上的记载。就算只是概括，约瑟王重临世界这种事情也不会没有记载！"]], ["........"]]];
        NpcDialog.showDialogs(dialog, function ():void {
            npc = _processor.resLib.getMovieClip("book");
            npc.gotoAndStop(1);
            npc.buttonMode = true;
            SceneManager.active.mapModel.front.addChild(npc);
            npc.mouseChildren = false;
            npc.addEventListener(MouseEvent.CLICK, onClickBook);
            npc.addEventListener(MouseEvent.ROLL_OVER, moveHandler);
            npc.addEventListener(MouseEvent.ROLL_OUT, outHandler);
        });
    }

    protected function onClickBook(param1:MouseEvent):void {
        var dialog1:Array = null;
        var dialog2:Array = null;
        var dialog3:Array = null;
        var dialog4:Array = null;
        var e:MouseEvent = param1;
        var dialog0:Array = [[400, "小赛尔", [[0, "上次我们看到了……“星际使者与向导告别，踏上了前往虫群氏族的旅程。接下来呢？"]], ["是写虫群氏族的经历吗？"]]];
        dialog1 = [[400, "小赛尔", [[0, "……什么？直接跳到了超能氏族？难道我们在虫群氏族就没有什么可圈可点的业绩？"]], ["......"]], [10, "巴蒂", [[0, "会不会是斯坦因搞的鬼？看看书缝里有没有被撕掉的部分？"]], ["好像真的没有。"]], [10, "巴蒂", [[0, "那这是怎么回事？这段经历没有被记录？不对，云海藏书的记载是可信的，那只可能是……"]], ["我们直接【奔赴】了超能氏族！"]], [400, "小赛尔", [[0, "姑且这么想，我们正准备去虫群氏族，却被突发情况打断，赶到了超能氏族。"]], ["......"]], [10, "巴蒂", [[0, "看来这段失去的记忆很复杂嘛……再看看下一篇。"]], ["....."]]];
        dialog2 = [[400, "小赛尔", [[0, "关于【日志】的重要资料？难道说的是巴金斯日志？"]], ["......"]], [10, "巴蒂", [[0, "队长，我记得在视界原野的时候，费德提克说巴金斯日志被抢走了半本！"]], ["我想起来了！另半本想必在萨伦帝国手里。"]], [400, "小赛尔", [[0, "这么说，只有这件事能和我们的现状对上号了，感觉莫名庆幸啊，至少它是真的！"]], ["........"]], [10, "巴蒂", [[0, "那么接下来……"]], ["看下一页吧。"]]];
        dialog3 = [[400, "小赛尔", [[0, "果然，这一段是不记得了，接下来呢？"]], ["......"]]];
        dialog4 = [[400, "小赛尔", [[0, "就是这些了，接下来就能和我们现在的记忆连上了。"]], ["......"]], [10, "巴蒂", [[0, "的内容无一不是重大事件，但是其中果然没有关于约瑟王的内容！"]], ["是的，那么这个约瑟王，究竟是什么？"]], [400, "小赛尔", [[0, "……事情有些严重。我们先回去找多罗会和吧。"]], ["........"]]];
        NpcDialog.showDialogs(dialog0, function ():void {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("107_0"), 1, [[1, 0]], function ():void {
                NpcDialog.showDialogs(dialog1, function ():void {
                    MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("107_1"), 1, [[1, 0]], function ():void {
                        NpcDialog.showDialogs(dialog2, function ():void {
                            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("107_2"), 1, [[1, 0]], function ():void {
                                NpcDialog.showDialogs(dialog3, function ():void {
                                    MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("107_3"), 1, [[1, 0]], function ():void {
                                        NpcDialog.showDialogs(dialog4, function ():void {
                                            QuestManager.completeStep(_quest.id, 1);
                                            SceneManager.changeScene(SceneType.COPY, 80538);
                                        });
                                    });
                                });
                            });
                        });
                    });
                });
            });
        });
    }

    private function moveHandler(param1:MouseEvent):void {
        this.npc.gotoAndStop(2);
    }

    private function outHandler(param1:MouseEvent):void {
        this.npc.gotoAndStop(1);
    }
}
}
