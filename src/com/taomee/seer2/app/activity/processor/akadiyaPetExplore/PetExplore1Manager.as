package com.taomee.seer2.app.activity.processor.akadiyaPetExplore {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.popup.AlertManager;
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

public class PetExplore1Manager {

    private static var MAP_IDS:Array = [80565];

    private static var DIALOG0:Array = [[505, "帕拉丁", [[0, "什么人！！不许动！！这里是赛尔号Ⅱ光之守卫队的控制区域，闲人不得入内！"]], [" 哇！吓死我了！"]], [400, "小赛尔", [[0, "那，那个！！我只是看到这个舱室的门开着，就进来了……这，这里是什么禁地吗？？"]], ["好汉饶命……"]], [505, "帕拉丁", [[0, "啊……是星际使者啊。好久不见，不知你是否还记得我？"]], ["诶……你是三年前黑化事件中的那只帕拉丁？？"]], [505, "帕拉丁", [[0, "（开心）是的！能被星际使者记住真是区区一员守卫的无上荣幸！自从带回了卡拉尔，我就被调派到了飞船重点区域的护卫队里。"]], ["重点区域……但这个地方好荒凉……"]], [505, "帕拉丁", [[0, "不不不，您难道忘了吗？再看看。虽然气灯并没有打开，但这里可是你应当十分熟悉的地方啊。"]], ["     ……卧槽，这里是旧时代的船长室？？"]], [505, "帕拉丁", [[0, "是的！自从失去动力，飞船一直在改变各舱室的功能与器械特征，以做好长期作为地表堡垒、适应阿卡迪亚环境的准备。这是赛尔号Ⅱ还在星海上漫游的时代留下的宝贵遗迹。"]], ["但是为什么入口移到了这里？"]], [505, "帕拉丁", [[0, "您在阿卡迪亚星南半球举步维艰时，飞船不仅进行了主要舱室的革新，老舱室的入口也随着主要走廊的迁移而改变。与其他舱室不同的是，旧船长室已经完全脱离了其功能。"]], ["但因为历史价值很高，所以被长期保存下来？"]], [505, "帕拉丁", [[0, "是的。话说回来，第七小队常年在外奔波，不知基本的作战能力有没有生疏？~"]], ["   当然没有。怎么，要切磋一下吗？"]], [505, "帕拉丁", [[0, "哈哈哈哈。这样吧。您可以先去英格瓦要塞新开放的孤独之门挑战一下。【接下来，您在[孤独之战•宣战阶段]每获得一场胜利，都会获得光之守卫队给予的额外奖励】。"]], [" 这么好？？那我去试试吧~"]], [505, "帕拉丁", [[0, "每次来到这里与我见面，您最多可以在接下来的孤独之战竞技中获得5个【净化之光】。当你获得了30个以上的净化之光时，请务必来告诉我这一荣耀！~"]], ["    行！让你看看我的实力！"]]];

    private static var DIALOG1:Array = [[505, "帕拉丁", [[0, "……勇敢的星际使者，你竟然收集到了这么多净化之光。作为光之守卫队的一员，我有必要与你进行一次战斗以示敬意！"]], ["  好啊！"]], [400, "小赛尔", [[0, "（帕拉丁5回合就会逃跑，务必做好准备进行捕捉！）"]], ["开始对战", "再准备一下"]]];

    private static var _fightIndex:int;

    private static var _fightId:int;

    private static const DIALOGS:Array = [DIALOG0, DIALOG1];

    private static var _npcMv:MovieClip;


    public function PetExplore1Manager() {
        super();
    }

    public static function start():void {
        _fightIndex = canCatch();
        SceneManager.changeScene(SceneType.COPY, 80565);
        if (SceneManager.active.mapID == 80565) {
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
                destroy();
            }
        }
    }

    private static function initMap():void {
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
        resUrl = String(URLUtil.getRes("activity/animation/akadiya/paLaDing.swf"));
        QueueLoader.load(resUrl, LoadType.SWF, function (param1:ContentInfo):void {
            var _loc2_:* = DomainUtil.getClass("mv", param1.domain);
            _npcMv = new _loc2_();
            _npcMv.addEventListener(MouseEvent.CLICK, onNpcClick);
            _npcMv.gotoAndStop(1);
            _npcMv.buttonMode = true;
            SceneManager.active.mapModel.front.addChild(_npcMv);
        });
    }

    private static function onNpcClick(param1:* = null):void {
        var _loc2_:Array = DIALOGS[_fightIndex];
        var _loc3_:Function = _fightIndex == 0 ? chuFa : fight;
        NpcDialog.showDialogs(_loc2_, _loc3_);
    }

    private static function chuFa():void {
        SwapManager.swapItem(4597, 1, function success(param1:IDataInput):void {
            var data:IDataInput = param1;
            AlertManager.showAlert("赶快前往孤独之战获取净化之光吧！", function ():void {
                SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onOver);
                SceneManager.changeScene(SceneType.LOBBY, 70);
            });
            new SwapInfo(data);
        });
    }

    private static function onOver(param1:* = null):void {
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onOver);
        ModuleManager.showAppModule("NoPoultryBattleFieldMainPanel");
    }

    private static function fight():void {
        _fightId = 1855;
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onFightOver);
        FightManager.startFightWithWild(_fightId);
    }

    private static function onFightOver(param1:* = null):void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            SceneManager.changeScene(SceneType.LOBBY, 70);
        }
    }

    private static function canCatch():int {
        var _loc1_:Array = [401289];
        if (ItemManager.getItemQuantityByReferenceId(_loc1_[0]) < 30) {
            return 0;
        }
        return 1;
    }

    private static function destroy():void {
        if (_npcMv != null) {
            _npcMv.parent.removeChild(_npcMv);
            _npcMv.removeEventListener(MouseEvent.CLICK, onNpcClick);
        }
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitch);
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onFightOver);
    }
}
}
