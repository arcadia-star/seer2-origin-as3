package com.taomee.seer2.app.processor.quest.handler.main.quest103 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_103_80516 extends QuestMapHandler {

    private static var count:int;


    private var th0:MovieClip;

    private var th1:MovieClip;

    private var th2:MovieClip;

    private var th3:MovieClip;

    private var tem:Array;

    public function QuestMapHandler_103_80516(param1:QuestProcessor) {
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
        var dialog3:Array = [[400, "小赛尔", [[0, "我没有找到这个芯片的插口，也就是说，它似乎不能打开这个设施。而且，我也没有找到类似于“开机键”的东西。可能只有右边的那扇门了，控制系统在那扇门里。"]], ["......"]], [106, "斯坦因", [[0, "巴蒂姐姐不要气馁啊，有我给你加油的~（嫌弃）不过，那个大喊大叫的家伙好吓人的！"]], ["......"]], [400, "小赛尔", [[0, "对……对不起……"]], ["......."]], [3100, "风暴伊特", [[0, "虽然很喜欢巴蒂姐姐，但想让我跟着你们的话，你们还要通过我的考验！"]], ["果然，虽然可爱，但是也很任性啊……"]], [400, "小赛尔", [[0, "好好好……考验就考验吧，我……我一定将功补过！"]], ["......"]], [106, "斯坦因", [[0, "不过话说回来，对于这么大的设施，把控制系统放在一个房间也不是没有可能。巴蒂，那扇门能打开么？"]], ["......"]], [3100, "风暴伊特", [[0, "从技术手段上来说应该可以，不过需要一定的时间。"]], ["......"]], [400, "小赛尔", [[0, "这个东西不能用吗？我们要打开下一扇门才能用它？"]], ["......"]], [3100, "风暴伊特", [[0, "（庆幸）你总算说对了。接下来，为了找回记忆和真相，我要试着打开下一扇门了！"]], ["......"]], [400, "小赛尔", [[0, "打开下一扇门，这个说法很妙啊。即将在我们面前打开的，不仅是面前的这扇大门，还有记忆的大门，真相的大门。而我们，都不知道在门后等着我们的将是什么。"]], ["......"]]];
        ++count;
        if (count == 4) {
            NpcDialog.showDialogs(dialog3, function ():void {
                QuestManager.completeStep(_quest.id, 2);
            });
        }
    }

    private function initStep2():void {
        var dialog:Array = null;
        var dialog2:Array = null;
        var movie1:MovieClip = null;
        var i:int = 0;
        while (i < 4) {
            this.tem[i] = _processor.resLib.getMovieClip("qq_" + i);
            SceneManager.active.mapModel.front.addChild(this.tem[i]);
            this.tem[i].addEventListener(MouseEvent.CLICK, this.onClick);
            i++;
        }
        dialog = [[400, "小赛尔", [[0, "（环顾四周）这里就是研究院……斯坦因留给我们的线索……"]], ["......"]], [11, "多罗", [[0, "这里好空旷啊，看起来好厉害！"]], ["......"]], [11, "多罗", [[0, "会不会有什么危险啊？"]], ["（努力无视掉多罗造成的紧张气氛）"]], [400, "小赛尔", [[0, "如果在之前，我一定会认为这是斯坦因要算计我们，从而不敢到这里来，但是现在不一样了。我们选择相信以前不会去相信的人，他也选择帮助以前不会去帮助的人。"]], ["......"]], [10, "巴蒂", [[0, "（没有说话，只是仔细打量着研究院中央的巨大设施）……"]], ["......"]], [400, "小赛尔", [[0, "（感受着莫名的安静，似乎暴风雨来临之前的宁静）……"]], ["......"]], [3100, "风暴伊特", [[0, "（已经全然懵了）……"]], ["......"]], [400, "小赛尔", [[0, "（突然开口，恍然大悟的样子）我知道了！这个设施的用处……看来这次他真的想要帮助我们！"]], ["......"]], [3100, "风暴伊特", [[0, "妈呀！吓死我了！"]], ["......"]], [400, "小赛尔", [[0, "吓……吓死宝宝了！"]], ["......"]], [3100, "风暴伊特", [[0, "妈呀！这又是谁？！……是，是不是怪物？"]], ["其实鬼哭狼嚎的多罗才是最可怕的。"]]];
        dialog2 = [[400, "小赛尔", [[0, "{从巨大的设施后面闪出来}说谁是怪物呢？你才是怪物！大铁皮！"]], ["等等……这不是？"]], [106, "斯坦因", [[0, "啊，看外形是飞伊特的超进化体吧？是斯坦因把你留在这里的么？"]], ["......"]], [400, "小赛尔", [[0, "（高兴）还是大姐姐了解我！就是斯坦因博士把我放在这里的哦！虽然不知道为什么，但是我自从记事起就是在这里的哦！"]], ["果然，除了风暴伊特之外还有啊！"]], [400, "小赛尔", [[0, "那么，你知道这个大东西是干什么的？"]], ["......"]], [106, "斯坦因", [[0, "（乖巧地摇头）不知道……？"]], ["......"]], [400, "小赛尔", [[0, "（有些失望）这样啊。不过，对于这个设施，我已经知道了一些……！"]], ["......"]], [106, "斯坦因", [[0, "巴蒂，说来听听。"]], ["......"]], [400, "小赛尔", [[0, "很显然，这座设施和斯坦因在飞翼氏族做的其他东西一样，都是将科技与精灵的能力结合起来制成的。"]], ["......"]], [106, "斯坦因", [[0, "它分析并利用了精灵的精神类能力，并将其放大。以这种能力为基础将数以万计的精灵的思维链接起来，形成巨大的信息系统。"]], ["精灵的精神类能力？"]], [400, "小赛尔", [[0, "（高兴）巴蒂姐姐好厉害！"]], ["......"]], [106, "斯坦因", [[0, "听起来好厉害的样子，虽然我还是不懂。"]], ["......"]], [400, "小赛尔", [[0, "也就是说，它将精灵的思维连成了网络，就像互联网一样。"]], ["......"]], [106, "斯坦因", [[0, "就是这样。这个信息系统包含着巨大的信息量，数以万计的记忆和思维都在其中。但是这又有什么用呢？模拟“最强大脑”的极限，还是探索计算机发展的新领域？"]], ["真是厉害的命题啊。"]], [400, "小赛尔", [[0, "但是目前看来，我们似乎失去了一些记忆，既然这个设施能够综合精灵的记忆，那么我们就可以通过精灵的视角看看当时究竟发生了什么。"]], ["......"]], [106, "斯坦因", [[0, "（思考了一会）……队长说的对，我刚才想得太深刻了，毕竟我是最聪明的。那么现在，我们就从眼下的需求入手吧。"]], ["......"]], [400, "小赛尔", [[0, "你们……要干什么？"]], ["......."]], [106, "斯坦因", [[0, "笨啦！当然是要试着开机啦！"]], ["......."]], [106, "斯坦因", [[0, "怎……怎么开机？"]], ["......"]], [400, "小赛尔", [[0, "（盯着多罗）……"]], ["......."]], [106, "斯坦因", [[0, "巴蒂你怎么了？"]], ["......."]], [106, "斯坦因", [[0, "这个问题我还真没想过。"]], ["…ヘ(_ _ヘ)在研究院的各个地方找找线索吧"]]];
        movie1 = _processor.resLib.getMovieClip("movie");
        _map.front.addChild(movie1);
        movie1.mouseChildren = false;
        NpcDialog.showDialogs(dialog, function ():void {
            MovieClipUtil.playMc(movie1, 2, movie1.totalFrames, function ():void {
                NpcDialog.showDialogs(dialog2, function ():void {
                });
            });
        });
    }
}
}
