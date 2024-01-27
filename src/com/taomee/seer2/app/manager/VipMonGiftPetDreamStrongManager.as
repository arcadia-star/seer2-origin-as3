package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.config.TimeLimitConfig;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

import org.taomee.utils.BitUtil;

public class VipMonGiftPetDreamStrongManager {

    private static var _npc:Mobile;

    private static var NPC_ID:int = 899;

    private static var SWAP_PAI_ID:int = 4010;

    private static var SWAP_MARK_ID:int = 4011;

    private static var DAY_LIST:Array = [1709];

    private static var FOR_LIST:Array = [205807, 205812];

    private static var isDay:int;

    private static var isSee:int;


    public function VipMonGiftPetDreamStrongManager() {
        super();
    }

    public static function init():void {
        if (TimeLimitConfig.InLimitTime(259) == false) {
            return;
        }
        updateDate();
    }

    private static function updateDate(param1:Boolean = true):void {
        var flag:Boolean = param1;
        DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
            var info:DayLimitListInfo = param1;
            isDay = info.getCount(DAY_LIST[0]);
            ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                isSee = param1.infoVec[0];
                if (BitUtil.getBit(param1.infoVec[1], 0)) {
                    return;
                }
                if (flag) {
                    createNpc();
                }
            });
        });
    }

    private static function createNpc():void {
        var _loc1_:MouseClickHintSprite = null;
        if (!_npc) {
            _npc = new Mobile();
            _npc.setPostion(new Point(460, 490));
            _npc.resourceUrl = URLUtil.getNpcSwf(NPC_ID);
            _npc.buttonMode = true;
            MobileManager.addMobile(_npc, MobileType.NPC);
            _loc1_ = new MouseClickHintSprite();
            _npc.addChild(_loc1_);
            _loc1_.y = -130;
            _npc.addEventListener(MouseEvent.CLICK, initStep2);
        }
    }

    private static function initStep2(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if (isSee == 0) {
            NpcDialog.show(NPC_ID, "发财萌", [[0, "让我去找暗的印记可以，但需要5000赛尔豆劳务费哦，你有" + ActorManager.actorInfo.coins + "个赛尔豆呢"]], ["给你", "你这个财迷"], [function ():void {
                SwapManager.swapItem(SWAP_PAI_ID, 1, function (param1:IDataInput):void {
                    var data:IDataInput = param1;
                    new SwapInfo(data);
                    ServerMessager.addMessage("花去了5000赛尔豆");
                    NpcDialog.show(NPC_ID, "发财萌", [[0, "你要的东西可不是轻松就能搞定的，我要花点时间的，你明天还来我这里取吧！"]], ["好的", "你这个财迷"], [function ():void {
                        updateDate(false);
                    }]);
                });
            }]);
        } else if (isSee == 1) {
            if (isDay == 1) {
                NpcDialog.show(NPC_ID, "发财萌", [[1, "（你太着急啦！明天才能拿呀）"]], ["哦……我就是想点点"], [function ():void {
                }]);
            } else if (isDay == 0) {
                NpcDialog.show(NPC_ID, "发财萌", [[0, "你要的东西拿走吧！我差点回不来了，这东西太危险了啦。"]], ["谢谢啦谢谢啦 "], [function ():void {
                    SwapManager.swapItem(SWAP_MARK_ID, 1, function (param1:IDataInput):void {
                        new SwapInfo(param1);
                        ServerMessager.addMessage("成功获得暗之印记，可以去解锁技能了！");
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        ModuleManager.showAppModule("VipMonGiftPetDreamStrongPanel");
                    }, null, new SpecialInfo(2, 0, 0));
                }]);
            }
        }
    }

    public static function dispose():void {
        if (_npc) {
            MobileManager.removeMobile(_npc, MobileType.NPC);
            _npc = null;
        }
    }
}
}
