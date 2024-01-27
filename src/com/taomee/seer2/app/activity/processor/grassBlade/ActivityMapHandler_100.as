package com.taomee.seer2.app.activity.processor.grassBlade {
import com.taomee.seer2.app.activity.data.ActivityPet;
import com.taomee.seer2.app.activity.processor.ActivityProcessor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class ActivityMapHandler_100 extends GrassBladeMapHandler {

    private static const GUARD_ID:uint = 1;


    private var _npc37Definition:NpcDefinition;

    private var _npc38Definition:NpcDefinition;

    private var _npc37:Mobile;

    private var _npc38:Mobile;

    private var _isActivityInitialized:Boolean;

    private var _teleport:Teleport;

    private var _teleportAniamtion:MovieClip;

    private var _ufo:Sprite;

    private var _activityMonsterVec:Vector.<ActivityPet>;

    public function ActivityMapHandler_100(param1:ActivityProcessor) {
        super(param1);
    }

    override public function process():void {
        super.process();
        if (_isTimeOut) {
            return;
        }
        if (this._isActivityInitialized == false) {
            this._isActivityInitialized = true;
            this.processActivityMonster();
            this.processNpc();
            this.processLayout();
        }
        this.refreshActivity();
    }

    private function processNpc():void {
        var _loc1_:XML = <npc id="37" resId="37" name="民兵安德鲁" dir="1" width="25" height="80" pos="570,270"
                              actorPos="550,280" path="">
            <dialog npcId="37" npcName="民兵安德鲁" transport="1,300,400">
                <branch id="default">
                    <node emotion="4"><![CDATA[碧玉森林那边有大批的萨伦卫兵，你确定准备好了吗？]]></node>
                    <reply action="close"><![CDATA[我来就是要把它们赶走的！]]></reply>
                </branch>
            </dialog>
            <eventHandler>
                <mouseOver>
                    <HandlerShowNpcSlogan><![CDATA[从这里向北走就是碧玉森林。]]></HandlerShowNpcSlogan>
                </mouseOver>
                <click>
                    <HandlerOpenDialogPanel/>
                </click>
            </eventHandler>
        </npc>;
        var _loc2_:XML = <npc id="38" resId="38" name="民兵安德烈" dir="1" width="25" height="80" pos="430,450"
                              actorPos="420,430" path="">
            <dialog npcId="38" npcName="民兵安德烈" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[萨伦士官怎么都戴着怪怪的头盔呢！]]></node>
                    <reply action="close"><![CDATA[或许可以用来换赛尔豆！]]></reply>
                </branch>
            </dialog>
            <eventHandler>
                <mouseOver>
                    <HandlerShowNpcSlogan><![CDATA[我们是草系部落的最后防线！]]></HandlerShowNpcSlogan>
                </mouseOver>
                <click>
                    <HandlerOpenDialogPanel/>
                </click>
            </eventHandler>
        </npc>;
        this._npc37Definition = new NpcDefinition(_loc1_);
        this._npc38Definition = new NpcDefinition(_loc2_);
        this._npc37 = MobileManager.createNpc(this._npc37Definition);
        this._npc38 = MobileManager.createNpc(this._npc38Definition);
        this._npc37.buttonMode = true;
        this._npc38.buttonMode = true;
    }

    private function refreshActivity():void {
        this.showMapActivityAnimation();
    }

    private function showMapActivityAnimation():void {
        var _loc1_:* = _activityProcessor.getActivityID() + "/1";
        playActivityAnimation(_loc1_);
    }

    private function removeMapNpc():void {
        if (this._npc37) {
            MobileManager.removeMobileById(this._npc37.id, MobileType.NPC);
        }
        this._npc37 = null;
        this._npc37Definition = null;
        if (this._npc38) {
            MobileManager.removeMobileById(this._npc38.id, MobileType.NPC);
        }
        this._npc38 = null;
        this._npc38Definition = null;
    }

    private function processLayout():void {
        this._ufo = SceneManager.active.mapModel.libManager.getSprite("UFO");
        this._ufo.x = -16;
        this._ufo.y = 1.25;
        SceneManager.active.mapModel.ground.addChild(this._ufo);
        this._teleport = new Teleport();
        this._teleport.setData(<teleport name="碧玉森林" pos="620,100" targetMapId="101" targetPos="300,450"/>);
        this._teleport.addEventListener(MouseEvent.CLICK, this.onActivityTeleportClick, false, 1);
        SceneManager.active.mapModel.content.addChild(this._teleport);
        this._teleportAniamtion = SceneManager.active.mapModel.libManager.getMovieClip("SMOKE");
        this._teleportAniamtion.mouseChildren = false;
        this._teleportAniamtion.mouseEnabled = false;
        this._teleportAniamtion.x = 548;
        this._teleportAniamtion.y = 70;
        SceneManager.active.mapModel.content.addChild(this._teleportAniamtion);
    }

    private function onActivityTeleportClick(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
        if (ActorManager.actorInfo.highestPetLevel < 6) {
            AlertManager.showAlert("你目前精灵等级太低");
            return;
        }
        (param1.target as Teleport).onMouseClick(param1);
    }

    private function removeMapLayout():void {
        DisplayObjectUtil.removeFromParent(this._ufo);
        DisplayObjectUtil.removeFromParent(this._teleport);
        DisplayObjectUtil.removeFromParent(this._teleportAniamtion);
        this._ufo = null;
        this._teleport = null;
        this._teleportAniamtion = null;
    }

    private function processActivityMonster():void {
        var _loc2_:ActivityPet = null;
        this._activityMonsterVec = new Vector.<ActivityPet>();
        var _loc1_:uint = 0;
        while (_loc1_ < ACTIVITY_MONSTER_NUM) {
            _loc2_ = new ActivityPet(GUARD_ID);
            this._activityMonsterVec.push(_loc2_);
            MobileManager.addMobile(_loc2_, MobileType.ACTIVITY_MONSTER);
            _loc1_++;
        }
    }

    private function removeMapActivityMonster():void {
        if (this._activityMonsterVec == null) {
            return;
        }
        var _loc1_:uint = 0;
        while (_loc1_ < this._activityMonsterVec.length) {
            MobileManager.removeMobileById(this._activityMonsterVec[_loc1_].id, MobileType.ACTIVITY_MONSTER);
            this._activityMonsterVec[_loc1_] = null;
            _loc1_++;
        }
        this._activityMonsterVec = null;
    }

    override public function dispose():void {
        super.dispose();
        this.removeMapNpc();
        this.removeMapLayout();
        this.removeMapActivityMonster();
    }
}
}
