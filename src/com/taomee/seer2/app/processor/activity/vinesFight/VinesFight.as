package com.taomee.seer2.app.processor.activity.vinesFight {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.common.ResourceLibraryLoader;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;

public class VinesFight {

    private static var _fightIndex:uint = 0;


    private const npcPointList:Vector.<Point> = Vector.<Point>([new Point(528, 345), new Point(625, 349)]);

    private var _map:MapModel;

    private var _bossNpc:Mobile;

    private var _noBossNpc:Mobile;

    private var _resourceLoader:ResourceLibraryLoader;

    private var _resLib:ResourceLibrary;

    private var _npcList:Vector.<MovieClip>;

    public function VinesFight(param1:MapModel) {
        super();
        this._map = param1;
        this.init();
    }

    private function init():void {
        var url:String = String(URLUtil.getActivityAnimation("vinesFight/vinesFight"));
        this._resourceLoader = new ResourceLibraryLoader(url);
        this._resourceLoader.getLib(function (param1:ResourceLibrary):void {
            var resLib:ResourceLibrary = param1;
            _resLib = resLib;
            initNpc();
            updateNpc();
            if (SceneManager.prevSceneType == SceneType.ARENA && _fightIndex == 1) {
                _fightIndex = 0;
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    NpcDialog.show(484, "埃鲁达克", [[1, "夫已经很多年没有遇到敌手了……的确，你已经不是小孩子，而是一个强大的战士了！老夫愿意永远与你并肩作战！"]], ["哇，太好啦！"]);
                } else {
                    NpcDialog.show(484, "埃鲁达克", [[1, "能坚持那么久已经让老夫感到敬佩！小孩，继续！"]], ["没问题！开始吧！", "还是算了！"], [function ():void {
                        _fightIndex = 1;
                        FightManager.startFightWithWild(102);
                    }]);
                }
            }
            TimeManager.addEventListener(TimeManager.TIME_UPDATE, onTimeUpdate);
        });
    }

    private function initNpc():void {
        this._npcList = Vector.<MovieClip>([]);
        var _loc1_:int = 0;
        while (_loc1_ < 2) {
            this._npcList.push(this._resLib.getMovieClip("npc" + _loc1_));
            this._npcList[_loc1_].x = this.npcPointList[_loc1_].x;
            this._npcList[_loc1_].y = this.npcPointList[_loc1_].y;
            this._map.content.addChild(this._npcList[_loc1_]);
            _loc1_++;
        }
        this._bossNpc = MobileManager.getMobile(484, MobileType.NPC);
        this._noBossNpc = MobileManager.getMobile(490, MobileType.NPC);
    }

    private function onTimeUpdate(param1:Event):void {
        this.updateNpc();
    }

    private function updateNpc():void {
        var _loc3_:MovieClip = null;
        var _loc4_:MovieClip = null;
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc2_:Number = uint(_loc1_.minutes);
        if (_loc2_ <= 30) {
            this._noBossNpc.visible = true;
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onNpc);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onNpc);
            for each(_loc3_ in this._npcList) {
                _loc3_.buttonMode = true;
                _loc3_.addEventListener(MouseEvent.CLICK, this.onNpcList);
            }
        } else {
            this._noBossNpc.visible = false;
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onNpc);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onNpc);
            for each(_loc4_ in this._npcList) {
                _loc4_.buttonMode = false;
                _loc4_.removeEventListener(MouseEvent.CLICK, this.onNpcList);
            }
        }
    }

    private function onNpc(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        var date:Date = new Date(TimeManager.getServerTime() * 1000);
        var minutes:Number = uint(date.minutes);
        if (event.content.params == "boss") {
            if (minutes <= 30) {
                NpcDialog.show(484, "埃鲁达克", [[3, "看到那些孜孜不倦的萨伦帝国士兵吗？帮老夫击退几个，对你来说小菜一碟吧！"]], ["与萨伦帝国士兵对战！"], [function ():void {
                    FightManager.startFightWithWild(101);
                }]);
            } else {
                this.goFight2();
            }
        }
    }

    private function goFight2():void {
        var petInfo:PetInfo = null;
        var b:Boolean = false;
        for each(petInfo in PetInfoManager.getAllBagPetInfo()) {
            if (petInfo.resourceId == 220) {
                b = true;
            }
        }
        if (b) {
            _fightIndex = 1;
            FightManager.startFightWithWild(102);
        } else {
            NpcDialog.show(484, "埃鲁达克", [[1, "嚯哈——哈——哈——！能够和老夫并肩作战那么久，也算是很强大的战士了！如何，想不想和老夫切磋切磋？"]], ["没问题！开始吧！", "我是打酱油的。"], [function ():void {
                _fightIndex = 1;
                FightManager.startFightWithWild(102);
            }]);
        }
    }

    private function onNpcList(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DayLimitManager.getDoCount(398, function (param1:int):void {
            if (param1 > 100) {
                NpcDialog.show(484, "埃鲁达克", [[1, "今天我们已经彻底挫败了他们的锐气！嚯哈——哈——哈——！"]], ["好！我明天再来！！"]);
                return;
            }
            FightManager.startFightWithWild(101);
        });
    }

    public function dispose():void {
        var _loc1_:MovieClip = null;
        for each(_loc1_ in this._npcList) {
            DisplayUtil.removeForParent(_loc1_);
        }
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onNpc);
        TimeManager.removeEventListener(TimeManager.TIME_UPDATE, this.onTimeUpdate);
        this._map = null;
        this._bossNpc = null;
        this._noBossNpc = null;
        this._resourceLoader = null;
        this._resLib = null;
        this._npcList = null;
    }
}
}
