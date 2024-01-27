package com.taomee.seer2.app.manager {
import com.greensock.TweenNano;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

public class MiuSiWakeupFirstManager {

    private static var _instance:MiuSiWakeupFirstManager;


    private var _frontMc:MovieClip;

    private var _mapId:int;

    private var _npc815:Mobile;

    private const FIGHT_ID:int = 1624;

    public function MiuSiWakeupFirstManager() {
        super();
    }

    public static function getInstance():MiuSiWakeupFirstManager {
        if (!_instance) {
            _instance = new MiuSiWakeupFirstManager();
        }
        return _instance;
    }

    public function setup():void {
        this._frontMc = SceneManager.active.mapModel.front as MovieClip;
        this._mapId = SceneManager.active.mapID;
        this.createNPC();
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (this.FIGHT_ID == FightManager.currentFightRecord.initData.positionIndex) {
                if (FightManager.isWinWar()) {
                    TweenNano.delayedCall(0.5, function ():void {
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        TweenNano.delayedCall(0.5, function ():void {
                            ModuleManager.showAppModule("MiuSiWakeupStartGamePanel");
                        });
                    });
                } else {
                    NpcDialog.show(815, "邪神", [[0, "哼~再回家修行几年再来吧！觉醒石我就先收下了。"]], ["我还会再回来的！"], [function ():void {
                        TweenNano.delayedCall(0.5, function ():void {
                            SceneManager.changeScene(SceneType.LOBBY, 70);
                            TweenNano.delayedCall(0.5, function ():void {
                                ModuleManager.showAppModule("MiuSiWakeupStartPanel");
                            });
                        });
                    }]);
                }
            }
        }
    }

    private function createNPC():void {
        this._npc815 = new Mobile();
        this._npc815.setPostion(new Point(396, 334));
        this._npc815.label = "邪神";
        this._npc815.resourceUrl = URLUtil.getNpcSwf(815);
        this._npc815.buttonMode = true;
        MobileManager.addMobile(this._npc815, MobileType.NPC);
        this._npc815.addEventListener(MouseEvent.CLICK, this.onDialog);
    }

    private function removeNPC():void {
        if (this._npc815) {
            this._npc815.removeEventListener(MouseEvent.CLICK, this.onDialog);
            MobileManager.removeMobile(this._npc815, MobileType.NPC);
            this._npc815 = null;
        }
    }

    private function onDialog(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(815, "邪神", [[0, "绝不能让战神们获得神迹之力。"]], ["缪斯的觉醒石在你手中吧！"], [function ():void {
            NpcDialog.show(815, "邪神", [[0, "是又怎样~凭你休想拿走！"]], ["废话少说！开战吧！", "等下再让你见识我的实力。"], [function ():void {
                FightManager.startFightWithWild(FIGHT_ID);
            }]);
        }]);
    }

    public function dispose():void {
        this.removeNPC();
    }
}
}
