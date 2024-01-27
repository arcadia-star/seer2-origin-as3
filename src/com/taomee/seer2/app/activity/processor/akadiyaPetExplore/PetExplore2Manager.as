package com.taomee.seer2.app.activity.processor.akadiyaPetExplore {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
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

public class PetExplore2Manager {

    private static var progressCount:int = 206411;

    private static var MAP_IDS:Array = [80576];

    private static var DIALOG0:Array = [[485, "维维", [[0, "吓！！！QAQ。我！！我没有偷吃东西！！没有！！"]], ["  ……放轻松。"]], [400, "小赛尔", [[0, "我说架子上怎么有动静……又有小精灵趁着舒尔不在偷吃东西了。"]], ["我不会把你扔进油锅里的，别紧张= =|||"]], [485, "维维", [[0, "QAQ我，我真的是太饿了……原本碧玉森林的大树上有许多好吃的浆果，现在都被萨伦帝国的坏家伙烧光了……"]], ["可怜的孩子。荆棘林也有挺多浆果的呀。"]], [400, "小赛尔", [[0, "你，叫什么名字？~"]], [" 不如我给你弄些填肚子的东西吧。"]], [485, "维维", [[0, "我，我叫维维。我们一族被称作美食猪，向来食量大，也会帮助人们烹调好吃的东西作为谢意……但我还没长大，我不会烹调……呜呜呜。"]], ["所以才饿着肚子啊。"]], [400, "小赛尔", [[0, "要不要跟我一起冒险？天天都有好吃的东西哟！"]], [" （引诱开始！！）"]], [485, "维维", [[0, "………………噫。你，一脸奸商的表情。…………害怕，维维限定版。"]], [" ……= =|||"]], [485, "维维", [[0, "这样吧，那个。你如果填饱了我的肚子，我就跟着你走！OAO（美食类道具能增加的“经验值”等于它们能增加的“美味满意度”哦！）~"]], ["现在就来！", "今天我好像没带什么好吃的……"]]];

    private static var DIALOG1:Array = [[485, "维维", [[0, "我还没吃饱，还有吗？还有吗？？OAO"]], ["还有还有！", "我的库存已经被你吃光了……"]]];

    private static var DIALOG2:Array = [[485, "维维", [[0, "好吧好吧……但是我还没吃饱……下次还要给我带好吃的啊，我在这等你！"]], ["  好的好的~"]], [485, "维维", [[0, "这些是我收集的食材，不介意的话请用它们来烹饪好吃的东西吧QWQ【可以使用[食材]在[七味小厨]烹饪美食猪喜欢的美食哦！】"]], ["哈，谢谢你~"]]];

    private static var DIALOG3:Array = [[485, "维维", [[0, "嗝~~~~~吃的好饱~~"]], ["我可以挑战你了吗！！"]], [485, "维维", [[0, "如果你能捕捉我，我就做你的精灵！！"]], [" 等候多时了！！"]]];

    private static var DIALOG4:Array = [[485, "帕拉丁", [[0, "嗝~~~~~吃的好饱~~"]], ["我可以挑战你了吗！！"]], [400, "小赛尔", [[0, "如果你能捕捉我，我就做你的精灵！！"]], [" 等候多时了！！"]]];

    private static var _fightIndex:int;

    private static var _fightId:int;

    private static const DIALOGS:Array = [DIALOG0, DIALOG1, DIALOG2, DIALOG3];

    private static var _npcMv:MovieClip;

    private static var _proMv:MovieClip;

    private static var isEnt:int;


    private var ss:Array;

    public function PetExplore2Manager() {
        this.ss = [206642, 200721, 200722, 200723, 200511, 200518, 200502, 200505, 200506, 200508, 200514, 200564, 200570, 200567];
        super();
    }

    public static function start():void {
        SceneManager.changeScene(SceneType.COPY, 80576);
        if (SceneManager.active.mapID == 80576) {
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
        isEnt = IsEnter();
        if (_npcMv != null) {
            if (_npcMv.parent != null) {
                _npcMv.parent.removeChild(_npcMv);
            }
            _npcMv.removeEventListener(MouseEvent.CLICK, onNpcClick);
            _npcMv = null;
        }
        resUrl = String(URLUtil.getRes("activity/animation/akadiya/proGress.swf"));
        QueueLoader.load(resUrl, LoadType.SWF, function (param1:ContentInfo):void {
            var _loc2_:* = DomainUtil.getClass("mv", param1.domain);
            _proMv = new _loc2_();
            _proMv.gotoAndStop(1);
            _proMv.buttonMode = true;
            SceneManager.active.mapModel.front.addChild(_proMv);
            canCatch();
        });
        resUrl = String(URLUtil.getRes("activity/animation/akadiya/weiwei.swf"));
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
        var _loc4_:Function = chuFa1;
        if (_fightIndex == 0) {
            NpcDialog.showDialogs(_loc2_, _loc3_, _loc4_);
        } else {
            NpcDialog.showDialogs(_loc2_, _loc3_);
        }
    }

    private static function chuFa1():void {
        NpcDialog.showDialogs(DIALOGS[1], chuFa, function ():void {
            NpcDialog.showDialogs(DIALOGS[2], function ():void {
                SwapManager.swapItem(4616, 1, function success(param1:IDataInput):void {
                    new SwapInfo(param1);
                });
            });
        });
    }

    private static function chuFa():void {
        if (isEnt == 1) {
            ModuleManager.showAppModule("NewOreSellPanel");
        } else {
            AlertManager.showAlert("你当前没有所需美食!", function ():void {
                NpcDialog.showDialogs(DIALOGS[2], function ():void {
                    SwapManager.swapItem(4616, 1, function success(param1:IDataInput):void {
                        new SwapInfo(param1);
                    });
                });
            });
        }
    }

    private static function onOver(param1:* = null):void {
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onOver);
        ModuleManager.showAppModule("NoPoultryBattleFieldMainPanel");
    }

    private static function fight():void {
        _fightId = 1861;
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onFightOver);
        FightManager.startFightWithWild(_fightId);
    }

    private static function onFightOver(param1:* = null):void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            SceneManager.changeScene(SceneType.LOBBY, 70);
        }
    }

    private static function canCatch():void {
        ActiveCountManager.requestActiveCountList([progressCount], function (param1:Parser_1142):void {
            var _loc2_:int = int(param1.infoVec[0]);
            _proMv["count"].text = _loc2_ + "";
            _proMv["progress"].gotoAndStop(int(_loc2_ / 500));
            if (_loc2_ < 50000) {
                _fightIndex = 0;
            } else {
                _fightIndex = 3;
            }
        });
    }

    private static function IsEnter():int {
        var _loc1_:Array = [206642, 200721, 200722, 200723, 200511, 200518, 200502, 200505, 200506, 200508, 200514, 200564, 200570, 200567];
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_.length) {
            if (ItemManager.getItemQuantityByReferenceId(_loc1_[_loc2_]) > 1) {
                return 1;
            }
            _loc2_++;
        }
        return 0;
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
