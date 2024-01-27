package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.net.parser.Parser_1065;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

public class MapProcessor_1190 extends MapProcessor {


    private const GUARD_ID:uint = 597;

    private const GUARD_NUM:uint = 4;

    private const GUARD_SEAT:Array = [new Point(140, 440), new Point(450, 460), new Point(815, 420), new Point(640, 370)];

    private const ZHUA_ID:uint = 595;

    private const CANDLE_ID:uint = 598;

    private const DAYLIMIT_ID:uint = 733;

    private const FIGHT_IDS:Array = [510, 511, 512, 513];

    private const DAYLIMIT_IDS:Array = [729, 730, 731, 732];

    private const FIGHT_ZHUA:uint = 514;

    private var guard_list:Vector.<Mobile>;

    private var zhua_mobile:Mobile;

    private var eft:MovieClip;

    private var _resLib:ResourceLibrary;

    private var dayLimit:Array;

    private var index:int;

    private var isCall:Boolean;

    private var leftCount:int;

    public function MapProcessor_1190(param1:MapModel) {
        this.dayLimit = [0, 0, 0, 0];
        super(param1);
    }

    override public function dispose():void {
        super.dispose();
        var _loc1_:int = 0;
        while (_loc1_ < this.GUARD_NUM) {
            this.guard_list[_loc1_].removeEventListener(MouseEvent.CLICK, this.toFightBadu);
            _loc1_++;
        }
        if (this.zhua_mobile) {
            this.zhua_mobile.removeEventListener(MouseEvent.CLICK, this.toFightZhua);
        }
    }

    override public function init():void {
        this.initMobile();
        var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc1_.writeUnsignedInt(4);
        var _loc2_:int = 0;
        while (_loc2_ < this.DAYLIMIT_IDS.length) {
            _loc1_.writeUnsignedInt(this.DAYLIMIT_IDS[_loc2_]);
            _loc2_++;
        }
        DayLimitListManager.getDoCount(_loc1_, this.getGuardState);
    }

    private function initMobile():void {
        var _loc2_:Mobile = null;
        this.guard_list = new Vector.<Mobile>();
        var _loc1_:int = 0;
        while (_loc1_ < this.GUARD_NUM) {
            _loc2_ = new Mobile();
            this.guard_list.push(_loc2_);
            this.guard_list[_loc1_].x = this.GUARD_SEAT[_loc1_].x;
            this.guard_list[_loc1_].y = this.GUARD_SEAT[_loc1_].y;
            _loc1_++;
        }
    }

    private function getGuardState(param1:DayLimitListInfo):void {
        var _loc2_:Parser_1065 = null;
        var _loc3_:int = 0;
        this.isCall = true;
        _loc3_ = 0;
        while (_loc3_ < this.GUARD_NUM) {
            _loc2_ = param1.dayLimitList[_loc3_];
            this.index = this.DAYLIMIT_IDS.indexOf(_loc2_.id);
            this.dayLimit[this.index] = _loc2_.count;
            _loc3_++;
        }
        _loc3_ = 0;
        while (_loc3_ < this.GUARD_NUM) {
            if (this.dayLimit[_loc3_] > 0) {
                this.guard_list[_loc3_].resourceUrl = URLUtil.getNpcSwf(this.CANDLE_ID);
            } else {
                this.guard_list[_loc3_].resourceUrl = URLUtil.getNpcSwf(this.GUARD_ID);
                this.guard_list[_loc3_].buttonMode = true;
                this.guard_list[_loc3_].mouseChildren = false;
                this.guard_list[_loc3_].addEventListener(MouseEvent.CLICK, this.toFightBadu);
                this.isCall = false;
            }
            MobileManager.addMobile(this.guard_list[_loc3_], MobileType.NPC);
            _loc3_++;
        }
        DayLimitManager.getDoCount(this.DAYLIMIT_ID, this.getDayCount);
        this.index = this.FIGHT_IDS.indexOf(FightManager.currentFightRecord.initData.positionIndex);
        if (this.index != -1 && FightManager.isJustWinFight()) {
            this.showCandle();
        }
        if (this.isCall && this.index == -1) {
            this.showZhua();
        }
    }

    private function getDayCount(param1:uint):void {
        this.leftCount = 3 - param1;
    }

    private function showCandle():void {
        this.guard_list[this.index].visible = false;
        QueueLoader.load(URLUtil.getQuestAnimation("sceneAnimation/" + 10197), LoadType.DOMAIN, this.onLoadComplete);
    }

    private function onLoadComplete(param1:ContentInfo):void {
        var info:ContentInfo = param1;
        this._resLib = new ResourceLibrary(info.content);
        this.eft = this._resLib.getMovieClip("ShowCandle");
        this.eft.x = this.GUARD_SEAT[this.index].x;
        this.eft.y = this.GUARD_SEAT[this.index].y;
        _map.content.addChild(this.eft);
        MovieClipUtil.playMc(this.eft, 1, this.eft.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(eft);
            guard_list[index].visible = true;
            if (isCall) {
                eft = _resLib.getMovieClip("ShowZhua");
                eft.x = 350;
                eft.y = 285;
                _map.content.addChild(eft);
                MovieClipUtil.playMc(eft, 1, eft.totalFrames, showZhua, true);
            }
        }, true);
    }

    private function showZhua():void {
        if (this.eft) {
            DisplayObjectUtil.removeFromParent(this.eft);
        }
        this.zhua_mobile = new Mobile();
        this.zhua_mobile.buttonMode = true;
        this.zhua_mobile.resourceUrl = URLUtil.getNpcSwf(this.ZHUA_ID);
        this.zhua_mobile.x = 350;
        this.zhua_mobile.y = 285;
        MobileManager.addMobile(this.zhua_mobile, MobileType.NPC);
        this.zhua_mobile.addEventListener(MouseEvent.CLICK, this.toFightZhua);
    }

    private function toFightZhua(param1:MouseEvent):void {
        var over:int;
        var event:MouseEvent = param1;
        if (this.leftCount <= 0) {
            NpcDialog.show(113, "超级NONO", [[0, "勇士！今天的挑战次数已经用完，请明天再来挑战吧！"]], ["明天再来！"]);
            return;
        }
        over = 3 - this.leftCount;
        if (over < 0) {
            over = 0;
        }
        NpcDialog.show(113, "超级NONO", [[0, "每天有3次挑战机会，您已经挑战" + over + "次！是否立即开始挑战？"]], ["开始挑战", "准备一下"], [function ():void {
            FightManager.addEventListener(FightStartEvent.FIGHT_OVER, onFightOver);
            FightManager.startFightWithBoss(FIGHT_ZHUA);
        }]);
    }

    private function onFightOver(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, this.onFightOver);
        if (!FightManager.isJustWinFight()) {
            NpcDialog.show(113, "超级NONO", [[0, "别灰心！换个打法再来挑战！"]], ["再次开始挑战！准备一下"]);
        }
    }

    private function toFightBadu(param1:MouseEvent):void {
//         if(!QuestManager.isComplete(10197))
//         {
//            AlertManager.showAlert("你还没完成相关挑战章节不能对战!!");
//            return;
//         }
        var _loc2_:int = this.guard_list.indexOf(param1.target as Mobile);
        FightManager.startFightWithWild(this.FIGHT_IDS[_loc2_]);
    }
}
}
