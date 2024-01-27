package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.config.TimeLimitConfig;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.npc.ActMobile;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.serverBuffer.positonValue.ServerBufferPosition_57;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.Tick;

public class MakeSnowmanAct {

    private static var _instance:MakeSnowmanAct;


    private var shovelMobile:ActMobile;

    private var snowmanMobile:ActMobile;

    private var snowpetMobile:ActMobile;

    private var fightId:uint = 246;

    private var startTime:uint;

    private var passTime:uint;

    private var mouseHit:MouseClickHintSprite;

    private var cap:MovieClip;

    private var mark:AcceptableMark;

    public function MakeSnowmanAct() {
        super();
    }

    public static function getInstance():MakeSnowmanAct {
        if (!_instance) {
            _instance = new MakeSnowmanAct();
        }
        return _instance;
    }

    public function setup():void {
        this.createNpc();
        if (SceneManager.prevSceneType == SceneType.ARENA && !FightManager.isWinWar() && FightManager.currentFightRecord.initData.positionIndex == this.fightId) {
            NpcDialog.show(533, "雪精灵", [[0, "别放弃啊，继续！过会儿我就要走了，阳光会让我融化掉，抓紧时间哦。 "]], [" 啊？那么继续！", "我……我……不知道该说什么了……"], [function ():void {
                if (TimeLimitConfig.InLimitTime(169)) {
                    FightManager.startFightWithWild(fightId);
                } else {
                    AlertManager.showAlert("当前的 雪精灵回来了 活动已结束！");
                }
            }]);
        }
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onReplayClick);
        this.cap = SceneManager.active.mapModel.content["cap"];
        this.cap.gotoAndStop(int(this.cap.totalFrames * Math.random()) + 1);
        DayLimitManager.getDoCount(569, this.getSwapCount);
    }

    private function onReplayClick(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "showClickMouse") {
            if (!this.mouseHit) {
                this.mouseHit = new MouseClickHintSprite();
            }
            this.mouseHit.x = 790;
            this.mouseHit.y = 130;
            SceneManager.active.mapModel.content["house"].addEventListener(MouseEvent.CLICK, this.hideTips);
            SceneManager.active.mapModel.front.addChild(this.mouseHit);
        }
    }

    private function hideTips(param1:MouseEvent):void {
        SceneManager.active.mapModel.content["house"].removeEventListener(MouseEvent.CLICK, this.hideTips);
        DisplayObjectUtil.removeFromParent(this.mouseHit);
    }

    private function getSwapCount(param1:int):void {
        if (param1 == 0 && Boolean(this.cap)) {
            this.cap.buttonMode = true;
            this.cap.addEventListener(MouseEvent.CLICK, this.swapHandler);
        } else if (this.cap) {
            DisplayObjectUtil.removeFromParent(this.cap);
        }
    }

    private function swapHandler(param1:MouseEvent):void {
        SwapManager.swapItem(856);
        DisplayObjectUtil.removeFromParent(this.cap);
    }

    public function dispose():void {
        if (this.shovelMobile) {
            TooltipManager.remove(this.shovelMobile);
            this.shovelMobile.removeEventListener(MouseEvent.CLICK, this.clickShovel);
            this.shovelMobile.clear();
        }
        if (this.snowpetMobile) {
            this.snowpetMobile.removeEventListener(MouseEvent.CLICK, this.toDia);
            this.snowpetMobile.clear();
        }
        if (this.snowmanMobile) {
            this.snowmanMobile.clear();
        }
        if (this.snowmanMobile) {
            this.snowmanMobile.clear();
        }
        Tick.instance.removeRender(this.changTime);
    }

    private function createNpc():void {
        if (!this.shovelMobile) {
            this.shovelMobile = new ActMobile();
        }
        this.shovelMobile.showMobile(URLUtil.getActivityMobile("Shovel"), new Point(710, 420));
        if (!this.mark) {
            this.mark = new AcceptableMark();
            this.mark.y = -90;
        }
        this.shovelMobile.addChild(this.mark);
        this.shovelMobile.addEventListener(MouseEvent.CLICK, this.clickShovel);
        DayLimitManager.getDoCount(576, this.getCount);
    }

    private function getCount(param1:uint = 0):void {
        if (param1 >= 1) {
            if (!this.snowmanMobile) {
                this.snowmanMobile = new ActMobile();
            }
            this.snowmanMobile.showMobile(URLUtil.getActivityMobile("Snowman"), new Point(382, 331));
            DayLimitManager.getDoCount(577, this.getStartTime);
        }
    }

    private function getStartTime(param1:uint):void {
        this.startTime = param1;
        DayLimitManager.getDoCount(578, this.isGetHandler);
        Tick.instance.addRender(this.changTime, 10000);
    }

    private function changTime(param1:int):void {
        this.passTime = TimeManager.getServerTime() - this.startTime;
        if (this.passTime >= 900) {
            Tick.instance.removeRender(this.changTime);
            if (this.snowpetMobile) {
                this.snowpetMobile.clear();
            }
        }
    }

    private function isGetHandler(param1:uint = 0):void {
        this.passTime = TimeManager.getServerTime() - this.startTime;
        if (param1 >= 1 || this.passTime >= 900) {
            if (this.snowpetMobile) {
                this.snowpetMobile.clear();
            }
        } else {
            if (!this.snowpetMobile) {
                this.snowpetMobile = new ActMobile();
            }
            this.snowpetMobile.showMobile(URLUtil.getActivityMobile("SnowPet"), new Point(341, 360));
            this.snowpetMobile.addEventListener(MouseEvent.CLICK, this.toDia);
        }
    }

    private function toDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(533, "雪精灵", [[0, "哈哈~我来了~~~终于有孩子想到我了，好开心啊？你愿意陪我玩吗？ "]], [" 我愿意！", "我……我……不知道该说什么了……!"], [function ():void {
            NpcDialog.show(533, "雪精灵", [[0, "那让我们来比试一下，准备好精灵胶囊哦，你可以带我回家哦，我想天天和你在一起哈。 当然打赢我也可以获得我的小礼物~ "]], [" 嗯嗯嗯！来吧！", "先去准备下胶囊"], [function ():void {
                if (TimeLimitConfig.InLimitTime(169)) {
                    FightManager.startFightWithWild(fightId);
                } else {
                    AlertManager.showAlert("当前的 雪精灵回来了 活动已结束！");
                }
            }]);
        }]);
    }

    private function clickShovel(param1:MouseEvent):void {
        ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_57, this.getServerBuffer);
    }

    private function getServerBuffer(param1:ServerBuffer):void {
        var buffer:ServerBuffer = param1;
        var isPlay:Boolean = Boolean(buffer.readDataAtPostion(ServerBufferPosition_57.IS_PLAY_MAKESNOWMAN));
        if (isPlay) {
            ModuleManager.addEventListener("startmake", "snowman", this.showComplete);
            ModuleManager.toggleModule(URLUtil.getAppModule("MakeSnowmanPanel"));
        } else {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("MakeSnowmanFull"), function ():void {
                ServerBufferManager.updateServerBuffer(ServerBufferType.BUFFER_SEAT_57, ServerBufferPosition_57.IS_PLAY_MAKESNOWMAN, 1);
                ModuleManager.addEventListener("startmake", "snowman", showComplete);
                ModuleManager.toggleModule(URLUtil.getAppModule("MakeSnowmanPanel"));
            });
        }
    }

    private function showComplete(param1:ModuleEvent):void {
        var event:ModuleEvent = param1;
        ModuleManager.removeEventListener("startmake", "snowman", this.showComplete);
        ActorManager.getActor().blockNoNo = true;
        ActorManager.getActor().blockFollowingPet = true;
        ActorManager.getActor().hide();
        MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("makeSnowMan"), function ():void {
            ActorManager.getActor().blockNoNo = false;
            ActorManager.getActor().blockFollowingPet = false;
            ActorManager.getActor().show();
            if (!snowmanMobile) {
                snowmanMobile = new ActMobile();
            }
            snowmanMobile.showMobile(URLUtil.getActivityMobile("Snowman"), new Point(382, 331));
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("snowPetShow"), function ():void {
                if (!snowpetMobile) {
                    snowpetMobile = new ActMobile();
                }
                snowpetMobile.showMobile(URLUtil.getActivityMobile("SnowPet"), new Point(341, 360));
                snowpetMobile.addEventListener(MouseEvent.CLICK, toDia);
            }, false, false, 1, false);
        }, false, false, 1, false);
    }
}
}
