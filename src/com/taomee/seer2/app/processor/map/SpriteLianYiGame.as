package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.BuyPropInfo;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.parser.Parser_1224;
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
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;

import org.taomee.utils.DomainUtil;

public class SpriteLianYiGame {

    private static const CURRENT_LAYER:uint = 203362;

    private static const FIGHT_INDEX:uint = 684;

    private static const NPC_ID:uint = 641;

    private static const EMBED_ID:uint = 203220;

    private static const PAPER_ID:uint = 200370;


    private var _map:MapModel;

    private var _npc:Mobile;

    private var _buyPanelBtn:SimpleButton;

    private var _progressPanelBtn:SimpleButton;

    private var _buyEmbedBtn:SimpleButton;

    private var _buyPaperBtn:SimpleButton;

    private var _resLibs:ApplicationDomain;

    private var mc:MovieClip;

    private var info:BuyPropInfo;

    public function SpriteLianYiGame(param1:MapModel) {
        super();
        this._map = param1;
        this.initMap();
        this.checkFromFight();
    }

    private function initMap():void {
        this._npc = MobileManager.getMobile(NPC_ID, MobileType.NPC);
        this._buyEmbedBtn = this._map.content["buyEmbedBtn"];
        this._buyPanelBtn = this._map.content["buyPanelBtn"];
        this._buyPaperBtn = this._map.content["buyPaperBtn"];
        this._progressPanelBtn = this._map.content["progressPanelBtn"];
    }

    private function checkFromFight():void {
        var a:Boolean = SceneManager.prevSceneType == SceneType.ARENA;
        var b:Boolean = FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX;
        var c:Boolean = FightManager.fightWinnerSide == FightSide.LEFT;
        if (a && b) {
            if (c) {
                if (this._npc) {
                    this._npc.visible = false;
                }
                QueueLoader.load(URLUtil.getActivityAnimation("SpriteLianYiMc"), LoadType.SWF, function (param1:ContentInfo):void {
                    var info:ContentInfo = param1;
                    _resLibs = info.domain;
                    mc = DomainUtil.getDisplayObject("movie", _resLibs) as MovieClip;
                    mc.stop();
                    _map.front.addChild(mc);
                    MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                        DisplayObjectUtil.removeFromParent(mc);
                        if (_npc) {
                            _npc.visible = true;
                        }
                        mc.stop();
                        mc = null;
                        show();
                    });
                });
            } else {
                MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("LoseMovie"), function ():void {
                    show();
                    NpcDialog.show(NPC_ID, "涟漪", [[0, "你的修为还不够！尝试换个打法，另外使用辅助道具提高战斗力也是一个很重的方法！"]], ["继续挑战", " 准备一下", "购买战斗辅助"], [function ():void {
                        FightManager.startFightWithWild(FIGHT_INDEX);
                        StatisticsManager.sendNovice("0x1003422E");
                    }, null, function ():void {
                        onPanel();
                    }]);
                });
            }
        }
        if (!a) {
            this.checkPlayMovie();
        }
    }

    private function checkPlayMovie():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.SPRITE_LIAN_YI, function (param1:ServerBuffer):void {
            var buffer:ServerBuffer = param1;
            var value:int = buffer.readDataAtPostion(0);
            if (value == 0) {
                MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("EnterMovie"), function ():void {
                    ServerBufferManager.updateServerBuffer(ServerBufferType.SPRITE_LIAN_YI, 0, 1);
                    show();
                });
            } else {
                show();
            }
        });
    }

    private function show():void {
        this.addEvent();
    }

    private function addEvent():void {
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc);
        this._buyEmbedBtn.addEventListener(MouseEvent.CLICK, this.onEmbed);
        this._buyPanelBtn.addEventListener(MouseEvent.CLICK, this.onPanel);
        this._buyPaperBtn.addEventListener(MouseEvent.CLICK, this.onPaper);
        this._progressPanelBtn.addEventListener(MouseEvent.CLICK, this.onProgress);
    }

    private function removeEvent():void {
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc);
        this._buyEmbedBtn.removeEventListener(MouseEvent.CLICK, this.onEmbed);
        this._buyPanelBtn.removeEventListener(MouseEvent.CLICK, this.onPanel);
        this._buyPaperBtn.removeEventListener(MouseEvent.CLICK, this.onPaper);
        this._progressPanelBtn.removeEventListener(MouseEvent.CLICK, this.onProgress);
    }

    private function onNpc(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(NPC_ID, "涟漪", [[0, "忍者龙剑坛之水忍涟漪在此！敢不敢来较量一下！"]], [" 开始挑战", " 准备一下"], [function ():void {
            FightManager.startFightWithWild(FIGHT_INDEX);
            StatisticsManager.sendNovice("0x1003422E");
        }]);
    }

    private function onPanel(param1:MouseEvent = null):void {
        ModuleManager.showModule(URLUtil.getAppModule("BuyItemPanel"), "");
    }

    private function onEmbed(param1:MouseEvent):void {
        this.info = new BuyPropInfo();
        this.info.itemId = EMBED_ID;
        this.info.buyComplete = this.complete;
        ShopManager.buyBagItem(this.info);
    }

    private function onPaper(param1:MouseEvent):void {
        this.info = new BuyPropInfo();
        this.info.itemId = PAPER_ID;
        this.info.buyComplete = this.complete;
        ShopManager.buyBagItem(this.info);
    }

    private function onProgress(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("ProgressPanel"), "");
    }

    public function dispose():void {
        this.removeEvent();
        this._resLibs = null;
        if (this.mc) {
            DisplayObjectUtil.removeFromParent(this.mc);
            this.mc = null;
        }
    }

    private function complete(param1:Parser_1224):void {
    }
}
}
