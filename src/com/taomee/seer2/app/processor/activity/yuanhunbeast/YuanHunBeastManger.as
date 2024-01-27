package com.taomee.seer2.app.processor.activity.yuanhunbeast {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

public class YuanHunBeastManger {

    private static var DAY_LIST:Array = [5098, 5099];

    private static var FOR_LIST:Array = [250267, 250268];

    private static var isOver:int;

    private static var _npc3011:Mobile;

    private static var fightID:int = 1598;

    private static var fightBossID:int = 1599;

    private static var npcPetID:Array = [3012, 3013, 3014, 3015];

    private static var npcPetName:Array = ["超煞", "魔渊梦神", "温柏", "魔念黯灵"];

    private static var posArr:Array = [[700, 400], [810, 410], [920, 410], [1030, 410]];

    private static var npcArr:Vector.<Mobile>;

    private static var curWinCount:int;

    private static var npcBoss:Mobile;

    private static var gameCount:int;

    private static var _map:MapModel;


    public function YuanHunBeastManger() {
        super();
    }

    public static function init(param1:MapModel):void {
        var map:MapModel = param1;
        _map = map;
        ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            if (par.infoVec[0] > 0 && par.infoVec[1] <= 0) {
                isOver = par.infoVec[1];
                _npc3011 = MobileManager.getMobile(3011, MobileType.NPC);
                _npc3011.visible = false;
                DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                    var i:int = 0;
                    var j:int = 0;
                    var info:DayLimitListInfo = param1;
                    curWinCount = info.getCount(DAY_LIST[0]);
                    npcBoss = createNpc(3011, "原魂兽", new Point(580, 460), 1);
                    npcBoss.addEventListener(MouseEvent.CLICK, onFightBoss);
                    if (curWinCount < 4) {
                        npcArr = new Vector.<Mobile>();
                        i = 0;
                        while (i < 4) {
                            if (i >= curWinCount) {
                                npcArr.push(createNpc(npcPetID[i], npcPetName[i], new Point(posArr[i][0], posArr[i][1]), 0.4));
                            }
                            i++;
                        }
                        j = 0;
                        while (j < npcArr.length) {
                            npcArr[j].addEventListener(MouseEvent.CLICK, onFight);
                            j++;
                        }
                    } else {
                        gameCount = ActsHelperUtil.getCanNum(info.getCount(DAY_LIST[1]), 0, 3);
                        ServerBufferManager.getServerBuffer(ServerBufferType.YUANHUNSHOU_SCENE_FIRST, function (param1:ServerBuffer):void {
                            var _loc2_:Boolean = Boolean(param1.readDataAtPostion(1));
                            if (!_loc2_) {
                                ServerBufferManager.updateServerBuffer(ServerBufferType.YUANHUNSHOU_SCENE_FIRST, 1, 1);
                                QueueLoader.load(URLUtil.getActivityAnimation("yuanhunshouAct"), LoadType.SWF, onResLoaded);
                            }
                        });
                    }
                });
            }
        });
    }

    private static function onResLoaded(param1:ContentInfo):void {
        var wordMc:MovieClip = null;
        var info:ContentInfo = param1;
        var MainMc:Sprite = info.content as Sprite;
        wordMc = MainMc["movieMc"];
        wordMc.x += 580;
        wordMc.y += 328;
        wordMc.gotoAndStop(1);
        _map.front.addChild(wordMc);
        MovieClipUtil.playMc(wordMc, 2, wordMc.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(wordMc);
        });
    }

    private static function onFightBoss(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if (curWinCount < 4) {
            NpcDialog.show(3011, "原魂兽", [[0, "我的身体……现在不受控制……帮帮我吧！"]], ["（战胜其它精灵）"], [function ():void {
            }]);
            return;
        }
        if (gameCount <= 0) {
            AlertManager.showAlert("今天3次挑战机会已用完，明天再来试试吧。");
        } else {
            NpcDialog.show(3011, "原魂兽", [[0, "我的意志被黑暗所侵蚀，挑战我吧！每天可以挑战3次哦。"]], ["挑战原魂兽", "准备一下"], [function ():void {
                FightManager.startFightWithWild(fightBossID);
            }]);
        }
    }

    private static function onFight(param1:MouseEvent):void {
        var _loc2_:int = npcArr.indexOf(param1.currentTarget as Mobile);
        var _loc3_:int = 4 - npcArr.length;
        if (_loc3_ + _loc2_ == curWinCount) {
            FightManager.startFightWithWild(fightID);
        } else {
            AlertManager.showAlert("请去挑战【" + npcPetName[curWinCount] + "】");
        }
    }

    private static function createNpc(param1:int, param2:String, param3:Point, param4:Number):Mobile {
        var _loc5_:Mobile;
        (_loc5_ = new Mobile()).setPostion(new Point(param3.x, param3.y));
        _loc5_.scaleX = _loc5_.scaleY = param4;
        _loc5_.resourceUrl = URLUtil.getNpcSwf(param1);
        _loc5_.buttonMode = true;
        MobileManager.addMobile(_loc5_, MobileType.NPC);
        return _loc5_;
    }

    public static function dispose():void {
        var _loc1_:int = 0;
        if (npcArr != null) {
            _loc1_ = 0;
            while (_loc1_ < npcArr.length) {
                MobileManager.removeMobile(npcArr[_loc1_], MobileType.NPC);
                _loc1_++;
            }
        }
        if (npcBoss) {
            MobileManager.removeMobile(npcBoss, MobileType.NPC);
            npcBoss = null;
        }
    }
}
}
