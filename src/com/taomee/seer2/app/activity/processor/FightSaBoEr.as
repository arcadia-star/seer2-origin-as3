package com.taomee.seer2.app.activity.processor {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.activity.data.ActivityDefinition;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.ui.ButtonPanelData;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1140;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.display.MovieClip;

public class FightSaBoEr extends ActivityProcessor {

    private static const MAP_ID:uint = 660;

    private static const NORMAL_FIGHT_INDEX:uint = 61;

    private static const SPECIAL_FIGHT_INDEX:uint = 62;

    private static const DUALPET_FIGHT_INDEX:uint = 60;

    private static const EVENT_INDEX:uint = 17;


    private var _map:MapModel;

    private var _sceneAnimation:MovieClip;

    public function FightSaBoEr(param1:ActivityDefinition) {
        super(param1);
    }

    override public function start():void {
        this.initEventListener();
        super.start();
    }

    override protected function onMapStart(param1:SceneEvent):void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
    }

    override protected function onMapComplete(param1:SceneEvent):void {
        var btnData:ButtonPanelData = null;
        var evt:SceneEvent = param1;
        if (Boolean(SceneManager.active) && SceneManager.active.mapID == MAP_ID) {
            btnData = new ButtonPanelData();
            btnData.catchEnabled = false;
            if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == NORMAL_FIGHT_INDEX && FightManager.fightWinnerSide != FightSide.LEFT) {
                NpcDialog.show(83, "萨伯尔兵团长", [[1, "如何？萨伯尔兵团和那些看门的可不一样……（露出了嘲讽的表情）"]], ["哎……那我还是走了", "继续挑战！"], [null, function ():void {
                    FightManager.startFightWithWild(NORMAL_FIGHT_INDEX, null, null, btnData);
                }]);
            } else if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == DUALPET_FIGHT_INDEX && FightManager.fightWinnerSide != FightSide.LEFT) {
                NpcDialog.show(83, "萨伯尔兵团长", [[1, "如何？萨伯尔兵团和那些看门的可不一样……（露出了嘲讽的表情）"]], ["哎……那我还是走了", "继续挑战！"], [null, function ():void {
                    FightManager.startFightBinaryWild(DUALPET_FIGHT_INDEX, null, null, btnData);
                }]);
            }
            this._map = SceneManager.active.mapModel;
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
        }
    }

    private function initEventListener():void {
        Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.onEventStart);
    }

    private function onEventStart(param1:MessageEvent):void {
        var evt:MessageEvent = param1;
        var parser:Parser_1140 = new Parser_1140(evt.message.getRawDataCopy());
        if (parser.id == EVENT_INDEX && parser.index == 16) {
            NpcDialog.show(463, "萨伯尔", [[0, "您……是我遇见过数一数二的高手！不愧是总督大人特许进入飞翼氏族的客人！"]], ["哦呵呵呵，那是当然！"], [function ():void {
                NpcDialog.show(463, "萨伯尔", [[0, "我们再比试一场！如果您还能获胜……我想跟您走！跟着您学习，让自己变得更强大！您愿意吗……？"]], ["当然当然愿意！开始吧！"], [function ():void {
                    FightManager.startFightWithWild(SPECIAL_FIGHT_INDEX);
                }]);
            }]);
        }
    }

    private function onActivityUnitClick(param1:DialogPanelEvent):void {
        var btnData:ButtonPanelData = null;
        var evt:DialogPanelEvent = param1;
        btnData = new ButtonPanelData();
        btnData.catchEnabled = false;
        if ((evt.content as DialogPanelEventData).params == "fight_single_npc_660") {
            NpcDialog.show(83, "萨伯尔兵团长", [[0, "我等肩负着整个飞翼群岛的安全，想要战胜萨伯尔兵团不是那么容易的！（露出了得意的表情）"]], ["等我准备一下！", "我就喜欢有难度的事情！"], [null, function ():void {
                FightManager.startFightWithWild(NORMAL_FIGHT_INDEX, null, null, btnData);
            }]);
        } else if ((evt.content as DialogPanelEventData).params == "fight_dual_npc_660") {
            NpcDialog.show(463, "萨伯尔", [[0, "我等肩负着整个飞翼群岛的安全，想要战胜萨伯尔兵团不是那么容易的！（露出了得意的表情）"]], ["等我准备一下！", "我就喜欢有难度的事情！"], [null, function ():void {
                FightManager.startFightBinaryWild(DUALPET_FIGHT_INDEX, null, null, btnData);
            }]);
        } else if ((evt.content as DialogPanelEventData).params == "fight_super_dual_npc_660") {
            ActiveCountManager.requestActiveCountList([206378], function (param1:Parser_1142):void {
                var par:Parser_1142 = param1;
                if ((par.infoVec[0] & 1 << 1 - 1) >> 1 - 1 > 0) {
                    NpcDialog.show(463, "萨伯尔", [[0, "萨伯尔兵团长：欢迎您，星际使者，多亏了你的努力探索让飞翼氏族尘封的地方又重见天日了呢。"]], ["......"], [function ():void {
                        NpcDialog.show(400, "小赛尔", [[0, "啊哈，没什么，多谢夸奖，萨伯尔兵团长，这是我必须要做的，为了真相。"]], ["......"], [function ():void {
                            NpcDialog.show(463, "萨伯尔", [[0, "我们飞翼氏族一直以来也崇尚着真相，不懈的追求，最近和族长大人商量了一下，为了纪念和传承这份精神打算开展什么比赛呢，到时候别忘了来参加哦。"]], ["........."], [function ():void {
                                NpcDialog.show(3094, "撒莱尔", [[0, "一定一定，我最喜欢热闹了，说到喜欢热闹，和你打听一下有没有见到从研究所飞出来的那个小家伙呀。"]], ["......"], [function ():void {
                                    NpcDialog.show(463, "萨伯尔", [[0, "哦哦，看到过，她好像经常去岛上空旷的地方飞来飞去，肯定是忍耐坏了吧，如何，星际使者，我也好久没见你，也手痒痒的很忍耐坏了呢，来和我的精锐部队打一场吧。"]], ["......"], [function ():void {
                                        NpcDialog.show(400, "小赛尔", [[0, "没问题！我也是精英满满的队伍哦"]], ["等我准备一下！", "挑战萨伯尔兵团！"], [null, function ():void {
                                            FightManager.startFightBinaryWild(1834, null, null, btnData);
                                        }]);
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                } else {
                    AlertManager.showAlert("你还没有战胜葛蕾芬兵团长哦!");
                }
            });
        }
    }

    override public function refresh():void {
    }

    override public function dispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.onEventStart);
        super.dispose();
    }
}
}
