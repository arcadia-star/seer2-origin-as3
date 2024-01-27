package com.taomee.seer2.app.processor.quest.handler.main.quest101 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_101_80509 extends QuestMapHandler {


    private var _clickTarget:DisplayObject;

    public function QuestMapHandler_101_80509(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        if (this._clickTarget != null) {
            this._clickTarget.removeEventListener(MouseEvent.CLICK, this.fight);
            this._clickTarget = null;
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
    }

    override public function processMapComplete():void {
        var _loc1_:Mobile = null;
        super.processMapComplete();
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 1) == false) {
            return;
        }
        if (!QuestManager.isAccepted(_quest.id)) {
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.initStep2();
            _loc1_ = MobileManager.getMobile(180, MobileType.NPC);
        } else if (QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.initStep3();
        }
    }

    private function initStep2():void {
        var dialog2_1:Array = null;
        var dialog2_2:Array = null;
        var dialog2_3:Array = null;
        var dialog2_0:Array = [[3094, "撒莱尔", [[0, "星际使者。你带这四位族人来到我面前，想必是有办法找出叛徒了？"]], ["......"]], [400, "小赛尔", [[0, "撒莱尔，这四位族人，你有印象吗？"]], ["......"]], [3094, "撒莱尔", [[0, "我已在影子密室拱卫法典百年有余……这四位都是熟悉的面孔，但与夺走法典者并不相像。事实上，夺走法典的族人我未曾见过，想必是变装而来。"]], ["......"]], [400, "小赛尔", [[0, "能瞒住法典守护者的变装者，真是不容小觑……撒莱尔，我这有一计，听我说…………"]], ["......"]], [3094, "撒莱尔", [[0, "……简单精妙的好计策。不愧是星际使者。不过，叛徒实力强硬，你要做好作战准备。"]], ["没问题。"]]];
        dialog2_1 = [[3020, "弗雷德", [[0, "做为暗影氏族的族人，想必诸位都已经听说了暗影法典的事情。那么，对于自己和这件事情的关系，诸位也应该心里清楚。"]], ["......"]], [400, "小赛尔", [[0, "贵族的守护者——撒莱尔，将用暗影法典的力量找出你们之中的背叛者。待到黑暗降临，请你们挨个去握一下他的手。倘若背叛者被识别出来，那么撒莱尔将当场指出这个人！"]], ["......"]], [3098, "翟", [[0, "为了和平，鄙人久经考验，这次又何妨呢！"]], ["......"]], [3097, "乌尔栀", [[0, "感觉好吓人啊，但是这和我又有什么关系呢？"]], ["......"]], [3096, "斯卡沃兹", [[0, "为了暗影氏族，我不惜一试。"]], ["......"]], [3095, "艾本德", [[0, "那就来吧。"]], ["......"]]];
        dialog2_2 = [[400, "小赛尔", [[0, "好的，现在看看你们的手吧。"]], ["......"]], [3097, "乌尔栀", [[0, "我手上的是什么东西啊？抽象派纹身？"]], ["......"]], [3098, "翟", [[0, "这是……暗影氏族常用的暗影标记……是撒莱尔做下的标记吗？"]], ["......"]], [3095, "艾本德", [[0, "……但为什么有人的手上没有？（警觉）"]], ["......"]], [3096, "斯卡沃兹", [[0, "这是怎么回事？（有些惊慌）难道是刚才……？不，不对，刚才并没有发生什么啊？"]], ["......"]], [400, "小赛尔", [[0, "斯卡沃兹，你还有什么可说的么？！"]], ["（没想到居然是满载贵族气质的他……）"]], [3096, "斯卡沃兹", [[0, "星际使者，你说什么？我似乎不甚明白"]], ["......"]], [400, "小赛尔", [[0, "撒莱尔根本没有直接指出叛徒，而是在每一个和他握过手的人的手上做了暗影标记。真正的叛徒害怕自己被指出，所以根本没有和撒莱尔握手——他的手上是干净的！"]], ["......"]], [3094, "撒莱尔", [[0, "确实如此。只有三个人与我握手。"]], ["......"]], [3096, "斯卡沃兹", [[0, "（语塞，脸色似乎有些难看）这……这怎么……"]], ["......"]], [3020, "弗雷德", [[0, "(严肃）是不是这样？斯卡沃兹，你还有机会，希望你不要辜负了星际使者和影灵兽。"]], ["......"]], [3096, "斯卡沃兹", [[0, "（沉默）……"]], ["......"]], [3095, "艾本德", [[0, "（冷眼）果然是有问题吗？"]], ["......"]], [3097, "乌尔栀", [[0, "天哪，似乎是很严重的事情呢……"]], ["......"]], [3098, "翟", [[0, "但愿你明白暗影法典对世间战局的影响。"]], ["......"]], [3096, "斯卡沃兹", [[0, "(突然爆发出疯狂的笑声）呵哈哈！！星际使者，干得不错啊，借用我们对暗影法典力量的敬畏引我出来么？很对，没错！我就是你们所谓的“叛徒”！"]], ["......"]], [3020, "弗雷德", [[0, "（失望）亏你嘴上总是挂着“暗影氏族”……没想到啊。"]], ["......"]], [3096, "斯卡沃兹", [[0, "你懂什么？老朽的人啊！萨伦帝国统治世界是大势所趋，暗影氏族区区之地，怎么能违逆天下之大势？还一心一意龟缩在世界阴暗的角落里吗？这样的暗影氏族有何未来可言？"]], ["......"]], [3098, "翟", [[0, "（气愤）大势所趋？用暴力让世界屈服是大势所趋？"]], ["......"]], [3095, "艾本德", [[0, "（冷酷的语气）暗影氏族的未来，还由不得你这个出卖了氏族秘密的人来指摘！"]], ["......"]], [3096, "斯卡沃兹", [[0, "还有你，所谓星际使者。萨伦帝国已经在北半球大获全胜，你只不过是逃窜到南半球的失败者而已！暗影氏族能选上你这样的人来拯救也真是让我大失所望。（冷笑）不过，能揭发出我的身份，你也还算有用。"]], ["......"]], [400, "小赛尔", [[0, "（这是什么意思？而且刚才揭发身份的计谋还不是我设计的……这不就是在说我没用吗？！）"]], ["北半球还没有失败！"]], [400, "小赛尔", [[0, "只要它的人民还在反抗，萨伦帝国就不会成功！"]], ["......"]], [3098, "翟", [[0, "（敬佩）说的对！胜利属于正义的人民！"]], ["......"]], [400, "小赛尔", [[0, "而且我并不是逃窜来南半球的，我肩负北半球的希望，也肩负着阿卡迪亚未来的希望！只要这希望还在，我就不会停止前进！"]], ["......"]], [3096, "斯卡沃兹", [[0, "(表情有些扭曲）哈哈哈，太好了，“希望”，你那是什么希望？希望不属于你们这群弱者，北半球、暗影氏族，终究会被萨伦帝国征服！现在归顺还来得及！"]], ["......"]], [3020, "弗雷德", [[0, "（命令）把他拿下！我会在主城召集全体族人一起审判这个叛徒！"]], ["......"]], [3098, "翟", [[0, "（敬佩）说的对！胜利属于正义的人民！"]], ["......"]]];
        dialog2_3 = [[3099, "暗影伊特", [[0, "咯咯……看来你们是要跟我的主人动手嘛？"]], ["......"]], [3020, "弗雷德", [[0, "（震惊）这是什么精灵？！我族之外居然还有这么强大的暗影系精灵吗……！！"]], ["......"]], [3094, "撒莱尔", [[0, "没有错……叛徒抢夺暗影法典时，与我交手的就是这只精灵！"]], ["......"]], [400, "小赛尔", [[0, "……这只精灵……好眼熟……"]], [" 赶紧用赛尔的精灵传感系统分析一下！……"]], [400, "小赛尔", [[0, "我知道它是什么了！！斯坦因博士曾在实验禁地创造了一只分支进化精灵……这只精灵的外形、生物讯号，都和暗伊特极为相似！"]], ["......"]], [10, "巴蒂", [[0, "……呲啦…呲啦……队长，听到了吗队长？！母舰提供的分析结果出来了，这确实是暗伊特的异变进化形态！数据上表明——"]], ["......"]], [1003, "多罗", [[0, "哎呀现在还有时间分析什么数据吗？！队长！超进化后的精灵与原形态的特征相似，我们有每一只伊特形态的详细资料，按暗伊特的方案来对付它！"]], ["......"]], [400, "小赛尔", [[0, "还用你说吗我当然知道！！撒莱尔，这里只有你能与它一战了！相信我，我对这只精灵的原形态了如指掌，我能帮你击败它！"]], ["......"]], [3094, "撒莱尔", [[0, "我明白了——星际使者，指挥交给你了！此战誓必拿下这个叛徒！"]], ["......"]], [3099, "暗影伊特", [[0, "咯咯……守护者大人，上一阵还没有输够吗？"]], ["......"]], [3094, "撒莱尔", [[0, "情报的量决定作战的胜负。晚辈，动用暴力之前，不作思考就夸下海口，可是会被命运所抛弃的！"]], ["（成功击败暗影伊特之后才可继续剧情）"]]];
        NpcDialog.showDialogs(dialog2_0, function ():void {
            NpcDialog.showDialogs(dialog2_1, function ():void {
                var movie0:MovieClip = null;
                movie0 = _processor.resLib.getMovieClip("Movie_0");
                _map.front.addChild(movie0);
                MovieClipUtil.playMc(movie0, 1, movie0.totalFrames, function ():void {
                    NpcDialog.showDialogs(dialog2_2, function ():void {
                        var movie1:MovieClip = null;
                        DisplayUtil.removeForParent(movie0);
                        movie1 = _processor.resLib.getMovieClip("Movie_1");
                        _map.front.addChild(movie1);
                        movie1.addEventListener(MouseEvent.CLICK, fight);
                        movie1.mouseChildren = false;
                        movie1.buttonMode = true;
                        _clickTarget = movie1;
                        MovieClipUtil.playMc(movie1, 1, movie1.totalFrames, function ():void {
                            NpcDialog.showDialogs(dialog2_3, function ():void {
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                                QuestManager.completeStep(questID, 2);
                                fight();
                            });
                        });
                    });
                });
            });
        });
    }

    private function initStep3():void {
        var _loc1_:MovieClip = _processor.resLib.getMovieClip("Movie_1");
        _loc1_.gotoAndStop(_loc1_.totalFrames);
        _loc1_.buttonMode = true;
        _loc1_.mouseChildren = false;
        _map.front.addChild(_loc1_);
        _loc1_.addEventListener(MouseEvent.CLICK, this.fight);
        this._clickTarget = _loc1_;
    }

    private function onFightOver():void {
        var dialog:Array = null;
        if (FightManager.fightWinnerSide == FightSide.LEFT) {
            dialog = [[3020, "弗雷德", [[0, "星际使者，感谢你的帮助。叛徒已经安全地被押送走了。"]], ["......"]], [400, "小赛尔", [[0, "（松了一口气）这件事应该告一段落了，但是……我刚才说了什么？（喃喃细语）肩负北半球的希望"]], ["（希望……那是什么？）"]], [3020, "弗雷德", [[0, "暗影氏族将感谢你为大家做出的贡献。我邀请你和暗影氏族的全体族人一起公审氏族的叛徒！"]], ["......"]], [400, "小赛尔", [[0, "感谢族长的邀请，但是……我突然想到了什么，有一件很重要的事情要去完成。所以，恕我不能参加了。"]], ["......"]], [3020, "弗雷德", [[0, "没有关系的，星际使者，我们一定会妥善处理叛徒的问题。这次十分感谢你。"]], ["......"]], [400, "小赛尔", [[0, "这是星际使者的使命……（似乎想到了什么）因为我要寻找希望……『希望之光』？"]], ["......"]]];
            NpcDialog.showDialogs(dialog, function ():void {
                DisplayUtil.removeForParent(_clickTarget);
                QuestManager.completeStep(questID, 3);
            });
        } else {
            NpcDialog.show(3099, "暗影伊特", [[0, "咯咯……还不服吗？"]], [" 再来！（点击再次挑战）"], [function ():void {
                fight();
            }]);
        }
    }

    private function fight(param1:* = null):void {
        var fightId:int = 0;
        var e:* = param1;
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        fightId = 1792;
        ModuleManager.closeForInstance(this);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, function complete(param1:SceneEvent):void {
            if (SceneManager.prevSceneType == SceneType.ARENA) {
                SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, complete);
                if (fightId == FightManager.currentFightRecord.initData.positionIndex) {
                    onFightOver();
                }
            }
        });
        FightManager.startFightWithWild(fightId);
    }

    private function onStep(param1:QuestEvent):void {
        if (param1 == null || param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            this.fight();
        }
    }
}
}
