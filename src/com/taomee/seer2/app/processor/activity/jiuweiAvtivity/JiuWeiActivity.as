package com.taomee.seer2.app.processor.activity.jiuweiAvtivity {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class JiuWeiActivity {

    private static var isFight:Boolean = false;


    private var _currFightCount:uint;

    public function JiuWeiActivity() {
        super();
        this.getFightCount();
        DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW, this.onDialogShow);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
    }

    private function onDialogShow(param1:DialogPanelEvent):void {
        if (this._currFightCount >= 9) {
            if (DialogPanel.functionalityBox.getUnit("挑战神秘九尾")) {
                DialogPanel.functionalityBox.removeUnit(DialogPanel.functionalityBox.getUnit("挑战神秘九尾"));
            }
        }
    }

    private function onActivityUnitClick(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if ((evt.content as DialogPanelEventData).params == "fightJiuWei") {
            NpcDialog.show(564, "神秘九尾", [[0, "勇敢的赛尔，我可是拥有9种力量哦，你必须通过我的9次试炼才能得到我哦！"]], ["我可以打败你！", "我只是路过。"], [function ():void {
                NpcDialog.show(564, "神秘九尾", [[0, getStatic()[0]]], ["我可以打败你！", "我只是路过。"], [function ():void {
                    isFight = true;
                    FightManager.startFightWithWild(getStatic()[1]);
                }]);
            }]);
        }
    }

    private function getFightCount():void {
        ActiveCountManager.requestActiveCount(202236, function (param1:uint, param2:uint):void {
            var type:uint = param1;
            var count:uint = param2;
            _currFightCount = count;
            if (SceneManager.prevSceneType == SceneType.ARENA && isFight) {
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    if (_currFightCount < 9) {
                        NpcDialog.show(564, "神秘九尾", [[0, getStatic()[0]]], ["我可以打败你！", "我只是路过。"], [function ():void {
                            isFight = true;
                            FightManager.startFightWithWild(getStatic()[1]);
                        }]);
                    } else {
                        isFight = false;
                        NpcDialog.show(564, "神秘九尾", [[0, "你终于完成了我所有的试炼，强大的赛尔，让我与你随行吧！"]], ["确定。"]);
                    }
                } else if (_currFightCount < 9) {
                    NpcDialog.show(564, "神秘九尾", [[0, "你还不行哦，变得更强大点再来挑战我吧！"]], ["不行！我要再试一次。", "好的。"], [function ():void {
                        isFight = true;
                        FightManager.startFightWithWild(getStatic()[1]);
                    }, function ():void {
                        isFight = false;
                    }]);
                }
            }
        });
    }

    private function getStatic():Array {
        var _loc1_:Array = [];
        switch (this._currFightCount) {
            case 0:
                _loc1_ = ["第一次试炼，在冰雪领域的条件下击败我的第一个分身，它会<font color=\'#ff0000\'>" + "闪避你的所有物攻伤害" + "</font>。", 408];
                break;
            case 1:
                _loc1_ = ["不错！你已经通过了第一次试炼，接下来会更强哦，在冰雪领域的条件下击败我的第二个分身，它会<font color=\'#ff0000\'>" + "闪避你的所有特攻伤害" + "</font>。", 409];
                break;
            case 2:
                _loc1_ = ["不错！你已经通过了第二次试炼，接下来会更强哦，在冰雪领域的条件下击败我的第三个分身，它会<font color=\'#ff0000\'>" + "闪避你的所有的攻击伤害" + "</font>。", 410];
                break;
            case 3:
                _loc1_ = ["不错！你已经通过了第三次试炼，接下来会更强哦，在冰雹领域的条件下击败我的第四个分身，它会<font color=\'#ff0000\'>" + "反射你的所有物攻伤害" + "</font>。", 411];
                break;
            case 4:
                _loc1_ = ["不错！你已经通过了第四次试炼，接下来会更强哦，在冰雹领域的条件下击败我的第五个分身，它会<font color=\'#ff0000\'>" + "反射你的所有特攻伤害" + "</font>。", 412];
                break;
            case 5:
                _loc1_ = ["不错！你已经通过了第五次试炼，接下来会更强哦，在冰雹领域的条件下击败我的第六个分身，它会<font color=\'#ff0000\'>" + "反射你所有的伤害" + "</font>。", 413];
                break;
            case 6:
                _loc1_ = ["不错！你已经通过了第六次试炼，接下来会更强哦，在冰锥领域的条件下击败我的第七个分身，它会<font color=\'#ff0000\'>" + "免疫所有异常状态" + "</font>。", 414];
                break;
            case 7:
                _loc1_ = ["不错！你已经通过了第七次试炼，接下来获得胜利就将获得我了，在冰锥领域的条件下击败我的第八个分身，它会<font color=\'#ff0000\'>" + "免疫所有不良状态" + "</font>。", 415];
                break;
            case 8:
                _loc1_ = ["真厉害！打败我的第九个分身，你将可以获得我的纹章了，在冰封领域的条件下击败我的第九个分身，它会<font color=\'#ff0000\'>" + "免疫所有异常和不良状态" + "</font>。", 416];
        }
        return _loc1_;
    }

    public function dispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW, this.onDialogShow);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
    }
}
}
