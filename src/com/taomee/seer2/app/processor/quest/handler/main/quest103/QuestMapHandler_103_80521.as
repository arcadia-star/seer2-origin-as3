package com.taomee.seer2.app.processor.quest.handler.main.quest103 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_103_80521 extends QuestMapHandler {

    private static var count:int;


    private var th0:MovieClip;

    private var th1:MovieClip;

    private var th2:MovieClip;

    private var th3:MovieClip;

    private var tem:Array;

    public function QuestMapHandler_103_80521(param1:QuestProcessor) {
        this.tem = [];
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
        if (QuestManager.isStepComplete(_quest.id, 1) == true && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.initStep2();
        }
    }

    protected function onClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        var index:uint = uint(e.currentTarget.name.split("_")[1]);
        var dialog3:Array = [[10, "巴蒂", [[0, "我没有找到这个芯片的插口，也就是说，它似乎不能打开这个设施。而且，我也没有找到类似于“开机键”的东西。可能只有右边的那扇门了，控制系统在那扇门里。"]], ["......"]], [3105, "飞羽伊特", [[0, "巴蒂姐姐不要气馁啊，有我给你加油的~（嫌弃）不过，那个大喊大叫的家伙好吓人的！"]], ["......"]], [11, "多罗", [[0, "对……对不起……"]], ["......."]], [3105, "飞羽伊特", [[0, "虽然很喜欢巴蒂姐姐，但想让我跟着你们的话，你们还要通过我的考验！"]], ["果然，虽然可爱，但是也很任性啊……"]], [11, "多罗", [[0, "好好好……考验就考验吧，我……我一定将功补过！"]], ["......"]], [400, "小赛尔", [[0, "不过话说回来，对于这么大的设施，把控制系统放在一个房间也不是没有可能。巴蒂，那扇门能打开么？"]], ["......"]], [10, "巴蒂", [[0, "从技术手段上来说应该可以，不过需要一定的时间。"]], ["......"]], [11, "多罗", [[0, "这个东西不能用吗？我们要打开下一扇门才能用它？"]], ["......"]], [10, "巴蒂", [[0, "（庆幸）你总算说对了。接下来，为了找回记忆和真相，我要试着打开下一扇门了！"]], ["......"]], [400, "小赛尔", [[0, "打开下一扇门，这个说法很妙啊。即将在我们面前打开的，不仅是面前的这扇大门，还有记忆的大门，真相的大门。而我们，都不知道在门后等着我们的将是什么。"]], ["......"]]];
        DisplayUtil.removeForParent(e.currentTarget as MovieClip);
        ++count;
        if (count == 4) {
            NpcDialog.showDialogs(dialog3, function ():void {
                QuestManager.completeStep(_quest.id, 2);
                SceneManager.changeScene(SceneType.LOBBY, 70);
            });
        }
    }

    private function initStep2():void {
        var i:int;
        var nm:MovieClip = null;
        var dialog:Array = null;
        var dialog2:Array = null;
        var movie1:MovieClip = null;
        var mc:MovieClip = null;
        nm = _processor.resLib.getMovieClip("nnnppp");
        nm.x += 450;
        nm.y += 100;
        SceneManager.active.mapModel.front.addChild(nm);
        nm.mouseChildren = false;
        i = 0;
        while (i < 4) {
            mc = _processor.resLib.getMovieClip("qq_" + i) as MovieClip;
            mc.name = "mc_" + i;
            SceneManager.active.mapModel.front.addChild(mc);
            mc.addEventListener(MouseEvent.CLICK, this.onClick);
            this.tem.push(mc);
            i++;
        }
        dialog = [[400, "小赛尔", [[0, "（环顾四周）这里就是研究院……斯坦因留给我们的线索……"]], ["......"]], [11, "多罗", [[0, "这里好空旷啊，看起来好厉害！"]], ["......"]], [11, "多罗", [[0, "等会ミ(ﾉ゜д゜)ﾉ会不会有什么危险啊？"]], ["（努力无视掉多罗造成的紧张气氛）"]], [400, "小赛尔", [[0, "如果在之前，我一定会认为这是斯坦因要算计我们，从而不敢到这里来，但是现在不一样了。我们选择相信以前不会去相信的人，他也选择帮助以前不会去帮助的人。"]], ["......"]], [10, "巴蒂", [[0, "（没有说话，只是仔细打量着研究院中央的巨大设施）……"]], ["......"]], [400, "小赛尔", [[0, "（感受着莫名的安静，似乎暴风雨来临之前的宁静）……"]], ["......"]], [11, "多罗", [[0, "（多罗……已经全然懵了！！！）……"]], ["......"]], [10, "巴蒂", [[0, "哇！！！！有什么东西从天上飞下来了！！！"]], ["......"]], [11, "多罗", [[0, "妈呀！吓死我了！"]], ["......"]], [3105, "飞羽伊特", [[0, "吓……吓死宝宝了！"]], ["......"]], [11, "多罗", [[0, "妈呀！这又是谁？！……是，是不是怪物？"]], ["其实鬼哭狼嚎的多罗才是最可怕的。"]]];
        dialog2 = [[3105, "飞羽伊特", [[0, "ヽ(ｏ`皿′ｏ)ﾉ说谁是怪物呢？你才是怪物！大铁皮！"]], ["等等……这不是？"]], [10, "巴蒂", [[0, "啊，看外形是飞伊特的超进化体吧？是斯坦因把你留在这里的么？"]], ["......"]], [3105, "飞羽伊特", [[0, "ヽ(=^･ω･^=)丿还是大姐姐了解我！就是斯坦因博士把我放在这里的哦！虽然不知道为什么，但是我自从记事起就是在这里的哦！"]], ["果然，除了风暴伊特之外还有啊！"]], [10, "巴蒂", [[0, "那么，你知道……【研究院中央的这个大东西】，是干什么的吗？"]], ["......"]], [3105, "飞羽伊特", [[0, "（乖巧地摇头）不知道……我只是觉得，从侧面看上去……有点像博士的脸！ヾ(｡｀Д´｡)"]], ["这……咋一看还真像= =|||"]], [10, "巴蒂", [[0, "好……好吧。ԅ(¯﹃¯ԅ)b不过……这个设施，看上去挺好懂的……"]], ["......"]], [400, "小赛尔", [[0, "巴蒂，说来听听。"]], ["......"]], [10, "巴蒂", [[0, "上半部分是一个大玻璃容器，容器里有一些电极，线路通向下方的基座内部……我的第一感觉是【精灵培养。】"]], ["......"]], [3105, "飞羽伊特", [[0, "（高兴）巴蒂姐姐好厉害！"]], ["......"]], [11, "多罗", [[0, "听起来好厉害的样子，虽然我还是不懂。"]], ["......"]], [400, "小赛尔", [[0, "就像……培养伊特一族精灵的设施那样？"]], ["......"]], [3105, "飞羽伊特", [[0, "不过我好像从来没进入过这个设施……也没有看见博士使用过它呢！~ヾ(*´▽‘*)ﾉ"]], ["真是厉害的命题啊。"]], [10, "巴蒂", [[0, "唔。既然容器里有一些电极，我想应该和精灵的脑部有关……难道是研究精灵的思维方式吗？"]], ["可怕的科学狂人啊……"]], [400, "小赛尔", [[0, "斯坦因的科学研究，已经与我们的科学体系脱离许久……以我们的经验知识，很难通过直接的研究来得知这个设施的功能吧。所以，最好的办法就是实践出真知。"]], ["......"]], [10, "巴蒂", [[0, "（思考了一会）……队长说的对，我刚才想得太深刻了，毕竟我是最聪明的。那么现在，我们就从眼下的需求入手吧。"]], ["......."]], [11, "多罗", [[0, "你们……要干什么┌(。Д。)┐"]], ["......."]], [10, "巴蒂", [[0, "笨啦！√(─皿─)√当然是要试着开机啦！打开这个设施用一用不就知道它是干嘛的了嘛！"]], ["......."]], [11, "多罗", [[0, "怎……怎么开机？"]], ["......"]], [10, "巴蒂", [[0, "（盯着多罗）……"]], ["......."]], [400, "小赛尔", [[0, "你怎么了？"]], ["......."]], [10, "巴蒂", [[0, "这个问题我还真没想过。"]], ["…ヘ(_ _ヘ)在研究院的各个地方找找线索吧"]]];
        movie1 = _processor.resLib.getMovieClip("movie1");
        _map.front.addChild(movie1);
        movie1.mouseChildren = false;
        movie1.gotoAndStop(1);
        NpcDialog.showDialogs(dialog, function ():void {
            MovieClipUtil.playMc(movie1, 2, movie1.totalFrames, function ():void {
                NpcDialog.showDialogs(dialog2, function ():void {
                });
            });
        });
    }
}
}
