package com.taomee.seer2.app.processor.activity.moPetProcessAct {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.system.ApplicationDomain;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class MoGetPetAct {


    private var _resLib:ApplicationDomain;

    private var _mapModel:MapModel;

    private var _npc:Mobile;

    private var _buy:SimpleButton;

    private const FIGHT_INDEX:int = 588;

    public function MoGetPetAct(param1:MapModel) {
        super();
        this._mapModel = param1;
        this.getURL();
    }

    private function getURL():void {
        QueueLoader.load(URLUtil.getActivityAnimation("moPetProcessAct/MoGetPetAct"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            init();
        });
    }

    private function init():void {
        this.addNpc();
        this.addBuy();
    }

    private function addBuy():void {
        this._buy = this.getMovie("Buy") as SimpleButton;
        this._buy.x = 15;
        this._buy.y = 175;
        this._mapModel.content.addChild(this._buy);
        this._buy.addEventListener(MouseEvent.CLICK, this.onBuy);
    }

    private function onBuy(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("BuyCatchItemPanel"), "正在打开购买精灵胶囊面板....");
    }

    private function addNpc():void {
        this._npc = new Mobile();
        this._npc.width = 278;
        this._npc.height = 332;
        this._npc.setPostion(new Point(310, 280));
        this._npc.resourceUrl = URLUtil.getNpcSwf(627);
        this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
        this._npc.label = "奇拉";
        this._npc.labelImage.x = 8;
        this._npc.labelImage.y = -this._npc.height + 225;
        this._npc.buttonMode = true;
        this._npc.x = 335;
        this._npc.y = 395;
        MobileManager.addMobile(this._npc, MobileType.NPC);
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc);
    }

    private function onNpc(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(628, "奇拉", [[0, "我想做英雄……求做英雄……求挑战胜利做英雄……求……"]], ["别求了！我来和你过过招！", "慢慢求吧，我没空哦"], [function ():void {
            FightManager.startFightWithWild(FIGHT_INDEX);
        }]);
    }

    private function getMovie(param1:String):DisplayObject {
        if (this._resLib) {
            return DomainUtil.getDisplayObject(param1, this._resLib);
        }
        return null;
    }

    public function dispose():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
        }
        if (this._buy) {
            this._buy.removeEventListener(MouseEvent.CLICK, this.onBuy);
            DisplayUtil.removeForParent(this._buy);
            this._buy = null;
        }
    }
}
}
