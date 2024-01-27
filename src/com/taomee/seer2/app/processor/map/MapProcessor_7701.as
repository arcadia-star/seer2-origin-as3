package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.arena.ui.ButtonPanelData;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.events.MouseEvent;

public class MapProcessor_7701 extends FeiyuyiteMap {


    public function MapProcessor_7701(param1:MapModel) {
        super(param1);
    }

    private static function overHandler(param1:* = null):void {
        var e:* = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, overHandler);
            if (FightManager.currentFightRecord.isWinWar()) {
                (SceneManager.active as LobbyScene).showToolbar();
                TweenNano.delayedCall(1, function ():void {
                    SceneManager.changeScene(SceneType.LOBBY, 80542);
                });
            }
        }
    }

    override public function init():void {
        FightManager.addEventListener(FightStartEvent.FIGHT_OVER, overHandler);
        this.hideLobbyMenu();
        fightId = 1833;
        maxCount = 0;
        npcId = 80;
        super.init();
    }

    override protected function toFight(param1:MouseEvent):void {
        var btnData:ButtonPanelData = null;
        var event:MouseEvent = param1;
        btnData = new ButtonPanelData();
        btnData.catchEnabled = false;
        NpcDialog.show(80, "葛蕾芬兵团长", [[0, "好久不见了，强大的星际使者。你是来寻求挑战的吗？"]], ["……"], [function ():void {
            NpcDialog.show(400, "小赛尔", [[0, "啊……好久不见（葛蕾芬兵团长还是这么咄咄逼人）"]], ["……"], [function ():void {
                NpcDialog.show(80, "葛蕾芬兵团长", [[0, "撒莱尔，自从你去过斯坦因的研究所，里面的那个小家伙就像解放了一样，每天在族里飞来飞去，大家都很喜欢他呢。"]], ["……"], [function ():void {
                    NpcDialog.show(400, "小赛尔", [[0, "是嘛，她也算完成任务了，放下重担开心生活了吧（没想到她居然会被萌物萌到……！）~"]], ["……"], [function ():void {
                        NpcDialog.show(80, "葛蕾芬兵团长", [[0, "葛蕾芬兵团长：你在找她的踪迹吗？我可以告诉你哦，不过先要看看你的实力才行。"]], ["……"], [function ():void {
                            NpcDialog.show(400, "小赛尔", [[3, "（果然还是变成这样子了，唉）那好吧……得罪啦！"]], ["我不想挨打……", "挑战葛蕾芬兵团！"], [null, function ():void {
                                FightManager.startFightBinaryWild(fightId, null, null, btnData);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }
}
}
