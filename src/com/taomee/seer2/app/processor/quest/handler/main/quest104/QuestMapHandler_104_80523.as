package com.taomee.seer2.app.processor.quest.handler.main.quest104 {
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

public class QuestMapHandler_104_80523 extends QuestMapHandler {


    private var npc:MovieClip;

    public function QuestMapHandler_104_80523(param1:QuestProcessor) {
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
        if (QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.initStep1();
        }
    }

    private function moveHandler(param1:MouseEvent):void {
        this.npc.gotoAndStop(2);
    }

    private function outHandler(param1:MouseEvent):void {
        this.npc.gotoAndStop(1);
    }

    private function initStep1():void {
        var dialog0:Array;
        var npc2:MovieClip = null;
        npc2 = _processor.resLib.getMovieClip("gang");
        npc2.x += 564;
        npc2.y += 150;
        SceneManager.active.mapModel.front.addChild(npc2);
        npc2.buttonMode = true;
        npc2.mouseChildren = false;
        this.npc = _processor.resLib.getMovieClip("book");
        this.npc.gotoAndStop(1);
        this.npc.buttonMode = true;
        SceneManager.active.mapModel.front.addChild(this.npc);
        this.npc.mouseChildren = false;
        this.npc.addEventListener(MouseEvent.CLICK, this.onClick);
        this.npc.addEventListener(MouseEvent.ROLL_OVER, this.moveHandler);
        this.npc.addEventListener(MouseEvent.ROLL_OUT, this.outHandler);
        dialog0 = [[10, "巴蒂", [[0, "这里是哪？不是设施的控制室？！φ(゜▽゜*)φ"]], ["显然……不是。"]], [11, "多罗", [[0, "好……好壮观……！！∑(ﾟДﾟ≡ﾟДﾟ)"]], ["......"]], [93, "刚铎", [[0, "当我来到这扇门前的时候，我便有所忆起……虽然我不爱看书，但是我的兄长以前经常到这里来。这里并不是什么控制室，而正是飞翼氏族保存——从某种程度上说，也是暂时封存历史的地方。"]], ["原来他们正是在这里保存历史的。"]], [10, "巴蒂", [[0, "这么说……我们还有可能找到真相？"]], ["......"]], [93, "刚铎", [[0, "是的。此外，封锁这扇门的翼灵兽的力量并非是来自斯坦因的抽取，而是来自翼灵兽本尊的意愿。它教导我们，保有真相是保有自由的重要的一部分。你们所要找到真相，也许就在这里。"]], ["那就找找看吧！"]], [10, "巴蒂", [[0, "………………………………ヽ(°◇° )ノ队长快看，那里有一本半抽出来的书！！！"]], ["......"]], [11, "多罗", [[0, "吓！！在哪？！在哪？！！∑(ﾟДﾟ≡ﾟДﾟ)"]], ["......"]], [93, "刚铎", [[0, "（警觉）有人来过这里……（迅速冷静下来）不，斯坦因也许早就来过这里了。"]], ["......"]], [400, "小赛尔", [[0, "无论如何先拿下来看看吧。"]], ["找出场景中半抽出的书！（完成后才可继续任务）"]]];
        NpcDialog.showDialogs(dialog0, function ():void {
        });
    }

    protected function onClick(param1:MouseEvent):void {
        var dialog0:Array = null;
        var e:MouseEvent = param1;
        dialog0 = [[400, "小赛尔", [[0, "这是什么……我为什么不记得？但是为什么这里会有记载？"]], ["......"]], [93, "刚铎", [[0, "这里的资料被翼灵兽的力量封锁着，除了斯坦因这种怪才之外，外人甚至来自外界的力量都无法干涉这些资料，所以你们尽管相信这些资料好了。"]], ["尽管相信，是的，这也许是我们最后能相信的了。"]], [10, "巴蒂", [[0, "你对斯坦因“怪才”的定义，我很赞同！（有些沮丧）但是现在我的思绪有点乱……这里的资料是真实的，那么我们的记忆确实缺失了，确实被修改了。当猜测变成了现实，我还有些难以接受。"]], ["......."]], [11, "多罗", [[0, "也就是说……我们都失忆了，现在发现了自己究竟忘了什么？"]], ["......"]], [400, "小赛尔", [[0, "是的，这是最精辟的总结。"]], ["......"]], [11, "多罗", [[0, "太好了！队长表扬我了！"]], ["……我没有表扬过你？"]], [400, "小赛尔", [[0, "感谢刚铎的帮助，我想我们找回了一些真相。但是现在，我的思绪仍旧有些乱。"]], ["......"]], [93, "刚铎", [[0, "不用谢！这是我应该做的！"]], ["......"]], [93, "刚铎", [[0, "星际使者啊，现在你已经找到了一些真相，我祝愿你们——寄托着星球未来的希望的你们，能够早日解开所有的疑惑，获得真相也同样获得自由！"]], ["......"]]];
        MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("104_0"), 2, [[1, 0]], function ():void {
            NpcDialog.showDialogs(dialog0, function ():void {
                QuestManager.completeStep(_quest.id, 3);
                SceneManager.changeScene(SceneType.LOBBY, 70);
            });
        });
    }
}
}
