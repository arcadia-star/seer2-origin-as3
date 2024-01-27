package com.taomee.seer2.app.actives {
import com.greensock.TweenMax;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.system.ApplicationDomain;

import org.taomee.utils.Tick;

public class RescueLunaAct {

    private static var _instance:RescueLunaAct;


    private const bloodList:Array = [3, 5, 10];

    private const npcIDs:Array = [509, 563, 565];

    private const needTime:int = 180;

    private const dayLimitSwap:int = 1233;

    private const dayLimitID:int = 670;

    private var npcList:Vector.<Mobile>;

    private var currentNpc:Mobile;

    private var panGuanMobile:Mobile;

    private var currentBlood:int;

    private var currentIndex:int;

    private var playerBlood:int = 20;

    private var shootEft:MovieClip;

    private var timeMc:MovieClip;

    private var _map:MapModel;

    private var bloodBarMc:Vector.<MovieClip>;

    private var overTime:int = 0;

    private var leftTime:int;

    private var waveNum:int = 0;

    private var defaultWidth:int = 86;

    private var currentWidth:int;

    private var subWidth:int;

    private var playerWidth:int;

    private var subPlayerWidth:int;

    private var playerBloodMc:MovieClip;

    private var app:ApplicationDomain;

    private var shootTips:MovieClip;

    private var positions:Array;

    private var bloodPositions:Array;

    private var hasSet:Boolean;

    private var isFighting:Boolean;

    public function RescueLunaAct() {
        this.positions = [new Point(255, 265), new Point(515, 405), new Point(670, 185)];
        this.bloodPositions = [new Point(0, 0), new Point(0, -200), new Point(0, -120)];
        super();
    }

    public static function getInstance():RescueLunaAct {
        if (!_instance) {
            _instance = new RescueLunaAct();
        }
        return _instance;
    }

    public function setup():void {
        this._map = SceneManager.active.mapModel;
        this.app = this._map.front.loaderInfo.applicationDomain;
        DayLimitManager.getDoCount(this.dayLimitID, this.getShootState);
    }

    private function getShootState(param1:int):void {
        if (param1 == 0) {
            this.initMobile();
            this.playerWidth = this.playerBloodMc.width;
            this.subPlayerWidth = this.playerWidth / 20;
            this.startShoot();
            this.resetData();
        } else {
            this.cretatePan(true);
        }
    }

    public function dispose():void {
        ShootController.removeEventListener(ShootEvent.PLAY_END, this.chekTarget);
        this.waveNum = 0;
        Tick.instance.removeRender(this.updateTime);
        if (this.panGuanMobile) {
            this.panGuanMobile.removeEventListener(MouseEvent.CLICK, this.showNpcDia);
        }
        if (this.playerBloodMc) {
            DisplayObjectUtil.removeFromParent(this.playerBloodMc);
            this.playerBloodMc = null;
            this.npcList = null;
            this.bloodBarMc = null;
            this.shootEft = null;
        }
    }

    private function initMobile():void {
        var _loc2_:Mobile = null;
        this.playerBloodMc = this._map.libManager.getMovieClip("BloodBarMc");
        this.playerBloodMc.x = -this.playerBloodMc.width / 2;
        this.playerBloodMc.y = -ActorManager.getActor().animation["height"];
        DisplayObjectContainer(ActorManager.getActor().animation).addChild(this.playerBloodMc);
        this.npcList = new Vector.<Mobile>();
        this.bloodBarMc = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            _loc2_ = new Mobile();
            _loc2_.resourceUrl = URLUtil.getNpcSwf(this.npcIDs[_loc1_]);
            _loc2_.x = this.positions[_loc1_].x;
            _loc2_.y = this.positions[_loc1_].y;
            _loc2_.visible = false;
            this.npcList.push(_loc2_);
            MobileManager.addMobile(_loc2_, MobileType.NPC);
            this.bloodBarMc.push(this._map.libManager.getMovieClip("BloodBarMc"));
            this.bloodBarMc[_loc1_].x = this.bloodPositions[_loc1_].x - this.bloodBarMc[_loc1_].width / 2;
            this.bloodBarMc[_loc1_].y = this.bloodPositions[_loc1_].y;
            _loc2_.addChild(this.bloodBarMc[_loc1_]);
            _loc1_++;
        }
    }

    private function startShoot():void {
        if (!this.shootTips) {
            this.shootTips = this._map.libManager.getMovieClip("ShootTips");
        }
        this._map.front.addChild(this.shootTips);
        MovieClipUtil.playMc(this.shootTips, 1, this.shootTips.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(shootTips);
            if (!timeMc) {
                timeMc = _map.libManager.getMovieClip("TimeMc");
            }
            timeMc.x = 390;
            timeMc.y = 100;
            _map.front.addChild(timeMc);
            ShootController.addEventListener(ShootEvent.PLAY_END, chekTarget);
            Tick.instance.addRender(updateTime, 1000);
        });
    }

    private function cretatePan(param1:Boolean = false):void {
        var showPanel:Boolean = param1;
        ShootController.removeEventListener(ShootEvent.PLAY_END, this.chekTarget);
        if (!this.panGuanMobile) {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("ShowPanFull"), function ():void {
                panGuanMobile = new Mobile();
                setPan();
                if (showPanel) {
                    ModuleManager.toggleModule(URLUtil.getAppModule("RescueLunaMinePanel"));
                }
            }, false, false, 1, false);
            return;
        }
        this.setPan();
    }

    private function setPan():void {
        if (ShootController.isAim) {
            ShootController.close();
        }
        if (this.playerBloodMc) {
            DisplayObjectUtil.removeFromParent(this.playerBloodMc);
        }
        this.panGuanMobile.resourceUrl = URLUtil.getNpcSwf(130);
        this.panGuanMobile.mouseChildren = false;
        this.panGuanMobile.buttonMode = true;
        this.panGuanMobile.x = 682;
        this.panGuanMobile.rotationY = 180;
        this.panGuanMobile.y = 330;
        this.panGuanMobile.height = 110;
        this.panGuanMobile.removeOverHeadMark();
        this.panGuanMobile.addOverHeadMark(new AcceptableMark());
        this.panGuanMobile.addEventListener(MouseEvent.CLICK, this.showNpcDia);
        MobileManager.addMobile(this.panGuanMobile, MobileType.NPC);
    }

    private function showNpcDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(130, "审判官", [[0, "嗯~~想救月神是吧？可以啊！来抽个签吧！抽到上上签就让你带走月神！"]], ["开始抽签", "今天运气不好"], [function ():void {
            ModuleManager.toggleModule(URLUtil.getAppModule("RescueLunaMinePanel"));
        }]);
    }

    private function updateTime(param1:int):void {
        if (this.playerBloodMc.y != -ActorManager.getActor().animation["height"] && !this.hasSet) {
            this.playerBloodMc.y = -ActorManager.getActor().animation["height"];
            this.hasSet = true;
        }
        ++this.overTime;
        this.leftTime = this.needTime - this.overTime;
        var _loc2_:int = Math.floor(this.leftTime / 60);
        var _loc3_:int = this.leftTime % 60;
        if (!this.timeMc) {
            this.timeMc = this._map.libManager.getMovieClip("TimeMc");
        }
        this.timeMc.time.text = _loc2_ + "分" + _loc3_ + "秒";
        if (_loc2_ == 0 && _loc3_ == 0) {
            Tick.instance.removeRender(this.updateTime);
            this.showFail();
        }
    }

    private function showFail():void {
        AlertManager.showConfirm("失败了！别灰心，你要重新开始再试一次吗?", function ():void {
            waveNum = 0;
            resetData(true);
        }, function ():void {
            SceneManager.changeScene(SceneType.LOBBY, 70);
        });
    }

    private function resetData(param1:Boolean = false):void {
        this.currentIndex = 0;
        this.currentBlood = 3;
        if (param1) {
            this.playerBlood = 20;
            this.overTime = 0;
            Tick.instance.removeRender(this.updateTime);
            Tick.instance.addRender(this.updateTime, 1000);
            this.playerBloodMc.bar.width = this.playerWidth;
        }
        this.currentWidth = this.defaultWidth;
        this.subWidth = this.defaultWidth / this.bloodList[this.currentIndex];
        this.resetNpc();
    }

    private function chekTarget(param1:ShootEvent):void {
        var _loc2_:ShootInfo = param1.info;
        if (_loc2_.userID == ActorManager.actorInfo.id && Boolean(this.currentNpc.hitTestPoint(_loc2_.endPos.x, _loc2_.endPos.y))) {
            --this.currentBlood;
            if (this.currentBlood == 0) {
                this.deadMobile();
                return;
            }
            this.currentWidth -= this.subWidth;
            this.bloodBarMc[this.currentIndex].bar.width = this.currentWidth;
            this.checkFight();
            ShootController.start(ShootController.id, true);
            ShootController.isAllow = true;
        }
    }

    private function checkFight():void {
        var _loc1_:Boolean = Math.random() * 100 < 30 ? true : false;
        if (_loc1_ && !this.isFighting) {
            this.isFighting = true;
            --this.playerBlood;
            this.playerBlood = this.playerBlood < 0 ? 0 : this.playerBlood;
            if (!this.shootEft) {
                this.shootEft = this._map.libManager.getMovieClip("ShootEft");
            }
            this.shootEft.gotoAndStop(1);
            this.shootEft.x = this.currentNpc.x;
            this.shootEft.y = this.currentNpc.y;
            this._map.front.addChild(this.shootEft);
            TweenMax.to(this.shootEft, 0.5, {
                "x": ActorManager.getActor().x,
                "y": ActorManager.getActor().y,
                "onComplete": this.complete
            });
        }
    }

    private function deadMobile():void {
        var _loc1_:int = 0;
        ++this.currentIndex;
        if (this.currentIndex > 2) {
            ++this.waveNum;
            this.currentIndex = 0;
        }
        this.currentNpc.visible = false;
        this.currentNpc = this.npcList[this.currentIndex];
        this.currentNpc.visible = true;
        this.subWidth = this.defaultWidth / this.bloodList[this.currentIndex];
        this.currentWidth = this.defaultWidth;
        this.currentBlood = this.bloodList[this.currentIndex];
        if (this.waveNum <= 2 && this.currentIndex == 0) {
            this.resetData();
        } else if (this.waveNum > 2) {
            Tick.instance.removeRender(this.updateTime);
            SwapManager.swapItem(this.dayLimitSwap);
            DisplayObjectUtil.removeFromParent(this.timeMc);
            _loc1_ = 0;
            while (_loc1_ < 3) {
                MobileManager.removeMobile(this.npcList[_loc1_], MobileType.NPC);
                _loc1_++;
            }
            this.cretatePan();
        }
    }

    private function resetNpc():void {
        this.bloodBarMc[0].bar.width = this.defaultWidth;
        this.bloodBarMc[1].bar.width = this.defaultWidth;
        this.bloodBarMc[2].bar.width = this.defaultWidth;
        this.npcList[0].resourceUrl = URLUtil.getNpcSwf(this.npcIDs[0]);
        this.npcList[1].resourceUrl = URLUtil.getNpcSwf(this.npcIDs[1]);
        this.npcList[2].resourceUrl = URLUtil.getNpcSwf(this.npcIDs[2]);
        MobileManager.addMobile(this.npcList[0], MobileType.NPC);
        MobileManager.addMobile(this.npcList[1], MobileType.NPC);
        MobileManager.addMobile(this.npcList[2], MobileType.NPC);
        this.currentNpc = this.npcList[this.currentIndex];
        this.npcList[0].visible = false;
        this.npcList[1].visible = false;
        this.npcList[2].visible = false;
        this.currentNpc.visible = true;
    }

    private function complete():void {
        MovieClipUtil.playMc(this.shootEft, 1, this.shootEft.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(shootEft);
            shootEft.gotoAndStop(1);
            playerBloodMc.bar.width -= subPlayerWidth;
            isFighting = false;
            if (playerBlood == 0) {
                showFail();
            }
        }, true);
    }
}
}
