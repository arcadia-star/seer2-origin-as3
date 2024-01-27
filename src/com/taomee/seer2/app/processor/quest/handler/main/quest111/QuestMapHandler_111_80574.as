package com.taomee.seer2.app.processor.quest.handler.main.quest111 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;

public class QuestMapHandler_111_80574 extends QuestMapHandler {


    public function QuestMapHandler_111_80574(param1:QuestProcessor) {
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
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.initStep();
        }
    }

    private function initStep():void {
        var dialog1:Array = null;
        var dialog2:Array = null;
        var mv0:MovieClip = null;
        var mv1:MovieClip = null;
        var dialog0:Array = [[7, "娜威拉", [[0, "嗨，第七小队，这里是资料室。我是情报部长娜威拉，找我有什么事吗？"]], ["……"]], [400, "小赛尔", [[0, "娜威拉部长，今天你还是这么漂亮。"]], ["没办法，按部长的性格，一定要夸夸她才好。"]], [7, "娜威拉", [[0, "年轻人，嘴越来越甜了嘛！好了，说正事吧"]], ["（作为部长她还是很敬业的。）"]], [400, "小赛尔", [[0, "部长，我们申请使用飞船的量子计算机处理一些数据。恳请部长批准。"]], ["……"]], [7, "娜威拉", [[0, "第七小队啊……（沉默了一会）从定位来看你们现在是在飞翼氏族，那里有什么新发现么？"]], ["……"]], [400, "小赛尔", [[0, "在飞翼氏族发现了疑似斯坦因制作的设施，我们本着了解斯坦因的行为的目的对其进行了调查，发现其中有一些限于设施计算能力而未处理的信息。"]], ["……"]], [7, "娜威拉", [[0, "斯坦因？！是他！这下就有意思了。量子计算机的使用权我批给你们，有发现的话别忘了第一时间汇报我。"]], [" 突然变得严肃起来了……"]], [400, "小赛尔", [[0, "多谢娜威拉部长！祝你永远青春美丽！"]], ["结束时也例行夸夸她吧。"]], [7, "娜威拉", [[0, "不愧是周游各族纵横捭阖的星际使者，真会说话！那么，接下来就加油探索吧！有发现了一定要汇报啊！"]], [" 放心吧，娜威拉部长！"]], [10, "巴蒂", [[0, "娜威拉部长，除此之外，我还想了解一件事"]], ["巴蒂你这是？"]], [7, "娜威拉", [[0, "你……想了解斯坦因的事吗？是你个人提出的这个要求，还是你的团队？"]], [" 巴蒂这么问一定是有原因的……"]], [10, "巴蒂", [[0, "以我个人的名义提出。娜威拉部长，请允许我浏览关于斯坦因之前所从事的研究的信息！"]], ["……"]], [7, "娜威拉", [[0, "这个……（有些犹豫）斯坦因这个家伙啊……以你的权限能看到的内容有限，原则上他的很多研究都属于保密内容，不对外开放的。"]], ["  这样啊。"]], [7, "娜威拉", [[0, "但是，对于巴蒂你，我可以网开一面。我相信你们能保守秘密。 "]], [" 部长，为什么？"]], [10, "巴蒂", [[0, "部长，你有什么能“违背原则”让我看到机密的方法？"]], ["巴蒂的关注点果然不一样……"]], [11, "多罗", [[0, "听……听起来很黑的样子？巴蒂……是要窃取机密吗？"]], [" 你这么说话绝对会被巴蒂……"]], [10, "巴蒂", [[0, "你个笨蛋！天才之间的事，怎么能叫“窃取”呢？！"]], ["……我说的没错。"]], [7, "娜威拉", [[0, "话也不能这么说，我只是卖个人情而已。你们是能理解她的，对么？"]], [" 那是当然，我们是队友啊！"]], [7, "娜威拉", [[0, "虽然已经被废弃了，但是旧资料室的那台老式计算机还可以使用，（丢出一张卡片）我想聪明的巴蒂知道怎么用，也知道怎么删除访问记录。"]], [" 原来是这样。"]], [10, "巴蒂", [[0, "谢谢娜威拉部长，以后有什么难题就找我吧，我一定倾力相助！"]], ["……"]], [7, "娜威拉", [[0, "真是进步很大啊……去吧，那里有着通向旧资料室的暗门，一定记得我这个人情啊！"]], ["  ……"]], [7, "娜威拉", [[0, "总有人想着用各种方式埋葬过去，但是那些往事，难道真的就能如他们所愿那般如烟消散么？"]], ["  ……"]]];
        dialog1 = [[400, "小赛尔", [[0, "巴蒂，她究竟想干什么啊？"]], ["……"]], [7, "娜威拉", [[0, "她啊，也许是因为太聪明了，所以有些行为会一时间令人感觉难以理解吧。毕竟，天才都是比较令人难以理解的。不过我觉得她在和你们组队之后成长了不少。"]], [" 为什么这么说呢？"]], [7, "娜威拉", [[0, "虽然聪明，但是她不懂得照顾别人的感受，恃才傲物，听不进别人的话……你们让她成长了不少啊。"]], ["这样看来，她还真的成长了不少呢。"]], [11, "多罗", [[0, "最最最美丽的娜威拉部长，那我呢？"]], ["……"]], [7, "娜威拉", [[0, "（笑）每个人都需要鼓励啊，多罗你跟着他们，想必也变得更聪明了吧？"]], ["这……应该是吧。"]], [11, "多罗", [[0, "应……应该是的！队长和巴蒂都那么聪明，我也不应该拖后腿！"]], [" 无论如何是个令人感动的家"]], [7, "娜威拉", [[0, "那么你们都要好好努力啊，看在最聪明最美丽的情报员娜威拉的份上！"]], [" 当然了，娜威拉部长！"]]];
        dialog2 = [[10, "巴蒂", [[0, "队长，我的事情已经解决了。现在开始使用超级计算机吧，我想结果会很快出来的。"]], [" 巴蒂，你回来了？"]], [10, "巴蒂", [[0, "是啊，我回来了。我们都会回来的"]], ["……"]], [400, "赛尔", [[0, "过去，我们回来了；未来，我们来了。"]], ["……"]]];
        mv0 = SceneManager.active.mapModel.content["mv0"];
        mv1 = SceneManager.active.mapModel.content["mv1"];
        NpcDialog.showDialogs(dialog0, function ():void {
            MovieClipUtil.playMc(mv0, 2, mv0.totalFrames, function ():void {
                NpcDialog.showDialogs(dialog1, function ():void {
                    MovieClipUtil.playMc(mv1, 2, mv1.totalFrames, function ():void {
                        NpcDialog.showDialogs(dialog2, function ():void {
                            QuestManager.completeStep(_quest.id, 2);
                            SceneManager.changeScene(SceneType.LOBBY, 70);
                        });
                    });
                });
            });
        });
    }
}
}
