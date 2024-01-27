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

public class MapProcessor_80543 extends FeiyuyiteMap {


    public function MapProcessor_80543(param1:MapModel) {
        super(param1);
    }

    private static function overHandler(param1:* = null):void {
        var e:* = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, overHandler);
            if (FightManager.currentFightRecord.isWinWar()) {
                (SceneManager.active as LobbyScene).showToolbar();
                TweenNano.delayedCall(1, function ():void {
                    SceneManager.changeScene(SceneType.LOBBY, 80544);
                });
            }
        }
    }

    override public function init():void {
        FightManager.addEventListener(FightStartEvent.FIGHT_OVER, overHandler);
        this.hideLobbyMenu();
        fightId = 1835;
        maxCount = 0;
        npcId = 102;
        super.init();
    }

    override protected function toFight(param1:MouseEvent):void {
        var event:MouseEvent = param1;
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
                                                FightManager.startFightBinaryWild(fightId);
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

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }
}
}
