package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.scene.LobbyPanel;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.IDataInput;
import flash.utils.Timer;

import org.taomee.utils.Tick;

public class MapProcessor_80127 extends MapProcessor {


    private var _npc:Mobile;

    private var _mc:MovieClip;

    private var petIconMc:MovieClip;

    private var timeMc:MovieClip;

    private var textMc:MovieClip;

    private var iconSp:Sprite;

    private var expContainer:int;

    private var totalTime:int;

    private var sumTime:int;

    private var addFlag:int;

    private var changeExpID:int = 205090;

    private var updateTm:Timer;

    public function MapProcessor_80127(param1:MapModel) {
        this.iconSp = new Sprite();
        this.updateTm = new Timer(5000);
        super(param1);
    }

    override public function init():void {
        LobbyPanel.instance.hide();
    }

    private function onResLoaded(param1:ContentInfo):void {
        this._mc = param1.content as MovieClip;
        this.createNpc(2);
        this.petIconMc = this.getMC("petIconMc");
        this.timeMc = this.getMC("timeMc");
        this.textMc = this.getMC("textMc");
        this.petIconMc.x = 20;
        this.petIconMc.y = 50;
        _map.front.addChild(this.petIconMc);
        this.petIconMc["petLogo"].addChild(this.iconSp);
        this.timeMc.x = 810;
        this.timeMc.y = 50;
        _map.front.addChild(this.timeMc);
        while (this.iconSp.numChildren > 0) {
            this.iconSp.removeChildAt(0);
        }
        var _loc2_:IconDisplayer = new IconDisplayer();
        _loc2_.setIconUrl(URLUtil.getPetIcon(ActorManager.getActor().getFollowingPet().getInfo().resourceId));
        _loc2_.scaleX = _loc2_.scaleY = 1.5;
        _loc2_.x = _loc2_.y = 10;
        this.iconSp.addChild(_loc2_);
        this.updateTm.addEventListener(TimerEvent.TIMER, this.updateExpShow);
        this.updateTm.start();
        this.totalTime = VipManager.vipInfo.isVip() ? 1800 : 900;
        ActorManager.getActor().addChild(this.textMc);
        this.textMc.y = -ActorManager.getActor().height;
        this.update();
    }

    private function updateExpShow(param1:TimerEvent):void {
        var e:TimerEvent = param1;
        ActiveCountManager.requestActiveCount(this.changeExpID, function (param1:int, param2:int):void {
            expContainer += param2;
            (petIconMc.uenum0 as MovieClip).gotoAndStop(expContainer % 10 + 1);
            (petIconMc.uenum1 as MovieClip).gotoAndStop(int(expContainer / 10) % 10 + 1);
            (petIconMc.uenum2 as MovieClip).gotoAndStop(int(expContainer / 100) % 10 + 1);
            (petIconMc.uenum3 as MovieClip).gotoAndStop(int(expContainer / 1000) % 10 + 1);
            (petIconMc.uenum4 as MovieClip).gotoAndStop(int(expContainer / 10000) % 10 + 1);
            (petIconMc.uenum5 as MovieClip).gotoAndStop(int(expContainer / 100000) % 10 + 1);
        });
    }

    private function update(param1:Function = null):void {
        var callBack:Function = param1;
        DayLimitListManager.getDaylimitList([1449, 1450], function (param1:DayLimitListInfo):void {
            addFlag = param1.getCount(1449);
            sumTime = param1.getCount(1450);
            if (addFlag == 1) {
                Tick.instance.addRender(updateTime, 1000);
            }
            if (callBack != null) {
                callBack();
            }
        });
    }

    private function updateTime(param1:uint):void {
        var u:uint = param1;
        if (this.sumTime >= this.totalTime) {
            SwapManager.swapItem(3401, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                SceneManager.changeScene(SceneType.LOBBY, 20);
                ModuleManager.showAppModule("KaiXueBigTrialWithExperience2Panel");
            });
            Tick.instance.removeRender(this.updateTime);
        } else {
            this.updateTimeTxt();
        }
    }

    private function updateTimeTxt():void {
        ++this.sumTime;
        if (this.sumTime >= this.totalTime) {
            this.sumTime = this.totalTime;
        }
        var _loc1_:uint = uint(this.sumTime);
        var _loc2_:int = int(_loc1_ / 60);
        var _loc3_:int = _loc1_ % 60;
        this.timeMc["mcMinDecade"].gotoAndStop(int(_loc2_ / 10) % 10 + 1);
        this.timeMc["mcMinUnit"].gotoAndStop(_loc2_ % 10 + 1);
        this.timeMc["mcSecDecade"].gotoAndStop(int(_loc3_ / 10) % 10 + 1);
        this.timeMc["mcSecUnit"].gotoAndStop(_loc3_ % 10 + 1);
    }

    public function getMC(param1:String):MovieClip {
        return this._mc[param1];
    }

    private function createNpc(param1:int):void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(238, 310));
            this._npc.resourceUrl = URLUtil.getNpcSwf(param1);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.dialogShow);
        }
    }

    private function dialogShow(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(2, "伊娃", [[0, "要关闭经验装置吗？经验室还在测试中，以后会更完美！"]], ["关闭经验装置", "继续测试......"], [function ():void {
            SwapManager.swapItem(3401, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                SceneManager.changeScene(SceneType.LOBBY, 20);
                ModuleManager.showAppModule("KaiXueBigTrialWithExperience2Panel");
            });
        }]);
    }

    override public function dispose():void {
        if (this._npc != null) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.dialogShow);
            MobileManager.removeMobile(this._npc, MobileType.NPC);
            this._npc = null;
        }
        LobbyPanel.instance.show();
        ActorManager.getActor().removeChild(this.textMc);
        this.updateTm.stop();
    }
}
}
