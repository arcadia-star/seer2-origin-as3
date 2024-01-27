package com.taomee.seer2.app.activity.processor.flameBattle {
import com.taomee.seer2.app.activity.processor.ActivityProcessor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class ActivityMapHandler_261 extends FlameBattleMapHandler {


    private var _isActivityInitialized:Boolean;

    private var _npc:Mobile;

    private var _teleport:Teleport;

    private var _npcDefinition:NpcDefinition;

    public function ActivityMapHandler_261(param1:ActivityProcessor) {
        super(param1);
    }

    override public function process():void {
        super.process();
        if (_isTimeOut) {
            return;
        }
        if (this.getCurrentBossId() == 0) {
            this.clear();
            return;
        }
        if (this._isActivityInitialized == false) {
            this._isActivityInitialized = true;
            if (troop == 0) {
                this.processNpc();
            } else {
                this.processTeleport();
            }
        }
        if (troop == 0) {
            this.processNpc();
        } else {
            this.processTeleport();
        }
    }

    private function getCurrentBossId():int {
        var _loc1_:uint = uint(TimeManager.getServerTime());
        var _loc2_:Date = new Date(_loc1_ * 1000);
        var _loc3_:uint = uint(_loc2_.hours * 60 + _loc2_.minutes);
        if (_loc3_ < _currentTimeVec[1] && _loc3_ >= _currentTimeVec[0]) {
            return 1;
        }
        if (_loc3_ < _currentTimeVec[3] && _loc3_ >= _currentTimeVec[2]) {
            return 2;
        }
        if (_loc3_ < _currentTimeVec[5] && _loc3_ >= _currentTimeVec[4]) {
            return 3;
        }
        if (_loc3_ < _currentTimeVec[7] && _loc3_ >= _currentTimeVec[6]) {
            return 4;
        }
        return 0;
    }

    private function processNpc():void {
        var _loc1_:DialogDefinition = null;
        var _loc3_:XML = null;
        var _loc4_:XML = null;
        if (Boolean(this._npc) || Boolean(this._teleport)) {
            return;
        }
        var _loc2_:int = Math.random() * 100;
        if (_loc2_ <= 50) {
            _loc3_ = <npc id="304" resId="304" name="巴尔卡卫兵" dir="1" width="25" height="80" pos="202,360"
                          actorPos="210,365" path="">
                <dialog npcId="304" npcName="巴尔卡卫兵" transport="261,202,360">
                    <branch id="default">
                        <node emotion="0"><![CDATA[你是来帮助巴尔卡重登烈焰蛮神王座的你要一起来吗？]]></node>
                        <reply action="close" params="bakaer"><![CDATA[我来帮巴尔卡]]></reply>
                        <reply action="close"><![CDATA[我走错了]]></reply>
                    </branch>
                </dialog>
            </npc>;
            this._npcDefinition = new NpcDefinition(_loc3_);
        } else {
            _loc4_ = <npc id="303" resId="303" name="洛克侍卫" dir="1" width="25" height="80" pos="202,360"
                          actorPos="210,365" path="">
                <dialog npcId="303" npcName="洛克侍卫" transport="261,202,360">
                    <branch id="default">
                        <node emotion="0"><![CDATA[你是来帮洛克老大一起对付那个手下败将的吗？]]></node>
                        <reply action="close" params="luoke"><![CDATA[我会帮洛克]]></reply>
                        <reply action="close"><![CDATA[我走错了]]></reply>
                    </branch>
                </dialog>
            </npc>;
            this._npcDefinition = new NpcDefinition(_loc4_);
        }
        this._npc = MobileManager.createNpc(this._npcDefinition);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onTeamLeaderClick);
    }

    private function onTeamLeaderClick(param1:MouseEvent):void {
        DialogPanel.addCloseEventListener(this.selectNpc);
        DialogPanel.showForNpc(this._npcDefinition);
    }

    private function selectNpc(param1:DialogCloseEvent):void {
        DialogPanel.removeCloseEventListener(this.selectNpc);
        if (param1.params == "bakaer") {
            if (ActorManager.actorInfo.highestPetLevel <= 15) {
                AlertManager.showAlert("你目前精灵等级太低");
                return;
            }
            troop = 1;
            Connection.send(CommandSet.SELECT_ACTIVITY_TROOP_1106, 1);
            SceneManager.changeScene(SceneType.LOBBY, 263, 510, 320);
        } else if (param1.params == "luoke") {
            if (ActorManager.actorInfo.highestPetLevel <= 15) {
                AlertManager.showAlert("你目前精灵等级太低");
                return;
            }
            troop = 2;
            Connection.send(CommandSet.SELECT_ACTIVITY_TROOP_1106, 2);
            SceneManager.changeScene(SceneType.LOBBY, 263, 510, 320);
        }
    }

    private function processTeleport():void {
        if (Boolean(this._npc) || Boolean(this._teleport)) {
            return;
        }
        var _loc1_:XML = <teleport name="火焰山" pos="200,400" targetMapId="263" targetPos="510,320"/>;
        this._teleport = new Teleport();
        this._teleport.setData(_loc1_);
        SceneManager.active.mapModel.content.addChild(this._teleport);
        this._teleport.addEventListener(MouseEvent.CLICK, this.onActivityTeleportClick, false, 1);
    }

    private function onActivityTeleportClick(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
        if (ActorManager.actorInfo.highestPetLevel <= 15) {
            AlertManager.showAlert("你目前精灵等级太低");
            return;
        }
        (param1.target as Teleport).onMouseClick(param1);
    }

    private function clear():void {
        if (this._npc) {
            MobileManager.removeMobileById(this._npc.id, MobileType.NPC);
        }
        this._npc = null;
        if (this._teleport) {
            DisplayUtil.removeForParent(this._teleport);
        }
        if (this._npcDefinition) {
            this._npcDefinition = null;
        }
    }

    override public function dispose():void {
        super.dispose();
        this.clear();
    }
}
}
