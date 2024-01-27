package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootGridPanel;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class FireGodCommandManager {

    private static var _map:MapModel;

    private static var _fireBoxMc:MovieClip;

    private static var _fireAniMc:MovieClip;

    private static var _tipMc:MovieClip;

    private static var counter:int;

    private static var SWAP_GAME_OVER:int = 3937;

    private static var SWAP_GAME_START:int = 3936;


    public function FireGodCommandManager() {
        super();
    }

    public static function init(param1:MapModel):void {
        counter = 0;
        _map = param1;
        _fireBoxMc = param1.content["fireBoxMc"];
        _fireAniMc = param1.content["fireAniMc"];
        _tipMc = param1.content["tipMc"];
        DisplayObjectUtil.removeFromParent(_tipMc);
        _tipMc.x = 792;
        _tipMc.y = 613;
        LayerManager.stage.addChild(_tipMc);
        _fireAniMc.visible = false;
        _fireBoxMc.gotoAndStop(1);
        _fireBoxMc["barMc"].gotoAndStop(1);
        if (Boolean(_fireBoxMc["bodyMc"]) && MovieClip(_fireBoxMc["bodyMc"]).hasEventListener(MouseEvent.CLICK) == false) {
            MovieClip(_fireBoxMc["bodyMc"]).buttonMode = true;
            MovieClip(_fireBoxMc["bodyMc"]).addEventListener(MouseEvent.CLICK, onBody);
        }
        update();
    }

    private static function onBody(param1:MouseEvent):void {
        ServerMessager.addMessage("用火焰头部射击点燃火盆！");
    }

    private static function update():void {
        ShootController.addEventListener(ShootEvent.PLAY_END, onShoot);
    }

    private static function onShoot(param1:ShootEvent):void {
        var shoot:Boolean = false;
        var evt:ShootEvent = param1;
        var shootInfo:ShootInfo = evt.info;
        var actorInfo:UserInfo = ActorManager.actorInfo;
        if (shootInfo.id == 3 && shootInfo.userID == actorInfo.id) {
            shoot = false;
            shoot = Boolean(_fireBoxMc["bodyMc"].hitTestPoint(evt.info.endPos.x, evt.info.endPos.y, true));
            if (shoot) {
                ++counter;
                _tipMc.visible = false;
                _fireBoxMc.gotoAndStop(1);
                _fireBoxMc["barMc"].gotoAndStop(counter + 1);
                if (counter == 10) {
                    counter = 0;
                    _fireAniMc.visible = true;
                    _fireBoxMc.visible = false;
                    _fireAniMc.gotoAndStop(1);
                    MovieClipUtil.playMc(_fireAniMc, 2, _fireAniMc.totalFrames, function ():void {
                        SwapManager.swapItem(SWAP_GAME_START, 1, function (param1:IDataInput):void {
                            new SwapInfo(param1);
                            if (ShootGridPanel.isShow) {
                                ShootGridPanel.instance.hide();
                            }
                            ModuleManager.showModule(URLUtil.getAppModule("GardenGameNewVersionPanel"), "正在打开猜拳面板...", {"func": gameHandle});
                        });
                    });
                }
            }
        }
    }

    private static function gameHandle(param1:int):void {
        var val:int = param1;
        var tmpVal:int = 0;
        if (val != 0) {
            tmpVal = 1;
        }
        SwapManager.swapItem(SWAP_GAME_OVER, 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            SceneManager.changeScene(SceneType.LOBBY, 70);
            ModuleManager.showAppModule("FireGodCommandPanel");
        }, null, new SpecialInfo(1, tmpVal));
    }

    public static function dispose():void {
        DisplayObjectUtil.removeFromParent(_tipMc);
    }
}
}
