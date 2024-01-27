package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.MineManger;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

public class MapProcessor_80382 extends MapProcessor {

    private static const SWAP_LIST:Vector.<int> = Vector.<int>([3592]);

    private static const DAY_LIST:Array = [1539];

    private static const FOR_LIST:Array = [205389];

    private static const ITEM_ID_LIST:Vector.<uint> = Vector.<uint>([401105, 206656]);

    private static const MINE_ID:int = 339;

    private static const TREE_STATE:Vector.<int> = Vector.<int>([1, 2, 65, 66, 203, 204, 282]);

    private static const MAGIC_STATE:Vector.<int> = Vector.<int>([1, 2, 28, 29, 167]);


    private var _npcList:Vector.<MovieClip>;

    public function MapProcessor_80382(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._npcList = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            this._npcList.push(_map.content["npc" + _loc1_]);
            this._npcList[_loc1_].buttonMode = true;
            this._npcList[_loc1_].addEventListener(MouseEvent.CLICK, this.onNpc);
            _loc1_++;
        }
    }

    private function onNpc(param1:MouseEvent):void {
        var _loc2_:int = this._npcList.indexOf(param1.currentTarget as MovieClip);
        switch (_loc2_) {
            case 0:
                this.magicHandle();
                break;
            case 1:
                this.treeClickHandle();
                break;
            case 2:
                this.ruleClickHandle();
        }
    }

    private function ruleClickHandle():void {
        ModuleManager.showAppModule("CandyNightmarePanel");
    }

    private function treeClickHandle():void {
        ItemManager.requestItemList(function ():void {
            ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                var num:int = 0;
                var par:Parser_1142 = param1;
                num = ItemManager.getItemQuantityByReferenceId(ITEM_ID_LIST[0]);
                NpcDialog.show(843, "小法师", [[0, "吃大蒜会吐什么皮啊？ 给树爷爷来来 <font color=\'#ff3300\'>30</font>个 大蒜！ 你有 <font color=\'#ff3300\'>" + num + "</font>个呢，每次抛糖都有礼物或万圣糖芯！再抛 <font color=\'#ff3300\'>" + (6 - par.infoVec[0]) + "</font>次一定会得到<font color=\'#ff3300\'>万圣糖芯 </font>"]], ["给你！ ", "我……我舍不得"], [function ():void {
                    if (num < 30) {
                        NpcDialog.show(843, "小法师", [[0, "要<font color=\'#ff3300\'>30</font>个才能吐呀！否则魔法没办法开始的呀！"]], ["知道了 "]);
                    } else {
                        MineManger.getMineItem(MINE_ID, function (param1:Parser_1060):void {
                            var getProcess:*;
                            var item:* = undefined;
                            var data:Parser_1060 = param1;
                            _npcList[1].mouseEnabled = _npcList[1].mouseChildren = false;
                            getProcess = false;
                            for each(item in data.addItemVec) {
                                if (ITEM_ID_LIST[1] == item.id) {
                                    getProcess = true;
                                    break;
                                }
                            }
                            if (getProcess) {
                                MovieClipUtil.playMc(_npcList[1], TREE_STATE[1], TREE_STATE[2], function ():void {
                                    MovieClipUtil.playMc(_npcList[1], TREE_STATE[3], TREE_STATE[4], function ():void {
                                        _npcList[1].gotoAndStop(1);
                                        _npcList[1].mouseEnabled = _npcList[1].mouseChildren = true;
                                        data.showResult(true);
                                    }, true);
                                }, true);
                            } else {
                                MovieClipUtil.playMc(_npcList[1], TREE_STATE[1], TREE_STATE[2], function ():void {
                                    MovieClipUtil.playMc(_npcList[1], TREE_STATE[5], TREE_STATE[6], function ():void {
                                        _npcList[1].gotoAndStop(1);
                                        _npcList[1].mouseEnabled = _npcList[1].mouseChildren = true;
                                        data.showResult(true);
                                    }, true);
                                }, true);
                            }
                        });
                    }
                }]);
            });
        });
    }

    private function magicHandle():void {
        ActorManager.getActor().walkToLocation(537, 543);
        MovieClipUtil.playMc(this._npcList[0], MAGIC_STATE[1], MAGIC_STATE[2], function ():void {
            _npcList[0].gotoAndStop(1);
            if (ActorManager.actorInfo.activityData[15] != 0) {
                NpcDialog.show(843, "小法师", [[0, "吃大蒜不吐橘子皮! 不吃大蒜倒吐梨皮！魔法结束拿走大蒜糖，再来找我变。"]], ["鬼知道了 "]);
            } else {
                DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                    var info:DayLimitListInfo = param1;
                    if (info.getCount(DAY_LIST[0]) >= 10) {
                        ActorManager.getActor().isShow = true;
                        ActorManager.getActor().update();
                        NpcDialog.show(843, "小法师", [[0, "吃大蒜不吐柚子皮! 不吃大蒜倒吐黄瓜皮！今天不能再变了，再变你就永远变不回来！"]], ["那我明天再来 "]);
                    } else {
                        NpcDialog.show(843, "小法师", [[0, "吃大蒜不吐葡萄皮! 不吃大蒜倒吐西瓜皮！（好奇怪的咒语……），变鬼就拿<font color=\'#ff3300\'>2</font>个大蒜糖"]], ["快把我变成鬼吧！ ", "有妖怪！"], [function ():void {
                            ActorManager.getActor().isShow = false;
                            ActorManager.getActor().update();
                            _npcList[0].mouseEnabled = _npcList[0].mouseChildren = false;
                            SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
                                var data:IDataInput = param1;
                                new SwapInfo(data);
                                MovieClipUtil.playMc(_npcList[0], MAGIC_STATE[3], MAGIC_STATE[4], function ():void {
                                    _npcList[0].mouseEnabled = _npcList[0].mouseChildren = true;
                                    _npcList[0].gotoAndStop(1);
                                    ActorManager.getActor().isShow = true;
                                    ActorManager.getActor().update();
                                }, true);
                            }, function (param1:uint):void {
                                _npcList[0].mouseEnabled = _npcList[0].mouseChildren = true;
                                ActorManager.getActor().isShow = true;
                                ActorManager.getActor().update();
                            });
                        }]);
                    }
                });
            }
        }, true);
    }

    override public function dispose():void {
        var _loc1_:MovieClip = null;
        SeatTipsManager.removeSeat(new Point(810, 110), 80382);
        SeatTipsManager.removeSeat(new Point(310, 415), 80382);
        if (this._npcList) {
            for each(_loc1_ in this._npcList) {
                _loc1_.removeEventListener(MouseEvent.CLICK, this.onNpc);
            }
            this._npcList = null;
        }
        ActorManager.getActor().isShow = true;
        ActorManager.getActor().update();
        super.dispose();
    }
}
}
