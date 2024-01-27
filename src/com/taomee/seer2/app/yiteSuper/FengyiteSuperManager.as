package com.taomee.seer2.app.yiteSuper {
import com.greensock.TweenNano;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.PetDemoDisplayer;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.utils.FightHelpUtil;
import com.taomee.seer2.app.utils.PetUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class FengyiteSuperManager {

    private static const config:Array = [[80534, [[1823, 100, [[3101, "风伊特", [[0, "哟！老大哥。还蜗居在这黑漆漆的老家呢？"]], ["……"]], [78, "战伊特", [[0, "是……阿风吗？斯坦因那个老家伙居然又对你做了改造……真是惨无人道……"]], ["……"]], [3101, "风伊特", [[0, "你似乎搞错了什么呀。我选择留在博士身边，只是因为他所做的一切都很有趣而已。那种世俗的正义和人道，太虚伪了，就像是枷锁一样。"]], ["……"]], [78, "战伊特", [[0, "……那就让我看看你寻求到了怎样的自由和力量吧。"]], ["不妨一战？"]]]], [1824, 97, [[476, "飞伊特", [[0, "哥哥！等你好久辣。"]], ["……"]], [3101, "风伊特", [[0, "哟。博士让我传话给你，星际使者一行人马上会到飞翼氏族走一趟，你需要充当一下向导。"]], ["……"]], [476, "飞伊特", [[0, "昂？好的。话说，你的模样和以前变化好大啊……"]], ["这就是我找你的第二个目的。"]], [3101, "风伊特", [[0, "博士已经完成了有关我们超进化的研究，事实证明大家都有着十分巨大的潜力。今天我带来了博士提供给你的进化血清——不过在那之前，得让我看看你有没有长进~"]], ["来切磋切磋吧！"]]]], [1825, 586, [[660, "巨石托尔", [[0, "路过找到个捣蛋鬼，可惜比我弱的多。不能拿来当凳子，就拿来当抱枕吧。嗯？你又是什么玩意？看上去和这只淡棕色的小家伙长得挺像啊。"]], ["……"]], [3101, "风伊特", [[0, "QAQ哥哥……"]], ["你也就只能欺凌弱小了吧，嗯？"]]]]]], [80535, [[1826, 887, [[212, "卡多斯", [[0, "……你又来了，面生的风族精灵。今日又是来讨教的吗？"]], ["是啊，我又来了~"]], [212, "卡多斯", [[0, "已经不记得将你打倒在地多少次了。你的执念着实可敬。是什么让你如此执拗地追求力量？"]], ["我可不是实力至上的信奉者啊~"]], [3100, "风暴伊特", [[0, "更强大，更能守护自己重要的事物。更强大，才更有资格追寻自由。我只是在寻求生命的意义，仅此而已。"]], ["……"]], [212, "卡多斯", [[0, "无妨。你的执念，我看到了。今日你的姿态已与往日不同，我也应以更强大的姿态与你切磋。告诉我你的名字吧——追寻着生命意义的风族！）"]], ["在下风暴伊特，请多指教！"]]]], [1827, 739, [[3100, "风暴伊特", [[0, "什……怎么了？这里是哪里？我分明刚才还在与卡多斯较量，这究竟是……"]], ["……"]], [3111, "瞳魂兽", [[0, "加持了飓风护佑的少年……你渴望力量吗？"]], ["什么……"]], [3100, "风暴伊特", [[0, "你是谁？这里是……哪里？！"]], ["这里……是风瞳之下的幻境。"]], [3111, "瞳魂兽", [[0, "年轻的少年，让吾好好看看你。你是渴望着力量，还是渴望着真理？"]], ["啧，要来一战对吧？！"]]]]]]];

    private static var _currentLevel:int;

    private static var _currentBossIndex:int;

    private static var _petIcon:PetDemoDisplayer;

    private static var _isStart:Boolean = false;

    private static var _helpUtil:FightHelpUtil;

    private static var _fightId:int;


    public function FengyiteSuperManager() {
        super();
    }

    public static function startGame(param1:int):void {
        if (param1 < 60) {
            _currentLevel = 0;
        } else {
            _currentLevel = 1;
        }
        _currentBossIndex = 0;
        var _loc2_:int = int(config[_currentLevel][0]);
        _isStart = true;
        if (SceneManager.active.mapID == _loc2_) {
            initMap();
        } else {
            SceneManager.changeScene(SceneType.COPY, _loc2_);
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitch);
        }
    }

    private static function onMapSwitch(param1:SceneEvent):void {
        if (SceneManager.active.type != SceneType.ARENA) {
            if (mapIds.indexOf(SceneManager.active.mapID) == -1) {
                _isStart = false;
            }
        }
        initMap();
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitch);
    }

    private static function get mapIds():Array {
        var _loc1_:Array = [];
        var _loc2_:int = 0;
        while (_loc2_ < config.length) {
            _loc1_.push(config[_loc2_][0]);
            _loc2_++;
        }
        return _loc1_;
    }

    private static function getNpcDialogs(param1:int, param2:int):Array {
        return config[param1][1][param2][2];
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
        var _loc1_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
        if (PetUtil.maxBagPetStarLevel >= 5 || _loc1_.length >= 6) {
            AlertManager.showAlert("携带最多5只4星以下的精灵才可以进入风暴伊特梦境哦!");
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
        if (_petIcon != null) {
            _petIcon.clearDemo();
            _petIcon.killLoad();
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
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitch);
        (SceneManager.active as LobbyScene).showToolbar();
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
        TweenNano.delayedCall(1, function ():void {
            ModuleManager.showAppModule("FengyiteSuperPanel");
        });
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    public static function onPetClick(param1:* = null):void {
        var _loc2_:Array = getNpcDialogs(_currentLevel, _currentBossIndex);
        NpcDialog.showDialogs(_loc2_, fight);
    }

    private static function fight():void {
        _fightId = getFightId(_currentLevel, _currentBossIndex);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onFightOver);
        FightManager.startFightWithWild(_fightId);
    }

    private static function onFightOver(param1:* = null):void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onFightOver);
            if (_fightId == FightManager.currentFightRecord.initData.positionIndex) {
                if (FightManager.currentFightRecord.isWinWar()) {
                    if (_currentBossIndex == config[_currentLevel][1].length - 1) {
                        _isStart = false;
                        leaveMap();
                    } else {
                        ++_currentBossIndex;
                        initMap(null);
                    }
                } else {
                    leaveMap();
                }
            }
        }
    }

    private static function exitMap(param1:* = null):void {
        var e:* = param1;
        AlertManager.showConfirm("离开地图将结束挑战，你确定要离开吗？", function ():void {
            _isStart = false;
            leaveMap();
        });
    }
}
}
