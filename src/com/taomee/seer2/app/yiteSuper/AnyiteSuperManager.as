package com.taomee.seer2.app.yiteSuper {
import com.greensock.TweenNano;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.PetDemoDisplayer;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.utils.FightHelpUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class AnyiteSuperManager {

    private static const config:Array = [[80512, [[1798, 118, 441, "老大！醒醒！还认得我是谁吗？万圣之夜捣蛋的作战不能没有你的指挥啊!", "我……不认识你这个绷带怪物……"], [1799, 89, 434, "喂！黑乎乎的家伙！你是那个烦人小鬼的哥哥吗？快起来管管你老弟吧！", "我……没有兄弟……"], [1800, 100, 492, "怎么回事啊？还没过几招就成这样了？眼里还有没有我这个大哥了？快爬起来继续战斗啊！", "我没有大哥，不要招惹我！！"], [1801, 96, 453, "光暗本是双生，你成了现在的这样子……纵使获得了力量，也脱离了本心，你的心中……没有一点光明了么？", "我……自有记忆起……就不认同光明！！"], [1802, 95, 440, "……谁？他们是谁？我是谁？我不能在这里倒下，我不能就这样……但是为什么？", "我……认识你……你……是谁？"]]], [80513, [[1803, 997, 3094, "老大！醒醒！还认得我是谁吗？万圣之夜捣蛋的作战不能没有你的指挥啊!", "我……不认识你这个绷带怪物……"], [1804, 95, 440, "喂！黑乎乎的家伙！你是那个烦人小鬼的哥哥吗？快起来管管你老弟吧！", "我……没有兄弟……"], [1805, 96, 3104, "光暗本是双生，你成了现在的这样子……纵使获得了力量，也脱离了本心，你的心中……没有一点光明了么？", "我……自有记忆起……就不认同光明！！"], [1806, 92, 3101, "……谁？他们是谁？我是谁？我不能在这里倒下，我不能就这样……但是为什么？", "再准备一下"], [1807, 93, 3102, "……谁？他们是谁？我是谁？我不能在这里倒下，我不能就这样……但是为什么？", "我……认识你……你……是谁？"], [1808, 94, 3103, "……谁？他们是谁？我是谁？我不能在这里倒下，我不能就这样……但是为什么？", "我……认识你……你……是谁？"]]], [80514, [[1809, 642, 694, "哈哈哈，萨伦帝国又多了一个忠诚的战士！我的战士不需要思考，只需要忠心跟随我!", "不……不是这样的……"], [1810, 2554, 3099, "我只是……不能接受这个盲目的现实……！萨伦一统阿卡迪亚指日可待，暗影氏族再必须选择立场，否则最后会落得和北半球相似的下场！！所以，和我一起把这腐朽颓败的地方摧毁吧！", "不……斯卡沃兹，你错了……！！"], [1811, 1046, 511, "阴影之下亦有道路，唯有本心可指引你不再迷茫。来吧，向前迈出最后一步——让我看到真正的你！", "再准备一下"]]]];

    private static var _currentLevel:int;

    private static var _currentBossIndex:int;

    private static var _petIcon:PetDemoDisplayer;

    private static var _isStart:Boolean = false;

    private static var _helpUtil:FightHelpUtil;

    private static var _fightId:int;


    public function AnyiteSuperManager() {
        super();
    }

    public static function startGame(param1:int):void {
        if (param1 < 40) {
            _currentLevel = 0;
        } else if (param1 < 80) {
            _currentLevel = 1;
        } else {
            _currentLevel = 2;
        }
        _currentBossIndex = 0;
        var _loc2_:int = int(config[_currentLevel][0]);
        _isStart = true;
        SceneManager.changeScene(SceneType.COPY, _loc2_);
        if (SceneManager.active.mapID == _loc2_) {
            initMap();
        }
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitch);
    }

    private static function onMapSwitch(param1:SceneEvent):void {
        if (SceneManager.active.type != SceneType.ARENA) {
            if ([80512, 80513, 80514].indexOf(SceneManager.active.mapID) == -1) {
                _isStart = false;
            }
        }
    }

    private static function getNpcDialogs(param1:int, param2:int):Array {
        return [config[param1][1][param2][3], config[param1][1][param2][4]];
    }

    private static function getNpcId(param1:int, param2:int):int {
        return config[param1][1][param2][2];
    }

    private static function getPetId(param1:int, param2:int):int {
        return config[param1][1][param2][1];
    }

    private static function getFightId(param1:int, param2:int):int {
        return config[param1][1][param2][0];
    }

    private static function getMapId(param1:int):int {
        return config[param1][0];
    }

    public static function checkEnterLimit():Boolean {
        var _loc6_:PetInfo = null;
        var _loc1_:Array = [10, 11, 12, 608];
        var _loc2_:int = ActorManager.actorInfo.followingPetInfo == null ? 0 : int(ActorManager.actorInfo.followingPetInfo.resourceId);
        if (ActorManager.actorInfo.followingPetInfo == null || _loc1_.indexOf(_loc2_) == -1) {
            AlertManager.showAlert("需要身边跟随具有入梦特性的精灵!");
            return false;
        }
        var _loc3_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
        var _loc4_:Boolean = true;
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_.length) {
            if ((_loc6_ = _loc3_[_loc5_]).getPetDefinition().starLevel > 4) {
                _loc4_ = false;
                break;
            }
            _loc5_++;
        }
        if (_loc4_ == false || _loc3_.length >= 6) {
            AlertManager.showAlert("携带最多5只4星以下的精灵才可以进入暗影伊特梦境哦!");
            return false;
        }
        return true;
    }

    public static function initMap(param1:MapModel = null):void {
        var petId:int;
        var mapModel:MapModel = param1;
        _helpUtil = new FightHelpUtil(SceneManager.active.mapModel.front["petBagBtn"], SceneManager.active.mapModel.front["reBloodBtn"]);
        if (SceneManager.active.mapModel.front["exitBtn"]) {
            SceneManager.active.mapModel.front["exitBtn"].addEventListener(MouseEvent.CLICK, exitMap);
        }
        if (!_isStart) {
            (SceneManager.active as LobbyScene).showToolbar();
            TweenNano.delayedCall(1, function ():void {
                SceneManager.changeScene(SceneType.LOBBY, 70);
            });
            return;
        }
        if (_petIcon != null) {
            TooltipManager.remove(_petIcon);
            _petIcon.removeEventListener(MouseEvent.CLICK, onPetClick);
            DisplayUtil.removeForParent(_petIcon);
        }
        _petIcon = new PetDemoDisplayer();
        _petIcon.clearDemo();
        _petIcon.scaleX = _petIcon.scaleY = 1;
        _petIcon.x = 200;
        _petIcon.y = 400;
        if (mapModel != null) {
            mapModel.front.addChild(_petIcon);
        } else {
            SceneManager.active.mapModel.front.addChild(_petIcon);
        }
        petId = getPetId(_currentLevel, _currentBossIndex);
        _petIcon.newSetUrl(URLUtil.getPetDemo(PetConfig.getPetDefinition(petId).resId));
        _petIcon.addEventListener(MouseEvent.CLICK, onPetClick);
        _petIcon.buttonMode = true;
        TooltipManager.addCommonTip(_petIcon, PetConfig.getPetDefinition(petId).name);
        (SceneManager.active as LobbyScene).hideToolbar();
    }

    public static function leaveMap():void {
        if (_helpUtil != null) {
            _helpUtil.dispose();
            _helpUtil = null;
        }
        if (_petIcon != null) {
            TooltipManager.remove(_petIcon);
            _petIcon.removeEventListener(MouseEvent.CLICK, onPetClick);
        }
        if (SceneManager.active.mapModel.front["exitBtn"]) {
            SceneManager.active.mapModel.front["exitBtn"].removeEventListener(MouseEvent.CLICK, exitMap);
        }
    }

    public static function onPetClick(param1:* = null):void {
        var _loc2_:Array = getNpcDialogs(_currentLevel, _currentBossIndex);
        var _loc3_:int = getNpcId(_currentLevel, _currentBossIndex);
        var _loc4_:int = getPetId(_currentLevel, _currentBossIndex);
        var _loc5_:String = PetConfig.getPetDefinition(_loc4_).name;
        NpcDialog.show(_loc3_, _loc5_, [[0, _loc2_[0]]], [_loc2_[1], "→进入挑战"], [cancelFight, fight]);
    }

    private static function cancelFight():void {
    }

    private static function fight():void {
        _fightId = getFightId(_currentLevel, _currentBossIndex);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onFightOver);
        FightManager.startFightWithWild(_fightId);
    }

    private static function onFightOver(param1:* = null):void {
        var e:* = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onFightOver);
            if (_fightId == FightManager.currentFightRecord.initData.positionIndex) {
                if (FightManager.currentFightRecord.isWinWar()) {
                    if (_currentBossIndex == config[_currentLevel][1].length - 1) {
                        _isStart = false;
                        (SceneManager.active as LobbyScene).showToolbar();
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        ModuleManager.showAppModule("AnyiteSuperFight0Panel");
                    } else {
                        ++_currentBossIndex;
                        initMap(null);
                    }
                } else {
                    (SceneManager.active as LobbyScene).showToolbar();
                    SceneManager.changeScene(SceneType.LOBBY, 70);
                    _isStart = false;
                    TweenNano.delayedCall(1, function ():void {
                        ModuleManager.showAppModule("AnyiteSuperFight0Panel");
                    });
                }
            }
        }
    }

    private static function exitMap(param1:* = null):void {
        var e:* = param1;
        AlertManager.showConfirm("离开地图将结束挑战，你确定要离开吗？", function ():void {
            _isStart = false;
            (SceneManager.active as LobbyScene).showToolbar();
            SceneManager.changeScene(SceneType.LOBBY, 70);
            TweenNano.delayedCall(1, function ():void {
                ModuleManager.showAppModule("AnyiteSuperPanel");
            });
        });
    }
}
}
