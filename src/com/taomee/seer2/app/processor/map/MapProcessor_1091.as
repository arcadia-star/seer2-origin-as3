package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.net.parser.baseData.ItemSwapInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

public class MapProcessor_1091 extends MapProcessor {

    private static const position:Vector.<Point> = Vector.<Point>([new Point(232, 201), new Point(345, 230), new Point(265, 396), new Point(440, 401), new Point(600, 409)]);

    private static const special_item_id_list:Vector.<int> = Vector.<int>([603204, 603205, 603204, 603206, 603901, 603902, 603903, 603904, 603905, 603906, 603907, 603908, 603214, 603717]);

    private static const special_item_name_list:Vector.<String> = Vector.<String>(["雪", "兔", "雪", "豹", "樱", "花", "熊", "小", "木", "马", "阿", "宝", "丘", "比"]);


    private var clickTarget:MovieClip;

    private var openPanelBtn:Sprite;

    private var petList:Vector.<MovieClip>;

    private var _libs:ResourceLibrary;

    private var haveGetItems:Boolean;

    private var freetimeLeft:int;

    private var alltimeLeft:int;

    public function MapProcessor_1091(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.petList = new Vector.<MovieClip>();
        this.loadSwf();
        this.openPanelBtn = _map.content["openPanelBtn"];
        this.openPanelBtn.alpha = 0;
        this.openPanelBtn.addEventListener(MouseEvent.CLICK, this.onClick);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_545);
    }

    private function getTimeCount():void {
        DayLimitManager.getDoCount(1183, this.getLimitData);
    }

    private function getLimitData(param1:uint):void {
        var currCount:uint = 0;
        var ddayLimitCount:uint = param1;
        if (ActorManager.actorInfo.vipInfo.isVip()) {
            currCount = 8;
        } else {
            currCount = 4;
        }
        ActiveCountManager.requestActiveCount(204298, function (param1:uint, param2:uint):void {
            alltimeLeft = ActsHelperUtil.getCanNum(ddayLimitCount, param2, currCount);
            getBackData();
        });
    }

    private function getBackData():void {
        this.haveGetItems = true;
        if (this.alltimeLeft > 0) {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("cathPet"), function ():void {
                Connection.addCommandListener(CommandSet.DIGGER_MINE_1060, onGetRewardSuccess);
                Connection.addErrorHandler(CommandSet.DIGGER_MINE_1060, onGetRewardError);
                Connection.send(CommandSet.DIGGER_MINE_1060, 256);
            });
        } else {
            AlertManager.showAlert("今天的捕捉次数已用完，请明天再来或购买捕捉绳。");
            if (this.clickTarget) {
                this.clickTarget.addEventListener(MouseEvent.CLICK, this.onPetClick);
            }
        }
    }

    private function onClick(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("PetCardsExchangePanel"));
    }

    private function loadSwf():void {
        QueueLoader.load(URLUtil.getActivityAnimation("PetCardsExchange"), LoadType.DOMAIN, this.onLoadComplete);
    }

    private function onLoadComplete(param1:ContentInfo):void {
        var _loc2_:MovieClip = null;
        this._libs = new ResourceLibrary(param1.content);
        var _loc3_:int = 0;
        while (_loc3_ < 5) {
            _loc2_ = this._libs.getMovieClip("pet");
            _loc2_.x = position[_loc3_].x;
            _loc2_.y = position[_loc3_].y;
            this.petList.push(_loc2_);
            _map.content.addChild(_loc2_);
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.CLICK, this.onPetClick);
            _loc3_++;
        }
    }

    private function onPetClick(param1:MouseEvent):void {
        this.clickTarget = param1.currentTarget as MovieClip;
        this.clickTarget.removeEventListener(MouseEvent.CLICK, this.onPetClick);
        this.getTimeCount();
    }

    private function onGetRewardSuccess(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.onGetRewardSuccess);
        Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060, this.onGetRewardError);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:Parser_1060 = new Parser_1060(param1.message.getRawData());
        var _loc4_:Vector.<ItemSwapInfo> = _loc3_.addItemVec;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_.length) {
            if (special_item_id_list.indexOf(_loc4_[_loc5_].id) != -1) {
                ServerMessager.addMessage("恭喜你获得1个[" + special_item_name_list[special_item_id_list.indexOf(_loc4_[_loc5_].id)] + "字]");
            }
            _loc5_++;
        }
        if (_loc4_ && _loc4_.length >= 1 && (_loc4_[0].id == 1 || _loc4_[0].id == 200016 || _loc4_[0].id == 200201)) {
            _loc3_.showResult(true, null, true);
        } else {
            _loc3_.showResult(true, null, false);
        }
        if (this.clickTarget) {
            this.clickTarget.addEventListener(MouseEvent.CLICK, this.onPetClick);
        }
    }

    private function onGetRewardError(param1:MessageEvent):void {
        Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060, this.onGetRewardError);
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.onGetRewardSuccess);
        AlertManager.showAlert("对不起，游戏出现了错误，请刷新试一下吧");
        if (this.clickTarget) {
            this.clickTarget.addEventListener(MouseEvent.CLICK, this.onPetClick);
        }
    }

    override public function dispose():void {
        this.openPanelBtn.removeEventListener(MouseEvent.CLICK, this.onClick);
        Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060, this.onGetRewardError);
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.onGetRewardSuccess);
        var _loc1_:int = 0;
        while (_loc1_ < this.petList.length) {
            this.petList[_loc1_].removeEventListener(MouseEvent.CLICK, this.onClick);
            DisplayObjectUtil.removeFromParent(this.petList[_loc1_]);
            _loc1_++;
        }
        this.petList = null;
        this._libs = null;
        this.haveGetItems = false;
        super.dispose();
    }
}
}
