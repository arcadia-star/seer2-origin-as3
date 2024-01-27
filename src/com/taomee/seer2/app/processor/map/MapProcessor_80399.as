package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import org.taomee.utils.BitUtil;
import org.taomee.utils.DisplayUtil;

public class MapProcessor_80399 extends MapProcessor {

    private static const FOR_LIST:Array = [205576, 205562];

    private static const RES_LIST:Vector.<int> = Vector.<int>([864, 865, 629]);

    private static const NPC_NAME:Vector.<String> = Vector.<String>(["魔尊左使", "魔尊右使", "魔奇拉"]);

    private static const FIGHT_INDEX:int = 1495;

    private static const TIP_POS:Point = new Point(530, 180);


    private var _hurtNum:TextField;

    private var _npc:Mobile;

    private var _par:Parser_1142;

    public function MapProcessor_80399(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.onActInit();
    }

    private function onActInit():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX) {
            this.getDataHandleFromBattle();
        } else {
            this.getDataHandleNormal();
        }
    }

    private function getDataHandleNormal():void {
        ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
            _par = param1;
            initSet();
        });
    }

    private function getDataHandleFromBattle():void {
        ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            _par = par;
            if (BitUtil.getBit(_par.infoVec[1], 3)) {
                ServerMessager.addMessage("恭喜过关喽!");
            }
            TweenNano.delayedCall(3, function ():void {
                SceneManager.changeScene(SceneType.LOBBY, 70);
                TweenNano.delayedCall(2, function ():void {
                    ModuleManager.showAppModule("DragonChroniclesThreeSeasonPanel");
                });
            });
        });
    }

    private function initSet():void {
        this.hideLobbyMenu();
        this.createNpc();
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.width = 110;
            this._npc.height = 180;
            this._npc.setPostion(new Point(530, 384));
            this._npc.resourceUrl = URLUtil.getNpcSwf(RES_LIST[this._par.infoVec[0] - 1]);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = NPC_NAME[this._par.infoVec[0] - 1];
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
            SeatTipsManager.registerSeat(TIP_POS, _map.id);
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        ModuleManager.showAppModule("PetSelectFightPanel", {
            "mode": 7,
            "posIndex": FIGHT_INDEX,
            "min": 1,
            "max": 5
        });
    }

    private function clearNpc():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
            SeatTipsManager.removeSeat(TIP_POS, _map.id);
        }
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function onActDispose():void {
        this.clearNpc();
        this._hurtNum = null;
        this._npc = null;
    }

    override public function dispose():void {
        this.onActDispose();
        super.dispose();
    }
}
}
