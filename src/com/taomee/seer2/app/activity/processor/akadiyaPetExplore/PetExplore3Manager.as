package com.taomee.seer2.app.activity.processor.akadiyaPetExplore {
import com.greensock.TweenNano;
import com.taomee.seer2.app.config.questAnswer.QuestInfo;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.ArrayUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class PetExplore3Manager {

    private static const MAP_ID:int = 80580;

    private static const QUESTIONS:Array = [["桃花潭水深千尺", ["疑似银河落九天", "不及汪伦送我情"], 2], ["吴质不眠倚桂树", ["露脚斜飞湿寒兔", "江州司马青衫湿"], 1], ["十年生死两茫茫", ["左牵黄，右擎苍", "不思量，自难忘"], 2], ["长太息以掩涕兮", ["哀民生之多艰", "吾将上下而求索"], 1], ["芙蓉如面柳如眉", ["春风拂槛露华浓", "对此如何不泪垂"], 2], ["二十四桥仍在", ["波心荡，冷月无声", "长空淡，烟水悠悠"], 1], ["拼将十万头颅血", ["去留肝胆两昆仑", "须把乾坤力挽回"], 2], ["风急天高猿啸哀", ["渚清沙白鸟飞回\t", "不尽长江滚滚来"], 1], ["已是悬崖百丈冰", ["只有香如故", "犹有花枝俏"], 2]];

    private static var DIALOGS:Array = [[3124, "诗风", [[0, "久在樊笼里，复得返自然。不禁逸兴遄飞啊。"]], [" 你……等等，这不是释放神兽的按钮吗？你是什么……？"]], [3124, "诗风", [[0, "名吾曰诗风兮，集诗歌以抒怀~若你能【对出吾所言之诗歌的下半句】，吾便给予你奖励~"]], ["行吧！我准备好了！ ", "我再准备准备……"]]];

    private static var DIALOGS_0:Array = [[3124, "诗风", [[0, "答错啦！~~大铁皮也不过如此嘛。这些羽毛就作为你的奖励吧~"]], [" 好吧好吧……"]]];

    private static var DIALOGS_1:Array = [[3124, "诗风", [[0, "厉害了！！居然全部答对了~~~。这些羽毛就作为你的奖励吧~"]], [" 谢谢你~~"]]];

    private static var _randomQuestions:Array;

    private static var _npcMv:DisplayObject;


    public function PetExplore3Manager() {
        super();
    }

    public static function start():void {
        if (SceneManager.active.mapID == MAP_ID) {
            initMap();
        } else {
            SceneManager.changeScene(SceneType.COPY, MAP_ID);
        }
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitch);
    }

    private static function onMapSwitch(param1:SceneEvent):void {
        var _loc2_:int = 0;
        if (SceneManager.active.type != SceneType.ARENA) {
            _loc2_ = int(SceneManager.active.mapID);
            if (MAP_ID == _loc2_) {
                initMap();
            } else {
                if (_npcMv != null) {
                    _npcMv.parent.removeChild(_npcMv);
                    _npcMv.removeEventListener(MouseEvent.CLICK, onNpcClick);
                }
                SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitch);
            }
        }
    }

    private static function initMap():void {
        _npcMv = SceneManager.active.mapModel.content["npc"];
        _npcMv.addEventListener(MouseEvent.CLICK, onNpcClick);
        startDialog();
    }

    private static function onNpcClick(param1:* = null):void {
        startDialog();
    }

    private static function initRandomQuestions():void {
        _randomQuestions = [];
        var _loc1_:int = 0;
        while (_loc1_ < QUESTIONS.length) {
            _randomQuestions.push(QUESTIONS[_loc1_]);
            _loc1_++;
        }
        _randomQuestions = ArrayUtil.randomArray(_randomQuestions);
    }

    private static function startDialog():void {
        NpcDialog.showDialogs(DIALOGS, function ():void {
            startQuest(function (param1:int):void {
                var dialogs:Array = null;
                var num:int = param1;
                if (num < 4) {
                    dialogs = DIALOGS_0;
                } else {
                    dialogs = DIALOGS_1;
                }
                NpcDialog.showDialogs(dialogs, function ():void {
                    SceneManager.changeScene(SceneType.LOBBY, 70);
                    SwapManager.swapItem(4623, 1, function success(param1:IDataInput):void {
                        new SwapInfo(param1);
                    }, null, new SpecialInfo(1, num));
                });
            });
        });
    }

    private static function startQuest(param1:Function):void {
        var index:int = 0;
        var fun:Function = null;
        var callback:Function = param1;
        index = 0;
        initRandomQuestions();
        fun = function ():void {
            var answers:Vector.<String>;
            var i:int;
            var qs:Vector.<QuestInfo>;
            var question:QuestInfo = new QuestInfo();
            question.ask = _randomQuestions[index][0];
            answers = new Vector.<String>();
            i = 0;
            while (i < _randomQuestions[index][1].length) {
                answers.push(_randomQuestions[index][1][i]);
                i++;
            }
            question.selectItems = answers;
            question.answer = _randomQuestions[index][2];
            qs = new Vector.<QuestInfo>();
            qs.push(question);
            ModuleManager.showModule(URLUtil.getAppModule("QuestAnswerPanel"), "正在打开答题面板...", {
                "time": 60,
                "questions": qs,
                "isRandom": false,
                "timeOutFunc": function (param1:int):void {
                    if (param1 == 0) {
                        callback(index);
                        return;
                    }
                    ++index;
                    if (index == _randomQuestions.length || index >= 5) {
                        callback(index);
                    } else {
                        TweenNano.delayedCall(0.5, fun);
                    }
                }
            });
        };
        fun();
    }
}
}
