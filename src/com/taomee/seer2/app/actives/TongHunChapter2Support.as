package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.ui.LoadingBar;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.events.SyncEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;

public class TongHunChapter2Support {

    private static var _instance:TongHunChapter2Support;


    private const SWAP_PASS:uint = 2829;

    private var gameBtn:SimpleButton;

    private var game:DisplayObject;

    private var mapList:Array;

    private var valueList:Array;

    private var pointList:Array;

    private var indexValue:int;

    public function TongHunChapter2Support(param1:Singleton) {
        this.mapList = [910, 920, 950];
        this.valueList = [0, 1, 2];
        this.pointList = [new Point(676, 193), new Point(819, 212), new Point(1057, 328)];
        super();
    }

    public static function getInstance():TongHunChapter2Support {
        if (!_instance) {
            _instance = new TongHunChapter2Support(new Singleton());
        }
        return _instance;
    }

    public function setup():void {
        ActiveCountManager.requestActiveCount(204248, this.getState);
    }

    private function getState(param1:uint, param2:uint):void {
        this.indexValue = this.mapList.indexOf(SceneManager.active.mapID);
        if (QuestManager.isComplete(10229) && param2 == this.valueList[this.indexValue]) {
            switch (this.indexValue) {
                case 0:
                    StatisticsManager.newSendNovice("2014活动", "瞳魂兽第二章", "进入第一关小游戏");
                    break;
                case 1:
                    StatisticsManager.newSendNovice("2014活动", "瞳魂兽第二章", "进入第二关小游戏");
                    break;
                case 2:
                    StatisticsManager.newSendNovice("2014活动", "瞳魂兽第二章", "进入第三关小游戏");
            }
            this.gameBtn = SceneManager.active.mapModel.content["gameBtn"];
            this.gameBtn.addEventListener(MouseEvent.CLICK, this.showGame);
            SeatTipsManager.registerSeat(this.pointList[this.indexValue], this.mapList[this.indexValue]);
        }
    }

    protected function showGame(param1:MouseEvent):void {
        LoadingBar.show("加载中...");
        QueueLoader.load(URLUtil.getMiniGameSwf("HideAndSeek"), LoadType.SWF, this.loadComplete);
    }

    private function loadComplete(param1:ContentInfo):void {
        this.game = param1.content as DisplayObject;
        LoadingBar.hide();
        LayerManager.hideMap();
        LayerManager.topLayer.addChild(this.game);
        DisplayUtil.align(this.game, 4, new Rectangle(0, 0, LayerManager.stage.stageWidth, LayerManager.stage.stageHeight));
        this.game.addEventListener("closeGame", this.overGame);
    }

    protected function overGame(param1:SyncEvent):void {
        var level:int;
        var event:SyncEvent = param1;
        this.game.removeEventListener("closeGame", this.overGame);
        level = int(event.changeList[1]);
        if (level >= 4) {
            SeatTipsManager.removeSeat(this.pointList[this.indexValue], this.mapList[this.indexValue]);
            this.gameBtn.removeEventListener(MouseEvent.CLICK, this.showGame);
            SwapManager.swapItem(this.SWAP_PASS, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                ModuleManager.showAppModule("TongHunBeastPanel", "2");
                if (mapList.indexOf(SceneManager.active.mapID) == 2) {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10229_2"));
                }
            }, null, new SpecialInfo(1, this.indexValue + 1));
        }
        LayerManager.showMap();
        DisplayObjectUtil.removeFromParent(this.game);
    }

    public function dispose():void {
        if (this.game) {
            this.game.removeEventListener("closeGame", this.overGame);
        }
        SeatTipsManager.removeSeat(this.pointList[this.indexValue], this.mapList[this.indexValue]);
    }
}
}

class Singleton {


    public function Singleton() {
        super();
    }
}
