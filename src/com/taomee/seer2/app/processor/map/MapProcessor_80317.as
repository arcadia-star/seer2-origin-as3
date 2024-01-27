package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.scene.LobbyPanel;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.system.ApplicationDomain;

import org.taomee.filter.ColorFilter;
import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class MapProcessor_80317 extends MapProcessor {


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    private var godLight:Mobile;

    private var _uiPanel:MovieClip;

    private var fireDream:MovieClip;

    private var oneKeyPass:SimpleButton;

    private var exitBtn:SimpleButton;

    private var passList:Vector.<MovieClip>;

    private var mc:MovieClip;

    private var _npc:Mobile;

    private var _mouseHint:MouseClickHintSprite;

    private var fightID:Array;

    private var foreverLimit:Array;

    private var dayLimit:int = 1359;

    private var fightSixID:Array;

    private var passBossNums:int;

    private var dreamValues:int;

    private var BuyBit:int;

    private var fightCount:int;

    private var buyCount:int;

    private var _resLib:ApplicationDomain;

    private var hasEvent:Boolean;

    public function MapProcessor_80317(param1:MapModel) {
        this.fightID = [1272];
        this.foreverLimit = [204820, 204821, 204822, 204823];
        this.fightSixID = [1239, 1240, 1241, 1242, 1243, 1244];
        super(param1);
    }

    public static function getCanNum(param1:int, param2:int, param3:int):int {
        var _loc4_:int = 0;
        if (param1 > param3) {
            _loc4_ = param2;
        } else {
            _loc4_ = param3 - param1 + param2;
        }
        return _loc4_;
    }

    override public function init():void {
        LobbyPanel.instance.hide();
        this.getURL();
    }

    private function getURL():void {
        QueueLoader.load(URLUtil.getActivityAnimation("huanlingshouAct/huanlingshouAct"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            initMc();
        });
    }

    private function getMovie(param1:String):DisplayObject {
        if (this._resLib) {
            return DomainUtil.getDisplayObject(param1, this._resLib);
        }
        return null;
    }

    override public function dispose():void {
        this.removeEvent();
    }

    private function initMc():void {
        var i:int;
        this._uiPanel = _map.front["uiPanel"];
        this._uiPanel.visible = false;
        this.fireDream = this._uiPanel["fireDreamBtn"];
        this.fireDream.buttonMode = true;
        this.mc = this._uiPanel["mc"];
        this.oneKeyPass = this._uiPanel["oneKeyPass"];
        this.passList = new Vector.<MovieClip>();
        i = 0;
        while (i < 6) {
            this.passList.push(this._uiPanel["passMcList" + i]);
            this.passList[i].visible = false;
            i++;
        }
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            this.onCompleteSwitch();
        } else {
            ServerBufferManager.getServerBuffer(ServerBufferType.HuanLingShouSuperStrengthen_FIRST_PLAY, function (param1:ServerBuffer):void {
                var server:ServerBuffer = param1;
                var _isPlay:Boolean = Boolean(server.readDataAtPostion(1));
                if (!_isPlay) {
                    ServerBufferManager.updateServerBuffer(ServerBufferType.HuanLingShouSuperStrengthen_FIRST_PLAY, 1, 1);
                    _mc1 = getMovie("Mc1") as MovieClip;
                    _map.front.addChild(_mc1);
                    _mc1.gotoAndStop(1);
                    MovieClipUtil.playMc(_mc1, 2, _mc1.totalFrames, function ():void {
                        _map.front.removeChild(_mc1);
                        createNpc();
                        checkStates();
                    }, true);
                } else {
                    checkStates();
                    TweenNano.delayedCall(1, function ():void {
                        _uiPanel.visible = true;
                        if (passBossNums == 6) {
                            mc.gotoAndPlay(2);
                        }
                    });
                }
            });
        }
    }

    private function checkStates():void {
        ActiveCountManager.requestActiveCountList(this.foreverLimit, this.onActiveCount);
    }

    private function onActiveCount(param1:Parser_1142):void {
        var par:Parser_1142 = param1;
        this.passBossNums = par.infoVec[0];
        this.dreamValues = par.infoVec[1];
        this.BuyBit = par.infoVec[2];
        this.buyCount = par.infoVec[3];
        DayLimitManager.getDoCount(this.dayLimit, function (param1:int):void {
            if (ActorManager.actorInfo.vipInfo.isVip()) {
                fightCount = getCanNum(param1, buyCount, 2);
            } else {
                fightCount = getCanNum(param1, buyCount, 1);
            }
            updateShow();
            addEvent();
        });
    }

    private function updateShow():void {
        var _loc1_:int = 0;
        while (_loc1_ < this.passBossNums) {
            this.passList[_loc1_].visible = true;
            _loc1_++;
        }
        if (this.passBossNums == 6) {
            this.fireDream.gotoAndStop(2);
            this.oneKeyPass.visible = false;
        }
    }

    private function addEvent():void {
        if (this.hasEvent == true) {
            return;
        }
        this.hasEvent = true;
        this.oneKeyPass.addEventListener(MouseEvent.CLICK, this.onOneKeyFire);
        this.fireDream.addEventListener(MouseEvent.CLICK, this.onFireDream);
    }

    private function onOneKeyFire(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        ShopManager.buyItemForId(604245, function (param1:*):void {
            var p:* = param1;
            checkStates();
            TweenNano.delayedCall(1, function ():void {
                _uiPanel.visible = true;
                if (passBossNums == 6) {
                    fireDream.gotoAndStop(2);
                    mc.gotoAndPlay(2);
                }
            });
        });
    }

    private function removeEvent():void {
        this.hasEvent = false;
        this.oneKeyPass.removeEventListener(MouseEvent.CLICK, this.onOneKeyFire);
        this.fireDream.removeEventListener(MouseEvent.CLICK, this.onFireDream);
    }

    private function onFireDream(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if ((e.target as MovieClip).currentFrame == 1) {
            ModuleManager.showAppModule("HuanLingShouSuperStrengthenTipsPanel");
        } else if ((e.target as MovieClip).currentFrame == 2) {
            this.firstPlayFullScreen(function ():void {
                SceneManager.changeScene(SceneType.COPY, 80318);
            });
        }
    }

    private function firstPlayFullScreen(param1:Function = null):void {
        var callBack:Function = param1;
        ServerBufferManager.getServerBuffer(ServerBufferType.HuanLingShouSuperStrengthen_FIRST, function (param1:ServerBuffer):void {
            var _loc2_:Boolean = Boolean(param1.readDataAtPostion(1));
            if (!_loc2_) {
                ServerBufferManager.updateServerBuffer(ServerBufferType.HuanLingShouSuperStrengthen_FIRST, 1, 1);
                MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("HuanLingShouSuperStrengthenFull"), callBack, true, true, 2, true);
            } else if (callBack != null) {
                callBack();
            }
        });
    }

    private function dialogShow1(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        this.removeMouseHint();
        NpcDialog.show(769, "梦魇", [[0, "你敢点我？小心我整天让你做噩梦！"]], ["我最喜欢做噩梦了~ ", "梦魇？！"], [function ():void {
            NpcDialog.show(113, "NONO", [[0, "小赛尔，别和他废话了，赶紧把这些黑雾清理掉！"]], [" NONO， 你的意思是？"], [function ():void {
                NpcDialog.show(769, "梦魇", [[0, "它的意思是和我过过招！就你这小智商还想清理掉我的魔障？哈哈哈！"]], ["别小看人！ "], [function ():void {
                    FightManager.startFightWithWild(fightID[0]);
                }]);
            }]);
        }]);
    }

    private function onCompleteSwitch():void {
        if (this.fightID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
            NpcDialog.show(113, "NONO", [[0, "赛尔，别打了，那边有个壶！"]], ["说不定可以派上用场。去瞧瞧"], [function ():void {
                createLight();
                checkStates();
            }]);
        }
        if (this.fightSixID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
            this.checkStates();
            TweenNano.delayedCall(1, function ():void {
                _uiPanel.visible = true;
                if (passBossNums == 6) {
                    fireDream.gotoAndStop(2);
                    mc.gotoAndPlay(2);
                }
            });
        }
    }

    private function showGodLight(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        MobileManager.removeMobile(this.godLight, MobileType.NPC);
        this._mc2 = this.getMovie("Mc2") as MovieClip;
        _map.front.addChild(this._mc2);
        this._mc2.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc2, 2, this._mc2.totalFrames, function ():void {
            removeMouseHint();
            _map.front.removeChild(_mc2);
            _uiPanel.visible = true;
            if (passBossNums == 6) {
                mc.gotoAndPlay(2);
            }
        }, true);
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 200;
            this._npc.setPostion(new Point(660, 420));
            this._npc.resourceUrl = URLUtil.getNpcSwf(769);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.dialogShow1);
            this.showMouseHintAtMonster(this._npc);
        }
    }

    private function createLight():void {
        if (!this.godLight) {
            this.godLight = new Mobile();
            this.godLight.setPostion(new Point(400, 300));
            this.godLight.resourceUrl = URLUtil.getNpcSwf(562);
            this.godLight.buttonMode = true;
            MobileManager.addMobile(this.godLight, MobileType.NPC);
            this.godLight.addEventListener(MouseEvent.CLICK, this.showGodLight);
            this.showMouseHintAtMonster(this.godLight);
        }
    }

    private function showMouseHintAtMonster(param1:Sprite):void {
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.y = -this._mouseHint.height - 50;
        this._mouseHint.x = (param1.width - this._mouseHint.width) / 2;
        param1.addChild(this._mouseHint);
    }

    private function removeMouseHint():void {
        if (this._mouseHint != null) {
            DisplayUtil.removeForParent(this._mouseHint);
            this._mouseHint = null;
        }
    }

    private function setBtnEnable(param1:SimpleButton, param2:Boolean):void {
        if (param2) {
            param1.filters = [];
        } else {
            ColorFilter.setGrayscale(param1);
        }
        param1.mouseEnabled = param2;
    }
}
}
