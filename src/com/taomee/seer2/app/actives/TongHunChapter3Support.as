package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

import org.taomee.utils.BitUtil;

public class TongHunChapter3Support {

    private static var _instance:TongHunChapter3Support;


    private const PASS_STATE:uint = 204314;

    private var hasPass:Boolean;

    private var hasComplete:Boolean;

    public function TongHunChapter3Support() {
        super();
    }

    public static function getInstance():TongHunChapter3Support {
        if (!_instance) {
            _instance = new TongHunChapter3Support();
        }
        return _instance;
    }

    public function setup():void {
        SceneManager.active.mapModel.content["luopanMc"].visible = false;
        ActiveCountManager.requestActiveCount(this.PASS_STATE, this.getState);
    }

    public function dispose():void {
        SceneManager.active.mapModel.content["luopanMc"].removeEventListener(MouseEvent.CLICK, this.onShowGame);
    }

    private function getState(param1:uint, param2:uint):void {
        this.hasPass = Boolean(BitUtil.getBit(param2, 0));
        ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_211, this.getBuffer);
    }

    private function getBuffer(param1:ServerBuffer):void {
        var _loc2_:int = param1.readDataAtPostion(13);
        this.hasComplete = _loc2_ == 2;
        if (this.hasPass && !this.hasComplete && _loc2_ == 0) {
            this.initDia();
        }
        if (_loc2_ == 1) {
            SceneManager.active.mapModel.content["luopanMc"].visible = true;
            SceneManager.active.mapModel.content["luopanMc"].buttonMode = true;
            SceneManager.active.mapModel.content["luopanMc"].addEventListener(MouseEvent.CLICK, this.onShowGame);
        } else if (_loc2_ == 2) {
            SceneManager.changeScene(SceneType.LOBBY, 951);
        } else {
            SceneManager.active.mapModel.content["luopanMc"].visible = false;
        }
    }

    private function onShowGame(param1:MouseEvent):void {
        ModuleManager.showAppModule("TongHunChapter3GamePanel", this.update);
    }

    private function update(param1:Boolean):void {
        this.hasComplete = param1;
    }

    private function initDia():void {
        NpcDialog.show(106, "斯坦因", [[1, "这里就是瞳之门了。"]], ["诶？门在哪里？"], [function ():void {
            NpcDialog.show(106, "斯坦因", [[1, "神兽罗盘说的是不会错的！快把风系精灵都放出来吧。"]], ["好的，博士！"], [function ():void {
                ServerBufferManager.updateServerBuffer(ServerBufferType.BUFFER_SEAT_211, 13, 1);
                MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("TongHun3LuoPanFull"), function ():void {
                    SceneManager.active.mapModel.content["luopanMc"].visible = true;
                    SceneManager.active.mapModel.content["luopanMc"].buttonMode = true;
                    SceneManager.active.mapModel.content["luopanMc"].addEventListener(MouseEvent.CLICK, onShowGame);
                    NpcDialog.show(400, "小赛尔", [[0, "这个图案……难道就是瞳之门！？"]], ["好神奇！"], [function ():void {
                        NpcDialog.show(106, "斯坦因", [[1, "没错，好了，是时候打开门了。"]], ["好！"], [function ():void {
                            ModuleManager.showAppModule("TongHunChapter3GamePanel", update);
                        }]);
                    }]);
                }, false, false, 1, false);
            }]);
        }]);
    }
}
}

class Singleton {


    public function Singleton() {
        super();
    }
}
