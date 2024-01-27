package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.ui.ButtonPanelData;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1065;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.net.MessageEvent;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class MapProcessor_700 extends MapProcessor {


    private var _animationBtn:SimpleButton;

    private const MAX_ANIMATION_COUNT:uint = 5;

    public function MapProcessor_700(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_265);
        this._animationBtn = _map.content["mc_8123asdfds"];
        Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065, this.onGetEnergyLotteryCnt);
        Connection.send(CommandSet.DAILY_LIMIT_1065, 345);
    }

    private function onActivityUnitClick(param1:DialogPanelEvent):void {
        var btnData:ButtonPanelData = null;
        var event:DialogPanelEvent = param1;
        btnData = new ButtonPanelData();
        btnData.catchEnabled = false;
        if ((event.content as DialogPanelEventData).params == "fight_dual_npc_700") {
            FightManager.startFightBinaryWild(73);
        } else if ((event.content as DialogPanelEventData).params == "fight_super_dual_npc_700") {
            ActiveCountManager.requestActiveCountList([206378], function (param1:Parser_1142):void {
                var par:Parser_1142 = param1;
                if ((par.infoVec[0] & 1 << 2 - 1) >> 2 - 1 > 0) {
                    NpcDialog.show(102, "观察员纳格托", [[0, "嗯……一一得一，二二得二……"]], ["......"], [function ():void {
                        NpcDialog.show(400, "小赛尔", [[0, "你好像说错了【……】"]], ["......"], [function ():void {
                            NpcDialog.show(102, "观察员纳格托", [[0, "啊！星际使者！吓我一跳，请别在人家专心演算的时候突然出现啊！"]], ["........."], [function ():void {
                                NpcDialog.show(400, "小赛尔", [[0, "汗……我又不是超能系精灵怎么会瞬间移动，话说你有没有见到飞羽伊特呢？"]], ["......"], [function ():void {
                                    NpcDialog.show(102, "观察员纳格托", [[0, "！！当然了，那孩子经常来我这玩，唉，我这又不是玩的地方，动动望远镜看我算数之类的，斯坦因也算个科学家，怎么就没教他严谨行事呢……"]], ["......"], [function ():void {
                                        NpcDialog.show(400, "小赛尔", [[0, "额……下次我看见他帮你数落他两句好了"]], ["......"], [function ():void {
                                            NpcDialog.show(102, "观察员纳格托", [[0, "唉，换换心情清扫怨气，来和我打一场吧，最近听说要办什么比赛我也想练练手不做个只会家里蹲算数的~"]], ["......"], [function ():void {
                                                NpcDialog.show(400, "小赛尔", [[3, "好吧，我就来陪你锻炼一下……"]], ["我不想挨打……", "挑战观察员！"], [null, function ():void {
                                                    FightManager.startFightBinaryWild(1835, null, null, btnData);
                                                }]);
                                            }]);
                                        }]);
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                } else {
                    AlertManager.showAlert("你还没有战胜萨伯尔兵团长哦!");
                }
            });
        }
    }

    private function onGetEnergyLotteryCnt(param1:MessageEvent):void {
        var _loc3_:uint = 0;
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onGetEnergyLotteryCnt);
        var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
        if (_loc2_.id == 345) {
            _loc3_ = _loc2_.count;
            if (_loc3_ >= 1) {
                this._animationBtn.removeEventListener(MouseEvent.CLICK, this.onAnimation);
            } else {
                this._animationBtn.addEventListener(MouseEvent.CLICK, this.onAnimation);
            }
        }
        if (QuestManager.isAccepted(38) && QuestManager.isComplete(38) == false) {
            this._animationBtn.removeEventListener(MouseEvent.CLICK, this.onAnimation);
        }
    }

    private function onAnimation(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        var ran:uint = uint(uint(Math.random() * this.MAX_ANIMATION_COUNT) + 1);
        MovieClipUtil.playFullScreen("res/sceneInteractive/" + ran + ".swf", function ():void {
            _animationBtn.removeEventListener(MouseEvent.CLICK, onAnimation);
            SwapManager.swapItem(259);
        }, false);
    }

    override public function dispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onGetEnergyLotteryCnt);
        this._animationBtn.removeEventListener(MouseEvent.CLICK, this.onAnimation);
        this._animationBtn = null;
        super.dispose();
    }
}
}
