package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.events.MouseEvent;

public class MapProcessor_80542 extends FeiyuyiteMap {


    public function MapProcessor_80542(param1:MapModel) {
        super(param1);
    }

    private static function overHandler(param1:* = null):void {
        var e:* = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, overHandler);
            if (FightManager.currentFightRecord.isWinWar()) {
                (SceneManager.active as LobbyScene).showToolbar();
                TweenNano.delayedCall(1, function ():void {
                    SceneManager.changeScene(SceneType.LOBBY, 80543);
                });
            }
        }
    }

    override public function init():void {
        FightManager.addEventListener(FightStartEvent.FIGHT_OVER, overHandler);
        this.hideLobbyMenu();
        fightId = 1834;
        maxCount = 0;
        npcId = 83;
        super.init();
    }

    override protected function toFight(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        ActiveCountManager.requestActiveCountList([206378], function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            if ((par.infoVec[0] & 1 << 1 - 1) >> 1 - 1 > 0) {
                NpcDialog.show(83, "萨伯尔兵团长", [[0, "萨伯尔兵团长：欢迎您，星际使者，多亏了你的努力探索让飞翼氏族尘封的地方又重见天日了呢。"]], ["……"], [function ():void {
                    NpcDialog.show(400, "小赛尔", [[0, "啊哈，没什么，多谢夸奖，萨伯尔兵团长，这是我必须要做的，为了真相。"]], ["……"], [function ():void {
                        NpcDialog.show(83, "萨伯尔兵团长", [[0, "我们飞翼氏族一直以来也崇尚着真相，不懈的追求，最近和族长大人商量了一下，为了纪念和传承这份精神打算开展什么比赛呢，到时候别忘了来参加哦。"]], ["……"], [function ():void {
                            NpcDialog.show(400, "小赛尔", [[0, "一定一定，我最喜欢热闹了，说到喜欢热闹，和你打听一下有没有见到从研究所飞出来的那个小家伙呀。"]], ["……"], [function ():void {
                                NpcDialog.show(83, "萨伯尔兵团长", [[0, "哦哦，看到过，她好像经常去岛上空旷的地方飞来飞去，肯定是忍耐坏了吧，如何，星际使者，我也好久没见你，也手痒痒的很忍耐坏了呢，来和我的精锐部队打一场吧。"]], ["……"], [function ():void {
                                    NpcDialog.show(400, "小赛尔", [[0, "没问题！我也是精英满满的队伍哦"]], ["等我准备一下！", "挑战萨伯尔兵团！"], [null, function ():void {
                                        FightManager.startFightBinaryWild(fightId);
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

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }
}
}
