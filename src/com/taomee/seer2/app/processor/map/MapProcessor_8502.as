package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.text.TextField;
import flash.utils.Timer;

public class MapProcessor_8502 extends MapProcessor {

    private static const floor_forever_limit:int = 203205;

    private static const next_floor_open_time_limit:int = 203206;


    private var machine:MovieClip;

    private var timeMc:Sprite;

    private var timeTxt:TextField;

    private var timer:Timer;

    private var leftTime:int = 0;

    private var openPanel:MovieClip;

    private var currentCompleteFloor:int = 0;

    private var nextOpenTime:int = 0;

    private var shi:int;

    private var fen:int;

    private var miao:int;

    private var str:String = "";

    public function MapProcessor_8502(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        StatisticsManager.sendNovice("0x10034134");
        this.timeMc = _map.content["timeMc"];
        this.timeTxt = this.timeMc["timeTxt"];
        this.timeMc.visible = false;
        this.openPanel = _map.content["openPanel"];
        this.openPanel.buttonMode = true;
        this.openPanel.addEventListener(MouseEvent.CLICK, this.onopenPanel);
        this.machine = _map.content["machine"];
        TooltipManager.addCommonTip(this.machine, "倒计时结束时点击进入坛塔开始修炼");
        this.machine.buttonMode = true;
        this.checkOpenPanel();
    }

    private function checkOpenPanel():void {
        ActiveCountManager.requestActiveCountList([floor_forever_limit, next_floor_open_time_limit], function (param1:Parser_1142):void {
            currentCompleteFloor = param1.infoVec[0];
            nextOpenTime = param1.infoVec[1];
            checkDisplay();
        });
    }

    private function checkDisplay():void {
        if (this.currentCompleteFloor == 6) {
            ModuleManager.showModule(URLUtil.getAppModule("GodMoonPanel"), "");
            this.timeMc.visible = false;
            return;
        }
        this.leftTime = this.nextOpenTime - TimeManager.getPrecisionServerTime();
        if (this.leftTime > 0) {
            this.showCountDown();
        } else {
            this.timeMc.visible = false;
            this.machine.addEventListener(MouseEvent.CLICK, this.onClick);
        }
    }

    private function showCountDown():void {
        this.timeMc.visible = true;
        this.timer = new Timer(1000);
        this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        this.timer.start();
    }

    private function onTimer(param1:TimerEvent):void {
        --this.leftTime;
        if (this.leftTime <= 0) {
            this.timeMc.visible = false;
            this.machine.addEventListener(MouseEvent.CLICK, this.onClick);
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this.timer = null;
        } else {
            this.shi = int(this.leftTime / 3600);
            this.fen = int((this.leftTime - this.shi * 3600) / 60);
            this.miao = this.leftTime - 60 * this.fen - 3600 * this.shi;
            this.str = "";
            if (this.shi < 10) {
                this.str += "0" + this.shi.toString() + ":";
            } else {
                this.str += this.shi.toString() + ":";
            }
            if (this.fen < 10) {
                this.str += "0" + this.fen.toString() + ":";
            } else {
                this.str += this.fen.toString() + ":";
            }
            if (this.miao < 10) {
                this.str += "0" + this.miao.toString();
            } else {
                this.str += this.miao.toString();
            }
            this.timeTxt.text = this.str;
            this.timeTxt.width = this.timeTxt.textWidth + 5;
        }
    }

    private function onClick(param1:MouseEvent):void {
        ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.getSpecialItem);
        ItemManager.requestSpecialItemList();
    }

    private function getSpecialItem(param1:ItemEvent):void {
        var e:ItemEvent = param1;
        ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.getSpecialItem);
        if (ItemManager.getSpecialItem(603309)) {
            AlertManager.showAlert("先将月神神化后才能再次进入神坛哦", function ():void {
                ModuleManager.showModule(URLUtil.getAppModule("GodMoonPanel"), "");
            });
        } else {
            SceneManager.changeScene(SceneType.LOBBY, 1900);
        }
    }

    private function onopenPanel(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("GodMoonPanel"), "");
    }

    override public function dispose():void {
        this.openPanel.removeEventListener(MouseEvent.CLICK, this.onopenPanel);
        this.machine.removeEventListener(MouseEvent.CLICK, this.onClick);
        if (this.timer) {
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this.timer = null;
        }
        super.dispose();
    }
}
}
