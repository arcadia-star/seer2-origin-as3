package com.taomee.seer2.app.processor.activity.sevenDragonNinja {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.system.ApplicationDomain;

import org.taomee.utils.DomainUtil;

public class SevenDragonNinjaMap {


    private var _mapModel:MapModel;

    private var _resLibs:ApplicationDomain;

    private var _buy:SimpleButton;

    private var _npc:Mobile;

    private var _mouseHint:MouseClickHintSprite;

    private var _bufferCount:int;

    private const npcId:int = 633;

    private const fightId:int = 617;

    public function SevenDragonNinjaMap(param1:MapModel) {
        super();
        this._mapModel = param1;
        this.getDomain();
    }

    private function getDomain():void {
        QueueLoader.load(URLUtil.getActivityAnimation("moPetProcessAct/MoGetPetAct"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLibs = param1.domain;
            init();
        });
    }

    private function init():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.SEVEN_DRAGON_NINJA_HINT, function (param1:ServerBuffer):void {
            _bufferCount = param1.readDataAtPostion(0);
        });
        this.addBuy();
        this.addNpc();
        if (this._bufferCount < 1) {
            this.addHint();
        }
    }

    private function addHint():void {
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = this._npc.x;
        this._mouseHint.y = this._npc.y - 100;
        this._mapModel.front.addChild(this._mouseHint);
    }

    private function addBuy():void {
        this._buy = this.getMovie("Buy") as SimpleButton;
        this._buy.x = 15;
        this._buy.y = 175;
        this._mapModel.content.addChild(this._buy);
        this._buy.addEventListener(MouseEvent.CLICK, this.onClickBuy);
    }

    private function addNpc():void {
        this._npc = new Mobile();
        this._npc.setPostion(new Point(310, 280));
        this._npc.resourceUrl = URLUtil.getNpcSwf(this.npcId);
        this._npc.buttonMode = true;
        this._npc.x = 517;
        this._npc.y = 317;
        MobileManager.addMobile(this._npc, MobileType.NPC);
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc);
    }

    private function onNpc(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(this.npcId, "初影尼加", [[0, "忍者无敌，视影为忍者先知，成正果，影必行，接招吧"]], ["接受挑战", "准备一下", "购买捕捉胶囊"], [function ():void {
            FightManager.startFightWithWild(fightId);
            if (_bufferCount < 1) {
                ServerBufferManager.updateServerBuffer(ServerBufferType.SEVEN_DRAGON_NINJA_HINT, 0, 1);
            }
        }, null, function ():void {
            ModuleManager.showModule(URLUtil.getAppModule("BuyCatchItemPanel"), "正在打开购买精灵胶囊面板....");
        }]);
    }

    private function getMovie(param1:String):DisplayObject {
        if (this._resLibs) {
            return DomainUtil.getDisplayObject(param1, this._resLibs);
        }
        return null;
    }

    public function setNpcHintVisible(param1:Boolean):void {
    }

    private function onClickBuy(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("BuyCatchItemPanel"), "正在打开购买精灵胶囊面板....");
    }

    public function dispose():void {
        if (this._buy) {
            this._buy.removeEventListener(MouseEvent.CLICK, this.onClickBuy);
            DisplayObjectUtil.removeFromParent(this._buy);
            this._buy = null;
        }
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc);
            DisplayObjectUtil.removeFromParent(this._npc);
            this._npc.dispose();
            this._npc = null;
        }
        if (this._mouseHint) {
            DisplayObjectUtil.removeFromParent(this._mouseHint);
        }
        if (this._resLibs) {
            this._resLibs = null;
        }
    }
}
}
