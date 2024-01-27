package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.net.parser.Parser_1065;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;

public class MapProcessor_1500 extends MapProcessor {

    private static const MaxPetNum:int = 5;

    private static const LimitIds:Vector.<int> = Vector.<int>([696, 697, 698, 699, 700]);

    private static const NpcIds:Vector.<int> = Vector.<int>([583, 431, 584, 443, 586]);

    private static const FightIds:Vector.<int> = Vector.<int>([454, 455, 456, 457, 458]);

    private static const MaxCounts:Vector.<int> = Vector.<int>([1, 1, 1, 1, 3]);

    private static const Positions:Vector.<Point> = Vector.<Point>([new Point(325, 270), new Point(400, 300), new Point(350, 380), new Point(250, 425), new Point(200, 325)]);


    private var _mobiles:Vector.<Mobile>;

    private var _dayLimit:Vector.<int>;

    public function MapProcessor_1500(param1:MapModel) {
        this._dayLimit = Vector.<int>([0, 0, 0, 0, 0]);
        super(param1);
    }

    override public function init():void {
        super.init();
        this._mobiles = new Vector.<Mobile>();
        var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
        _loc1_.writeUnsignedInt(MaxPetNum);
        var _loc2_:int = 0;
        while (_loc2_ < MaxPetNum) {
            _loc1_.writeUnsignedInt(LimitIds[_loc2_]);
            this._mobiles.push(new Mobile());
            _loc2_++;
        }
        DayLimitListManager.getDoCount(_loc1_, this.getDayLimitList);
    }

    private function getDayLimitList(param1:DayLimitListInfo):void {
        var _loc2_:Parser_1065 = null;
        var _loc3_:int = 0;
        while (_loc3_ < MaxPetNum) {
            _loc2_ = param1.dayLimitList[_loc3_];
            this._dayLimit[LimitIds.indexOf(_loc2_.id)] = _loc2_.count;
            _loc3_++;
        }
        this.checkMobile();
    }

    private function checkMobile():void {
        var _loc1_:Boolean = true;
        var _loc2_:int = 0;
        while (_loc2_ < MaxPetNum - 1) {
            if (this._dayLimit[_loc2_] < MaxCounts[_loc2_]) {
                this._mobiles[_loc2_].resourceUrl = URLUtil.getNpcSwf(NpcIds[_loc2_]);
                this._mobiles[_loc2_].buttonMode = true;
                this._mobiles[_loc2_].addEventListener(MouseEvent.CLICK, this.toFight);
                this._mobiles[_loc2_].setPostion(Positions[_loc2_]);
                this._mobiles[_loc2_].height = 100;
                MobileManager.addMobile(this._mobiles[_loc2_], MobileType.NPC);
                _loc1_ = false;
            }
            _loc2_++;
        }
        if (_loc1_) {
            if (SceneManager.prevSceneType == SceneType.ARENA && FightIds.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
                if (FightManager.currentFightRecord.initData.positionIndex != FightIds[4]) {
                    MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("ShowYueBeast"), this.showYueBeast);
                } else {
                    this.showYueBeast();
                }
            } else {
                this.showYueBeast();
            }
        }
    }

    private function showYueBeast():void {
        this._mobiles[4].resourceUrl = URLUtil.getNpcSwf(NpcIds[4]);
        this._mobiles[4].buttonMode = true;
        this._mobiles[4].addEventListener(MouseEvent.CLICK, this.toFight);
        this._mobiles[4].setPostion(Positions[4]);
        MobileManager.addMobile(this._mobiles[4], MobileType.NPC);
    }

    private function toFight(param1:MouseEvent):void {
        var index:int = 0;
        var e:MouseEvent = param1;
//         if(!QuestManager.isComplete(10190))
//         {
//            AlertManager.showAlert("你还没有完成月灵兽的试炼任务，不能挑战我");
//            return;
//         }
        index = this._mobiles.indexOf(e.currentTarget as Mobile);
        if (index != 4) {
            FightManager.startFightWithWild(FightIds[index]);
        } else if (this._dayLimit[4] < MaxCounts[4]) {
            NpcDialog.show(586, "月灵兽", [[0, "准备收接受我的试炼了吗？通过了我的试炼，就可以与我一起去挽回氏族间的和平。你每天可以与我战斗3次。"]], ["挑战月灵兽", "我准备下"], [function ():void {
                FightManager.startFightWithWild(FightIds[index]);
            }]);
        } else {
            NpcDialog.show(586, "月灵兽", [[0, "勇士还差一点点，就差一点点了，今天就到这里吧，请明天再来和我挑战。"]], ["好吧"]);
        }
    }

    override public function dispose():void {
        var _loc1_:int = 0;
        while (_loc1_ < MaxPetNum) {
            this._mobiles[_loc1_].removeEventListener(MouseEvent.CLICK, this.toFight);
            _loc1_++;
        }
        super.dispose();
    }
}
}
