package com.taomee.seer2.app.processor.quest.handler.main.quest113 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;

public class QuestMapHandler_113_80578 extends QuestMapHandler {


    private var mc:MovieClip;

    public function QuestMapHandler_113_80578(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (!QuestManager.isAccepted(_quest.id)) {
            return;
        }
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        var dialog0:Array;
        var dialog4:Array;
        var dialog1:Array = null;
        var dialog2:Array = null;
        var dialog3:Array = null;
        SceneManager.active.mapModel.content["mv0"].visible = false;
        SceneManager.active.mapModel.content["mv1"].visible = false;
        SceneManager.active.mapModel.content["mv2"].visible = false;
        SceneManager.active.mapModel.content["mv3"].visible = false;
        SceneManager.active.mapModel.content["badi1"].visible = false;
        dialog0 = [[3124, "我", [[0, "那是什么声音？如同雷声滚过天际？然而黑夜不能给我黑色的眼睛，让我看不明晰这一切"]], ["……"]], [3124, "我", [[0, "沉默着，沉默着，沉默中爆发了一个声音。"]], ["……"]], [10, "???", [[0, "……可恶，被暗算了，这个老铁皮！……幸好机体没有受损，队长呢？队长？"]], ["……"]], [10, "???", [[0, "这是哪里？先找找看……"]], ["……"]]];
        dialog1 = [[3124, "我", [[0, "穿过幽暗的岁月，也曾感到彷徨，隐约看到下方亮起的光。"]], ["……"]], [10, "???", [[0, "没有看见……不在这里。试着联络一下吧。"]], ["……"]], [10, "???", [[0, "可恶！信号被屏蔽了！这个老铁皮……用量子通信试试。"]], ["……"]], [3124, "我", [[0, "在风声都为之沉默的夜晚,我用只有你能听到的声音呼唤。"]], ["……"]], [10, "???", [[0, "队长！我还好！……这里似乎是底下，我先在周围看看！"]], ["……"]], [3124, "我", [[0, "吾将上下而求索，景翳翳以将入。"]], ["……"]]];
        dialog2 = [[10, "???", [[0, "这是什么？面板？……好像懂了！就让最聪明的我来解决一切吧！"]], ["……"]]];
        dialog3 = [[10, "???", [[0, "这……很眼熟，飞翼……核不也像这里一样吗？那么……中间的那个容器里是……？"]], ["……"]], [3124, "我", [[0, "那是什么？同样的初见,眼中同样的困惑。"]], ["……"]], [10, "???", [[0, "Rele……ase？我明白了！就让最聪明的我来做这个英雄吧！"]], ["……"]], [3124, "我", [[0, "英雄驱虎豹……门开了！漫卷诗书喜欲狂！"]], ["……"]]];
        dialog4 = [[3124, "我", [[0, "久在樊笼里，复得返自然。不禁逸兴遄飞啊。"]], ["……"]], [10, "???", [[0, "你……等等，这不是释放神兽的按钮吗？你是什么……？"]], ["……"]], [3124, "我", [[0, "名吾曰诗风兮，集诗歌以抒怀。"]], ["……"]], [10, "巴蒂", [[0, "你叫诗风？不是神兽啊……斯坦……老铁皮！我巴蒂什么时候被这样捉弄过？！"]], ["……"]], [3124, "我", [[0, "山重水复疑无路，柳暗花明又一村。莫生气啊。"]], ["……"]], [10, "巴蒂", [[0, "好了好了，别安慰我了！我现在要想办法救这个神兽，顺便找到出去的路。我还要继续看看……"]], ["……"]]];
        NpcDialog.showDialogs(dialog0, function ():void {
            SceneManager.active.mapModel.content["black"].visible = false;
            mc = SceneManager.active.mapModel.content["mv0"];
            mc.visible = true;
            MovieClipUtil.playMc(mc, 2, mc.totalFrames, function ():void {
                NpcDialog.showDialogs(dialog1, function ():void {
                    mc = SceneManager.active.mapModel.content["mv1"];
                    mc.visible = true;
                    MovieClipUtil.playMc(mc, 2, mc.totalFrames, function ():void {
                        SceneManager.active.mapModel.content["badi"].visible = false;
                        NpcDialog.showDialogs(dialog2, function ():void {
                            SceneManager.active.mapModel.content["mv0"].visible = false;
                            SceneManager.active.mapModel.content["mv1"].visible = false;
                            mc = SceneManager.active.mapModel.content["mv2"];
                            mc.visible = true;
                            MovieClipUtil.playMc(mc, 2, mc.totalFrames, function ():void {
                                mc.visible = false;
                                SceneManager.active.mapModel.content["badi1"].visible = true;
                                NpcDialog.showDialogs(dialog3, function ():void {
                                    mc = SceneManager.active.mapModel.content["mv3"];
                                    mc.visible = true;
                                    MovieClipUtil.playMc(mc, 2, mc.totalFrames, function ():void {
                                        QuestManager.completeStep(questID, 1);
                                        SceneManager.changeScene(SceneType.LOBBY, 70);
                                    });
                                });
                            });
                        });
                    });
                });
            });
        });
    }
}
}
