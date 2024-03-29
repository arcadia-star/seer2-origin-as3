package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.utils.IDataInput;

import org.taomee.utils.BitUtil;

public class ChuanShuoZhuiSuAct {

    private static var _instance:ChuanShuoZhuiSuAct;


    private var dialogs:Array;

    private var NPC_IDS:Array;

    private var _haveGotPet:Boolean;

    public function ChuanShuoZhuiSuAct() {
        this.dialogs = [[[400, "赛尔", [[0, "这里是……赫尔卡星荒地？……我分明在草目氏族的深林里，为何……"]], ["......"]], [1066, "雷神·雷伊", [[0, "雷文的使者，终于还是来了。"]], ["......"]], [1066, "雷神·雷伊", [[0, "不必讶异，你仍在阿卡迪亚。这赫尔卡的愿景，只是我以精细的电流击穿空气、投射出的幻影罢了。我：……你被召唤至阿卡迪亚很久了啊，雷伊。这荒凉的愿景……你很孤独吧？"]], ["......"]], [1066, "雷神·雷伊", [[0, "我生于赫尔卡文明的末日……此生，本注定是孤独的。这颗星球很美丽，也很有趣。来到这里，我不觉得有所遗憾"]], [" ......"]], [1066, "雷神·雷伊", [[0, "不必讶异，你仍在阿卡迪亚。这赫尔卡的愿景，只是我以精细的电流击穿空气、投射出的幻影罢了。我：……你被召唤至阿卡迪亚很久了啊，雷伊。这荒凉的愿景……你很孤独吧？"]], ["......"]], [1066, "雷神·雷伊", [[0, "我生于赫尔卡文明的末日……此生，本注定是孤独的。这颗星球很美丽，也很有趣。来到这里，我不觉得有所遗憾"]], ["......"]], [400, "赛尔", [[0, "但你一直在寻找回去的路。不是么？"]], ["......"]], [1066, "雷神·雷伊", [[0, "赫尔卡所在的帕诺星系，与这阿卡迪亚相距数十万光年……以自然的力量，无论我有多快，此生不可能回到那里。不过我还是在努力。"]], ["......"]], [1066, "雷神·雷伊", [[0, "我想，你应该见过……雷神形态，原本是与阿卡迪亚的上古器灵共生，很难持续存在。如今，我终于能控制这力量了。我很快，快得几乎无与伦比。但我仍旧回不到那里。"]], ["......"]], [400, "赛尔", [[0, "……你归乡的思念，或许可以通过两艘赛尔号飞船的跃迁对接来实现。不过，远程建立空间跳跃连接，以我们的技术也要数年之久……"]], ["......"]], [1066, "雷神·雷伊", [[0, "不用为我担心。这颗阿卡迪亚给我带来了很多挑战和责任。我喜欢这里，这里也需要我。如果命运无法被挑战，那我就以恒心让它屈服。"]], ["......"]], [400, "赛尔", [[0, "我明白雷文上尉为何让我来找你了。"]], ["......"]], [1066, "雷神·雷伊", [[0, "哦？说来听听。"]], ["......"]], [400, "赛尔", [[0, "雷，声势浩大，气吞山河，狂暴桀骜缺不失威严，就像永不服输且绝对自信的昂扬斗志。"]], ["......"]], [400, "赛尔", [[0, "电，电平静而又犀利，光芒万丈，又好似黎明一样充满希望，即是荡除邪恶的极致正义。"]], ["......"]], [1066, "雷神·雷伊", [[0, "不愧是雷文看中之人。你对这雷电的理解深之又深……不错，你所说的雷电象征的精神，即是X队的精神。永不退缩，正气凌然，一往无前。"]], ["......"]], [1066, "雷神·雷伊", [[0, "大赛筹备之初，我便有所关注，雷文邀请我成为其中一队的旗帜，我也欣然答应。毕竟……赛尔是我在这星球上仅剩的旧友。看着你们成长与拼搏，我也很欣慰。"]], ["......"]], [1066, "雷神·雷伊", [[0, "这阿卡迪亚星历经无数兴衰、无数的风雨……形容已不为过。每一个存在文明的星球，都是这样……我不想让这颗星球成为下一个赫尔卡。"]], ["......"]], [1066, "雷神·雷伊", [[0, "那些狂妄的恶徒，妄图控制不属于自己的力量，将灾难强加于弱者，踩着战火踏上统治地位。我在这里，我有能力阻止他们，所以我不允许。"]], ["......"]], [400, "赛尔", [[0, "是的，能力越强，责任越大！"]], ["精灵王争霸赛——我来了！"]], [1066, "雷神·雷伊", [[0, "五年来，你赛尔所做的始终与我想做的一致。地球人是个伟大的文明，他们将自己的正义与责任传承给了你们……"]], ["......"]], [400, "赛尔", [[0, "赫尔卡的正义与责任，也体现在这高贵的金色雷电之中。雷神雷伊，象征着X队雷电精神的旗帜——请将你的力量借给我们！"]], ["......"]], [1066, "雷神·雷伊", [[0, "无妨。在成为你的伙伴前，请向我重复一遍希望之光的寓意。希望之光不只是唤醒精灵王约瑟的条件，也是希望的曙光。谨记，与其寻找希望，莫如成为希望"]], ["......"]], [400, "赛尔", [[0, "是，我明白了，与其寻找希望，莫如成为希望！"]], ["......"]]], [[400, "赛尔", [[0, "火源通径这鬼地方……！！真是要热成传说了！！！"]], ["......"]], [1064, "炎帝·凯萨", [[0, "来者何人？！"]], ["......"]], [400, "赛尔", [[0, "哇啊！凯萨，别激动，是我……诶，你怎么一身狼狈不堪的样子……"]], ["......"]], [1064, "炎帝·凯萨", [[0, "是你啊……铁皮。如你所见，近些日子，我已经可以稳定操控上古器灵的力量了。炎爪帮助我集中火焰，我尝试做出一个能自由操控的火分身。这会儿出了点儿小问题，它爆炸了……弄了我一身的灰。见笑了。"]], ["......"]], [400, "赛尔", [[0, "呃，不不。我可不是来找你聊天的啊。"]], ["......"]], [1064, "炎帝·凯萨", [[0, "不急，不急。我知道你的来意。早在争霸赛开赛前，门罗就曾亲自来此与我商谈，邀请我成为Y队的旗帜。没想到你竟然是Y队的一分子，真是荣幸有加。"]], ["......"]], [1064, "炎帝·凯萨", [[0, "所谓旗帜，是象征着队伍精神的灵魂。恕我冒昧，我想听一听你对于[火]的理解——你觉得，火能带来什么？"]], ["......"]], [400, "赛尔", [[0, "唔……火可以带来温暖，又可以焚毁一切事物，火是多变的。例如一簇火焰和燎原之火，它们的外形不同，威力也是相差甚远，但它们都拥有一颗炽热的心，一个可以带来温暖希望，给人信心，另一个则能令敌人闻风丧胆，焚尽八荒。即使把火焰扑灭，只要存留一点火星便可复燃，再度猛烈燃烧，生生不息，永不放弃，这便是火的精神。"]], ["......"]], [1064, "炎帝·凯萨", [[0, "……诚然，门罗不欺我。你的理解很透彻。"]], ["......"]], [400, "赛尔", [[0, "呃……你怎么突然沉默了？我说错什么了吗？"]], ["......"]], [1064, "炎帝·凯萨", [[0, "曾经，我被力量蒙蔽了双眼，做出了无法挽回的事。如今，希望之光仍不知身在何处，作为火幻的守护者，我背叛了我族与约瑟王数千年不变的羁绊。"]], ["......"]], [400, "赛尔", [[0, "能源之潮的那场战役已是过去的事了。你没有忽视自己的错误，没有逃避自己的责任，选择了承担、选择了弥补。如今你的所作所为，无愧于炎帝之名啊！"]], ["......"]], [1064, "炎帝·凯萨", [[0, "你真认真，铁皮。（笑）"]], ["......"]], [400, "赛尔", [[0, "我去，我这么认真的想安慰你，你还笑！"]], ["......"]], [1064, "炎帝·凯萨", [[0, "火苗可以温暖心灵，但温度仍旧很高。如果它的外形使人放松警惕，就有可能伤及无辜。烈焰可以燃遍敌阵，但也会波及自己。如果它的力量不被加以控制，整个世界都有可能被蔓延。"]], ["......"]], [1064, "炎帝·凯萨", [[0, "我明白的。火焰象征着一种很难控制的力量。只有铭记错误，才能让这火不再伤及本应守护的事物。"]], ["......"]], [400, "赛尔", [[0, "我可以！请成为我们的旗帜，炎帝！"]], ["......"]], [1064, "炎帝·凯萨", [[0, "很好。与其寻找希望，莫如成为希望。希望本无形，这火，你，我，都能成为希望的微光。带着我赋予的火苗，去照亮整个世界吧！"]], ["......"]]], [[400, "赛尔", [[0, "炼狱，这个地方还是这么令人毛骨悚然，更何况还是最底层的忏悔宗殿……"]], ["..........."]], [1065, "冥王·撒旦", [[0, "你……是谁？"]], ["..........."]], [400, "赛尔", [[0, "撒旦，你还记得我吗？"]], ["..........."]], [1065, "冥王·撒旦", [[0, "你是……是你啊，面熟的赛尔。我知道你的来意。是克拉克让你来找我的吧？为了争霸赛的事。"]], ["..........."]], [400, "赛尔", [[0, "（紧张）尊敬的冥王，我代表争霸赛Z队，向您来寻求力量。"]], ["..........."]], [1065, "冥王·撒旦", [[0, "在寻求力量之前……且听我讲一个故事吧。"]], ["..........."]], [1065, "冥王·撒旦", [[0, "五千年前……那撕裂大地的双王之战后，几近毁灭的阿卡迪亚星以数百年的时间重获新生……自然环境的更替诞生了许多新种类的精灵，【他】也是其中之一……"]], ["..........."]], [1065, "冥王·撒旦", [[0, "他很虚弱。一股强大的能量在腐蚀着他的躯体。他又充满欲望，然而他很虚弱，故被长久的欺凌……他想得到力量。之后，他成功了。他变得很强大，很多精灵对他望而生畏……他变得贪婪，他不想只居于现状……"]], ["..........."]], [1065, "冥王·撒旦", [[0, "他妒忌那些强大而又很有风度的精灵，于是无限制地开发自己的力量，希望有朝一日能击败他们。他很自私，所以没有朋友，他希望得到友情，又害怕失去，他剥夺了这位对他以心相交的朋友的自由……"]], ["..........."]], [1065, "冥王·撒旦", [[0, "在变强的过程中，他遭到强烈的反噬，奄奄一息。一个人类救下了他，并悉心照料，他第一次感受到了温暖。但由于这个人的身份与一件事，那人被关进了世界上最可怕的监狱，受尽非人的折磨"]], ["..........."]], [1065, "冥王·撒旦", [[0, "他变得暴躁愤怒，开始堕落，迷惘。他迷失自我，扪心自问，这就是我想要的么？这就是我希望看到的么？这就是我想得到的么？不！这不是"]], ["..........."]], [1065, "冥王·撒旦", [[0, "他终日忏悔，希望靠自己的能力赎罪，也救赎自己。"]], ["..........."]], [400, "赛尔", [[0, "真是凄惨的故事，但结局不坏。"]], ["..........."]], [1065, "冥王·撒旦", [[0, "他就是我，我即是他。七宗罪我都承受过，很痛苦，令人彷徨，令人迷惘，令人迷失自我，令人忘记初衷……我的本意不过是想自保而已，但现在却仍走上了救赎之路。"]], ["..........."]], [1065, "冥王·撒旦", [[0, "其实阿卡迪亚的现状又何尝不是如此？正义者弱小羸弱，利欲熏心者蠢蠢欲动，权与力把玩着整个阿卡迪亚……欲望使人自私残暴，无恶不作，整个阿卡迪亚变得乌烟瘴气……"]], ["..........."]], [1065, "冥王·撒旦", [[0, "直到数年前的阿卡迪亚，与以往早已无可比拟……它沉沦堕落，这是你我都不愿看到的。人心难测，七情六欲，最是可怕。"]], ["..........."]], [400, "赛尔", [[0, "历史竟如此惊人地相似！"]], ["..........."]], [1065, "冥王·撒旦", [[0, "然而，从你们身上，我看到了希望。仅仅五年，你们解决了整个北半球乃至半个南半球的大量问题……有几杆秤，似乎总得由局外人来把握。你们对阿卡迪亚星的贡献，是不可估量的。"]], ["..........."]], [400, "赛尔", [[0, "阿卡迪亚的希望与公正仍在，罪恶会被严惩，无辜着会被守护。这也是这次争霸赛所寄托的精神，也是我们Z队所向往的精神！"]], ["..........."]], [1065, "冥王·撒旦", [[0, "有志气的小家伙。你很让我满意，但救赎这个世界仅仅只有实力是不够的。与其寻找希望，莫如成为希望，迷惘不知方向，那就走那个自己相信的方向。堕落并不可怕，可怕的是无知与无动于衷。"]], ["..........."]], [1065, "冥王·撒旦", [[0, "这份力量……是我对原罪的忏悔所得。没有洁净的心灵，就无法控制它。我相信你，所以将这份力量借给你……现在，我们一同开创未来吧！"]], ["..........."]]]];
        this.NPC_IDS = [1066, 1064, 1065];
        super();
    }

    public static function get instance():ChuanShuoZhuiSuAct {
        if (!_instance) {
            _instance = new ChuanShuoZhuiSuAct();
        }
        return _instance;
    }

    public function setUp():void {
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onCustomUnitClick);
    }

    private function onCustomUnitClick(param1:DialogPanelEvent):void {
        if (param1.content.params != "ChuanShuoZhuiSuAct") {
            return;
        }
        var _loc2_:int = (param1.target as DialogPanel).currentNpcId;
        var _loc3_:int = this.NPC_IDS.indexOf(_loc2_);
        this.clickNpc(_loc3_);
    }

    private function clickNpc(param1:int):void {
        var index:int = param1;
        if (YueseCraft2016Act.instance.army == 0) {
            return;
        }
        ActiveCountManager.requestActiveCount(206371, function (param1:uint, param2:uint):void {
            var _loc3_:Boolean = Boolean(BitUtil.getBit(param2, YueseCraft2016Act.instance.army - 1));
            if (!_loc3_) {
                if (YueseCraft2016Act.instance.army - 1 == index) {
                    receivePet();
                }
            } else if (YueseCraft2016Act.instance.army - 1 != index) {
                fight(index);
            }
        });
    }

    private function receivePet():void {
        var teamIndex:int = 0;
        teamIndex = int(YueseCraft2016Act.instance.army);
        NpcDialog.showDialogs(this.dialogs[teamIndex - 1], function ():void {
            SwapManager.swapItem(4560, 1, function success(param1:IDataInput):void {
                new SwapInfo(param1);
                SceneManager.changeScene(SceneType.LOBBY, 70);
            }, function failed(param1:uint):void {
            }, new SpecialInfo(2, 0, teamIndex - 1));
        });
    }

    private function fight(param1:int):void {
        var index:int = param1;
        var fightDialogs:Array = [[[1066, "雷神·雷伊", [[0, "来自" + this.teamName + "队的挑战者吗……五年的磨砺，你们的精神和实力已经成长起来了，但面对未来的挑战还远远不够。不尝试放弃吗？不出力也没有人会埋怨你，直面整个阿卡迪亚的邪恶是需要巨大的勇气的。"]], ["......."]], [400, "赛尔", [[0, "既然来了，就没有放弃的道理。既然已经有了觉悟，就不会动摇半点决心。我不会退却！"]], ["......"]], [1066, "雷神·雷伊", [[0, "孤傲不屈，这是战士的眼神。我收回前言——让我看看你的本事吧，年轻的赛尔！"]], ["放马过来，雷神！", "我准备准备再来"]]], [[1064, "炎帝·凯萨", [[0, "终于来了，" + this.teamName + "队的挑战者……咦，居然是你啊？"]], ["......"]], [400, "赛尔", [[0, "炎帝凯萨，作为Y队的旗帜，做好与我们一决高下的觉悟了吗！"]], ["......"]], [1064, "炎帝·凯萨", [[0, "哟呵……气场不小。有意思！有意思！"]], ["......"]], [1064, "炎帝·凯萨", [[0, "哈哈哈哈对不起。忍不住被你认真的态度震慑到了。诚然，赛尔都很博学，也很勇敢。但光有头脑是不行的——如果不能拿出实力，纸上谈兵，只能被消灭！"]], ["......"]], [1064, "炎帝·凯萨", [[0, "来吧，让我的火焰来见证，这五年的时间，孱弱的你们成长到了怎样的地步！"]], ["放马过来，炎帝！", "我准备准备再来"]]], [[1065, "冥王·撒旦", [[0, this.teamName + "队的挑战者，恭候多时。在接受你的挑战前，容我一问……你可知道七宗罪分别是哪七宗？"]], ["......"]], [400, "赛尔", [[0, "七宗罪，即是七种不可饶恕的重大罪过，分别是傲慢，妒忌，暴怒，欲望，怠惰，暴食及贪婪。这七种原罪乃是世间一些罪恶之本，应当加以警醒。"]], ["......"]], [1065, "冥王·撒旦", [[0, "你觉得……这个充斥着原罪的世界，还有什么值得去守护和留恋呢？"]], ["......"]], [400, "赛尔", [[0, "我们仅仅用了五年时间就解决了这么多的事，将来也定会让黑暗无所遁形。曙光仍然在闪耀，希望从未黯淡！"]], ["....."]], [1065, "冥王·撒旦", [[0, "看来，是一个值得认真应对的挑战者。战队可不仅需要智力，还要有实力、以及坚不可摧的灵魂。让我看看你的灵魂有多纯净吧……！"]], ["放马过来，撒旦！", "我准备准备再来"]]]];
        NpcDialog.showDialogs(fightDialogs[index], function ():void {
            var fightId:int = 0;
            fightId = 1820 + index;
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, function complete(param1:SceneEvent):void {
                if (SceneManager.prevSceneType == SceneType.ARENA) {
                    SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, complete);
                    if (fightId == FightManager.currentFightRecord.initData.positionIndex) {
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                    }
                }
            });
            FightManager.startFightWithWild(fightId);
        });
    }

    private function get teamName():String {
        return ["X", "Y", "Z"][YueseCraft2016Act.instance.army - 1];
    }
}
}
