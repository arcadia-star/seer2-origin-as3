package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_730 extends MapProcessor {


    public function MapProcessor_730(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_267);
    }

    private function onActivityUnitClick(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "fight_super_dual_npc_730") {
            ActiveCountManager.requestActiveCountList([206378], function (param1:Parser_1142):void {
                var par:Parser_1142 = param1;
                if ((par.infoVec[0] & 1 << 3 - 1) >> 3 - 1 > 0) {
                    NpcDialog.show(95, "克里斯蒂", [[0, "哎呦呦~这不是星际使者大人嘛，来来，过来姐姐这边，和姐姐过一会下午茶时光~"]], ["......"], [function ():void {
                        NpcDialog.show(400, "小赛尔", [[0, "额……大姐我还忙着呢。"]], ["......"], [function ():void {
                            NpcDialog.show(95, "克里斯蒂", [[0, "你叫我啥？！【怒目而视】"]], ["........."], [function ():void {
                                NpcDialog.show(400, "小赛尔", [[0, "呃，没事……正好和你打听打听飞羽伊特的事，你看见了她了吗？"]], ["......"], [function ():void {
                                    NpcDialog.show(95, "克里斯蒂", [[0, "看到了哦，真是个活泼的小家伙呢，有时候过来和我一起逛街，她呀，对什么都好奇，让我逛了不少好店家，你看，我更加光鲜亮丽了都是靠她……"]], ["......"], [function ():void {
                                        NpcDialog.show(400, "小赛尔", [[0, "停停停！和你侃时尚又要到黄昏了，飞羽伊特在哪儿呢？找她一天了……"]], ["......"], [function ():void {
                                            NpcDialog.show(95, "克里斯蒂", [[0, "好像跟每个人都挺亲的呀，这孩子，总算变得像飞行系精灵，自由一些了，对了，要不要来和我试试手，等我参加族内大赛得了奖，买点小零食饼干经验果什么的送给这孩子答谢好啦！"]], ["......"], [function ():void {
                                                NpcDialog.show(400, "小赛尔", [[3, "嗯，好的，话说我也想吃些甜食……"]], ["我不想挨打……", " 挑战克里斯蒂！"], [null, function ():void {
                                                    FightManager.startFightBinaryWild(1836);
                                                }]);
                                            }]);
                                        }]);
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                } else {
                    AlertManager.showAlert("你还没有战胜观察员纳格托哦!");
                }
            });
        }
    }

    override public function dispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
    }
}
}
