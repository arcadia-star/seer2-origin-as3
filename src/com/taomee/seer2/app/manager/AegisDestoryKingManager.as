package com.taomee.seer2.app.manager {
import com.greensock.TweenNano;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.config.TimeLimitConfig;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class AegisDestoryKingManager {

    private static var _map:MapModel;

    private static var mapID:int;

    private static var contentMc:MovieClip;

    private static var _petMc:MovieClip;

    private static var _harmMc:MovieClip;

    private static var FIGHT_ID:int = 1623;


    public function AegisDestoryKingManager() {
        super();
    }

    public static function init():void {
//         if(SceneManager.prevSceneType == SceneType.ARENA)
//         {
//            if(FIGHT_ID == FightManager.currentFightRecord.initData.positionIndex)
//            {
//               TweenNano.delayedCall(1,function():void
//               {
//                  SceneManager.changeScene(SceneType.LOBBY,70);
//                  TweenNano.delayedCall(1,function():void
//                  {
//                     ModuleManager.showAppModule("AegisDestoryKingPanel");
//                  });
//               });
//            }
//         }
//         else
        {
            _map = SceneManager.active.mapModel;
            mapID = _map.id;
            contentMc = _map.content as MovieClip;
            //if(TimeLimitConfig.InLimitTime(263))
            {
                CommonUseManager.hideLobbyMenu();
                QueueLoader.load(URLUtil.getActivityAnimation("aegisdestoryking"), LoadType.SWF, onResLoaded);
            }
        }
    }

    private static function onResLoaded(param1:ContentInfo):void {
        var _loc2_:Sprite = param1.content as Sprite;
        _petMc = _loc2_["petMC"];
        contentMc.addChild(_petMc);
        _petMc.buttonMode = true;
        _petMc.addEventListener(MouseEvent.CLICK, onPet);
        _harmMc = _loc2_["harmMc"];
        contentMc.addChild(_harmMc);
    }

    private static function onPet(param1:MouseEvent):void {
        FightManager.startFightWithWild(FIGHT_ID);
    }
}
}
