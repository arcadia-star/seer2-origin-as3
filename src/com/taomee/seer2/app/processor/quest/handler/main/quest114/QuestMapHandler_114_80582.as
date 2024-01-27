package com.taomee.seer2.app.processor.quest.handler.main.quest114 {
import com.greensock.TweenLite;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_114_80582 extends QuestMapHandler {

    private static var isStartFight:Boolean = false;


    private var _dialog0:Array;

    private var _dialog1:Array;

    private var _dialog2:Array;

    private var _fightId:int = 1865;

    private var _clickTargets:Array;

    public function QuestMapHandler_114_80582(param1:QuestProcessor) {
        this._dialog0 = [[519, "奥罗吉尔", [[0, "嘤嘤嘤……博士……我又把事情搞砸了……又被嫌弃了…… "]], ["……"]], [400, "小赛尔", [[0, "收到了巴蒂的通讯，她还好。多罗，跟上！我们要尽快想办法营救。"]], [" 哎？这不是上次的铁皮吗？"]], [11, "多罗", [[0, "队长！你看那些柱子！ "]], ["柱子？"]], [400, "小赛尔", [[0, "那些记号？上次还没有的，莫非是斯坦因留下的？ ？"]], ["斯坦因是什么"]], [11, "多罗", [[0, "队长，我们来试试看吧？ "]], ["你们……你们又要干什么？"]], [519, "奥罗吉尔", [[0, "停！你们难道没有发现美丽可爱的我吗？！这次我一定为博士看好门！先过我这关吧！"]], ["……"]], [400, "小赛尔", [[0, "奥罗吉尔……斯坦因派你看守这里的？ "]], ["斯坦因是什么东西？"]], [11, "多罗", [[0, "就……就是那个黑黑的老铁皮啊！ "]], ["哎？博士？博士叫斯坦因？"]], [400, "小赛尔", [[0, "原来你不知道……算了。这些信息是他留下的么？ "]], ["什么信息？那些字？"]], [11, "多罗", [[0, "是……是啊。（望向旁边的铁皮）队长，她的理解能力比我还弱哎？ "]], ["你……你说什么？可恶！看招！"]]];
        this._dialog1 = [[519, "奥罗吉尔", [[0, "哼！好歹出了一口气！叫你们嫌弃我！"]], ["……"]], [400, "小赛尔", [[0, "我们并没有嫌弃你啊，我们只是来问问那些符号…… "]], ["好啦，能来这里的只有你们和博士！就是博士好啦！"]], [400, "小赛尔", [[0, "那就好，我们来试试。 "]], ["……"]]];
        this._dialog2 = [[400, "小赛尔", [[0, "成功了！不过总是让人怀疑啊……为什么这样做？"]], ["……"]], [11, "多罗", [[0, "队长……接下来怎么办？ "]], ["……"]], [400, "小赛尔", [[0, "鉴于刚才收到的是量……通信，我怀疑这里屏蔽……线电信号。"]], [" 什么东西？好厉害的样子？"]], [400, "小赛尔", [[0, "为了确保安全，我们向克拉克……联络。 "]], ["（然后他拿出了一个什么东西开始讲话）"]], [6, "克拉克", [[0, "这里是……，我是……官克拉克。请讲。 "]], ["好多不知道什么东西的词汇……"]], [400, "小赛尔", [[0, "……小队在风刃……研究所遭遇斯坦因，我和队员巴蒂同时掉入陷阱，但是我……送回地面，并且在刚才收到了巴蒂疑似……地下的量……通信信号。 "]], ["反正我很多都没听懂啦……"]], [6, "克拉克", [[0, "斯坦因……巴蒂情况如何？你们接下来作何打算？ "]], ["……"]], [400, "小赛尔", [[0, "巴蒂目前……良好。我们看见了斯坦因提供的线索，再次打开了机关，预备……营救。但是斯坦因行为诡异，所以…… "]], ["……"]], [6, "克拉克", [[0, "我会联系其他……队作为……支援，期间务必保持通讯畅通。完毕。 "]], ["就这么完了？"]], [400, "小赛尔", [[0, "好了，得到了后援，我们就着手营救吧！"]], ["怎么营救？"]], [11, "多罗", [[0, "队……队长，我们是要跳下去吗？ "]], ["不然呢？"]], [11, "多罗", [[0, "妈呀！队队队队长，you jump I 不 jump啊！风刃氏族太……太凶险了…… "]], ["胆小鬼，跳下去又摔不死！"]], [400, "小赛尔", [[0, "你想想，巴蒂还一个人在底下呢！ "]], ["……"]], [11, "多罗", [[0, "巴蒂……对啊！为了队友我……我不能退缩！亮晶晶小队冲啊！……但是还是好可怕。"]], ["……"]], [400, "小赛尔", [[0, "为了让我们安全地跳下去，我们需要风系精灵或者飞行系精灵的帮助。 "]], ["喂！看这里看这里！别忘了我啊！"]], [11, "多罗", [[0, "这听起来放心了一点……那个，队长，奥罗吉尔…… "]], ["……"]], [400, "小赛尔", [[0, "奥罗吉尔，我们相信你的能力！只要发挥最好的自己，不要在乎别人的目光！要不要帮我们一程？ "]], ["太……太感动了！我终于被赏识了！"]], [400, "小赛尔", [[0, "我一定好好帮你们！我要让你们看看最美丽的风！走吧！ "]], ["……"]], [11, "多罗", [[0, "为了队友，不抛弃不放弃，亮晶晶小队……冲啊！"]], ["……"]]];
        this._clickTargets = [];
        super(param1);
    }

    override public function processMapComplete():void {
        if (!QuestManager.isAccepted(_quest.id)) {
            return;
        }
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        if (isStartFight) {
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        var mv:MovieClip = SceneManager.active.mapModel.content["mv0"];
        mv.gotoAndPlay(1);
        MovieClipUtil.playMc(mv, 2, mv.totalFrames, function ():void {
            NpcDialog.showDialogs(_dialog0, function ():void {
                SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onFightOver);
                isStartFight = true;
                FightManager.startFightWithWild(_fightId);
            });
        });
    }

    private function initStep1_0():void {
        NpcDialog.showDialogs(this._dialog1, function ():void {
            initBtns();
        });
    }

    private function initBtns():void {
        var _loc3_:MovieClip = null;
        var _loc1_:MovieClip = SceneManager.active.mapModel.content["keyMc"];
        _loc1_.addEventListener(MouseEvent.CLICK, this.onButtonsClick);
        var _loc2_:int = 0;
        while (_loc2_ < 5) {
            _loc3_ = _loc1_["key_" + _loc2_];
            _loc3_.mouseChildren = false;
            _loc3_.buttonMode = true;
            _loc3_.gotoAndStop(1);
            if (_loc2_ == 0) {
                _loc3_.gotoAndStop(2);
            }
            _loc2_++;
        }
    }

    private function onFightOver(param1:* = null):void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (this._fightId == FightManager.currentFightRecord.initData.positionIndex) {
                this.initStep1_0();
            }
        }
    }

    private function onButtonsClick(param1:MouseEvent):void {
        var isFinishAll:Boolean;
        var i:int;
        var index:int = 0;
        var keyMc:MovieClip = null;
        var mv:MovieClip = null;
        var e:MouseEvent = param1;
        var btnName:String = String(e.target.name);
        index = parseInt(btnName.split("_")[1]);
        if (index != 0 && this._clickTargets.indexOf(index - 1) != -1 || index == 0) {
            this._clickTargets.push(index);
            keyMc = e.target as MovieClip;
            keyMc.gotoAndStop(3);
            keyMc.mouseChildren = keyMc.mouseEnabled = false;
            if (index != 4) {
                keyMc.parent["key_" + (index + 1)].gotoAndStop(2);
            }
        }
        isFinishAll = true;
        i = 0;
        while (i < 5) {
            if (this._clickTargets.indexOf(i) == -1) {
                isFinishAll = false;
                break;
            }
            i++;
        }
        if (isFinishAll) {
            mv = SceneManager.active.mapModel.content["stairMc"];
            MovieClipUtil.playMc(mv, 2, mv.totalFrames, function ():void {
                initStep1_1();
            });
        }
    }

    private function initStep1_1():void {
        NpcDialog.showDialogs(this._dialog2, function ():void {
            var cover:DisplayObject = SceneManager.active.mapModel.front["cover"];
            cover.visible = true;
            cover.alpha = 0;
            TweenLite.to(cover, 3, {
                "alpha": 1,
                "onComplete": function ():void {
                    SceneManager.changeScene(SceneType.COPY, 80583);
                }
            });
        });
    }
}
}
