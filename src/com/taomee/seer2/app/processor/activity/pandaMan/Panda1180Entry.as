package com.taomee.seer2.app.processor.activity.pandaMan {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;

public class Panda1180Entry {

    public static var _fightPanda:Boolean = false;


    private var _threeMan:MovieClip;

    private var _rankList:MovieClip;

    private var _resLib:ResourceLibrary;

    private var _mc:MovieClip;

    public function Panda1180Entry() {
        super();
    }

    public function setup():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && _fightPanda == true) {
            _fightPanda = false;
            Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.onRandomStatus);
            Connection.send(CommandSet.RANDOM_EVENT_1140, 41, 0);
            return;
        }
        this._threeMan = SceneManager.active.mapModel.content["threeMan"];
        this._rankList = SceneManager.active.mapModel.content["rankList"];
        this.initEvent();
    }

    private function onRandomStatus(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.onRandomStatus);
        var _loc2_:IDataInput = param1.message.getRawDataCopy();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint;
        if ((_loc4_ = uint(_loc2_.readUnsignedInt())) == 1) {
            QueueLoader.load(URLUtil.getActivityAnimation("panda/pandaScreen1180"), LoadType.DOMAIN, this.onLoadComplete);
        } else {
            this._threeMan = SceneManager.active.mapModel.content["threeMan"];
            this._rankList = SceneManager.active.mapModel.content["rankList"];
            this.initEvent();
        }
    }

    private function onLoadComplete(param1:ContentInfo):void {
        var info:ContentInfo = param1;
        this._resLib = new ResourceLibrary(info.content);
        this._mc = this._resLib.getMovieClip("mc");
        LayerManager.topLayer.addChild(this._mc);
        MovieClipUtil.playMc(this._mc, 2, this._mc.totalFrames, function ():void {
            DisplayUtil.removeForParent(_mc);
            FightManager.startFightWithWild(283);
        }, true);
    }

    private function initEvent():void {
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        this._threeMan.buttonMode = true;
        this._threeMan.addEventListener(MouseEvent.CLICK, this.onThree);
        this._rankList.buttonMode = true;
        this._rankList.addEventListener(MouseEvent.CLICK, this.onRank);
    }

    private function onRank(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("Panda1180ListPanel"), "正在打开...");
    }

    private function onThree(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("Panda1180MainPanel"), "正在打开...");
    }

    private function onUnit(param1:DialogPanelEvent):void {
        var _loc2_:int = 0;
        switch (String(param1.content)) {
            case "fight544":
                _loc2_ = 112;
                break;
            case "fight545":
                _loc2_ = 113;
                break;
            case "fight546":
                _loc2_ = 114;
        }
        FightManager.startFightWithWild(_loc2_);
    }

    public function dispose():void {
        DisplayUtil.removeForParent(this._mc);
        if (this._resLib) {
            this._resLib.dispose();
            this._resLib = null;
        }
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.onRandomStatus);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
    }
}
}
