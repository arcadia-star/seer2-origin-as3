package com.taomee.seer2.app.activity.processor.akadiyaPetExplore {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.utils.DomainUtil;

public class PetExplore0Manager {

    private static var MAP_IDS:Array = [80558, 80559];

    private static var DIALOG0:Array = [[3118, "尼禄", [[0, "黑夜！火光！无边的黑暗里点燃火苗是最刺激的！"]], ["好黑呀~好亮呀~"]], [3119, "尼禄", [[0, "看到那棵树了吗！！烧了它！！烧了它！！！~"]], ["嘻嘻嘻嘻嘻~"]], [400, "小赛尔", [[0, "烧……烧了它……（我的神志怎么变模糊了……）"]], ["烧了它……"]]];

    private static var DIALOG1:Array = [[3118, "尼禄", [[0, "它刺伤我的眼睛了！……"]], ["我的灯笼都显得暗淡无光了……"]], [3118, "尼禄", [[0, "呜……这么亮晶晶的东西，不能在这里出现！~"]], ["然而，它是光系精灵……~"]], [3119, "尼古拉斯", [[0, "年轻的提灯怪灵们，不要惧怕。去战胜它！"]], ["我会祝你们一臂之力！"]], [3118, "尼禄", [[0, "和……和那只光系精灵战斗，我们会获得奖励吗？~"]], ["当然了！~"]], [400, "尼古拉斯", [[0, "你们越快战胜它，我就奖励你们越多的福文！"]], ["那、那好吧！"]]];

    private static var DIALOG2:Array = [[3118, "尼禄", [[0, "：呀，你有好多福咒和福文！把它们送给我吧！作为交换，我就和你来一场战斗！"]], [" 好啊！"]], [400, "小赛尔", [[0, "尼禄5回合就会逃跑，务必做好准备进行捕捉！）"]], ["开始对战", "再准备一下"]]];

    private static var DIALOG3:Array = [[3118, "尼禄", [[0, "呀，你有好多福咒和福文！但还不够呢！如果你有10个福咒和10个福文，下次碰到你的时候就和你来场对战哟！"]], [" 好啊！"]], [400, "小赛尔", [[0, "尼禄：今天我很开心~这些奖励送给你吧！幸福、喜悦，愿它们都属于你~"]], ["再见尼禄~"]]];

    private static const DIALOGS:Array = [DIALOG0, DIALOG1, DIALOG2, DIALOG3];

    private static var _fightIndex:int;

    private static var _fightId:int;

    private static var _npcMv:MovieClip;


    public function PetExplore0Manager() {
        super();
    }

    public static function start():void {
        _fightIndex = 0;
        SceneManager.changeScene(SceneType.COPY, 80558);
        if (SceneManager.active.mapID == 80558) {
            initMap();
        }
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitch);
    }

    private static function onMapSwitch(param1:SceneEvent):void {
        var _loc2_:int = 0;
        if (SceneManager.active.type != SceneType.ARENA) {
            _loc2_ = int(SceneManager.active.mapID);
            if (MAP_IDS.indexOf(_loc2_) != -1) {
                initMap();
            } else {
                if (_npcMv != null) {
                    _npcMv.parent.removeChild(_npcMv);
                    _npcMv.removeEventListener(MouseEvent.CLICK, onNpcClick);
                }
                SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitch);
                SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onFightOver);
            }
        }
    }

    private static function initMap():void {
        ModuleManager.showAppModule("NiluItemBuyPanel");
        initNpc();
    }

    private static function initNpc():void {
        var resUrl:String;
        if (_npcMv != null) {
            if (_npcMv.parent != null) {
                _npcMv.parent.removeChild(_npcMv);
            }
            _npcMv.removeEventListener(MouseEvent.CLICK, onNpcClick);
            _npcMv = null;
        }
        resUrl = String(URLUtil.getRes("activity/animation/akadiya/nilu.swf"));
        QueueLoader.load(resUrl, LoadType.SWF, function (param1:ContentInfo):void {
            var _loc2_:* = DomainUtil.getClass("mv", param1.domain);
            _npcMv = new _loc2_();
            _npcMv.addEventListener(MouseEvent.CLICK, onNpcClick);
            _npcMv.gotoAndStop(_fightIndex + 1);
            _npcMv.buttonMode = true;
            SceneManager.active.mapModel.front.addChild(_npcMv);
        });
    }

    private static function onNpcClick(param1:* = null):void {
        var _loc2_:Array = DIALOGS[_fightIndex];
        var _loc3_:Function = fight;
        if (_fightIndex == 2 && !canCatch) {
            _loc2_ = DIALOG3;
            _loc3_ = swapItem;
        }
        NpcDialog.showDialogs(_loc2_, _loc3_);
    }

    private static function swapItem():void {
        var swapId:int;
        SceneManager.changeScene(SceneType.LOBBY, 70);
        swapId = 4590;
        SwapManager.swapItem(swapId, 1, function success(param1:IDataInput):void {
            new SwapInfo(param1);
        });
    }

    private static function fight():void {
        _fightId = 1849 + _fightIndex;
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onFightOver);
        FightManager.startFightWithWild(_fightId);
    }

    private static function onFightOver(param1:* = null):void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (_fightId == FightManager.currentFightRecord.initData.positionIndex) {
                if (FightManager.currentFightRecord.isWinWar()) {
                    if (_fightIndex == 2) {
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        return;
                    }
                    ++_fightIndex;
                    if (_fightIndex == 2) {
                        SceneManager.changeScene(SceneType.COPY, 80559);
                    }
                    initNpc();
                } else {
                    SceneManager.changeScene(SceneType.LOBBY, 70);
                }
            }
        }
    }

    private static function get canCatch():Boolean {
        var _loc1_:Array = [400239, 400240];
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_.length) {
            if (ItemManager.getItemQuantityByReferenceId(_loc1_[_loc2_]) < 10) {
                return false;
            }
            _loc2_++;
        }
        return true;
    }
}
}
